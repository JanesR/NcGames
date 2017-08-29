#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณMicrosiga           บ Data ณ  03/20/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function HTMTESTE()
RpcSetEnv("01","03")

SA1->(DbSeek(xFilial('SA1')+"007647"))
U_EcomHtm7("EXISTENTE")
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณMicrosiga           บ Data ณ  02/20/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ECOMHTM1(aRecZC6)
Local cHtml			:=''
Local cPictQuantid:=Avsx3("ZC6_QTDVEN",6)
Local cPictVlrUnit:="@E 99,999,999.99"
Local cPictVlrTota:="@E 999,999,999.99"
Local cPictQuantid:="@E 999999999"
Local cPerLiq		:="@E 9999.99"
//Local cHtml:='workflow\Ecommerce01.htm'
//Local oHtml	:= TWFHTML():New( cHtml )
//Local cNomeArq:=E_Create(,.F.)
Local aCombo	:=RetSx3Box( Posicione("SX3", 2, "C6_YSTPCMV","X3CBox()" ),,,1)
Local cCor

cHtml+='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtml+='<html xmlns="http://www.w3.org/1999/xhtml">
cHtml+='<head>
cHtml+='<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
cHtml+='<title>Mensageiro E-Commerce</title>

cHtml+='</head>

cHtml+='<!-- CONTEUDO DA PAGINA -->
cHtml+='<!-- <body bgcolor="#FFFFFF" 	style="margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF; color: #000000; font-family: Tahoma; text-shadow: 0px 0px #FFFFFF; border: #FFFFFF; background-image: url(/imagens/fundo.png);" >-->


cHtml+='<center>
cHtml+='<!-- ABERTURA DA DIV PRINCIPAL -->
cHtml+='<!-- <div id="principal" style="margin: 20px auto; width: 1212px; padding: 15px; background-color: #FFF; border: #FFFFFF; border-top-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-color: #FFFFFF;" >-->

cHtml+='<!-- INICIO DO FORMULมRIO -->


cHtml+='<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="33%" height="39" align="left" valign="top">
cHtml+='<img src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" width="315" height="104" alt="Logo Nc Games" />	</td>
cHtml+='<td height="39" valign="middle" style="font-family: Baskerville, '+Chr(39)+'Palatino Linotype'+Chr(39)+', Palatino, '+Chr(39)+'Century Schoolbook L'+Chr(39)+', '+Chr(39)+'Times New Roman'+Chr(39)+', serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;" >
cHtml+='<p style="text-align: center">Estoque Insuficiente</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<!-- TABELA CABEวALHO -->

cHtml+='<hr style="border:none; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto"/>

cHtml+='<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style="font-family: Tahoma; font-size: 10px;">
cHtml+='<tr>
cHtml+='<th colspan="4" bgcolor="#efefef" style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #000;"><div align="left">Prezados </div></th>
cHtml+='</tr>
cHtml+='<tr>
SA1->(DbSetOrder(1))
SA1->(DbSeek(xFilial("SA1")+ZC5->(ZC5_CLIENT+ZC5_LOJA)))

cHtml+='<td bgcolor="#efefef" width="832"><p><font size="2" face="Arial">Cliente protheus:'+ZC5->ZC5_CLIENT+'/'+ZC5->ZC5_LOJA+':'+SA1->A1_NOME +' </font>- <font size="2" face="Arial"></font></p>
cHtml+='<td bgcolor="#efefef" width="832"><p><font size="2" face="Arial">Endere็o:'+SA1->(AllTrim(A1_END)+'-'+AllTrim(A1_BAIRRO)+' '+AllTrim(A1_MUN)+' '+A1_EST+' CEP:'+A1_CEP)+' </font>- <font size="2" face="Arial"></font></p>
cHtml+='<td bgcolor="#efefef" width="832"><p><font size="2" face="Arial">Telefone:('+SA1->A1_DDD+')'+SA1->A1_TEL+' </font>- <font size="2" face="Arial"></font></p>


//cHtml+='<p><font size="2" face="Arial">C&oacute;digo do cliente site:'+AllTrim(Str(Posicione("SA1",1,xFilial("SA1")+ZC5->(ZC5_CLIENT+ZC5_LOJA)),"A1_ZCODCIA"))+' </font></p>
cHtml+='<p><font size="2" face="Arial">Forma de Pagamento:'+ZC5->ZC5_COND+"-"+Alltrim(Posicione("SX5",1,xFilial("SX5")+"24"+ZC5->ZC5_COND,"X5_DESCRI"))+'  </font></p></td>
cHtml+='<p><font size="2" face="Arial">Status Pedido:'+Alltrim(Posicione("SX5",1,xFilial("SX5")+"_Z"+ZC5->ZC5_STATUS,"X5_DESCRI"))+'  </font></p></td>

cHtml+='<td bgcolor="#666666" width="272"><p><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;"><strong>Pedido Site:'+AllTrim(Str(ZC5->ZC5_NUM))+' </strong></span></p>
//cHtml+='<p><strong><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;">Pedido Protheus:'+ZC5->ZC5_NUMPV+' Margem Liquida:'+TransForm(SC5->C5_YTOTLIQ,AvSx3("C5_YTOTLIQ",6))+' '+TransForm(SC5->C5_YPERLIQ,AvSx3("C5_YPERLIQ",6))+'% </span></strong></p></td>
cHtml+='<p><strong><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;">Pedido Protheus:'+ZC5->ZC5_NUMPV+' </span></strong></p></td>
cHtml+='</tr>
cHtml+='<tr>
cHtml+='<td colspan="4" bgcolor="#efefef">&nbsp;</td>
cHtml+='</tr>

cHtml+='</table>

cHtml+='&nbsp;<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style=" font-family:Arial, Helvetica, sans-serif; font-size:10px; ">
cHtml+='<tr>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Item</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Nosso C&oacute;digo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;"><p>Descri&ccedil;&atilde;o do Produto</p></th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Qtd. Pedido</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Qtd. Reservada</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Saldo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Custo uni.</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Tipo CM</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Mrg Liq (R$)</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Mrg Liq (%)</th>
cHtml+='</tr>

For nInd:=1 To Len(aRecZC6)
	ZC6->(DbGoTo(aRecZC6[nInd]))
	
	cCor:="#efefef"
	If ZC6->(ZC6_QTDRES<>ZC6_QTDVEN)
		cCor:="#FFF788"
	EndIf
	
	cHtml+='<tr>
	cHtml+='<td bgcolor='+cCor+' width="51"><font size="1">'+ZC6->ZC6_ITEM+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1"  face="Arial">'+ZC6->ZC6_PRODUTO+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="315"><font size="1" face="Arial">'+Posicione("SB1",1,xFilial("SB1")+ZC6->ZC6_PRODUTO,"B1_XDESC")+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="98">'+TransForm(ZC6->ZC6_QTDVEN,cPictQuantid)+'</td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1">'+TransForm(ZC6->ZC6_QTDRES,cPictQuantid)+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="85"><font size="1" face="Arial">'+TransForm(ZC6->(ZC6_QTDRES-ZC6_QTDVEN),cPictQuantid)+'</font></td>
	
	If SC6->( DbSeek(xFilial("SC6")+SC5->C5_NUM+ZC6->(ZC6_ITEM+ZC6_PRODUTO)   ) )
		cHtml+='<td bgcolor='+cCor+' width="84"><font size="1" face="Arial">'+TransForm(SC6->C6_YCMVUNI,cPictQuantid)+'</font></td>
		cHtml+='<td bgcolor='+cCor+' width="61"><font size="1" face="Arial">'+aCombo[Ascan(aCombo,{|a| a[2]==SC6->C6_YSTPCMV} ),3]+'</font></td>
		cHtml+='<td bgcolor='+cCor+' width="69"><font size="1">'+TransForm(SC6->C6_YMKPLIQ,cPictVlrUnit )+'</font></td>
		cHtml+='<td bgcolor='+cCor+' width="81"><font size="1">'+TransForm(SC6->C6_YPERLIQ,cPerLiq   )+'</font></td>
	Else
		cHtml+='<td bgcolor='+cCor+' width="84"><font size="1" face="Arial">0</font></td>
		cHtml+='<td bgcolor='+cCor+' width="61"><font size="1" face="Arial"></font></td>
		cHtml+='<td bgcolor='+cCor+' width="69"><font size="1">0</font></td>
		cHtml+='<td bgcolor='+cCor+' width="81"><font size="1">0</font></td>
	EndIf
	cHtml+='</tr>
Next



cHtml+='</table>
cHtml+='<p>&nbsp;</p>
cHtml+='<table width="100%" height="62" border="0" bordercolor="#006600" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="100%" height="52">
cHtml+='<table width="95%" border="0" align="center" style="
cHtml+='font-family:Arial, Helvetica, sans-serif;
cHtml+='font-size:11px; ">
cHtml+='<tr>
cHtml+='<td><p>E-mail informativo enviado por rotinas automaticas.  </p>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<table width="100%" border="0" id="tbrodape">
cHtml+='<tr>
cHtml+='<td height="30" align="center" style=" font-family: Verdana, Geneva, sans-serif;
cHtml+='font-size: 11px;
cHtml+='color: #000; "> WORKFLOW PROTHEUS</td>
cHtml+='</tr>
cHtml+='</table></td>
cHtml+='</tr>
cHtml+='</table>


cHtml+='<!-- </form>-->
cHtml+='<!--                  </div>-->
cHtml+='</center>
cHtml+='</body>
cHtml+='</html>

Return cHtml


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณMicrosiga           บ Data ณ  02/20/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ECOMHTM2()
Local cHtml			:=""
Local cChaveZC6	:=xFilial("ZC6")+Str(ZC5->ZC5_NUM,6,0)
Local cPictQuantid:=Avsx3("ZC6_QTDVEN",6)
Local cPictVlrUnit:="@E 99,999,999.99"
Local cPictVlrTota:="@E 999,999,999.99"
Local cPictQuantid:="@E 999999999"
Local cPerLiq		:="@E 9999.99"
Local aCombo		:=RetSx3Box( Posicione("SX3", 2, "C6_YSTPCMV","X3CBox()" ),,,1)
Local cCor


cHtml+='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtml+='<html xmlns="http://www.w3.org/1999/xhtml">
cHtml+='<head>
cHtml+='<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
cHtml+='<title>Mensageiro E-Commerce</title>

cHtml+='</head>

cHtml+='<!-- CONTEUDO DA PAGINA -->
cHtml+='<!-- <body bgcolor="#FFFFFF" 	style="margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF; color: #000000; font-family: Tahoma; text-shadow: 0px 0px #FFFFFF; border: #FFFFFF; background-image: url(/imagens/fundo.png);" >-->


cHtml+='<center>
cHtml+='<!-- ABERTURA DA DIV PRINCIPAL -->
cHtml+='<!-- <div id="principal" style="margin: 20px auto; width: 1212px; padding: 15px; background-color: #FFF; border: #FFFFFF; border-top-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-color: #FFFFFF;" >-->

cHtml+='<!-- INICIO DO FORMULมRIO -->


cHtml+='<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="33%" height="39" align="left" valign="top">
cHtml+='<img src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" width="315" height="104" alt="Logo Nc Games" />	</td>
cHtml+='<td height="39" valign="middle" style="font-family: Baskerville, '+Chr(39)+'Palatino Linotype'+Chr(39)+', Palatino, '+Chr(39)+'Century Schoolbook L'+Chr(39)+', '+Chr(39)+'Times New Roman'+Chr(39)+', serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;" >
cHtml+='<p style="text-align: center">Aguardando Estorno WMS</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<!-- TABELA CABEวALHO -->

cHtml+='<hr style="border:none; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto"/>

cHtml+='<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style="font-family: Tahoma; font-size: 10px;">
cHtml+='<tr>
cHtml+='<th colspan="2" bgcolor="#efefef" style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #000;"><div align="left">Prezados, o pedido abaixo estแ aguardando o estorno do WMS para finaliza็ใo do processo no E-commerce </div></th>
cHtml+='</tr>
cHtml+='<tr>
cHtml+='<td bgcolor="#efefef" width="832"><p><font size="2" face="Arial">Cliente protheus:'+ZC5->ZC5_CLIENT+'/'+ZC5->ZC5_LOJA+':'+Posicione("SA1",1,xFilial("SA1")+ZC5->(ZC5_CLIENT+ZC5_LOJA),"A1_NOME") +' </font>- <font size="2" face="Arial"></font></p>

//cHtml+='<p><font size="2" face="Arial">C&oacute;digo do cliente site:'+AllTrim(Str(Posicione("SA1",1,xFilial("SA1")+ZC5->(ZC5_CLIENT+ZC5_LOJA)),"A1_ZCODCIA")+' </font></p>
//cHtml+='<p><font size="2" face="Arial">Forma de Pagamento:'+ZC5->ZC5_COND+"-"+Alltrim(Posicione("SX5",1,xFilial("SX5")+"24"+ZC5->ZC5_COND,"X5_DESCRI"))+'  </font></p></td>
cHtml+='<td bgcolor="#666666" width="272"><p><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;"><strong>Pedido Site:'+AllTrim(Str(ZC5->ZC5_NUM))+' </strong></span></p>
cHtml+='<p><strong><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;">Pedido Protheus:'+ZC5->ZC5_NUMPV+' </span></strong></p></td>
cHtml+='</tr>
cHtml+='<tr>
cHtml+='<td colspan="2" bgcolor="#efefef">&nbsp;</td>
cHtml+='</tr>

cHtml+='</table>

cHtml+='&nbsp;<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style=" font-family:Arial, Helvetica, sans-serif; font-size:10px; ">
cHtml+='<tr>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Item</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Nosso C&oacute;digo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;"><p>Descri&ccedil;&atilde;o do Produto</p></th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Qtd. Pedido</th>
cHtml+='</tr>


ZC6->(DbSetOrder(1))//ZC6_FILIAL+Str(ZC6_NUM,6,0)+ZC6_ITEM
ZC6->(DbSeek(cChaveZC6))

Do While ZC6->(!Eof())  .And. ZC6->(ZC6_FILIAL+Str(ZC6_NUM,6,0))==cChaveZC6
	
	cCor:="#efefef"
	//If ZC6->(ZC6_QTDRES<>ZC6_QTDVEN)
	//cCor:="#FFF788"
	//EndIf
	
	cHtml+='<tr>
	cHtml+='<td bgcolor='+cCor+' width="51"><font size="1">'+ZC6->ZC6_ITEM+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1"  face="Arial">'+ZC6->ZC6_PRODUTO+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="315"><font size="1" face="Arial">'+Posicione("SB1",1,xFilial("SB1")+ZC6->ZC6_PRODUTO,"B1_XDESC")+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="98">'+TransForm(ZC6->ZC6_QTDVEN,cPictQuantid)+'</td>
	cHtml+='</tr>
	
	ZC6->(DbSkip())
EndDo

cHtml+='</table>
cHtml+='<p>&nbsp;</p>
cHtml+='<table width="100%" height="62" border="0" bordercolor="#006600" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="100%" height="52">
cHtml+='<table width="95%" border="0" align="center" style="
cHtml+='font-family:Arial, Helvetica, sans-serif;
cHtml+='font-size:11px; ">
cHtml+='<tr>
cHtml+='<td><p>E-mail informativo enviado por rotinas automaticas.  </p>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<table width="100%" border="0" id="tbrodape">
cHtml+='<tr>
cHtml+='<td height="30" align="center" style=" font-family: Verdana, Geneva, sans-serif;
cHtml+='font-size: 11px;
cHtml+='color: #000; "> WORKFLOW PROTHEUS</td>
cHtml+='</tr>
cHtml+='</table></td>
cHtml+='</tr>
cHtml+='</table>


cHtml+='<!-- </form>-->
cHtml+='<!--                  </div>-->
cHtml+='</center>
cHtml+='</body>
cHtml+='</html>

Return cHtml

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณMicrosiga           บ Data ณ  02/20/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ECOMHTM3()
Local cHtml:=''
Local cPictQuantid:=Avsx3("ZC6_QTDVEN",6)
Local cPictVlrUnit:="@E 99,999,999.99"
Local cPictVlrTota:="@E 999,999,999.99"
Local cPictQuantid:="@E 999999999"
Local cPerLiq:="@E 9999.99"
//Local cHtml:='workflow\Ecommerce01.htm'
//Local oHtml	:= TWFHTML():New( cHtml )
//Local cNomeArq:=E_Create(,.F.)
Local aCombo	:=RetSx3Box( Posicione("SX3", 2, "C6_YSTPCMV","X3CBox()" ),,,1)
Local cCor
Local cChaveZC6:=xFilial("ZC6")+Str(ZC5->ZC5_NUM,6,0)

cHtml+='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtml+='<html xmlns="http://www.w3.org/1999/xhtml">
cHtml+='<head>
cHtml+='<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
cHtml+='<title>Mensageiro E-Commerce</title>

cHtml+='</head>

cHtml+='<!-- CONTEUDO DA PAGINA -->
cHtml+='<!-- <body bgcolor="#FFFFFF" 	style="margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF; color: #000000; font-family: Tahoma; text-shadow: 0px 0px #FFFFFF; border: #FFFFFF; background-image: url(/imagens/fundo.png);" >-->


cHtml+='<center>
cHtml+='<!-- ABERTURA DA DIV PRINCIPAL -->
cHtml+='<!-- <div id="principal" style="margin: 20px auto; width: 1212px; padding: 15px; background-color: #FFF; border: #FFFFFF; border-top-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-color: #FFFFFF;" >-->

cHtml+='<!-- INICIO DO FORMULมRIO -->


cHtml+='<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="33%" height="39" align="left" valign="top">
cHtml+='<img src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" width="315" height="104" alt="Logo Nc Games" />	</td>
cHtml+='<td height="39" valign="middle" style="font-family: Baskerville, '+Chr(39)+'Palatino Linotype'+Chr(39)+', Palatino, '+Chr(39)+'Century Schoolbook L'+Chr(39)+', '+Chr(39)+'Times New Roman'+Chr(39)+', serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;" >
cHtml+='<p style="text-align: center">Estoque Insuficiente</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<!-- TABELA CABEวALHO -->

cHtml+='<hr style="border:none; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto"/>

cHtml+='<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style="font-family: Tahoma; font-size: 10px;">
cHtml+='<tr>
cHtml+='<th colspan="2" bgcolor="#efefef" style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #000;"><div align="left">Prezados </div></th>
cHtml+='</tr>
cHtml+='<tr>
cHtml+='<td bgcolor="#efefef" width="832"><p><font size="2" face="Arial">Cliente protheus:'+ZC5->ZC5_CLIENT+'/'+ZC5->ZC5_LOJA+':'+Posicione("SA1",1,xFilial("SA1")+ZC5->(ZC5_CLIENT+ZC5_LOJA),"A1_NOME") +' </font>- <font size="2" face="Arial"></font></p>

//cHtml+='<p><font size="2" face="Arial">C&oacute;digo do cliente site:'+AllTrim(Str(Posicione("SA1",1,xFilial("SA1")+ZC5->(ZC5_CLIENT+ZC5_LOJA)),"A1_ZCODCIA"))+' </font></p>
cHtml+='<p><font size="2" face="Arial">Forma de Pagamento:'+ZC5->ZC5_COND+"-"+Alltrim(Posicione("SX5",1,xFilial("SX5")+"24"+ZC5->ZC5_COND,"X5_DESCRI"))+'  </font></p></td>
cHtml+='<td bgcolor="#666666" width="272"><p><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;"><strong>Pedido Site:'+AllTrim(Str(ZC5->ZC5_NUM))+' </strong></span></p>
//cHtml+='<p><strong><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;">Pedido Protheus:'+ZC5->ZC5_NUMPV+' Margem Liquida:'+TransForm(SC5->C5_YTOTLIQ,AvSx3("C5_YTOTLIQ",6))+' '+TransForm(SC5->C5_YPERLIQ,AvSx3("C5_YPERLIQ",6))+'% </span></strong></p></td>
cHtml+='<p><strong><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;">Pedido Protheus:'+ZC5->ZC5_NUMPV+' </span></strong></p></td>
cHtml+='</tr>
cHtml+='<tr>
cHtml+='<td colspan="2" bgcolor="#efefef">&nbsp;</td>
cHtml+='</tr>

cHtml+='</table>

cHtml+='&nbsp;<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style=" font-family:Arial, Helvetica, sans-serif; font-size:10px; ">
cHtml+='<tr>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Item</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Nosso C&oacute;digo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;"><p>Descri&ccedil;&atilde;o do Produto</p></th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Qtd. Pedido</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Qtd. Reservada</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Saldo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Custo uni.</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Tipo CM</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Mrg Liq (R$)</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Mrg Liq (%)</th>
cHtml+='</tr>

ZC6->(DbSetOrder(1))//ZC6_FILIAL+Str(ZC6_NUM,6,0)+ZC6_ITEM
ZC6->(DbSeek(cChaveZC6))

Do While ZC6->(!Eof())  .And. ZC6->(ZC6_FILIAL+Str(ZC6_NUM,6,0))==cChaveZC6
	
	cCor:="#efefef"
	If ZC6->(ZC6_QTDRES<>ZC6_QTDVEN)
		cCor:="#FFF788"
	EndIf
	
	cHtml+='<tr>
	cHtml+='<td bgcolor='+cCor+' width="51"><font size="1">'+ZC6->ZC6_ITEM+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1"  face="Arial">'+ZC6->ZC6_PRODUTO+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="315"><font size="1" face="Arial">'+Posicione("SB1",1,xFilial("SB1")+ZC6->ZC6_PRODUTO,"B1_XDESC")+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="98">'+TransForm(ZC6->ZC6_QTDVEN,cPictQuantid)+'</td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1">'+TransForm(ZC6->ZC6_QTDRES,cPictQuantid)+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="85"><font size="1" face="Arial">'+TransForm(ZC6->(ZC6_QTDRES-ZC6_QTDVEN),cPictQuantid)+'</font></td>
	
	If SC6->( DbSeek(xFilial("SC6")+SC5->C5_NUM+ZC6->(ZC6_ITEM+ZC6_PRODUTO)   ) )
		cHtml+='<td bgcolor='+cCor+' width="84"><font size="1" face="Arial">'+TransForm(SC6->C6_YCMVUNI,cPictQuantid)+'</font></td>
		cHtml+='<td bgcolor='+cCor+' width="61"><font size="1" face="Arial">'+aCombo[Ascan(aCombo,{|a| a[2]==SC6->C6_YSTPCMV} ),3]+'</font></td>
		cHtml+='<td bgcolor='+cCor+' width="69"><font size="1">'+TransForm(SC6->C6_YMKPLIQ,cPictVlrUnit )+'</font></td>
		cHtml+='<td bgcolor='+cCor+' width="81"><font size="1">'+TransForm(SC6->C6_YPERLIQ,cPerLiq   )+'</font></td>
	Else
		cHtml+='<td bgcolor='+cCor+' width="84"><font size="1" face="Arial">0</font></td>
		cHtml+='<td bgcolor='+cCor+' width="61"><font size="1" face="Arial"></font></td>
		cHtml+='<td bgcolor='+cCor+' width="69"><font size="1">0</font></td>
		cHtml+='<td bgcolor='+cCor+' width="81"><font size="1">0</font></td>
	EndIf
	cHtml+='</tr>
	ZC6->(DbSkip())
EndDo



cHtml+='</table>
cHtml+='<p>&nbsp;</p>
cHtml+='<table width="100%" height="62" border="0" bordercolor="#006600" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="100%" height="52">
cHtml+='<table width="95%" border="0" align="center" style="
cHtml+='font-family:Arial, Helvetica, sans-serif;
cHtml+='font-size:11px; ">
cHtml+='<tr>
cHtml+='<td><p>E-mail informativo enviado por rotinas automaticas.  </p>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<table width="100%" border="0" id="tbrodape">
cHtml+='<tr>
cHtml+='<td height="30" align="center" style=" font-family: Verdana, Geneva, sans-serif;
cHtml+='font-size: 11px;
cHtml+='color: #000; "> WORKFLOW PROTHEUS</td>
cHtml+='</tr>
cHtml+='</table></td>
cHtml+='</tr>
cHtml+='</table>


cHtml+='<!-- </form>-->
cHtml+='<!--                  </div>-->
cHtml+='</center>
cHtml+='</body>
cHtml+='</html>

Return cHtml


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณMicrosiga           บ Data ณ  02/24/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function EcomHtm5()

Local cHtml 	:= ''
Local dDtLanc	:= ""
Local cDGenero	:= ""
Local cCodForne:= ""
Local cPlatafor:= ""
Local cCodBar	:= ""
Local cDescProd:= ""
Local cCodiPro	:= ""


cCodiPro 	:= SB1->B1_COD
cDescProd	:= SB1->B1_XDESC
cCodBar		:= SB1->B1_CODBAR
cPlatafor	:= SB1->B1_PLATEXT
cCodForne	:= SB1->B1_PUBLISH
cDGenero	:= Posicione("SX5",1,xFilial("SX5")+"Z2"+SB1->B1_CODGEN,"X5_DESCRI")
dDtLanc		:= DtoS(Posicione("SB5",1,xFilial("SB5")+cCodiPro,"B5_DTLAN"))
cMostSite	:= IIF(SB1->B1_XMOSTSI=="1","Sim Ambos",IIf(SB1->B1_XMOSTSI=="2","Nใo Ambos",IIf(SB1->B1_XMOSTSI=="3","S๓ Latam",IIf(SB1->B1_XMOSTSI=="4","S๓ Brasil",""))))


cHtml := '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtml += '<html xmlns="http://www.w3.org/1999/xhtml">
cHtml += '<head>
cHtml += '        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
cHtml += '<title>Mensageiro E-Commerce</title>

cHtml += '    <style type="text/css">
cHtml += '    body,td,th {
cHtml += '	color: #000;
cHtml += '	border-color: #FFFFFF;
cHtml += '}
cHtml += '    #principal form table tr td {
cHtml += '	font-size: 16px;
cHtml += '}
cHtml += '    .grid {
cHtml += '	font-size: 14px;
cHtml += '}
cHtml += '    p {
cHtml += '	font-size: 12px;
cHtml += '}
cHtml += '    </style>    </head>

cHtml += '<!-- CONTEUDO DA PAGINA -->
cHtml += '<body bgcolor="#FFFFFF" 	style="font-size: 16px; margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF; color: #000000; font-family: Tahoma; text-shadow: 0px 0px #FFFFFF; border: #FFFFFF; background-image: url(%SERVER%/imagens/fundo.png);" >

cHtml += '<center>
cHtml += '<!-- ABERTURA DA DIV PRINCIPAL -->
cHtml += '<div id="principal" style="margin: 20px auto; width: 1212px; padding: 15px; background-color: #FFF; border: #FFFFFF; border-top-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-color: #FFFFFF;" >

cHtml += '<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600"><tr>
cHtml += '<td width="33%" height="39" align="left" valign="top">
cHtml += '<img src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" width="315" height="104" alt="Logo Nc Games" />	</td>
cHtml += '<td height="39" valign="middle" style="font-family: Baskerville, Palatino Linotype, Palatino, Century Schoolbook L, Times New Roman, serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;" >
cHtml += '<p style="text-align: center; font-size: 36px;">Inclusใo de Produto - '+cMostSite+'</td>
cHtml += '</tr></table>

cHtml += ' <!-- TABELA CABEวALHO -->

cHtml += '<hr style="border:none; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto"/>
cHtml += '<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style="font-family: Tahoma; font-size: 10px;"><tr>
cHtml += '<th bgcolor="#efefef" style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #000;"><div align="left">Aten&ccedil;&atilde;o Prezados</div></th>
cHtml += '</tr><tr>
cHtml += '<td bgcolor="#efefef"><p><font size="2" face="Arial">O Produto '+cCodiPro+' - '+cDescProd+', acaba de ser incluso no Protheus e na tabela de produtos para o site.</font></p>
cHtml += '<p><font size="2" face="Arial">Para prosseguir com o cadastro basta realizar o cadastro do produto no site, liberar a importa&ccedil;&atilde;o de estoque e pre&ccedil;o atrav&eacute;s do menu do Protheus.</font></p>                                              <p>&nbsp;</p></td>
cHtml += '</tr></table>
//Primeira Linha
cHtml += '<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style=" font-family:Arial, Helvetica, sans-serif; font-size:10px; "><tr>
cHtml += '<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;"><p>Produto</p></th>
cHtml += '<th colspan="2" bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Descri&ccedil;&atilde;o NC</th>
cHtml += '<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Cod. Barras</th>
cHtml += '</tr><tr>
cHtml += '<td bgcolor="#efefef" width="192"><font size="1" face="Arial" class="grid">'+cCodiPro+'</font></td>
cHtml += '<td colspan="2" bgcolor="#efefef"><font size="1" class="grid">'+cDescProd+'</font></td>
cHtml += '<td bgcolor="#efefef"><font size="1" class="grid">'+cCodBar+'</font></td>
cHtml += '</tr><tr>
//Segunda Linha
cHtml += '<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;"><p>Plataforma</p></th>
cHtml += '<th width="315" bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;"><p>Fornecedor/Publisher</p></th>
cHtml += '<th width="357" bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">G&ecirc;nero</th>
cHtml += '<th width="222" bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Data de Lan&ccedil;amento</th>
cHtml += '</tr><tr>
cHtml += '<td bgcolor="#efefef"><font size="1" class="grid">'+cPlatafor+'</font></td>
cHtml += '<td bgcolor="#efefef"><font size="1" class="grid">'+cCodForne+'</font></td>
cHtml += '<td bgcolor="#efefef"><font size="1" class="grid">'+cDGenero+'</font></td>
cHtml += '<td bgcolor="#efefef"><font size="1" class="grid">'+dDtLanc+'</font></td>
cHtml += '</tr></table>

cHtml += '<table width="100%" height="62" border="0" bordercolor="#006600" bordercolorlight="#006600" bordercolordark="#006600">
cHtml += '<tr><td width="100%" height="52">
cHtml += '<table width="95%" border="0" align="center" style="font-family:Arial, Helvetica, sans-serif;font-size:11px; ">
cHtml += '<tr><td><p>Workflow informativo enviado por rotinas automaticas.  </p>
cHtml += '</td></tr></table></td></tr></table><table width="100%" border="0" id="tbrodape"><tr>
cHtml += '<td height="30" align="center" style=" font-family: Verdana, Geneva, sans-serif font-size: 11px color: #000 "> WORKFLOW PROTHEUS</td>
cHtml += '</tr></table></td></tr></table></form></div></center></body></html>

Return cHtml


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณMicrosiga           บ Data ณ  02/24/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function EcomHtm6(cAltInc)

Local cHtml 	:= ''
Local cDescProd:= ""
Local cCodiPro	:= ""
Local aCmps		:= u_GetCmpsB1()

cCodiPro := SB1->B1_COD
cDescProd:= SB1->B1_XDESC
cMostSite:= IIF(SB1->B1_XMOSTSI=="1","Sim Ambos",;
IIf(SB1->B1_XMOSTSI=="2","Nใo Ambos",;
IIf(SB1->B1_XMOSTSI=="3","S๓ Latam",;
IIf(SB1->B1_XMOSTSI=="4","S๓ Brasil",""))))

If Len(aCmps) == 0
	Return
EndIf
cHtml += '<!-- saved from url=(0022)http://internet.e-mail -->
cHtml += '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtml += '<html xmlns="http://www.w3.org/1999/xhtml">
cHtml += '<head>
cHtml += '        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
cHtml += '<title>Mensageiro E-Commerce</title>

cHtml += '    <style type="text/css">
cHtml += '    body,td,th {
cHtml += '	color: #000;
cHtml += '	border-color: #FFFFFF;
cHtml += '}
cHtml += '    #principal form table tr td {
cHtml += '	font-size: 16px;
cHtml += '}
cHtml += '    .grid {
cHtml += '	font-size: 14px;
cHtml += '}
cHtml += 'p {
cHtml += 'font-size: 12px;
cHtml += '}
cHtml += '</style></head>

cHtml += '<body bgcolor="#FFFFFF" 	style="font-size: 16px; margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF; color: #000000; font-family: Tahoma; text-shadow: 0px 0px #FFFFFF; border: #FFFFFF; background-image: url(%SERVER%/imagens/fundo.png);" >

cHtml += '<center>

cHtml += '<div id="principal" style="margin: 20px auto; width: 1212px; padding: 15px; background-color: #FFF; border: #FFFFFF; border-top-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-color: #FFFFFF;" >
cHtml += '<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">
cHtml += '<tr>
cHtml += '<td width="33%" height="39" align="left" valign="top">
cHtml += '<img src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" width="315" height="104" alt="Logo Nc Games" />	</td>
cHtml += '<td height="39" valign="middle" style="font-family: Baskerville, Palatino Linotype, Palatino, Century Schoolbook L, Times New Roman, serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;" >

If cAltInc == "A"
	cHtml += '<p style="text-align: center; font-size: 36px;">Altera็ใo de Produto - '+cMostSite+'</td></tr></table>
ElseIf cAltInc == "E"
	cHtml += '<p style="text-align: center; font-size: 36px;">Exclusใo de Produto - '+cMostSite+'</td></tr></table>
ElseIf cAltInc == "N"
	cHtml += '<p style="text-align: center; font-size: 36px;">Altera็ใo de Produto - '+cMostSite+'</td></tr></table>
EndIf

cHtml += '<hr style="border:none; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto"/>

cHtml += '<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style="font-family: Tahoma; font-size: 10px;">
cHtml += '<tr>
cHtml += '<th bgcolor="#efefef" style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #000;"><div align="left">Aten&ccedil;&atilde;o Prezados</div></th>
cHtml += '</tr><tr>

If cAltInc == "A"
	cHtml += '<td bgcolor="#efefef"><p><font size="2" face="Arial">O Produto '+cCodiPro+' - '+cDescProd+', teve os seguinte campo(s) alterado(s).</font></p>                                              <p>&nbsp;</p></td>
ElseIf cAltInc == "E"
	cHtml += '<td bgcolor="#efefef"><p><font size="2" face="Arial">O Produto '+cCodiPro+' - '+cDescProd+', foi excluido do cadastro de produtos.</font></p>                                              <p>&nbsp;</p></td>
ElseIf cAltInc == "N"
	cHtml += '<td bgcolor="#efefef"><p><font size="2" face="Arial">O Produto '+cCodiPro+' - '+cDescProd+', teve o campo mostra site foi alterado para nใo.</font></p>                                              <p>&nbsp;</p></td>
EndIf
cHtml += '</tr></table>

If cAltInc == "A" .Or. cAltInc == "N"
	cHtml += '<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style=" font-family:Arial, Helvetica, sans-serif; font-size:10px; "><tr>
	cHtml += '<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;"><p>Campo alterado</p></th>
	cHtml += '<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Conteudo anterios do campo</th>
	cHtml += '<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Conteudo atual do campo</th>
	cHtml += '</tr>
	
	For nY:=1 to len(aCmps)
		cNomeCpo:=aCmps[nY,1]
		xContAnt:=aCmps[nY,4]
		xContDep:=aCmps[nY,5]
		cTipo := aCmps[nY,3]
		
		If cTipo=="D"
			xContAnt:=DTOC(xContAnt)
			xContDep:=DTOC(xContDep)
		ElseIf cTipo=="N"
			xContAnt:=TransForm(xContAnt,AvSx3(cNomeCpo,6))
			xContDep:=TransForm(xContDep,AvSx3(cNomeCpo,6))
		EndIf
		cHtml += '<tr>
		cHtml += '<td bgcolor="#efefef" width="34%"><font size="1" face="Arial" class="grid">'+AllTrim(aCmps[nY,2])+'</font></td>
		cHtml += '<td bgcolor="#efefef" width="33%"><font size="1" class="grid">'+xContAnt+'</font></td>
		cHtml += '<td bgcolor="#efefef" width="33%"><font size="1" class="grid">'+xContDep+'</font></td>
		cHtml += '</tr>
		
	Next nY
	
EndIf
cHtml += '</table>

cHtml += '<table width="100%" height="62" border="0" bordercolor="#006600" bordercolorlight="#006600" bordercolordark="#006600"><tr>
cHtml += '<td width="100%" height="52"><table width="95%" border="0" align="center" style=" font-family:Arial, Helvetica, sans-serif; font-size:11px; ">
cHtml += '<tr><td><p>Workflow informativo enviado por rotinas automaticas. </p></td></tr></table></td></tr></table>
cHtml += '<table width="100%" border="0" id="tbrodape"><tr>
cHtml += '<td height="30" align="center" style=" font-family: Verdana, Geneva, sans-serif; font-size: 11px; color: #000; "> WORKFLOW PROTHEUS</td>
cHtml += '</tr></table></td></tr></table></div></center></body></html>

Return cHtml

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณMicrosiga           บ Data ณ  02/25/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function EcomHtm7(cOpcao)
Local aAreaAtu:=GetArea()
Local aAreaSA1:=SA1->(GetArea())
Local cHtml:=''
Local cMensagem
Local aCombo	:=RetSx3Box( Posicione("SX3", 2, "A1_PESSOA","X3CBox()" ),,,1)
Local lJuridica:=(SA1->A1_PESSOA=="J")
Local cPicture:=Iif(lJuridica,"@R 99.999.999/9999-99","@R 999.999.999-99")
Local aCpoSA1Alt:={}
Local xContAnt
Local xContDep
Local	cEmailTo:=Alltrim(U_MyNewSX6(	"EC_NCG0006","cleverson.silva@acpd.com.br"	   ,"C","E-mail do responsav้l do PV Site","E-mail do responsav้l do PV Site","E-mail do responsav้l do PV Site",.F. ))
Local cAssunto:="Manuten็ใo Cliente E-Commerce-"+"Codigo CiaShop:"+AllTrim(Str(SA1->A1_ZCODCIA))+" Codigo Protheus:"+SA1->A1_COD+'/'+SA1->A1_LOJA+" Nome:"+AllTrim(SA1->A1_NOME)+" (Pessoa "+Trim(aCombo[Ascan(aCombo,{|a| a[2]==SA1->A1_PESSOA} ),3])+")"
Local lAlterou:=.F.

If cOpcao=="EXCLUSAO"
	cMensagem:='Prezado(a), o cliente abaixo foi excluํdo no sistema Protheus.'
ElseIf cOpcao=="ALTERACAO"
	cMensagem:='Prezado(a), o cliente abaixo foi alterado no sistema Protheus.'
	aCpoSA1Alt:=U_GetaCpoSA1()
	
	If Len(aCpoSA1Alt)==0
		Return
	EndIf
		
	If (nAscan:=ascan(aCpoSA1Alt,{|a| a[1]=="A1_MSBLQL"}))>0
		xContAnt:=aCpoSA1Alt[nAscan,4]
		xContDep:=aCpoSA1Alt[nAscan,5]
		cAssunto+=' '+IIf( xContDep=="1","Bloqueado","Desbloqueado")  //1=Sim;2=Nไo
		If AllTrim(xContDep)=="1"
			cMensagem+=" (BLOQUEADO)"
		Else
			cMensagem+=" (DESBLOQUEADO)"
		EndIf
	EndIf
ElseIf cOpcao=="INCLUSAO"
	cMensagem:='Prezado(a), o cliente abaixo foi incluido no sistema Protheus e aguarda desbloqueio.'
ElseIf cOpcao=="EXISTENTE"
	cMensagem:='Prezado(a), o cliente abaixo realizou cadastro no Site jแ sendo cliente da NcGames.'
EndIf


cHtml+='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtml+='<html xmlns="http://www.w3.org/1999/xhtml">
cHtml+='<head>
cHtml+='<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
cHtml+='  <title>Mensageiro E-Commerce</title>"
cHtml+='</head>
cHtml+='	<body style="border: medium none rgb(255, 255, 255); margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: center top; color: rgb(0, 0, 0); font-family: Tahoma; text-shadow: rgb(255, 255, 255) 0px 0px ; background-image: url(/imagens/fundo.png); background-color: rgb(255, 255, 255);">
cHtml+='<center>
cHtml+='<!-- <div id="principal" style="margin: 20px auto; width: 1212px; padding: 15px; background-color: #FFF; border: #FFFFFF; border-top-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-color: #FFFFFF;" >-->
cHtml+='<table bordercolorlight="#006600" bordercolordark="#006600" align="center" border="0" bordercolor="#ffffff" cellpadding="0" cellspacing="0" width="95%">
cHtml+='  <tbody>
cHtml+='    <tr>
cHtml+='      <td align="left" height="39" valign="top" width="33%">
cHtml+='      <img src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" alt="Logo Nc Games" height="104" width="315" />
cHtml+='      </td>
cHtml+='      <td style="font-family: Baskerville,'+Chr(39)+',Palatino Linotype,'+Chr(39)+',Palatino,'+Chr(39)+',Century Schoolbook L,'+Chr(39)+','+Chr(39)+',Times New Roman,'+Chr(39)+',serif; font-size: 30px; color: rgb(153, 153, 153); text-transform: uppercase; text-align: left;" height="39" valign="middle">
cHtml+='      <p style="text-align: center;">('+Capital(cOpcao)+') Cliente E-Commerce</p>
cHtml+='      </td>
cHtml+='    </tr>
cHtml+='  </tbody>
cHtml+='</table>

cHtml+='<hr style="border-style: solid none none; border-color: rgb(223, 223, 223) -moz-use-text-color -moz-use-text-color; border-width: 1px medium medium; margin: 30px auto; width: 95%;" />
cHtml+='</center>

cHtml+='<p align="left"><strong>
cHtml+='<span style="font-family: Arial,Helvetica,sans-serif; font-size: 13px; font-weight: bold; color: rgb(255, 255, 255);">&nbsp;</span></strong><span style="font-family: Arial,Helvetica,sans-serif; font-size: 13px; color: rgb(255, 255, 255)"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong> </span>
cHtml+='<strong style="font-weight: 400">
cHtml+='<span style="font-family: Arial,Helvetica,sans-serif; "><font size="4">&nbsp;'+cMensagem+'</font></span></strong></p>'

If !lJuridica
	cHtml+='<p align="center"> 	<strong><font size="6" color="#3399FF">	<span style="font-family: Arial,Helvetica,sans-serif">Aten็ใo Cliente Pessoa Fํsica!</span></font></strong></p>'
EndIf

cHtml+='<p align="left">&nbsp;</p><center>'

cHtml+='<table style="font-family: Tahoma; font-size: 10px;" align="center" border="0" cellpadding="4" cellspacing="1" width="95%">
cHtml+='  <tbody>
cHtml+='    <tr>
cHtml+='    <th style="font-family: Arial,Helvetica,sans-serif; font-size: 14px; font-weight: bold; color: rgb(0, 0, 0);" bgcolor="#efefef" bordercolor="#000000">C๓digo Site</th>
cHtml+='      <th style="font-family: Arial,Helvetica,sans-serif; font-size: 14px; font-weight: bold; color: rgb(0, 0, 0);" bgcolor="#efefef" bordercolor="#000000">C๓digo Protheus</th>
cHtml+='      <th style="font-family: Arial,Helvetica,sans-serif; font-size: 14px; font-weight: bold; color: rgb(0, 0, 0);" bgcolor="#efefef" bordercolor="#000000">Nome</th>
cHtml+='      <th style="font-family: Arial,Helvetica,sans-serif; font-size: 14px; font-weight: bold; color: rgb(0, 0, 0);" bgcolor="#efefef" bordercolor="#000000">Tipo Pessoa</th>
cHtml+='      <th style="font-family: Arial,Helvetica,sans-serif; font-size: 14px; font-weight: bold; color: rgb(0, 0, 0);" bgcolor="#efefef" bordercolor="#000000">'+Iif(lJuridica,"CNPJ","CPF")+'</th>'
cHtml+='      <th style="font-family: Arial,Helvetica,sans-serif; font-size: 14px; font-weight: bold; color: rgb(0, 0, 0);" bgcolor="#efefef" bordercolor="#000000">Endere็o</th>
cHtml+='      <th style="font-family: Arial,Helvetica,sans-serif; font-size: 14px; font-weight: bold; color: rgb(0, 0, 0);" bgcolor="#efefef" bordercolor="#000000">Telefone</th>
If cOpcao=="EXISTENTE"
	cHtml+='      <th style="font-family: Arial,Helvetica,sans-serif; font-size: 14px; font-weight: bold; color: rgb(0, 0, 0);" bgcolor="#efefef" bordercolor="#000000">Vendedor</th>
	cHtml+='      <th style="font-family: Arial,Helvetica,sans-serif; font-size: 14px; font-weight: bold; color: rgb(0, 0, 0);" bgcolor="#efefef" bordercolor="#000000">Canal de Venda</th>
EndIf
cHtml+='      </th>
cHtml+='    </tr>
cHtml+='    <tr>



cHtml+='      <td bgcolor="#FFFFFF" width="70"  bordercolor="#000000" align="center"><font size="2">'+AllTrim(Str(SA1->A1_ZCODCIA))+'</td>
cHtml+='      <td bgcolor="#FFFFFF" width="77"  bordercolor="#000000" align="center"><font size="2">'+SA1->A1_COD+'/'+SA1->A1_LOJA+'</td>
cHtml+='      <td bgcolor="#FFFFFF" width="606" bordercolor="#000000" align="center"><font size="2">'+SA1->A1_NOME+'</td>
cHtml+='      <td bgcolor="#FFFFFF" width="202" bordercolor="#000000" align="center"><font size="2">'+aCombo[Ascan(aCombo,{|a| a[2]==SA1->A1_PESSOA} ),3]+'</td>
cHtml+='      <td bgcolor="#FFFFFF" width="149" bordercolor="#000000" align="center"><font size="2">'+TransForm(SA1->A1_CGC,cPicture)+'</td>
cHtml+='      <td bgcolor="#FFFFFF" width="352" bordercolor="#000000" align="center"><font size="2">'+SA1->(AllTrim(A1_END)+'-'+AllTrim(A1_BAIRRO)+' '+AllTrim(A1_MUN)+' '+A1_EST+' CEP:'+A1_CEP)+'</td>
cHtml+='      <td bgcolor="#FFFFFF" width="479" bordercolor="#000000" align="center"><font size="2">('+SA1->A1_DDD+')'+SA1->A1_TEL+'</font></font></td>
If cOpcao=="EXISTENTE"
	cHtml+='      <td bgcolor="#FFFFFF" width="352" bordercolor="#000000" align="center"><font size="2">'+SA1->A1_VEND+'-'+AllTrim(Posicione("SA3",1,xFilial("SA3")+SA1->A1_VEND,"A3_NOME") )+'</td>
	cHtml+='      <td bgcolor="#FFFFFF" width="479" bordercolor="#000000" align="center"><font size="2">'+SA1->A1_YCANAL+'-'+AllTrim(SA1->A1_YDCANAL)+'</font></font></td>
Endif
cHtml+='    </tr>
cHtml+='  </tbody>
cHtml+='</table>
cHtml+='<br />
cHtml+='<br />

If Len(aCpoSA1Alt)>0
	lAlterou:=.T.
	
	cHtml+='<table style="font-family: Tahoma; font-size: 10px;" align="center" border="0" cellpadding="4" cellspacing="1" width="95%">
	cHtml+='    <tr>
	cHtml+='      <th style="font-family: Arial,Helvetica,sans-serif; font-size: 14px; font-weight: bold; color: rgb(0, 0, 0);" bgcolor="#efefef" bordercolor="#000000">Campo</th>
	cHtml+='      <th style="font-family: Arial,Helvetica,sans-serif; font-size: 14px; font-weight: bold; color: rgb(0, 0, 0);" bgcolor="#efefef" bordercolor="#000000">Conte๚do Anterior</th>
	cHtml+='      <th style="font-family: Arial,Helvetica,sans-serif; font-size: 14px; font-weight: bold; color: rgb(0, 0, 0);" bgcolor="#efefef" bordercolor="#000000">Conte๚do Atual</th>
	cHtml+='    </tr>
	
	For nInd:=1 To Len(aCpoSA1Alt)
		
		
		cHtml+='    <tr>
		cHtml+='      <td bgcolor="#FFFFFF" width="70" bordercolor="#000000" align="center"> <font size="2">'+aCpoSA1Alt[nInd,2]+'</td>
		xContAnt:=aCpoSA1Alt[nInd,4]
		xContDep:=aCpoSA1Alt[nInd,5]
		
		If aCpoSA1Alt[nInd,3]=="D"
			xContAnt:=DTOC(aCpoSA1Alt[nInd,4])
			xContDep:=DTOC(aCpoSA1Alt[nInd,5])
		ElseIf aCpoSA1Alt[nInd,3]=="N"
			xContAnt:=TransForm(aCpoSA1Alt[nInd,4],AvSx3(aCpoSA1Alt[nInd,1],6))
			xContDep:=TransForm(aCpoSA1Alt[nInd,5],AvSx3(aCpoSA1Alt[nInd,1],6))
		EndIf
		
		cHtml+='      <td bgcolor="#FFFFFF" width="70" bordercolor="#000000" align="center"> <font size="2">'+xContAnt+'</td>
		cHtml+='      <td bgcolor="#FFFFFF" width="77" bordercolor="#000000" align="center"><font size="2">'+xContDep+'</td>
		cHtml+='    </tr>
		
	Next
	
	cHtml+='    </table>'
	cHtml+='    <p><br /></p>
	
EndIf

cHtml+='<table bordercolorlight="#006600" bordercolordark="#006600" border="0" bordercolor="#006600" height="62" width="100%">
cHtml+='  <tbody>
cHtml+='   <tr>
cHtml+='      <td height="52" width="100%">
cHtml+='      <table style="font-family: Arial,Helvetica,sans-serif; font-size: 11px;" align="center" border="0" width="95%">
cHtml+='        <tbody>
cHtml+='          <tr>
cHtml+='            <td>
cHtml+='            <p>E-mail informativo enviado por rotinas automaticas. </p>
cHtml+='            </td>
cHtml+='          </tr>
cHtml+='        </tbody>
cHtml+='      </table>
cHtml+='      </td>
cHtml+='    </tr>
cHtml+='  </tbody>
cHtml+='</table>
cHtml+='<table id="tbrodape" border="0" width="100%">
cHtml+='  <tbody>
cHtml+='    <tr>
cHtml+='      <td style="font-family: Verdana,Geneva,sans-serif; font-size: 11px; color: rgb(0, 0, 0);" align="center" height="30"> WORKFLOW PROTHEUS</td>
cHtml+='    </tr>
cHtml+='  </tbody>
cHtml+='</table>
cHtml+='<!-- </form>-->
cHtml+='<!-- </div>--></center>
cHtml+='</body>
cHtml+='</html>


If  (cOpcao=="EXCLUSAO" .Or. cOpcao=="INCLUSAO" .Or. cOpcao=="EXISTENTE") .Or. lAlterou
	U_COM08SEND(cAssunto, cHtml, , cEmailTo,,)
EndIf


RestArea(aAreaAtu)
RestArea(aAreaSA1)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณMicrosiga           บ Data ณ  03/11/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ECOMHTM8()
Local cHtml:=''
Local cPictQuantid:=Avsx3("ZC6_QTDVEN",6)
Local cPictVlrUnit:="@E 99,999,999.99"
Local cPictVlrTota:="@E 999,999,999.99"
Local cPictQuantid:="@E 999999999"
Local cPerLiq:="@E 9999.99"
Local aCombo	:=RetSx3Box( Posicione("SX3", 2, "C6_YSTPCMV","X3CBox()" ),,,1)
Local cCor
Local cChaveSC6:=xFilial("SC6")+SC5->C5_NUM

cHtml+='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtml+='<html xmlns="http://www.w3.org/1999/xhtml">
cHtml+='<head>
cHtml+='<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
cHtml+='<title>Mensageiro E-Commerce</title>

cHtml+='</head>

cHtml+='<!-- CONTEUDO DA PAGINA -->
cHtml+='<!-- <body bgcolor="#FFFFFF" 	style="margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF; color: #000000; font-family: Tahoma; text-shadow: 0px 0px #FFFFFF; border: #FFFFFF; background-image: url(/imagens/fundo.png);" >-->


cHtml+='<center>
cHtml+='<!-- ABERTURA DA DIV PRINCIPAL -->
cHtml+='<!-- <div id="principal" style="margin: 20px auto; width: 1212px; padding: 15px; background-color: #FFF; border: #FFFFFF; border-top-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-color: #FFFFFF;" >-->

cHtml+='<!-- INICIO DO FORMULมRIO -->


cHtml+='<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="33%" height="39" align="left" valign="top">
cHtml+='<img src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" width="315" height="104" alt="Logo Nc Games" />	</td>
cHtml+='<td height="39" valign="middle" style="font-family: Baskerville, '+Chr(39)+'Palatino Linotype'+Chr(39)+', Palatino, '+Chr(39)+'Century Schoolbook L'+Chr(39)+', '+Chr(39)+'Times New Roman'+Chr(39)+', serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;" >
cHtml+='<p style="text-align: center">Pedido Ecommerce esta por expirar a data de entrega</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<!-- TABELA CABEวALHO -->

cHtml+='<hr style="border:none; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto"/>

cHtml+='<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style="font-family: Tahoma; font-size: 10px;">
cHtml+='<tr>
cHtml+='<th colspan="2" bgcolor="#efefef" style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #000;"><div align="left">Prezados </div></th>
cHtml+='</tr>
cHtml+='<tr>
cHtml+='<td bgcolor="#efefef" width="832"><p><font size="2" face="Arial">Cliente protheus:'+SC5->C5_CLIENT+'/'+SC5->C5_LOJACLI+':'+Posicione("SA1",1,xFilial("SA1")+SC5->(C5_CLIENT+C5_LOJACLI),"A1_NOME") +' </font>- <font size="2" face="Arial"></font></p>

//cHtml+='<p><font size="2" face="Arial">C&oacute;digo do cliente site:'+AllTrim(Str(Posicione("SA1",1,xFilial("SA1")+SC5->(SC5_CLIENTE+C5_LOJACLI)),"A1_ZCODCIA"))+' </font></p>
cHtml+='<p><font size="2" face="Arial">Forma de Pagamento:'+SC5->C5_CONDPAG+"-"+Alltrim(Posicione("SX5",1,xFilial("SX5")+"24"+SC5->C5_CONDPAG,"X5_DESCRI"))+'  </font></p></td>
cHtml+='<td bgcolor="#666666" width="272"><p><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;"><strong>Pedido Site:'+AllTrim(Str(ZC5->ZC5_NUM))+' </strong></span></p>
//cHtml+='<p><strong><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;">Pedido Protheus:'+SC5->SC5_NUMPV+' Margem Liquida:'+TransForm(SC5->C5_YTOTLIQ,AvSx3("C5_YTOTLIQ",6))+' '+TransForm(SC5->C5_YPERLIQ,AvSx3("C5_YPERLIQ",6))+'% </span></strong></p></td>
cHtml+='<p><strong><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;">Pedido Protheus:'+SC5->C5_NUM+' </span></strong></p></td>
cHtml+='</tr>
cHtml+='<tr>
cHtml+='<td colspan="2" bgcolor="#efefef">&nbsp;</td>
cHtml+='</tr>

cHtml+='</table>

cHtml+='&nbsp;<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style=" font-family:Arial, Helvetica, sans-serif; font-size:10px; ">
cHtml+='<tr>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Item</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Nosso C&oacute;digo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;"><p>Descri&ccedil;&atilde;o do Produto</p></th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Qtd. Pedido</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Qtd. Reservada</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Data Entrega</th>
//cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Custo uni.</th>
//cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Tipo CM</th>
//cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Mrg Liq (R$)</th>
//cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Mrg Liq (%)</th>
cHtml+='</tr>

SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
SC6->( DbSeek(cChaveSC6))

Do While SC6->(!Eof()) .And. SC6->(C6_FILIAL+C6_NUM)==cChaveSC6
	
	cCor:="#efefef"
	If SC6->(C6_QTDRESE<>C6_QTDVEN)
		cCor:="#FFF788"
	EndIf
	
	cHtml+='<tr>
	cHtml+='<td bgcolor='+cCor+' width="51"><font size="1">'+SC6->C6_ITEM+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1"  face="Arial">'+SC6->C6_PRODUTO+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="315"><font size="1" face="Arial">'+Posicione("SB1",1,xFilial("SB1")+SC6->C6_PRODUTO,"B1_XDESC")+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="98">'+TransForm(SC6->C6_QTDVEN,cPictQuantid)+'</td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1">'+TransForm(SC6->C6_QTDRESE,cPictQuantid)+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="85"><font size="1" face="Arial">'+DTOC(SC6->C6_ENTREG)+'</font></td>
	
	//cHtml+='<td bgcolor='+cCor+' width="84"><font size="1" face="Arial">'+TransForm(SC6->C6_YCMVUNI,cPictQuantid)+'</font></td>
	//cHtml+='<td bgcolor='+cCor+' width="61"><font size="1" face="Arial">'+aCombo[Ascan(aCombo,{|a| a[2]==SC6->C6_YSTPCMV} ),3]+'</font></td>
	//cHtml+='<td bgcolor='+cCor+' width="69"><font size="1">'+TransForm(SC6->C6_YMKPLIQ,cPictVlrUnit )+'</font></td>
	//cHtml+='<td bgcolor='+cCor+' width="81"><font size="1">'+TransForm(SC6->C6_YPERLIQ,cPerLiq   )+'</font></td>
	cHtml+='</tr>
	SC6->(DbSkip())
EndDo



cHtml+='</table>
cHtml+='<p>&nbsp;</p>
cHtml+='<table width="100%" height="62" border="0" bordercolor="#006600" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="100%" height="52">
cHtml+='<table width="95%" border="0" align="center" style="
cHtml+='font-family:Arial, Helvetica, sans-serif;
cHtml+='font-size:11px; ">
cHtml+='<tr>
cHtml+='<td><p>E-mail informativo enviado por rotinas automaticas.  </p>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<table width="100%" border="0" id="tbrodape">
cHtml+='<tr>
cHtml+='<td height="30" align="center" style=" font-family: Verdana, Geneva, sans-serif;
cHtml+='font-size: 11px;
cHtml+='color: #000; "> WORKFLOW PROTHEUS</td>
cHtml+='</tr>
cHtml+='</table></td>
cHtml+='</tr>
cHtml+='</table>


cHtml+='<!-- </form>-->
cHtml+='<!--                  </div>-->
cHtml+='</center>
cHtml+='</body>
cHtml+='</html>

Return cHtml




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM9  บAutor  ณMicrosiga           บ Data ณ  02/20/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ECOMHTM9(aTitBx, cDtBaixa)
Local cHtml:=''
Local cCor
Local nX		:= 0

Default aTitBx		:= {}
Default cDtBaixa  := ""

cHtml+='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtml+='<html xmlns="http://www.w3.org/1999/xhtml">
cHtml+='<head>
cHtml+='<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
cHtml+='<title>Mensageiro E-Commerce</title>

cHtml+='</head>

cHtml+='<!-- CONTEUDO DA PAGINA -->
cHtml+='<!-- <body bgcolor="#FFFFFF" 	style="margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF; color: #000000; font-family: Tahoma; text-shadow: 0px 0px #FFFFFF; border: #FFFFFF; background-image: url(/imagens/fundo.png);" >-->


cHtml+='<center>
cHtml+='<!-- ABERTURA DA DIV PRINCIPAL -->
cHtml+='<!-- <div id="principal" style="margin: 20px auto; width: 1212px; padding: 15px; background-color: #FFF; border: #FFFFFF; border-top-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-color: #FFFFFF;" >-->

cHtml+='<!-- INICIO DO FORMULมRIO -->


cHtml+='<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="33%" height="39" align="left" valign="top">
cHtml+='<img src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" width="315" height="104" alt="Logo Nc Games" />	</td>
cHtml+='<td height="39" valign="middle" style="font-family: Baskerville, '+Chr(39)+'Palatino Linotype'+Chr(39)+', Palatino, '+Chr(39)+'Century Schoolbook L'+Chr(39)+', '+Chr(39)+'Times New Roman'+Chr(39)+', serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;" >
cHtml+='<p style="text-align: center">Baixa de Titulo E-commerce</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<!-- TABELA CABEวALHO -->

cHtml+='<hr style="border:none; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto"/>

cHtml+='<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style="font-family: Tahoma; font-size: 10px;">
cHtml+='<tr>
cHtml+='<th colspan="2" bgcolor="#efefef" style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #000;"><div align="center">Tํtulo(s) baixado(s) em: '+cDtBaixa+'</div></th> '
cHtml+='</tr>

cHtml+='</table>

cHtml+='&nbsp;<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style=" font-family:Arial, Helvetica, sans-serif; font-size:10px; ">

cHtml+='<tr>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Pv.Site</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Pv.Proth.</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Prefixo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Tํtulo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Parcela</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Tipo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Valor</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Saldo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Dt.Vencto.</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Dt.Baixa</th>
cHtml+='</tr>

cCor:="#efefef"

For nX := 1 To Len(aTitBx)
	cHtml+='<tr>
	cHtml+='<td bgcolor='+cCor+' width="70"><font size="1"  face="Arial">'+aTitBx[nX][1]+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="70"><font size="1"  face="Arial">'+aTitBx[nX][2]+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="51"><font size="1">'+aTitBx[nX][3]+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="70"><font size="1"  face="Arial">'+aTitBx[nX][4]+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="20"><font size="1" face="Arial">'+aTitBx[nX][5]+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="40">'+aTitBx[nX][6]+'</td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1">'+aTitBx[nX][7]+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1" face="Arial">'+aTitBx[nX][8]+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="80"><font size="1" face="Arial">'+aTitBx[nX][9]+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="80"><font size="1" face="Arial">'+aTitBx[nX][10]+'</font></td>
	cHtml+='</tr>
Next



cHtml+='</table>
cHtml+='<p>&nbsp;</p>
cHtml+='<table width="100%" height="62" border="0" bordercolor="#006600" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="100%" height="52">
cHtml+='<table width="95%" border="0" align="center" style="
cHtml+='font-family:Arial, Helvetica, sans-serif;
cHtml+='font-size:11px; ">
cHtml+='<tr>
cHtml+='<td><p>E-mail informativo enviado por rotinas automaticas.  </p>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<table width="100%" border="0" id="tbrodape">
cHtml+='<tr>
cHtml+='<td height="30" align="center" style=" font-family: Verdana, Geneva, sans-serif;
cHtml+='font-size: 11px;
cHtml+='color: #000; "> WORKFLOW PROTHEUS</td>
cHtml+='</tr>
cHtml+='</table></td>
cHtml+='</tr>
cHtml+='</table>


cHtml+='<!-- </form>-->
cHtml+='<!--                  </div>-->
cHtml+='</center>
cHtml+='</body>
cHtml+='</html>

Return cHtml





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณMicrosiga           บ Data ณ  03/31/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ECOMHTMA()
Local cHtml:=''
Local cPictQuantid:=Avsx3("ZC6_QTDVEN",6)
Local cPictVlrUnit:="@E 99,999,999.99"
Local cPictVlrTota:="@E 999,999,999.99"
Local cPictQuantid:="@E 999999999"
Local cPerLiq:="@E 9999.99"
Local aCombo	:=RetSx3Box( Posicione("SX3", 2, "C6_YSTPCMV","X3CBox()" ),,,1)
Local cCor
Local cChaveSC6:=xFilial("SC6")+SC5->C5_NUM

cHtml+='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtml+='<html xmlns="http://www.w3.org/1999/xhtml">
cHtml+='<head>
cHtml+='<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
cHtml+='<title>Mensageiro E-Commerce</title>

cHtml+='</head>

cHtml+='<!-- CONTEUDO DA PAGINA -->
cHtml+='<!-- <body bgcolor="#FFFFFF" 	style="margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF; color: #000000; font-family: Tahoma; text-shadow: 0px 0px #FFFFFF; border: #FFFFFF; background-image: url(/imagens/fundo.png);" >-->


cHtml+='<center>
cHtml+='<!-- ABERTURA DA DIV PRINCIPAL -->
cHtml+='<!-- <div id="principal" style="margin: 20px auto; width: 1212px; padding: 15px; background-color: #FFF; border: #FFFFFF; border-top-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-color: #FFFFFF;" >-->

cHtml+='<!-- INICIO DO FORMULมRIO -->


cHtml+='<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="33%" height="39" align="left" valign="top">
cHtml+='<img src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" width="315" height="104" alt="Logo Nc Games" />	</td>
cHtml+='<td height="39" valign="middle" style="font-family: Baskerville, '+Chr(39)+'Palatino Linotype'+Chr(39)+', Palatino, '+Chr(39)+'Century Schoolbook L'+Chr(39)+', '+Chr(39)+'Times New Roman'+Chr(39)+', serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;" >
cHtml+='<p style="text-align: center">Pedido Ecommerce Cancelado Site e Faturado NF:'+SC5->C5_NOTA+'+</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<!-- TABELA CABEวALHO -->

cHtml+='<hr style="border:none; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto"/>

cHtml+='<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style="font-family: Tahoma; font-size: 10px;">
cHtml+='<tr>
cHtml+='<th colspan="2" bgcolor="#efefef" style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #000;"><div align="left">Prezados </div></th>
cHtml+='</tr>
cHtml+='<tr>
cHtml+='<td bgcolor="#efefef" width="832"><p><font size="2" face="Arial">Cliente protheus:'+SC5->C5_CLIENT+'/'+SC5->C5_LOJACLI+':'+Posicione("SA1",1,xFilial("SA1")+SC5->(C5_CLIENT+C5_LOJACLI),"A1_NOME") +' </font>- <font size="2" face="Arial"></font></p>

//cHtml+='<p><font size="2" face="Arial">C&oacute;digo do cliente site:'+AllTrim(Str(Posicione("SA1",1,xFilial("SA1")+SC5->(SC5_CLIENTE+C5_LOJACLI)),"A1_ZCODCIA"))+' </font></p>
cHtml+='<p><font size="2" face="Arial">Forma de Pagamento:'+SC5->C5_CONDPAG+"-"+Alltrim(Posicione("SX5",1,xFilial("SX5")+"24"+SC5->C5_CONDPAG,"X5_DESCRI"))+'  </font></p></td>
cHtml+='<td bgcolor="#666666" width="272"><p><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;"><strong>Pedido Site:'+AllTrim(Str(ZC5->ZC5_NUM))+' </strong></span></p>
//cHtml+='<p><strong><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;">Pedido Protheus:'+SC5->SC5_NUMPV+' Margem Liquida:'+TransForm(SC5->C5_YTOTLIQ,AvSx3("C5_YTOTLIQ",6))+' '+TransForm(SC5->C5_YPERLIQ,AvSx3("C5_YPERLIQ",6))+'% </span></strong></p></td>
cHtml+='<p><strong><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;">Pedido Protheus:'+SC5->C5_NUM+' </span></strong></p></td>
cHtml+='</tr>
cHtml+='<tr>
cHtml+='<td colspan="2" bgcolor="#efefef">&nbsp;</td>
cHtml+='</tr>

cHtml+='</table>

cHtml+='&nbsp;<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style=" font-family:Arial, Helvetica, sans-serif; font-size:10px; ">
cHtml+='<tr>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Item</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Nosso C&oacute;digo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;"><p>Descri&ccedil;&atilde;o do Produto</p></th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Qtd. Pedido</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Qtd. Reservada</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Data Entrega</th>
//cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Custo uni.</th>
//cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Tipo CM</th>
//cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Mrg Liq (R$)</th>
//cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Mrg Liq (%)</th>
cHtml+='</tr>

SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
SC6->( DbSeek(cChaveSC6))

Do While SC6->(!Eof()) .And. SC6->(C6_FILIAL+C6_NUM)==cChaveSC6
	
	cCor:="#efefef"
	If SC6->(C6_QTDRESE<>C6_QTDVEN)
		cCor:="#FFF788"
	EndIf
	
	cHtml+='<tr>
	cHtml+='<td bgcolor='+cCor+' width="51"><font size="1">'+SC6->C6_ITEM+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1"  face="Arial">'+SC6->C6_PRODUTO+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="315"><font size="1" face="Arial">'+Posicione("SB1",1,xFilial("SB1")+SC6->C6_PRODUTO,"B1_XDESC")+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="98">'+TransForm(SC6->C6_QTDVEN,cPictQuantid)+'</td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1">'+TransForm(SC6->C6_QTDRESE,cPictQuantid)+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="85"><font size="1" face="Arial">'+DTOC(SC6->C6_ENTREG)+'</font></td>
	
	//cHtml+='<td bgcolor='+cCor+' width="84"><font size="1" face="Arial">'+TransForm(SC6->C6_YCMVUNI,cPictQuantid)+'</font></td>
	//cHtml+='<td bgcolor='+cCor+' width="61"><font size="1" face="Arial">'+aCombo[Ascan(aCombo,{|a| a[2]==SC6->C6_YSTPCMV} ),3]+'</font></td>
	//cHtml+='<td bgcolor='+cCor+' width="69"><font size="1">'+TransForm(SC6->C6_YMKPLIQ,cPictVlrUnit )+'</font></td>
	//cHtml+='<td bgcolor='+cCor+' width="81"><font size="1">'+TransForm(SC6->C6_YPERLIQ,cPerLiq   )+'</font></td>
	cHtml+='</tr>
	SC6->(DbSkip())
EndDo



cHtml+='</table>
cHtml+='<p>&nbsp;</p>
cHtml+='<table width="100%" height="62" border="0" bordercolor="#006600" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="100%" height="52">
cHtml+='<table width="95%" border="0" align="center" style="
cHtml+='font-family:Arial, Helvetica, sans-serif;
cHtml+='font-size:11px; ">
cHtml+='<tr>
cHtml+='<td><p>E-mail informativo enviado por rotinas automaticas.  </p>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<table width="100%" border="0" id="tbrodape">
cHtml+='<tr>
cHtml+='<td height="30" align="center" style=" font-family: Verdana, Geneva, sans-serif;
cHtml+='font-size: 11px;
cHtml+='color: #000; "> WORKFLOW PROTHEUS</td>
cHtml+='</tr>
cHtml+='</table></td>
cHtml+='</tr>
cHtml+='</table>


cHtml+='<!-- </form>-->
cHtml+='<!--                  </div>-->
cHtml+='</center>
cHtml+='</body>
cHtml+='</html>

Return cHtml
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณMicrosiga           บ Data ณ  03/31/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ECOMHTMB(aRecZC6)
Local cHtml			:=''
Local cPictQuantid:=Avsx3("ZC6_QTDVEN",6)
Local cPictVlrUnit:="@E 99,999,999.99"
Local cPictVlrTota:="@E 999,999,999.99"
Local cPictQuantid:="@E 999999999"
Local cPerLiq		:="@E 9999.99"
Local aCombo	:=RetSx3Box( Posicione("SX3", 2, "C6_YSTPCMV","X3CBox()" ),,,1)
Local cCor

cHtml+='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtml+='<html xmlns="http://www.w3.org/1999/xhtml">
cHtml+='<head>
cHtml+='<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
cHtml+='<title>Mensageiro E-Commerce</title>

cHtml+='</head>

cHtml+='<!-- CONTEUDO DA PAGINA -->
cHtml+='<!-- <body bgcolor="#FFFFFF" 	style="margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF; color: #000000; font-family: Tahoma; text-shadow: 0px 0px #FFFFFF; border: #FFFFFF; background-image: url(/imagens/fundo.png);" >-->


cHtml+='<center>
cHtml+='<!-- ABERTURA DA DIV PRINCIPAL -->
cHtml+='<!-- <div id="principal" style="margin: 20px auto; width: 1212px; padding: 15px; background-color: #FFF; border: #FFFFFF; border-top-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-color: #FFFFFF;" >-->

cHtml+='<!-- INICIO DO FORMULมRIO -->


cHtml+='<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="33%" height="39" align="left" valign="top">
cHtml+='<img src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" width="315" height="104" alt="Logo Nc Games" />	</td>
cHtml+='<td height="39" valign="middle" style="font-family: Baskerville, '+Chr(39)+'Palatino Linotype'+Chr(39)+', Palatino, '+Chr(39)+'Century Schoolbook L'+Chr(39)+', '+Chr(39)+'Times New Roman'+Chr(39)+', serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;" >
cHtml+='<p style="text-align: center">Estoque Insuficiente</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<!-- TABELA CABEวALHO -->

cHtml+='<hr style="border:none; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto"/>

cHtml+='<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style="font-family: Tahoma; font-size: 10px;">
cHtml+='<tr>
cHtml+='<th colspan="2" bgcolor="#efefef" style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #000;"><div align="left">Prezados </div></th>
cHtml+='</tr>
cHtml+='<tr>
SA1->(DbSetOrder(1))
SA1->(DbSeek(xFilial("SA1")+ZC5->(ZC5_CLIENT+ZC5_LOJA)))

cHtml+='<td bgcolor="#efefef" width="832"><p><font size="2" face="Arial">Cliente protheus:'+ZC5->ZC5_CLIENT+'/'+ZC5->ZC5_LOJA+':'+SA1->A1_NOME +' </font>- <font size="2" face="Arial"></font></p>
cHtml+='<td bgcolor="#efefef" width="832"><p><font size="2" face="Arial">Endere็o:'+SA1->(AllTrim(A1_END)+'-'+AllTrim(A1_BAIRRO)+' '+AllTrim(A1_MUN)+' '+A1_EST+' CEP:'+A1_CEP)+' </font>- <font size="2" face="Arial"></font></p>
cHtml+='<td bgcolor="#efefef" width="832"><p><font size="2" face="Arial">Telefone:('+SA1->A1_DDD+')'+SA1->A1_TEL+' </font>- <font size="2" face="Arial"></font></p>



cHtml+='<p><font size="2" face="Arial">Forma de Pagamento:'+ZC5->ZC5_COND+"-"+Alltrim(Posicione("SX5",1,xFilial("SX5")+"24"+ZC5->ZC5_COND,"X5_DESCRI"))+'  </font></p></td>
cHtml+='<p><font size="2" face="Arial">Status Pedido:'+Alltrim(Posicione("SX5",1,xFilial("SX5")+"_Z"+ZC5->ZC5_STATUS,"X5_DESCRI"))+'  </font></p></td>

cHtml+='<td bgcolor="#666666" width="272"><p><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;"><strong>Pedido Site:'+AllTrim(Str(ZC5->ZC5_NUM))+' </strong></span></p>

cHtml+='<p><strong><span style="font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #FFF;">Pedido Protheus:'+ZC5->ZC5_NUMPV+' </span></strong></p></td>
cHtml+='</tr>
cHtml+='<tr>
cHtml+='<td colspan="2" bgcolor="#efefef">&nbsp;</td>
cHtml+='</tr>

cHtml+='</table>

cHtml+='&nbsp;<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style=" font-family:Arial, Helvetica, sans-serif; font-size:10px; ">
cHtml+='<tr>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Item</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Nosso C&oacute;digo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;"><p>Descri&ccedil;&atilde;o do Produto</p></th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Qtd. Pedido</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Qtd. Reservada</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Saldo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Custo uni.</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Tipo CM</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Mrg Liq (R$)</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Mrg Liq (%)</th>
cHtml+='</tr>

For nInd:=1 To Len(aRecZC6)
	ZC6->(DbGoTo(aRecZC6[nInd]))
	
	cCor:="#efefef"
	cHtml+='<tr>
	cHtml+='<td bgcolor='+cCor+' width="51"><font size="1">'+ZC6->ZC6_ITEM+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1"  face="Arial">'+ZC6->ZC6_PRODUTO+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="315"><font size="1" face="Arial">'+Posicione("SB1",1,xFilial("SB1")+ZC6->ZC6_PRODUTO,"B1_XDESC")+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="98">'+TransForm(ZC6->ZC6_QTDVEN,cPictQuantid)+'</td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1">'+TransForm(ZC6->ZC6_QTDRES,cPictQuantid)+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="85"><font size="1" face="Arial">'+TransForm(ZC6->(ZC6_QTDRES-ZC6_QTDVEN),cPictQuantid)+'</font></td>
	
	cHtml+='<td bgcolor='+cCor+' width="84"><font size="1" face="Arial">0</font></td>
	cHtml+='<td bgcolor='+cCor+' width="61"><font size="1" face="Arial"></font></td>
	cHtml+='<td bgcolor='+cCor+' width="69"><font size="1">0</font></td>
	cHtml+='<td bgcolor='+cCor+' width="81"><font size="1">0</font></td>
	
	cHtml+='</tr>
Next



cHtml+='</table>
cHtml+='<p>&nbsp;</p>
cHtml+='<table width="100%" height="62" border="0" bordercolor="#006600" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="100%" height="52">
cHtml+='<table width="95%" border="0" align="center" style="
cHtml+='font-family:Arial, Helvetica, sans-serif;
cHtml+='font-size:11px; ">
cHtml+='<tr>
cHtml+='<td><p>E-mail informativo enviado por rotinas automaticas.  </p>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<table width="100%" border="0" id="tbrodape">
cHtml+='<tr>
cHtml+='<td height="30" align="center" style=" font-family: Verdana, Geneva, sans-serif;
cHtml+='font-size: 11px;
cHtml+='color: #000; "> WORKFLOW PROTHEUS</td>
cHtml+='</tr>
cHtml+='</table></td>
cHtml+='</tr>
cHtml+='</table>


cHtml+='<!-- </form>-->
cHtml+='<!--                  </div>-->
cHtml+='</center>
cHtml+='</body>
cHtml+='</html>

Return cHtml

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณMicrosiga           บ Data ณ  04/28/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ECOMHTMC(cRecZC5,cRecSA1)

Local cHtml			:= ""

Local cAliasZC5	:= ZC5->(GetArea())
Local cAliasSA1	:= SA1->(GetArea())

Local cHoraBole	:= SuperGetMV("EC_NCG0018",,"120")

Local cCodLoja		:= ""
Local cNome			:= ""
Local cEmailCli		:= ""
Local cTelCli		:= ""
Local cNumCia     	:= ""
Local cNumPed		:= ""
Local nValorTotal	:= ""
Local dDtVencto		:= ""

DbSelectArea("ZC5")
ZC5->(DbGoto(cRecZC5))


cNumPed     := ZC5->ZC5_NUMPV
cCodLoja	:= ZC5->ZC5_CLIENT +'/'+ZC5->ZC5_LOJA
cNumCia     := Alltrim(STR(ZC5->ZC5_NUM))
nValorTotal	:= ZC5_FRETE+ZC5_TOTAL

dDtEmissao	:= Posicione("SC5",1,xFilial("SC5")+cNumPed,"C5_EMISSAO")
dData		:= datavalida((cHoraBole/24)+dDtEmissao,.T.)
dDtVencto	:= datavalida(MsDate()) - dData
lDtVencto	:= dDtVencto > 1

DbSelectArea("SA1")
SA1->(DbGoto(cRecSA1))

cNome		:= SA1->A1_NREDUZ
cEmailCli	:= SA1->A1_EMAIL
cTelCli		:= '0'+ SA1->A1_DDD +' '+ SA1->A1_TEL

If !lDtVencto
	Return cHtml
EndIf

cHtml := ''
cHtml+='<!-- saved from url=(0022)http://internet.e-mail -->'
cHtml+='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
cHtml+='<html xmlns="http://www.w3.org/1999/xhtml">'
cHtml+='<head>'
cHtml+='        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />'
cHtml+='<title>Mensageiro E-Commerce</title>'

cHtml+='    <style type="text/css">'
cHtml+='    body,td,th {color: #555;border-color: #FFFFFF;font-family: "Roboto", Verdana;}'
cHtml+='    #principal form table tr td {font-size: 16px;}'
cHtml+='    .grid {font-size: 14px;}'
cHtml+='    p {}'
cHtml+='    .Grid {font-size: 14px;}'
cHtml+='    #principal table .Grid td {font-family: Tahoma, Geneva, sans-serif;}'
cHtml+='    #principal table .Grid td {font-size: 12px;}'
cHtml+='    </style>'
cHtml+='	<link href="http://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" type="text/css">'
cHtml+='    </head>'
cHtml+='<body bgcolor="#FFFFFF" 	style="font-size: 16px; margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF; color: #000000; font-family: Tahoma; text-shadow: 0px 0px #FFFFFF; border: #FFFFFF;" >'
cHtml+='<center>'
cHtml+='<div id="principal" style="margin: 20px auto; width: 1212px; padding: 15px; background-color: #FFF; border: #FFFFFF; border-top-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-color: #FFFFFF; font-size: 9px;">'

cHtml+='<table style="border-radius: 20px; background: #ececec;" cellpadding="0" cellspacing="0" width="95%"><tbody><tr align="center" valign="middle">'
cHtml+='<td style=" width: 25%;"><img style="width: 214px; height: 60px;" src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" alt="Logo Nc Games"></td>'
cHtml+='<td style="width: 75%; font-family: Baskerville, "Palatino Linotype", Palatino, "Century Schoolbook L", "Times New Roman", serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;">'
cHtml+='<p style="text-align: center; font-size: 36px; color: #FF952B;">Boleto Vencido</p></td></tr></tbody></table>'

cHtml+='<hr style="border:radius; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto">'

cHtml+='<table style="font-family: Tahoma; font-size: 10px;" cellpadding="4" cellspacing="1" align="center" border="0" width="95%">'
cHtml+='<tbody>'
cHtml+='<tr>'
cHtml+='<th style="font-family:"Roboto"; font-size: 14px; font-weight: bold; color: #000;" bgcolor="#FFFFFF"><div align="left">Aten็ใo Prezados</div></th></tr><tr>'
cHtml+='<td bgcolor="#FFFFFF"><p><font style="font-family:"Roboto";" size="2">O Pedido '+cNumPed+' com o tipo de pagamento Boleto bancario venceu em '+DtoS(dData)+', favor verificar com cliente real interesse e realizar os procedimentos de acordo com a solicita็ใo do cliente.</font></p></td>'
cHtml+='</tr>'
cHtml+='</tbody></table>'
cHtml+='&nbsp;'
cHtml+='<style text="css/javascript">'
cHtml+='	.caixa{font-family:Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#FFF;background: #3399ff;padding: 12px 0px;}'
cHtml+='	.caixa2{background: #efefef;}'
cHtml+='</style>'
cHtml+='<table style="font-family: Arial, Helvetica, sans-serif; font-size:10px; width: 95%; border: 0px solid transparent; text-align: center;" cellpadding="4" cellspacing="2">'
cHtml+='	<tbody><tr>'
cHtml+='		<th style="font-family:Arial, Helvetica, sans-serif; font-size:16px; font-weight:bold; color:#FFF; background: #3399ff; border-radius: 25px 25px 0px 0px;" colspan="4">'
cHtml+='			Dados do Cliente'
cHtml+='		</th>'
cHtml+='	</tr>'
cHtml+='	<tr>'
cHtml+='		<td class="caixa" style="width: 20%;"><div>Codigo/Loja</div></td>'
cHtml+='		<td class="caixa" style="width: 30%;"><div>Nome Fantasia</div></td>'
cHtml+='		<td class="caixa" style="width: 30%"><div>Email</div></td>'
cHtml+='		<td class="caixa" style="width: 20%"><div>Telefone</div></td>'
cHtml+='	</tr>'
cHtml+='	<tr class="Grid">'
cHtml+='		<td class="caixa2" style="border-radius: 0 0 0 25px;"><div class="grid">'+cCodLoja+'</div></td>'
cHtml+='		<td class="caixa2"><div class="grid">'+cNome+'</div></td>'
cHtml+='		<td class="caixa2"><div class="grid">'+cEmailCli+'</div></td>'
cHtml+='		<td class="caixa2" style="border-radius: 0 0 25px 0;"><div class="grid">'+cTelCli+'</div></td>'
cHtml+='	</tr>'

cHtml+='</tbody></table><br>'
cHtml+='     <style text="css/javascript">'
cHtml+='	 .box1{background: #3399ff;font-family:Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#FFF;padding: 12px;}'
cHtml+='	 .box2{background: #efefef;}'
cHtml+='</style>'
cHtml+='<table style="width: 70%; text-align: center;" border="0">'
cHtml+='	<tbody><tr>'
cHtml+='		<th style="background: #3399ff; border-radius: 25px 25px 0 0;" colspan="4">'
cHtml+='		<div><span style="font-family:Arial, Helvetica, sans-serif; font-size:16px; font-weight:bold; color:#FFF;">Dados do Pedido</span></div></th>'
cHtml+='	</tr>'
cHtml+='	<tr>'
cHtml+='		<td style="width: 25%;" class="box1"><div>Pedido Ciashop</div></td>'
cHtml+='		<td style="width: 25%;" class="box1"><div>Pedido<div></td>'
cHtml+='		<td style="width: 25%;" class="box1"><div>Valor do pedido</div></td>'
cHtml+='		<td style="width: 25%;" class="box1"><div>Data de Vencimento</div></td>'
cHtml+='	</tr>'
cHtml+='	<tr>'
cHtml+='		<td class="box2" style="border-radius: 0 0 0 25px;"><div class="grid">'+cNumCia+'</div></td>'
cHtml+='		<td class="box2"><div class="grid">'+cNumPed+'</div></td>'
cHtml+='		<td class="box2"><div class="grid">'+nValorTotal+'</div></td>'
cHtml+='		<td class="box2" style="border-radius: 0 0 25px 0;"><div class="grid">'+dDtVencto+'</div></td></tr>'

cHtml+='</tbody></table><p>&nbsp;</p><p>&nbsp;</p>'
cHtml+='<table bordercolorlight="#006600" bordercolordark="#006600" border="0" bordercolor="#006600" height="62" width="100%">'
cHtml+='<tbody><tr><td height="52" width="100%">'
cHtml+='<table style="font-family:"Roboto"; font-size:11px;" align="center" border="0" width="95%"><tbody><tr>'
cHtml+='<td><p>Workflow informativo enviado por rotinas automaticas.  </p>'
cHtml+='</td></tr></tbody></table></td></tr></tbody></table>'
cHtml+='table width="100%"><tbody><tr>'
cHtml+='<td style="font-family:"Roboto"; font-size: 11px; color: #000;" align="center" height="30"> WORKFLOW PROTHEUS</td></tr>'
cHtml+='</tbody></table></div></center></body></html>'


Return cHtml


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTMD  บAutor  ณMicrosiga           บ Data ณ  02/20/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP      	                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ECOMHTMD(aTitBx, cDtBaixa)
Local cHtml:=''
Local cCor
Local nX		:= 0

Default aTitBx		:= {}
Default cDtBaixa  := ""

cHtml+='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtml+='<html xmlns="http://www.w3.org/1999/xhtml">
cHtml+='<head>
cHtml+='<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
cHtml+='<title>Mensageiro E-Commerce</title>

cHtml+='</head>

cHtml+='<!-- CONTEUDO DA PAGINA -->
cHtml+='<!-- <body bgcolor="#FFFFFF" 	style="margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF; color: #000000; font-family: Tahoma; text-shadow: 0px 0px #FFFFFF; border: #FFFFFF; background-image: url(/imagens/fundo.png);" >-->


cHtml+='<center>
cHtml+='<!-- ABERTURA DA DIV PRINCIPAL -->
cHtml+='<!-- <div id="principal" style="margin: 20px auto; width: 1212px; padding: 15px; background-color: #FFF; border: #FFFFFF; border-top-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-color: #FFFFFF;" >-->

cHtml+='<!-- INICIO DO FORMULมRIO -->


cHtml+='<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="33%" height="39" align="left" valign="top">
cHtml+='<img src="http://www.ncgames.com.br/public/img/logo/home-logo.png" width="315" height="104" alt="Logo Nc Games" />	</td>
cHtml+='<td height="39" valign="middle" style="font-family: Baskerville, '+Chr(39)+'Palatino Linotype'+Chr(39)+', Palatino, '+Chr(39)+'Century Schoolbook L'+Chr(39)+', '+Chr(39)+'Times New Roman'+Chr(39)+', serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;" >
cHtml+='<p style="text-align: center">Concilia็ใo de tํtulo(s) E-commerce x MOIP</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<!-- TABELA CABEวALHO -->

cHtml+='<hr style="border:none; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto"/>

cHtml+='<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style="font-family: Tahoma; font-size: 10px;">
cHtml+='<tr>
cHtml+='<th colspan="2" bgcolor="#efefef" style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #000;"><div align="center">Tํtulos a serem baixados ap๓s a concilia็ใo com o Moip.</div></th> '
cHtml+='</tr>

cHtml+='</table>

cHtml+='&nbsp;<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style=" font-family:Arial, Helvetica, sans-serif; font-size:10px; ">

cHtml+='<tr>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Pv.Site</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Pv.Proth.</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Prefixo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Tํtulo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Parcela</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Tipo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Valor</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Saldo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Dt.Vencto.</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Dt.Baixa</th>
cHtml+='</tr>

cCor:="#efefef"

For nX := 1 To Len(aTitBx)
	cHtml+='<tr>
	cHtml+='<td bgcolor='+cCor+' width="70"><font size="1"  face="Arial">'+aTitBx[nX][1]+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="70"><font size="1"  face="Arial">'+aTitBx[nX][2]+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="51"><font size="1">'+aTitBx[nX][3]+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="70"><font size="1"  face="Arial">'+aTitBx[nX][4]+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="20"><font size="1" face="Arial">'+aTitBx[nX][5]+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="40">'+aTitBx[nX][6]+'</td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1">'+aTitBx[nX][7]+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1" face="Arial">'+aTitBx[nX][8]+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="80"><font size="1" face="Arial">'+aTitBx[nX][9]+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="80"><font size="1" face="Arial">'+aTitBx[nX][10]+'</font></td>
	cHtml+='</tr>
Next



cHtml+='</table>
cHtml+='<p>&nbsp;</p>
cHtml+='<table width="100%" height="62" border="0" bordercolor="#006600" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="100%" height="52">
cHtml+='<table width="95%" border="0" align="center" style="
cHtml+='font-family:Arial, Helvetica, sans-serif;
cHtml+='font-size:11px; ">
cHtml+='<tr>
cHtml+='<td><p>E-mail informativo enviado por rotinas automaticas.  </p>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<table width="100%" border="0" id="tbrodape">
cHtml+='<tr>
cHtml+='<td height="30" align="center" style=" font-family: Verdana, Geneva, sans-serif;
cHtml+='font-size: 11px;
cHtml+='color: #000; "> WORKFLOW PROTHEUS</td>
cHtml+='</tr>
cHtml+='</table></td>
cHtml+='</tr>
cHtml+='</table>


cHtml+='<!-- </form>-->
cHtml+='<!--                  </div>-->
cHtml+='</center>
cHtml+='</body>
cHtml+='</html>

Return cHtml


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณMicrosiga           บ Data ณ  06/03/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function EHtmErro(cXml)

Local cServer  	:= GetNewPar("MV_RELSERV","")                                                
Local cAccount	:= GetNewPar("MV_RELACNT","")
Local cPassword	:= GetNewPar("MV_RELAPSW","")
Local lMailAuth	:= GetNewPar("MV_RELAUTH",.F.)

Local cErro		:= ""
Local cAssunto	:= "Erro importa็ใo de Arquivo"
Local cEmailTo	:= "helpdesk@ncgames.com.br;lfelipe@ncgames.com.br"
Local cBody		:= ""
Local aAnexos	:= {}
Local lRetorno	:= .T.

Local cPath		:= AllTrim(GetSrvProfString("Startpath",""))  
local cFile		:= cPath+"ArqErrorEcom.txt" 
Local nH 

nH := fCreate(cFile)

iif(valtype(cXml) == "U" , cXml := " " , cXml := cXml)

fWrite(nH,cXml)
fClose(nH) 

aAnexos:= {cFile}

cBody := '<html xmlns="http://www.w3.org/1999/xhtml">'
cBody += '<head>'                                      
cBody += '<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
cBody += '<title>Documento sem tรญtulo</title>
cBody += '</head>
cBody += '<body>
cBody += '<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">
cBody += '  <tr>
cBody += '	  <td width="33%" height="39" align="left" valign="top"><img src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" alt="Logo Nc Games" width="214" height="60" align="middle" /></td>
cBody += '    <td height="39" valign="middle" style="font-family: Trebuchet MS, Arial, Helvetica, sans-serif; font-size: 30px; color: #FF952B; text-transform: uppercase; text-align: left;" ><div style="text-align: center">erro imp cliente</div></td>
cBody += '</tr></table>
cBody += '<hr style="border:none; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto"/>
cBody += '<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">
cBody += '  <tr>
cBody += '    <td height="39" align="left" valign="top"><p>Houve um erro no momento da importaรงรฃo dos clientes do Ecommerce, favor verificar o anexo</p></td>
cBody += '  </tr></table></body></html>

If !Empty(cEmailTo) .And. !Empty(cAssunto) .And. !Empty(cBody)
	If MailSmtpOn( cServer, cAccount, cPassword )
		If lMailAuth
			If ! ( lRetorno := MailAuth(cAccount,cPassword) )
				lRetorno := MailAuth(SubStr(cAccount,1,At("@",cAccount)-1),cPassword)
			EndIf
		Endif
		If lRetorno
			If !MailSend(cAccount,{cEmailTo},{},{},cAssunto,cBody,aAnexos,.F.)
				cErro := "Erro na tentativa de e-mail para " + cEmailTo + ". " + Mailgeterr()
				lRetorno := .F.
			EndIf
		Else
			cErro := "Erro na tentativa de autentica็ใo da conta " + cAccount + ". "
			lRetorno := .F.
		EndIf
		MailSmtpOff()
	Else
		cErro := "Erro na tentativa de conexใo com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
		lRetorno := .F.
	EndIf
Endif
      
FErase(cFile)

Return(lRetorno)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณLucas Oliveira      บ Data ณ  04/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EHtmSend(cFrom,cPara,cAssunto,cBody)

Local cUser := GetNewPar("MV_RELACNT","")
Local cPass := GetNewPar("MV_RELAPSW","")
Local cSendSrv := GetNewPar("MV_RELSERV","")
Local lMailAuth := GetNewPar("MV_RELAUTH",.F.) 
Local nSmtpPort := GetNewPar("MV_GCPPORT","")
Local nPopPort
Local lSSL	:= SuperGetMv("MV_RELSSL",.F.)
Local lTLS	:= SuperGetMv("MV_RELTLS",.F.)

Local xRet 
Local oServer, oMessage

Default cFrom := "Workflow@ncgames.com.br"
Default cPara := "lfelipe@ncgames.com.br"
Default cAssunto := "Teste"
Default cBody := "Teste"

If At(":",cSendSrv) > 0
	cSendSrv := SubStr(cSendSrv,1,At(":",cSendSrv)-1)
EndIf

oServer := TMailManager():New()
oServer:SetUseSSL( lSSL ) //ADD 26/05/2015 -- configura็ใo de gmail
oServer:SetUseTLS( lTLS ) //ADD 23/06/2016 -- configura็ใo de gmail
oServer:Init( "", cSendSrv, cUser, cPass,/*nPopPort*/,nSmtpPort)

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
// Adiciona um anexo, nesse caso a imagem esta no root
//oMessage:AttachFile( cStarFolder+cNameFile )

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


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTME  บAutor  ณLucas Oliveira      บ Data ณ  04/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Email de erro de cadastro de cliente                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function EcomHtmE(cPedVtex)

Local aAreaAtu	:= GetArea()
Local aAreaZA1	:= ZA1->(GetArea())
Local cHtml		:= ""
Local cBody		:= ""
Local cEmailTo	:= Alltrim(U_MyNewSX6("VT_000008","lfelipe@ncgames.com.br;rciambarella@ncgames.com.br","C","E-mail do responsav้l do PV Site B2C","","",.F. ))
Local cAssunto	:= "Oper็ใo B2C - Erro Cliente B2C"
Local cFrom 	:= "Workflow@ncgames.com.br" 
Local aAnexos	:= {}
Local aDados	:= {}
Local cEmailCc, cErro := ""

Local cPedido	:= ""
Local cNomecli	:= ""
Local cErro		:= ""
Local cOrigem	:= ""

ZA1->(DbSetOrder(1))
ZA1->(DbSeek(xFilial("ZA1")+cPedVtex)) 

aDados:=Separa(ZA1->ZA1_ERRO,CRLF)
For nInd:=1 To Len(aDados)
	If "INVALIDO"$Upper(aDados[nInd])
		cErro:=aDados[nInd]
		Exit
	EndIf	
Next

cPedido	:= ZA1->ZA1_PVVTEX
cNomecli	:= ZA1->ZA1_NOME
cOrigem	:= AllTrim(Posicione("ZC5",6,xFilial("ZC5")+cPedVtex,"ZC5_NOECOM"))

cHtml:='<!DOCTYPE html>'
cHtml+='<html lang="pt-br">'
cHtml+='<head>'
cHtml+='	<meta charset="UTF-8"/>'
cHtml+='	<style>'
cHtml+='		body{width: 100%;height: 100%;background: #ffffff;}'
cHtml+='		div#interface {width: 95%;border: 20px;border-radius: 14px;padding: 20px;background: #ffffff;vertical-align: center;}'
cHtml+='		nav#cabec .tab1{width: 90%;padding: 30px;text-align: center;text-transform: uppercase;font-family: Segoe Ui, Tahoma;font-size: 30px;}'
cHtml+='		table, thead, th, tbody, td{ border: none;}'
cHtml+='		div#corpo {text-align: center;width: 95%;height: 100%;}'
cHtml+='		div#corpo p{font-family: Calibri Light;	font-size: 19px;}'
cHtml+='		div#corpo1 {text-align: center;	width: 95%;	height: 100%;overflow-x: auto;}'
cHtml+='		.tab2{	width: 100%;font-family: arial;vertical-align: center;	}'
cHtml+='		.tab2 thead th{	background: #ebebeb;text-transform: uppercase;	font-size: 14px;padding: 4px 5px 4px 5px;}'
cHtml+='		.tab2 td{font-size: 14px;}'
cHtml+='		.tab2 table, .tab2 thead, .tab2 th, .tab2 tbody, .tab2 td{ border: solid 1px #d1d1d1;}'
cHtml+='		.tab2 {border-collapse: collapse;}'
cHtml+='		div#rodape {width: 90%;text-align: right; }	'
cHtml+='		div#rodape p{font-family: Calibri Light;font-size: 10px;}'
cHtml+='	</style>'
cHtml+='	<title>Erro Cadastro de Cliente</title>'
cHtml+='</head>'
cHtml+='	<body>'
cHtml+='		<div id="interface" style="width: 95%;border: 20px;border-radius: 14px;padding: 20px;background: #ffffff;vertical-align: center;">'
cHtml+='			<nav id="cabec">'
cHtml+='					<table class="tab1" style="width: 90%;padding: 30px;">'
cHtml+='						<tr>'
cHtml+='							<td><img src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" alt="Logo Nc Games" width="215" height="60"></td>'
cHtml+='							<td style="text-align: center;text-transform: uppercase;font-family: Segoe Ui, Tahoma;font-size: 30px;">Erro Cadastro de Cliente</td>'
cHtml+='                        </tr>'
cHtml+='					</table>'
cHtml+='			</nav>'
cHtml+='			<hr style="border:none; border-top: 1px solid #dfdfdf;  width: 99%; margin: 30px auto">'
cHtml+='			<div id="corpo">'
cHtml+='			</br>'
cHtml+='			<p>Foi encontrado um erro ao tentar ao tentar cadastrar o cliente abaixo, necessario realizar a manuten็ใo do mesmo na tela de cadastro de'
cHtml+='			cliente ecommerce, para que o pedido possa ser importado.</p>'
cHtml+='			</br>'
cHtml+='			</div>'
cHtml+='			<div id="corpo1">'
cHtml+='				<table class="tab2">'
cHtml+='					<thead>'
cHtml+='						<tr>'
cHtml+='							<th>Pedido</th>	'
cHtml+='							<th>Nome Cliente</th>'
cHtml+='							<th>Erro</th>'
cHtml+='							<th>Origem</th>'
cHtml+='						</tr>'
cHtml+='					</thead>'
cHtml+='					<tbody>'
cHtml+='						<tr>'
cHtml+='							<td width="15%">'+ cPedido +'</td>'
cHtml+='							<td width="25%">'+ cNomecli +'</td>'
cHtml+='							<td width="35%">'+ cErro +'</td>'
cHtml+='							<td width="25%">'+ cOrigem +'</td>'
cHtml+='						</tr>'
cHtml+='					</tbody>'
cHtml+='				</table>'
cHtml+='			</div>'
cHtml+='			<br><br/>'
cHtml+='			<div id="rodape">'
cHtml+='				<p>E-mail gerado automaticamente pelo Protheus</p>'
cHtml+='			</div>'
cHtml+='			</form>'
cHtml+='		</div>'
cHtml+='	</body>'
cHtml+='</html>' 

cBody:= cHtml

EHtmSend(cFrom,cEmailTo,cAssunto,cBody)
u_COM08SEND(cAssunto, cBody, aAnexos, cEmailTo, cEmailCc, cErro)

RestArea(aAreaZA1)
RestArea(aAreaAtu)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณMicrosiga           บ Data ณ  04/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function EcoHtmE(cPedVtex)

Local aAreaAtu	:= GetArea()
Local aAreaZC6	:= ZC6->(GetArea())
Local cHtml		:= ""
Local cBody		:= ""
Local cPara		:= Alltrim(U_MyNewSX6("VT_000008","lfelipe@ncgames.com.br;rciambarella@ncgames.com.br","C","E-mail do responsav้l do PV Site B2C","","",.F. ))
Local cAssunto	:= "Oper็ใo B2C - Erro de Produto nใo encontrado"
Local cFrom 	:= "Workflow@ncgames.com.br"
Local aAnexos	:= {}
Local cEmailCc, cErro := ""

Local cPedido	:= ""



cHtml:='<!DOCTYPE html>'
cHtml+='<html lang="pt-br">'
cHtml+='<head>'
cHtml+='	<meta charset="UTF-8"/>'
cHtml+='	<style>'
cHtml+='		body{width: 100%;height: 100%;background: #ffffff;}'
cHtml+='		div#interface {width: 95%;border: 20px;border-radius: 14px;padding: 20px;background: #ffffff;vertical-align: center;}'
cHtml+='		nav#cabec .tab1{width: 90%;padding: 30px;text-align: center;text-transform: uppercase;font-family: Segoe Ui, Tahoma;font-size: 30px;		}'
cHtml+='		table, thead, th, tbody, td{ border: none;}'
cHtml+='		div#corpo {text-align: center;width: 95%;height: 100%;}'
cHtml+='		div#corpo p{font-family: Calibri Light;	font-size: 19px;}'
cHtml+='		div#corpo1 {text-align: center;	width: 95%;	height: 100%;overflow-x: auto;}'
cHtml+='		.tab2{	width: 100%;font-family: arial;vertical-align: center;	}'
cHtml+='		.tab2 thead th{	background: #ebebeb;text-transform: uppercase;	font-size: 14px;padding: 4px 5px 4px 5px;}'
cHtml+='		.tab2 td{font-size: 14px;}'
cHtml+='		.tab2 table, .tab2 thead, .tab2 th, .tab2 tbody, .tab2 td{ border: solid 1px #d1d1d1;}'
cHtml+='		.tab2 {border-collapse: collapse;}'
cHtml+='		div#rodape {width: 90%;text-align: right; }		'
cHtml+='		div#rodape p{font-family: Calibri Light;font-size: 10px;}'
cHtml+='	</style>'
cHtml+='	<title>Produto nใo encontrado</title>'
cHtml+='</head>'
cHtml+='	<body>'
cHtml+='		<div id="interface" style="width: 95%;border: 20px;border-radius: 14px;padding: 20px;background: #ffffff;vertical-align: center;">'
cHtml+='			<nav id="cabec">'
cHtml+='					<table class="tab1" style="width: 90%;padding: 30px;text-align: center;text-transform: uppercase;font-family: Segoe Ui, Tahoma;font-size: 30px;">'
cHtml+='						<tr>'
cHtml+='							<td><img src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" alt="Logo Nc Games" width="215" height="60"></td>'
cHtml+='							<td>Produto nใo Encontrado</td>'
cHtml+='                        </tr>'
cHtml+='					</table>'
cHtml+='			</nav>'
cHtml+='			<hr style="border:none; border-top: 1px solid #dfdfdf;  width: 99%; margin: 30px auto">'
cHtml+='			<div id="corpo">'
cHtml+='			</br>'
cHtml+='			<p>O(s) Produto(s) listado(s) nใo foi (foram) encontrado(s) na tabela de “amarra็ใo de c๓digos”.'
cHtml+='				Favor analisar o cadastro do produto na loja, e na sequ๊ncia completar o cadastro da na tabela' 
cHtml+='				de “amarra็ใo de c๓digos”. E depois reprocessar a importa็ใo do pedido de venda.'
cHtml+='			</p>'
cHtml+='			</br>'
cHtml+='			</div>'
cHtml+='			<div id="corpo1">'
cHtml+='				<table class="tab2">'
cHtml+='					<thead>'
cHtml+='						<tr>'
cHtml+='							<th>Pedido</th>	'
cHtml+='							<th>ProdutId</th>'
cHtml+='							<th>Ean</th>'
cHtml+='							<th>Erro</th>'
cHtml+='							<th>Quantidade</th>'
cHtml+='						</tr>'
cHtml+='					</thead>'
cHtml+='					<tbody>'   

ZC6->(DbSetOrder(3))
ZC6->(DbSeek(xFilial("ZC6")+cPedVtex))

Do While ZC6->(!EoF()) .And. ZC6->ZC6_FILIAL+Alltrim(ZC6->ZC6_PVVTEX) == xFilial("ZC6")+Alltrim(cPedVtex)

cPedido := ZC6->ZC6_DESCRI

	cHtml+='						<tr>'
	cHtml+='							<td width="20%">'+ cPedVtex +'</td>'
	cHtml+='							<td width="20%">'+ ZC6->ZC6_IDPROD +'</td>'
	cHtml+='							<td width="20%">'+ ZC6->ZC6_EAN +'</td>'
	cHtml+='							<td width="25%">'+ ZC7->ZC7_OBS +'</td>'
	cHtml+='							<td width="15%">'+ Transform(ZC6->ZC6_QTDVEN,"@E 999,999") +'</td>'  
	cHtml+='						</tr>' 
	
	ZC6->(DbSkip())     
	
EndDo  

cHtml+='					</tbody>'
cHtml+='				</table>'
cHtml+='			</div>'
cHtml+='			<br><br/>'
cHtml+='			<div id="rodape">'
cHtml+='				<p>E-mail gerado automaticamente pelo Protheus</p>'
cHtml+='			</div>'
cHtml+='			</form>'
cHtml+='		</div>'
cHtml+='	</body>'
cHtml+='</html>'

cBody:= cHtml

EHtmSend(cFrom,cPara,cAssunto,cBody)
u_COM08SEND(cAssunto, cBody, aAnexos, cPara, cEmailCc, cErro)


RestArea(aAreaZC6)
RestArea(aAreaAtu)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTF   บAutor  ณMicrosiga           บ Data ณ  04/27/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Email de estoque insuficiente opera็ใo B2C                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function EcomHtmF(aRecZC6)

Local cHtml			:= ''
Local cPictQuantid:= Avsx3("ZC6_QTDVEN",6)
Local cPictVlrUnit:= "@E 99,999,999.99"
Local cPictVlrTota:= "@E 999,999,999.99"
Local cPictQuantid:= "@E 999999999"
Local cPerLiq		:= "@E 9999.99"
Local aCombo   	:= RetSx3Box( Posicione("SX3", 2, "C6_YSTPCMV","X3CBox()" ),,,1)
Local cCor

Local cTeste	:= Posicione("ZX5",1,xFilial("ZX5")+"00002"+ZC5->ZC5_TPPGTO,"ZX5_DESCRI")

cHtml+='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtml+='<html xmlns="http://www.w3.org/1999/xhtml">
cHtml+='<head>
cHtml+='<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
cHtml+='<title>Operca็ใo B2C - Estoque Insuficiente</title>
cHtml+='</head>
cHtml+='<!-- <body bgcolor="#FFFFFF" 	style="margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF; color: #000000; font-family: Tahoma; text-shadow: 0px 0px #FFFFFF; border: #FFFFFF; background-image: url(/imagens/fundo.png);" >-->
cHtml+='<center>
cHtml+='<!-- <div id="principal" style="margin: 20px auto; width: 1212px; padding: 15px; background-color: #FFF; border: #FFFFFF; border-top-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-color: #FFFFFF;" >-->
cHtml+='<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="33%" height="39" align="left" valign="top">
cHtml+='<img src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" width="315" height="104" alt="Logo Nc Games" />	</td>
cHtml+='<td height="39" valign="middle" style="font-family: Baskerville, '+Chr(39)+'Palatino Linotype'+Chr(39)+', Palatino, '+Chr(39)+'Century Schoolbook L'+Chr(39)+', '+Chr(39)+'Times New Roman'+Chr(39)+', serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;" >
cHtml+='<p style="text-align: center">Estoque Insuficiente B2C</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<hr style="border:none; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto"/> 

SA1->(DbSetOrder(1))
SA1->(DbSeek(xFilial("SA1")+ZC5->(ZC5_CLIENT+ZC5_LOJA)))

cHtml+='<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style="font-family: Tahoma; font-size: 10px;">
cHtml+='	<tr>
cHtml+='		<th colspan="4" bgcolor="#efefef" style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #000;"><div align="left">Prezados </div></th>
cHtml+='	</tr>
cHtml+='	<tr>
cHtml+='		<td bgcolor="#efefef" width="25%">
cHtml+='   			<p><font size="2" face="Arial">Cliente protheus:'+ZC5->ZC5_CLIENT+'/'+ZC5->ZC5_LOJA+' : '+SA1->A1_NOME +' </font></p>
cHtml+='   		</td>
cHtml+='   		<td bgcolor="#efefef" width="30%">
cHtml+='			<p><font size="2" face="Arial">Endere็o: '+SA1->(AllTrim(A1_END)+' - '+AllTrim(A1_BAIRRO)+' - '+AllTrim(A1_MUN)+' - '+A1_EST+' CEP:'+A1_CEP)+' </font></p>
cHtml+='		</td>
cHtml+='		<td bgcolor="#efefef" width="20%">
cHtml+='   			<p><font size="2" face="Arial">Telefone:('+SA1->A1_DDD+')'+SA1->A1_TEL+' </font></p> 
cHtml+='   			<p><font size="2" face="Arial">Forma de Pagamento:'+ZC5->ZC5_COND+"-"+Alltrim(cTeste)+'</font></p>
cHtml+='		</td>     
cHtml+='		<td bgcolor="#666666" width="15%">
cHtml+='			<p><span style="font-family: Arial; font-size: 13px; font-weight: bold; color: #FFF;">Pedido Site: '+AllTrim(ZC5->ZC5_PVVTEX)+'</span></p>
cHtml+='	 		<p><span style="font-family: Arial; font-size: 13px; font-weight: bold; color: #FFF;">Pedido Protheus: '+ZC5->ZC5_NUMPV+'</span></p>
cHtml+='		</td>
cHtml+='	</tr>
cHtml+='	<tr>
cHtml+='   		<td colspan="4" bgcolor="#efefef">
cHtml+='   			<p><font size="2" face="Arial"><b>Status Pedido:'+Alltrim(Posicione("SX5",1,xFilial("SX5")+"_Z"+ZC5->ZC5_STATUS,"X5_DESCRI"))+'</b></font></p>
cHtml+='   		</td>
cHtml+='	</tr>
cHtml+='</table>

cHtml+='&nbsp;<table width="95%" border="0" align="center" cellpadding="4" cellspacing="1" style=" font-family:Arial, Helvetica, sans-serif; font-size:10px; ">
cHtml+='<tr>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Item</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Nosso C&oacute;digo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;"><p>Descri&ccedil;&atilde;o do Produto</p></th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Qtd. Pedido</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Qtd. Reservada</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Saldo</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Custo uni.</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Tipo CM</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Mrg Liq (R$)</th>
cHtml+='<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Mrg Liq (%)</th>
cHtml+='</tr>

For nInd:=1 To Len(aRecZC6)
	ZC6->(DbGoTo(aRecZC6[nInd]))
	
	cCor:="#efefef"
	If ZC6->(ZC6_QTDRES<>ZC6_QTDVEN)
		cCor:="#FFF788"
	EndIf
	
	cHtml+='<tr>
	cHtml+='<td bgcolor='+cCor+' width="51"><font size="1">'+ZC6->ZC6_ITEM+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1"  face="Arial">'+ZC6->ZC6_PRODUTO+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="315"><font size="1" face="Arial">'+Posicione("SB1",1,xFilial("SB1")+ZC6->ZC6_PRODUTO,"B1_XDESC")+'</font></td>
	cHtml+='<td bgcolor='+cCor+' width="98">'+TransForm(ZC6->ZC6_QTDVEN,cPictQuantid)+'</td>
	cHtml+='<td bgcolor='+cCor+' width="94"><font size="1">'+TransForm(ZC6->ZC6_QTDRES,cPictQuantid)+'</font> </td>
	cHtml+='<td bgcolor='+cCor+' width="85"><font size="1" face="Arial">'+TransForm(ZC6->(ZC6_QTDRES-ZC6_QTDVEN),cPictQuantid)+'</font></td>
	
	If SC6->( DbSeek(xFilial("SC6")+SC5->C5_NUM+ZC6->(ZC6_ITEM+ZC6_PRODUTO)   ) )
		cHtml+='<td bgcolor='+cCor+' width="84"><font size="1" face="Arial">'+TransForm(SC6->C6_YCMVUNI,cPictQuantid)+'</font></td>
		cHtml+='<td bgcolor='+cCor+' width="61"><font size="1" face="Arial">'+aCombo[Ascan(aCombo,{|a| a[2]==SC6->C6_YSTPCMV} ),3]+'</font></td>
		cHtml+='<td bgcolor='+cCor+' width="69"><font size="1">'+TransForm(SC6->C6_YMKPLIQ,cPictVlrUnit )+'</font></td>
		cHtml+='<td bgcolor='+cCor+' width="81"><font size="1">'+TransForm(SC6->C6_YPERLIQ,cPerLiq   )+'</font></td>
	Else
		cHtml+='<td bgcolor='+cCor+' width="84"><font size="1" face="Arial">0</font></td>
		cHtml+='<td bgcolor='+cCor+' width="61"><font size="1" face="Arial"></font></td>
		cHtml+='<td bgcolor='+cCor+' width="69"><font size="1">0</font></td>
		cHtml+='<td bgcolor='+cCor+' width="81"><font size="1">0</font></td>
	EndIf
	cHtml+='</tr>
Next



cHtml+='</table>
cHtml+='<p>&nbsp;</p>
cHtml+='<table width="100%" height="62" border="0" bordercolor="#006600" bordercolorlight="#006600" bordercolordark="#006600">
cHtml+='<tr>
cHtml+='<td width="100%" height="52">
cHtml+='<table width="95%" border="0" align="center" style="
cHtml+='font-family:Arial, Helvetica, sans-serif;
cHtml+='font-size:11px; ">
cHtml+='<tr>
cHtml+='<td><p>E-mail informativo enviado por rotinas automaticas.  </p>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='</td>
cHtml+='</tr>
cHtml+='</table>
cHtml+='<table width="100%" border="0" id="tbrodape">
cHtml+='<tr>
cHtml+='<td height="30" align="center" style=" font-family: Verdana, Geneva, sans-serif;
cHtml+='font-size: 11px;
cHtml+='color: #000; "> WORKFLOW PROTHEUS - Opera็ใo B2C</td>
cHtml+='</tr>
cHtml+='</table></td>
cHtml+='</tr>
cHtml+='</table>


cHtml+='<!-- </form>-->
cHtml+='<!--                  </div>-->
cHtml+='</center>
cHtml+='</body>
cHtml+='</html>

Return cHtml


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTM   บAutor  ณMicrosiga           บ Data ณ  04/28/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ECOMHTMG(nRecZC5)
Local cHtml			:= ""

Local cAliasZC5	:= ZC5->(GetArea())
Local cAliasSA1	:= SA1->(GetArea())

ZC5->(DbGoto(nRecZC5))
SA1->(MsSeek(xFilial("SA1")+ZC5->ZC5_CLIENT+ZC5->ZC5_LOJA))
cHtml := ''
cHtml += '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtml += '<html xmlns="http://www.w3.org/1999/xhtml">    
cHtml += '    <head>
cHtml += '        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"
cHtml += '        />
cHtml += '        <title>
cHtml += '            Mensageiro E-Commerce
cHtml += '        </title>
cHtml += '        <style type="text/css">
cHtml += '            body,td,th {color: #555;border-color: #FFFFFF;font-family: "Roboto", Verdana;}
cHtml += '            #principal form table tr td {font-size: 16px;} .grid {font-size: 14px;}
cHtml += '            p {} .Grid {font-size: 14px;} #principal table .Grid td {font-family: Tahoma,
cHtml += '            Geneva, sans-serif;} #principal table .Grid td {font-size: 12px;}
cHtml += '        </style>
cHtml += '        <link href="http://fonts.googleapis.com/css?family=Roboto" rel="stylesheet"
cHtml += '        type="text/css">
cHtml += '    </head>
cHtml += '    <body bgcolor="#FFFFFF" style="font-size: 16px; margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF; color: #000000; font-family: Tahoma; text-shadow: 0px 0px #FFFFFF; border: #FFFFFF;">
cHtml += '        <center>
cHtml += '            <div id="principal" style="margin: 20px auto; width: 90%; padding: 15px; background-color: #FFF; border: #FFFFFF; border-top-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-color: #FFFFFF; font-size: 9px;">
cHtml += '                <table style="border-radius: 20px; background: #ececec;" cellpadding="0" width: 90%'
cHtml += '                cellspacing="0" width="119%">
cHtml += '                    <tbody>
cHtml += '                        <tr align="center" valign="middle">
cHtml += '                            <td style=" width: 25%;">
cHtml += '                                <img style="width: 214px; height: 60px;" src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png"
cHtml += '                                alt="Logo Nc Games">
cHtml += '                            </td>
cHtml += '                            <td style="width: 75%; font-family: Baskerville, " Palatino Linotype
cHtml += '                            ", Palatino, "Century Schoolbook L ", "Times New Roman
cHtml += '                            ", serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;">
cHtml += '                                <p style="text-align: center; font-size: 36px; color: #FF952B;">
cHtml += '                                    Pedido e-commerce com forma de pagamento Boleto
cHtml += '                                </p>
cHtml += '                            </td>
cHtml += '                        </tr>
cHtml += '                    </tbody>
cHtml += '                </table>
cHtml += '                <hr style="border:radius; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto">
cHtml += '                <table style="font-family: Tahoma; font-size: 10px;" cellpadding="4" cellspacing="1"
cHtml += '                align="center" border="0" width="95%">
cHtml += '                    <tbody>
cHtml += '                        <tr>
cHtml += '                            <th style="font-family:" Roboto
cHtml += '                            "; font-size: 14px; font-weight: bold; color: #000;" bgcolor="#FFFFFF"></th>
cHtml += '                        </tr>
cHtml += '                        <tr>
cHtml += '                            <td bgcolor="#FFFFFF">
cHtml += '                                &nbsp;</td>
cHtml += '                        </tr>
cHtml += '                    </tbody>
cHtml += '                </table>
cHtml += '                &nbsp;
cHtml += '                <style text="css/javascript">
cHtml += '                    .caixa{font-family:Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#FFF;background:
cHtml += '                    #3399ff;padding: 12px 0px;} .caixa2{background: #efefef;}
cHtml += '                </style>
cHtml += '                <table style="font-family: Arial, Helvetica, sans-serif; font-size:10px; width: 95%; border: 0px solid transparent; text-align: center;"
cHtml += '                cellpadding="4" cellspacing="2">
cHtml += '                    <tbody>
cHtml += '                        <tr>
cHtml += '                            <th style="font-family:Arial, Helvetica, sans-serif; font-size:16px; font-weight:bold; color:#FFF; background: #3399ff; border-radius: 25px 25px 0px 0px;"
cHtml += '                            colspan="4">
cHtml += '                                Dados do Cliente
cHtml += '                            </th>
cHtml += '                        </tr>
cHtml += '                        <tr>
cHtml += '                            <td class="caixa" style="width: 20%;">
cHtml += '                                <div>
cHtml += '                                    Codigo/Loja
cHtml += '                                </div>
cHtml += '                            </td>
cHtml += '                            <td class="caixa" style="width: 30%;">
cHtml += '                                <div>
cHtml += '                                    Nome Fantasia
cHtml += '                                </div>
cHtml += '                            </td>
cHtml += '                            <td class="caixa" style="width: 30%">
cHtml += '                                <div>
cHtml += '                                    CPF
cHtml += '                                </div>
cHtml += '                            </td>
cHtml += '                            <td class="caixa" style="width: 20%">
cHtml += '                                <div>
cHtml += '                                    Telefone
cHtml += '                                </div>
cHtml += '                            </td>
cHtml += '                        </tr>
cHtml += '                        <tr class="Grid">
cHtml += '                            <td class="caixa2" style="border-radius: 0 0 0 25px;">
cHtml += '                                <div class="grid">'+ZC5->ZC5_CLIENT +'/'+ZC5->ZC5_LOJA
cHtml += '                                </div>
cHtml += '                            </td>
cHtml += '                            <td class="caixa2">
cHtml += '                                <div class="grid">'+SA1->A1_NREDUZ
cHtml += '                                </div>
cHtml += '                            </td>
cHtml += '                            <td class="caixa2">
cHtml += '                                <div class="grid">'+TransForm(SA1->A1_CGC,"@R 999.999.999-99")
cHtml += '                                </div>
cHtml += '                            </td>
cHtml += '                            <td class="caixa2" style="border-radius: 0 0 25px 0;">
cHtml += '                                <div class="grid">'+SA1->A1_DDD +' '+ SA1->A1_TEL
cHtml += '                                </div>
cHtml += '                            </td>
cHtml += '                        </tr>
cHtml += '                    </tbody>
cHtml += '                </table>
cHtml += '                <br>
cHtml += '                <style text="css/javascript">
cHtml += '                    .box1{background: #3399ff;font-family:Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#FFF;padding:
cHtml += '                    12px;} .box2{background: #efefef;}
cHtml += '                </style>
cHtml += '                <table style="width: 70%; text-align: center;" border="0">
cHtml += '                    <tbody>
cHtml += '                        <tr>
cHtml += '                            <th style="background: #3399ff; border-radius: 25px 25px 0 0;" colspan="5">
cHtml += '                                <div>
cHtml += '                                    <span style="font-family:Arial, Helvetica, sans-serif; font-size:16px; font-weight:bold; color:#FFF;">
cHtml += '                                        Dados do Pedido
cHtml += '                                    </span>
cHtml += '                                </div>
cHtml += '                            </th>
cHtml += '                        </tr>
cHtml += '                        <tr>
cHtml += '                            <td style="width: 20%;" class="box1">
cHtml += '                                Loja</td>
cHtml += '                            <td style="width: 20%;" class="box1">
cHtml += '                                <div>
cHtml += '                                    Pedido Site
cHtml += '                                    <div>
cHtml += '                            </td>
cHtml += '                            <td style="width: 20%;" class="box1">
cHtml += '                                <div>
cHtml += '                                    Pedido Protheus
cHtml += '                                    <div>
cHtml += '                            </td>
cHtml += '                            <td style="width: 20%;" class="box1">
cHtml += '                                <div>
cHtml += '                                    Emissใo</div>
cHtml += '                            </td>
cHtml += '                            <td style="width: 20%;" class="box1">
cHtml += '                                <div>
cHtml += '                                    Valor do pedido
cHtml += '                                </div>
cHtml += '                            </td>
cHtml += '                        </tr>
cHtml += '                        <tr>
cHtml += '                            <td class="box2">
cHtml += '                            <div class="grid">'+Posicione("SA1",1,xFilial("SA1")+"000000"+ZC5->ZC5_PLATAF,"A1_NOME")
cHtml += '                                </div>
cHtml += '                            </td>
cHtml += '                            <td class="box2">
cHtml += '                                <div class="grid">'+ZC5->ZC5_PVVTEX
cHtml += '                                </div>
cHtml += '                            </td>
cHtml += '                            <td class="box2">
cHtml += '                                <div class="grid">'+ZC5->ZC5_NUMPV
cHtml += '                                </div>
cHtml += '                            </td>
cHtml += '                            <td class="box2">
cHtml += '                                <div class="grid">'+dtoc(ZC5->ZC5_DTVTEX)
cHtml += '                                </div>
cHtml += '                            </td>
cHtml += '                            <td class="box2" style="border-radius: 0 0 25px 0;">
cHtml += '                                <div class="grid">'+TransForm(ZC5->ZC5_TOTAL,"@E 999,999,999.99")
cHtml += '                                </div>
cHtml += '                            </td>
cHtml += '                        </tr>
cHtml += '                    </tbody>
cHtml += '                </table>
cHtml += '                <p>
cHtml += '                    &nbsp;
cHtml += '                </p>
cHtml += '                <p>
cHtml += '                    &nbsp;
cHtml += '                </p>
cHtml += '                <table bordercolorlight="#006600" bordercolordark="#006600" border="0"
cHtml += '                bordercolor="#006600" height="62" width="100%">
cHtml += '                    <tbody>
cHtml += '                        <tr>
cHtml += '                            <td height="52" width="100%">
cHtml += '                                <table style="font-family:" Roboto "; font-size:11px;" align="center"
cHtml += '                                border="0" width="95%">
cHtml += '                                    <tbody>
cHtml += '                                        <tr>
cHtml += '                                            <td>
cHtml += '                                                <p>
cHtml += '                                                    Workflow informativo enviado por rotinas automaticas.
cHtml += '                                                </p>
cHtml += '                                            </td>
cHtml += '                                        </tr>
cHtml += '                                    </tbody>
cHtml += '                                </table>
cHtml += '                            </td>
cHtml += '                        </tr>
cHtml += '                    </tbody>
cHtml += '                </table>
cHtml += '                <table width="100%">
cHtml += '                <tbody>
cHtml += '                    <tr>
cHtml += '                        <td style="font-family:" Roboto "; font-size: 11px; color: #000;" align="center"
cHtml += '                        height="30">
cHtml += '                            WORKFLOW PROTHEUS
cHtml += '                        </td>
cHtml += '                    </tr>
cHtml += '                </tbody>
cHtml += '                </table>
cHtml += '                </div>
cHtml += '        </center>
cHtml += '    </body>
cHtml += '</html>


Return cHtml
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณECOMHTMI  บAutor  ณMicrosiga           บ Data ณ  04/18/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina que irแ informar a incluisใo de um pedido para o    บฑฑ
ฑฑบ          ณ protheus.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function ECOMHTMI(nRecZC5,lfin)

Local cHtml			:= ""

Local aAreaAtu		:= GetArea()
Local aAreaZC5		:= ZC5->(GetArea())
Local aAreaSA1		:= SA1->(GetArea())

Default lfin := .F.

If !Empty(nRecZC5)
	
	ZC5->(DbGoto(nRecZC5))
	
	SA1->(DbSetOrder(1))
	SA1->(MsSeek(xFilial("SA1")+ZC5->ZC5_CLIENT+ZC5->ZC5_LOJA))
	
	chtml += '<!DOCTYPE html>'
	chtml += '<html  lang="pt-br">'
	chtml += '    <head>'
	chtml += '        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>'
	chtml += '        <title>Mensageiro E-Commerce</title>'
	chtml += '        <style type="text/css">'
	chtml += '				body {font-size: 16px; margin: auto; padding: 0px; background-color: #FFF; color: #000000; font-family: Tahoma; width: 95%; }'
	chtml += '        	#head1 {margin: auto; width: 80%; padding: 15px; background-color: #FFF; border: #FFFFFF; font-size: 16px;}'
	chtml += '				#principal {margin: auto; width: 80%; padding: 15px; font-size: 14px; font-family: Tahoma;}'
	chtml += '				#rodape { margin: auto; width: 80%;}'
	chtml += '        </style>'
	chtml += '    </head>'
	chtml += '    <body bgcolor="#FFFFFF">'
	chtml += '        <div id="head1">'
	chtml += '            <table style="border-radius: 20px; background: #ececec;" cellpadding="0" cellspacing="0" width="100%">'
	chtml += '                <tr align="center" valign="middle">'
	chtml += '                    <td style="width: 25%;">'
	chtml += '						<img style="width: 214px; height: 60px; margin: auto;" src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" alt="Logo Nc Games">'
	chtml += '					</td>'
	chtml += '                    <td style="width: 75%; font-family: Baskerville,Palatino Linotype,Palatino,Century Schoolbook L;text-transform: uppercase; text-align: left;">'
	
	If !lfin
		chtml += '						<p style="text-align: center; font-size: 30px; color: #FF952B;">  Pedido '+ Str(ZC5->ZC5_NUM)+' </p>'
	Else
		chtml += '						<p style="text-align: center; font-size: 24px; color: #FF952B;"> Pedido em analํse de cr้dito '+ IIf(SA1->A1_YBLQFIN=="1","(Cliente c/Bloqueio financeiro)","") +' </p>'
	EndIf
	
	chtml += '					</td>'
	chtml += '                </tr>'
	chtml += '            </table>'
	chtml += '		</div>'
	chtml += '		<br/>'
	chtml += '		<hr style=" border-top: 1px solid #dfdfdf;  width: 80%; margin: auto">'
	chtml += '		<br/>'
	chtml += '		<div id="principal">'
	
	If !lfin
		chtml += '			<p> O pedido abaixo foi gravado no sistema da distribuidora, por้m estแ sujeito a analํse de cr้dito e analํse de estoque.</p>'
		chtml += '			<p> Durante o processo ้ possํvel acompanhar o tracking do pedido atrav้s do sistema da loja  .</p>'
	Else
		chtml += '			<p> O pedido abaixo foi liberado por vendas estแ aguardando a analํse de cr้dito.</p>'
	EndIf
	chtml += '			<br/>'
	
	cHtml += '         <table class="tb1" style="width:95%;border: 1px solid gray; border-radius: 5px; background: #ececec;">'
	cHtml += '            <tr>'
	cHtml += '               <th style="width:20%;border: 1px solid gray; background: #FFFFFF;">Pedido Loja</th>'
	cHtml += '               <th style="width:20%;border: 1px solid gray; background: #FFFFFF;">Pedido Protheus</th>'
	If !lfin
		cHtml += '               <th style="width:60%;border: 1px solid gray; background: #FFFFFF;">Cliente e Loja</th>'
	Else
		cHtml += '               <th style="width:40%;border: 1px solid gray; background: #FFFFFF;">Cliente e Loja</th>'
		cHtml += '               <th style="width:20%;border: 1px solid gray; background: #FFFFFF;">Bloq fin.</th>'
	EndIf
	cHtml += '            </tr>'
	cHtml += '            <tr>'
	cHtml += '               <td style="width:20%;border: 1px solid gray; background: #FFFFFF;" align="center">'+ Str(ZC5->ZC5_NUM)+'</td>'
	cHtml += '               <td style="width:20%;border: 1px solid gray; background: #FFFFFF;" align="center">'+ ZC5->ZC5_NUMPV +'</td>'
	If !lfin
		cHtml += '               <td style="width:60%;border: 1px solid gray; background: #FFFFFF;" align="left">'+ ZC5->ZC5_CLIENT + '-' + ZC5->ZC5_LOJA +' - '+ SA1->A1_NREDUZ +'</td>'
	else
		cHtml += '               <td style="width:40%;border: 1px solid gray; background: #FFFFFF;" align="left">'+ ZC5->ZC5_CLIENT + '-' + ZC5->ZC5_LOJA +' - '+ SA1->A1_NREDUZ +'</td>'
		cHtml += '               <td style="width:20%;border: 1px solid gray; background: #FFFFFF;" align="left">'+ IIf(SA1->A1_YBLQFIN=="1","Sim","Nใo") +'</td>'
	EndIf
	cHtml += '            </tr>'
	cHtml += '         </table>'
	
	chtml += '		</div>'
	chtml += '		<div id="rodape">'
	chtml += '			<table border="0" height="62" width="100%">'
	chtml += '				<tr>'
	chtml += '					<td height="52" width="100%">'
	chtml += '						<table style="font-family: tahoma;font-size:11px;" align="center" border="0" width="95%">'
	chtml += '							<tr>'
	chtml += '								<td><p>Workflow informativo enviado por rotinas automaticas.</p></td>'
	chtml += '							</tr>'
	chtml += '						</table>'
	chtml += '					</td>'
	chtml += '				</tr>'
	chtml += '			</table>'
	chtml += '			<table width="100%">'
	chtml += '				<tr>'
	chtml += '					<td style="font-family:tahoma; font-size: 11px; color: #000;" align="center" height="30">WORKFLOW PROTHEUS </td>'
	chtml += '				</tr>'
	chtml += '			</table>'
	chtml += '        </div>'
	chtml += '    </body>'
	chtml += '</html>'
	
EndIf

RestArea(aAreaSA1)
RestArea(aAreaZC5)
RestArea(aAreaAtu)

Return chtml
