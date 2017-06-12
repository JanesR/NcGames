#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "FIVEWIN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TBICODE.CH"
#INCLUDE "AP5MAIL.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR110  ºAutor  ³Microsiga           º Data ³  10/29/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NC110JOB(aDados)

Local cQuery	:= ""

Default aDados:= {"01","03"}

RpcSetEnv(aDados[1],aDados[2] )

Processa ({|| PR110DEPURA() })



Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NC110Mail ºAutor  ³Microsiga           º Data ³  10/29/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NC110Mail(cPedidoWM)

Local aAreaATU 	:= GetArea()
Local aAreaZC5 	:= ZC5->(GetArea())

Local l110Exc		:= IsInCallStack("U_A410EXC")//Verifica se foi chamado pela PE A410EXC Exclusão de pedido de venda.
Local lM410TSS		:= IsInCallStack("U_M410STTS")//Verifica se foi chamado pela PE M410TSS pedido de venda.
Local lFranqueado	:=	FWIsInCallStack("U_WM001SEND")
Local cPictQtd		:= AvSx3("C6_QTDVEN",6)
Local _nI        	:= 0
Local _cUser     	:= RetCodUsr(Substr(cUsuario,1,6))
Local _cNomeusr  	:= UsrRetName(_cUser)
Local _cRecebe   	:= UsrRetMail(AllTrim(_cUser))
Local _cFinMail  	:= SuperGetMv("NCG_000045",.t.,"lfelipe@ncgames.com.br")
Local _cUsrVenM  	:= ""

Private _cCRLF		:= Chr(13) + Chr(10)

Private _lSendMail 	:= .T.
Private _cSA3Mail  	:= AllTrim(GetAdvFVal("SA3","A3_EMAIL",xFilial("SA3")+SC5->C5_VEND1,1,Space(30)))
Private _cVendedor 	:= AllTrim(GetAdvFVal("SA3","A3_CODUSR",xFilial("SA3")+SC5->C5_VEND1,1,Space(30)))
Private _cSA1Mail  	:= AllTrim(GetAdvFVal("SA1","A1_EMAIL",xFilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI,1,Space(30)))

_cUsrVenM  := UsrRetMail(AllTrim(_cVendedor))
_carq := U_NC110GetArq()

//If   // Verifica se a rotina foi chamada atraves M410TSS Ou Pedido Franqueado

If lFranqueado
	
	ZC5->(DbSetOrder(2))//ZC5_FILIAL+ZC5_NUMPV
	ZC5->(DbSeek(xFilial("ZC5")+cPedidoWM))
	
	cBody := U_ECOMHTMI(ZC5->(Recno()))
	
	EnvMail(,,cBody)
	
ElseIf l110Exc //Verifica se vem da rotina u_A410Exc
	
	Private _cSA3Mail  := AllTrim(GetAdvFVal("SA3","A3_EMAIL",xFilial("SA3")+M->C5_VEND1,1,Space(30)))
	Private _cVendedor := AllTrim(GetAdvFVal("SA3","A3_CODUSR",xFilial("SA3")+M->C5_VEND1,1,Space(30)))
	Private _cSA1Mail  := AllTrim(GetAdvFVal("SA1","A1_EMAIL",xFilial("SA1")+M->C5_CLIENTE+M->C5_LOJACLI,1,Space(30)))
	
	_cUsrVenM  := UsrRetMail(AllTrim(_cVendedor))
	
	Private _cAssunto  := "EXCLUSAO DE PEDIDO DE VENDA E CANCELAMENTO DE RESERVA DO(S) PRODUTO(S)"
	Private _cMensagem := ""
	
	
	_cMensagem := _cMensagem                                                                                          + _cCRLF + _cCRLF +;
	"O usuário "+AllTrim(_cNomeusr)+" em "+Dtoc(dDataBase)+" as "+time()+" Excluiu o pedido de venda "+M->C5_NUM      + _cCRLF + _cCRLF +;
	"Para esse pedido foi cancelada em nosso sistema a reserva do(s) produto(s) em nosso estoque."  + _cCRLF + _cCRLF + _cCRLF + _cCRLF + _cCRLF
	
	_cMensagem := _cMensagem + "______________________________________________________________________________________"     + _cCRLF + _cCRLF
	_cMensagem := _cMensagem + "Favor não responder esse e-mail. Mensagem enviada automaticamente pelo sistema Protheus11 - TOTVS"
	
	_cRecebe   := AllTrim(SC5->C5_XDESPVV)
	
	U_Nc110Send(_cRecebe,_cAssunto,_cMensagem)
	
ElseIf lM410TSS   // Verifica se a rotina foi chamada atraves M410TSS
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Email de Pre-nota em anexo³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	Private _cWhere    := "\SPOOL\"
	Private _cAnexo    := _cWhere+_carq+".pdf" //_cWhere + "PRENOTA_"+SC5->C5_NUM+".PDF"
	Private _lComC0    := .T.
	
	Private _cAssunto  := "Inclusão ou Alteração de Pedido de Venda e Reserva de Produtos"
	Private _cMsg      := ""
	
	_cMsg += '<html>'
	_cMsg += '<head>'
	_cMsg += '<title> Sem Titulo </title>'
	_cMsg += '</head>' + _cCRLF
	_cMsg += '<BODY>'  + _cCRLF
	_cMsg += '	<table width="95%" border="0">	'
	_cMsg += '		<tr>	'
	_cMsg += '			<td width="32%"><img src=https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png width="315" height="104" alt="Logo Nc Games" /></td>'
	_cMsg += '			<td width="68%"><div align="center"><font size="5" color="Darkgray" face="Verdana">Inclusão de PV e Reserva de Produtos</font></div></td>'
	_cMsg += '		</tr>	'
	_cMsg += '	</table>	'
	_cMsg += '	<DIV> <hr color=CC0000> </DIV>' + _cCRLF + _cCRLF
	
	_cMsg += '   <font size="3" face="Verdana">Prezado Cliente. </font>'                                                               + _cCRLF
	_cMsg += '   <font size="3" face="Verdana">Seguem itens reservados de seu pedido ' + '<b> NUMERO ' + SC5->C5_NUM + '</b></font>'   + _cCRLF + _cCRLF
	
	//Abre Tabela
	_cMsg += '<table border="0" width="100%" bgcolor="#EEE9E9">'
	_cMsg += '	<tr>'
	_cMsg += '		<td width="6%"><b><font size="2" face="Verdana">Item</font></b></td>'
	_cMsg += '		<td width="24%"><b><font size="2" face="Verdana">Produto</font></b></td>'
	_cMsg += '		<td width="40%"><b><font size="2" face="Verdana">Descrição</font></b></td>'
	_cMsg += '		<td width="15%"><b><font size="2" face="Verdana"><p align="Right">Quantidade</p></font></b></td>'
	_cMsg += '		<td width="15%"><b><font size="2" face="Verdana"><p align="Right">Reservado</p></font></b></td>'
	_cMsg += '	</tr>'
	_cMsg += '</table>'
	
	//Preenche Tabela com itens reservados
	_lComC0 := .T.
	_aDados := BuscaSC6()
	
	If Len(_aDados) > 0
		For _nX := 1  To  Len(_aDados)
			_cItem  		:= AllTrim(_aDados[_nX,1])
			_cProduto	:= AllTrim(_aDados[_nX,2])
			_cDescri		:= AllTrim(_aDados[_nX,3])
			
			_cQtdEnt		:= AllTrim(Str(_aDados[_nX,5],10,4))
			_cLocal		:= AllTrim(_aDados[_nX,6])
			
			_cQuant 		:= Transform(_aDados[_nX,4],cPictQtd)
			_cReserv		:= Transform(GetAdvFVal("SC0","C0_QTDPED",xFilial("SC0")+SC5->C5_NUM+_aDados[_nX,2]+_cLocal,1,0),cPictQtd)
			
			_cMsg += '<table border="0" width="100%" bgcolor="#EEE9E9">'
			_cMsg += '	<tr>'
			_cMsg += '		<td width="06%"><font size="2" face="Verdana">' + _cItem +    '</font></td>'
			_cMsg += '		<td width="24%"><font size="2" face="Verdana">' + _cProduto + '</font></td>'
			_cMsg += '		<td width="40%"><font size="2" face="Verdana">' + _cDescri +  '</font></td>'
			_cMsg += '		<td width="15%"><font size="2" face="Verdana"><p align="Right">' + _cQuant + '</p></font></td>'
			_cMsg += '		<td width="15%"><font size="2" face="Verdana"><p align="Right">' + _cReserv + '</p></font></td>'
			_cMsg += '	</tr>'
			_cMsg += '</table>'
			
		Next
	EndIf
	
	//Fecha Tabela
	_cMsg += _cCRLF + _cCRLF + _cCRLF
	_cMsg += '<font size="2" face="Verdana">Atenciosamente. </font>' + _cCRLF
	_cMsg += '<DIV> <hr color=CC0000> </DIV>' + _cCRLF
	_cMsg += '<font size="2" face="Verdana">E-Mail enviado automaticamente pelo sistema da ' + SM0->M0_NOMECOM + '</font>'       + _cCRLF
	_cMsg += '<font size="2" face="Verdana">Qualquer duvida ou necessidade de responder esse E-Mail, favor utilizar o endereco eletronico abaixo: </font>' + _cCRLF
	_cMsg += '<font size="2" face="Verdana">E-Mail: ' + _cUsrVenM + ' </font>' + _cCRLF
	_cMsg += '</body>'
	_cMsg += '</html>'
	
	IF _lSENDMAIL
		_cRecOK   	:= _cRecebe + ";" + _cSA3Mail + ";" + _cUsrVenM + ";" + _cFinMail + ";" + AllTrim(SC5->C5_XDESPVV)
	ELSE
		_cRecOK   	:=  _cRecebe + ";" + _cSA3Mail + ";" + _cUsrVenM + ";" + _cFinMail + ";"
	ENDIF
	_cRecErr		:= _cRecebe + ";" + _cSA3Mail + ";" + _cUsrVenM + ";" + _cFinMail + ";"
	
	_cRecOK		:= AllTrim(SC5->C5_XDESPVV)
	
	cReserva:=_cMsg
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Email de Carta de Deposito³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	Private _dVencto   := Posicione("SC0",1,xFilial("SC0")+SC5->C5_NUM,"C0_VALIDA"  ) //DataValida(dDataBase+(_nHorasRes/12),.F.)
	Private _cDadosBco := GetMV("MV_NCBANCO")
	
	If Substr(_cDadosBco,1,3) == "237"
		_cBanco   := "237"
		_cNomeBco := "Banco Bradesco S.A."
	ElseIf Substr(_cDadosBco,1,3) == "341"
		_cBanco   := "341"
		_cNomeBco := "Banco Itaú S.A."
	ElseIf Substr(_cDadosBco,1,3) == "001"
		_cBanco   := "001"
		_cNomeBco := "Banco do Brasil S.A."
	ElseIf Substr(_cDadosBco,1,3) == "104"
		_cBanco   := "104"
		_cNomeBco := "Caixa Economica Federal"
	ElseIf Substr(_cDadosBco,1,3) == "033"
		_cBanco   := "033"
	EndIf
	
	
	Private _cAgencia   := ""
	Private _cConta     := ""
	Private _lAsterisco := .F.
	Private _lJogoVelha := .F.
	For _nI := 1  To  Len(AllTrim(_cDadosBco))
		If _lAsterisco
			_cAgencia := _cAgencia + Substr(_cDadosBco,_nI,1)
		EndIf
		If _lJogoVelha
			_cConta := _cConta + Substr(_cDadosBco,_nI,1)
		EndIf
		If Substr(_cDadosBco,_nI,1) == "*"
			_lAsterisco := .T.
		EndIf
		If Substr(_cDadosBco,_nI,1) == "#"
			_lAsterisco := .F.
			_lJogoVelha := .T.
		EndIf
	Next
	
	_cAgencia := Substr(_cAgencia,1,Len(AllTrim(_cAgencia))-1)
	
	Private _cAssunto  := "PEDIDO "+SC5->C5_NUM+" - CARTA DEPOSITO"
	Private _cMsg      := ""
	
	_nTotPV :=U_NC110Total()
	
	cNomeCli := ALLTRIM(GETADVFVAL("SA1","A1_NOME",XFILIAL("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI,1,SPACE(10)))
	cNumPed	 := SC5->C5_NUM
	dVenc	 := Dtoc(_dVencto)
	nTotalPV := AllTrim(Transform(_nTotPV,"@E 999,999,999.99"))
	_dDia	 := StrZero(Day(dDataBase),2)
	_dMes	 := StrZero(Month(dDataBase),2)
	_dAno	 := StrZero(Year(dDataBase),4)
	
	
	_cMsg += '	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "ht	tp://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
	_cMsg += '	<html xmlns="http://www.w3.org/1999/xhtml">	'
	_cMsg += '	<head>	'
	_cMsg += '	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"	/>'
	_cMsg += '	<title>Carta de Deposito</title>	'
	_cMsg += '	<style type="text/css">	'
	
	_cMsg += '	</style>	'
	_cMsg += '	</head>	'
	
	_cMsg += '	<body>	'
	_cMsg += '	<table width="95%" border="0">	'
	_cMsg += '	<tr>	'
	_cMsg += '	<td width="32%"><img src=https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png alt="Logo Nc Games" /></td>'
	_cMsg += '	<td width="68%"><div align="center"><font size="6" color="Darkgray" face="Verdana">CARTA DE DEPOSITO</font></div></td>'
	_cMsg += '	</tr>	'
	_cMsg += '	</table>	'
	
	_cMsg += '	<table width="95%" border="0"><tr><hr color=CC0000></td></tr></table>'
	
	_cMsg += '	<p><font size="2" face="Verdana">São Paulo, ' + _dDia +' de '+ MesExtenso(_dMes) +' de '+ _dAno + '<br />	'
	_cMsg += '	<font size="2" face="Verdana">A Empresa: <strong>'+ cNomeCli +'</strong></font></font></p>	'
	
	_cMsg += '	<table width="95%" border="0"><tr><hr color=CC0000></td></tr></table>'
	
	_cMsg += '	<p><font size="2" face="Verdana">A  reserva<font color="RED">*</font> '
	_cMsg += '  dos produtos em seu pedido  ' + cNumPed + ' está garantida até o dia ' + Dtoc(_dVencto) + ', '
	_cMsg += '  para a liberação e despacho de sua mercadoria solicitamos<br/>que seja feito um <strong>DEPÓSITO  IDENTIFICADO</strong> '
	_cMsg += '  com seu CNPJ conforme abaixo: <br /><br /></font>'
	_cMsg += '	<font size="3" face="Tahoma">  Valor: <strong>R$ ' + nTotalPV + '**</strong>.<br/>
	_cMsg += '	Banco: <strong> ' + _cBanco + ' - ' + _cNomeBco + ' </strong><br/>'
	_cMsg += '	Agência: <strong>  ' + _cAgencia + ' </strong><br/> '
	_cMsg += '  Conta Corrente: <strong> ' + _cConta + ' </strong><br/> '
	_cMsg += '  Favorecido: NC GAMES &amp; ARCADES C.I.E.L.F.M. Ltda.<br /><br/><br/></font>'
	_cMsg += '	<font size="1" color="#666666" face="Verdana">*  Sujeito a disponibilidade no estoque. ** Com Impostos</font></p>'
	
	_cMsg += '	<table width="95%" border="0"><tr><hr color=CC0000></td></tr></table>'
	
	_cMsg += '	<p><font size="2" face="Verdana">Obs.: <br />	'
	_cMsg += '	Seu  pedido será liberado após a compensação do depósito na conta da NC Games. <br/>'
	_cMsg += '	Os  depósitos devem ser feitos em valores exatos para evitar bloqueio no  financeiro.<br/>'
	_cMsg += '	Para  liberação mais rápida de seu pedido sugerimos que seu depósito seja feito em  dinheiro na boca do caixa ou TED '
	_cMsg += '	que são identificados em conta imediatamente.<br />'
	_cMsg += '	Depósito  em cheque ou caixas de autoatendimento são compensados no dia seguinte.<br/>'
	_cMsg += '	Pedidos  pagos através de DOC serão faturados após a compensação que ocorre no dia  seguinte.</font><br/>'
	_cMsg += '	<font size="2" face="Verdana">Não garantimos a reserva de estoque para depósitos efetuados após o prazo de 24h<br/>'
	_cMsg += '	podendo haver a possibilidade de troca por outro item de mesmo valor.</font></p>'
	
	_cMsg += '	<table width="95%" border="0"><tr><hr color=CC0000></td></tr></table>'
	
	_cMsg += '	<p><font size="2" face="Verdana">Após  efetuar o pagamento, favor enviar o comprovante para o e-mail abaixo: <br />'
	_cMsg += '	E-mail:' + _cUsrVenM + '</a> <br/>'
	_cMsg += '	O envio do comprovante é imprescindível  aos cuidados do seu consultor de vendas. <br />'
	_cMsg += '	</font></p>	'
	_cMsg += '	<p><font size="2" face="Verdana"><br />	'
	_cMsg += '	Atenciosamente.</font></p>	'
	
	_cMsg += '	<table width="95%" border="0"><tr><hr color=CC0000></td></tr></table>'
	
	_cMsg += '	<p><font size="1" face="Verdana">E-mail enviado  automaticamente pelo sistema da NC GAMES &amp; ARCADES C.I.E.L.F.M LTDA, qualquer '
	_cMsg += '	dúvida ou necessidade de responder esse E-Mail, favor utilizar o endereço eletrônico:<strong> '+ _cUsrVenM + ' </strong></a></font></p>'
	_cMsg += '	</body>	'
	_cMsg += '	</html>	'
	
	_cRecErr	:= _cRecebe + ";" + _cSA3Mail + ";" + _cUsrVenM + ";" + _cFinMail + ";" + AllTrim(SC5->C5_XDESPVV)
	_cRecebe	:= AllTrim(SC5->C5_XDESPVV)
	
	EnvMail(_cMsg,cReserva)
	
Else
	
	Private _cAssunto  := "RESERVA COM PRAZO A VENCER"
	Private _cMensagem := ""
	
	_cMensagem := _cMensagem                                                                           + _cCRLF + _cCRLF +;
	"A reserva em nosso sistema para o pedido de venda "+SC5->C5_NUM                                   + _cCRLF + _cCRLF +;
	"atingiu prazo limite para confirmação, favor confirmar através do endereço eletrônico abaixo: "   + _cCRLF + _cCRLF +;
	"E-Mail: "+_cSA3Mail                                                                               + _cCRLF + _cCRLF + _cCRLF + _cCRLF + _cCRLF
	
	_cMensagem := _cMensagem + "______________________________________________________________________________________"     + _cCRLF + _cCRLF
	_cMensagem := _cMensagem + "Favor não responder esse e-mail. Mensagem enviada automaticamente pelo sistema Protheus11 - TOTVS"
	
	_cRecebe := AllTrim(SC5->C5_XDESPVV)
	
	U_Nc110Send(_cRecebe,_cAssunto,_cMensagem)
	
Endif

RestArea(aAreaZC5)
RestArea(aAreaATU)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR110  ºAutor  ³Microsiga           º Data ³  10/30/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Nc110Send(_cRecebe,_cAssunto,_cMensagem)

Local _cServer   	:= GetNewPar("MV_RELSERV","")
Local _cAccount  	:= GetNewPar("MV_RELACNT","")
Local _cEnvia    	:= GetNewPar("MV_RELACNT","")
Local _cPassword 	:= GetNewPar("MV_RELAPSW","")
Local _lMailAuth 	:= GetNewPar("MV_RELAUTH",.F.)


CONNECT SMTP SERVER _cServer ACCOUNT _cAccount PASSWORD _cPassword Result lConectou
MAILAUTH(_cAccount,_cPassword)

SEND MAIL FROM _cEnvia;
TO _cRecebe;
SUBJECT _cAssunto;
BODY _cMensagem;
RESULT lEnviado

If !lEnviado
	_cMensagem := "Falha ao Enviar"
	GET MAIL ERROR _cMensagem
	Alert(_cMensagem)
EndIf

DISCONNECT SMTP SERVER Result lDisConectou

If !lDisConectou
	Alert("Falha ao Desconectar com servidor de E-Mail - " + _cServer)
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR110  ºAutor  ³Microsiga           º Data ³  10/30/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function 110Send2(_cRecOK,_cAssunto,_cMsg)

Local _cServer   	:= GetNewPar("MV_RELSERV","")
Local _cAccount  	:= GetNewPar("MV_RELACNT","")
Local _cEnvia    	:= GetNewPar("MV_RELACNT","")
Local _cPassword 	:= GetNewPar("MV_RELAPSW","")
Local _lMailAuth 	:= GetNewPar("MV_RELAUTH",.F.)
Local nSmtpPort := GetNewPar("MV_GCPPORT","")
Local lSSL	:= SuperGetMv("MV_RELSSL",.F.)
Local lTLS	:= SuperGetMv("MV_RELTLS",.F.)

If At(":",_cServer) > 0
	_cServer := SubStr(_cServer,1,At(":",_cServer)-1)
EndIf

oMail := tMailManager():new()
nRet := 0
oMail:SetUseSSL( lSSL )
oMail:SetUseTLS( lTLS ) //ADD 23/06/2016 -- configuração de gmail
oMail:Init("", _cServer, _cAccount, _cPassword, /*nPopPort*/, nSmtpPort)
nret := oMail:SetSMTPTimeout(60) //1 min

If nRet == 0
	conout("SetSMTPTimeout Successful")
Else
	conout(nret)
	conout(oMail:GetErrorString(nret))
Endif
nret := oMail:SMTPConnect()
If nRet == 0
	conout("Connect Successful")
Else
	conout(nret)
	conout(oMail:GetErrorString(nret))
Endif

nRet := oMail:SMTPAuth(_cAccount, _cPassword)

oMessage := TMailMessage():New()
oMessage:Clear()
oMessage:cFrom          := _cEnvia
oMessage:cTo            := _cRecOK
oMessage:cCc            := ""
oMessage:cBcc           := ""
oMessage:cSubject       := _cAssunto
oMessage:cBody          := _cMsg
oMessage:AttachFile(_cAnexo)
conout("[SEND] Sending ...")
nRet := oMessage:Send( oMail )


If nRet == 0
	conout("SendMail Successful")
Else
	conout(nret)
	conout(oMail:GetErrorString(nret))
Endif
nRet := oMail:SmtpDisconnect()
If nRet == 0
	conout("Disconnect Successful")
Else
	conout(nret)
	conout(oMail:GetErrorString(nret))
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³110Destin  ºAutor  ³Lucas Felipe       º Data ³  10/29/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function 110Destin()

Private _lRet     := .F.
Private _cMailPVV := SC5->C5_XDESPVV

Do While .T.
	
	@ 100,001 TO 250,750 DIALOG oDlg1 TITLE "Venda a Vista - E-Mail do Destinatario"
	@ 020,005 Say "E-mail de Destinatario do Cliente  "
	@ 030,040 Get _cMailPVV  Valid NaoVazio() Size 300,010
	@ 060,015 BMPBUTTON TYPE 01 ACTION _fGrava()
	activate dialog oDlg1 centered
	
	If !_lRet
		Alert("Voce deve digitar o E-Mail do destinatario e depois sair pelo botão OK")
		Loop
	Else
		Exit
	EndIf
EndDo

Return(.T.)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ4¿
//³Função para gravar o destinatario no SC5³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ4Ù

Static Function _fGrava()

RecLock("SC5",.F.)
SC5->C5_XDESPVV := _cMailPVV
MsUnlock()
_lRet := .T.
Close(oDlg1)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³110DEPURA  ºAutor  ³Lucas Oliveira     º Data ³  10/29/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function 110DEPURA()
Local aAreaAtu		:= GetArea()
Local cAliasQuery	:= GetNextAlias()
Local cQuery


cQuery:=" Select SC0.R_E_C_N_O_ RecSC0"
cQuery+=" From "+RetSqlName("SC0")+" SC0"
cQuery+=" Where SC0.C0_FILIAL='"+xFilial("SC0")+"'"
cQuery+=" And SC0.C0_QTDPED>0 "
cQuery+=" And SC0.C0_VALIDA<='"+Dtos(MsDate())+"'"
cQuery+=" And SC0.C0_XHORA<='"+Time()+"'"
cQuery+=" And SC0.D_E_L_E_T_=' '"

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQuery, .F., .F.)


Do While (cAliasQuery)->(!Eof())
	SC0->(DbGoTo((cAliasQuery)->RecSC0  ) )
	IncProc("Depurando Reservas... Reserva: "+SC0->C0_NUM)
	
	If !Empty(SC0->C0_XVALIDA) .And. !Empty(SC0->C0_XALERTA) .And. Empty(SC0->C0_YENVIAD)
		
		If SC0->C0_XVALIDA < MsDate() // Validade for menor executa
			SC5->(dbSetOrder(1))
			If SC5->(DbSeek(xFilial("SC5")+SC0->C0_NUM))
				U_NC110MAIL()
				SC0->(Reclock("SC0",.F.))
				SC0->C0_YENVIAD := "E"
				SC0->(MsUnlock())
			EndIf
		ElseIf SC0->C0_XVALIDA == MsDate() // Se validade For Igual valida a hora
			If SC0->C0_XALERTA <= Time()	// Validação da hora
				SC5->(dbSetOrder(1))
				If SC5->(DbSeek(xFilial("SC5")+SC0->C0_NUM))
					U_NC110MAIL()
					SC0->(Reclock("SC0",.F.))
					SC0->C0_YENVIAD := "E"
					SC0->(MsUnlock())
				EndIf
			EndIf
		EndIf
	ElseIf (SC0->C0_VALIDA <= MsDate() .And. SC0->C0_XHORA < Time())
		U_NC110Del(SC0->C0_NUM)
	EndIf
	
	(cAliasQuery)->(dbSkip())
EndDo

(cAliasQuery)->(DbCloseArea())
RestArea(aAreaAtu)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BUSCASC6  ºAutor  ³Microsiga           º Data ³  10/30/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function BUSCASC6()
Private _aDados  	:= {}
Private _aAreaC6 	:= {}

_aAreaC6 			:= GetArea()

dbSelectArea("SC6")
dbSetOrder(1)
dbSeek(xFilial("SC6")+SC5->C5_NUM)

Do While !Eof() .And. SC5->C5_NUM == SC6->C6_NUM
	If _lComC0
		If AllTrim(SC6->C6_RESERVA) == AllTrim(SC5->C5_NUM)
			// ITEM, PRODUTO, DESCRICAO e QUANTIDADE VENDIDA
			AADD(_aDados,{SC6->C6_ITEM, SC6->C6_PRODUTO, SC6->C6_DESCRI, Round(SC6->C6_QTDVEN,2), Round(GetAdvFVal("SC0","C0_QTDPED",xFilial("SC0")+SC6->C6_NUM+SC6->C6_PRODUTO+SC6->C6_LOCAL,1,0),2), ALLTRIM(SC6->C6_LOCAL)} )
		ELSEIF Empty(SC6->C6_RESERVA)
			// ITEM, PRODUTO, DESCRICAO e QUANTIDADE VENDIDA
			AADD(_aDados,{SC6->C6_ITEM, SC6->C6_PRODUTO, SC6->C6_DESCRI, Round(SC6->C6_QTDVEN,2), Round(GetAdvFVal("SC0","C0_QTDPED",xFilial("SC0")+SC6->C6_NUM+SC6->C6_PRODUTO+SC6->C6_LOCAL,1,0),2), ALLTRIM(SC6->C6_LOCAL)} )
		EndIf
	Else
		If Empty(SC6->C6_RESERVA)
			// ITEM, PRODUTO, DESCRICAO e QUANTIDADE VENDIDA
			AADD(_aDados,{SC6->C6_ITEM, SC6->C6_PRODUTO, SC6->C6_DESCRI, Round(SC6->C6_QTDVEN,2), Round(GetAdvFVal("SC0","C0_QTDPED",xFilial("SC0")+SC6->C6_NUM+SC6->C6_PRODUTO+SC6->C6_LOCAL,1,0),2), ALLTRIM(SC6->C6_LOCAL)} )
		EndIf
	EndIf
	dbSelectArea("SC6")
	dbSkip()
Enddo

RestArea(_aAreaC6)
Return(_aDados)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NC110MTA410ºAutor  ³Microsiga          º Data ³  10/30/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Chama a função padrão para inclusão e alteração de reserva º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NC110MTA410()
Local aAreaAtu	:= GetArea()
Local aAreaSC6	:= SC6->(GetArea())
Local _aAreaC0	:= SC0->(GetArea())
Local lCondPag	:= SC5->C5_CONDPAG $ AllTrim(SuperGetMv("MV_NCRESER",.F.,""))
Local lPedidoSite	:= Iif(SC5->C5_XECOMER=="C",.T.,.F.)
Local cSolicit	:= UsrRetName(RetCodUsr())
Local aRecno		:= {}
Local _nQtdRes 	:= 0
Local cHoraVenc
Local dDtVencto
Local dDtAlert
Local lReservou	:= .F.
Local lTemSC0
Local lWMPedido	:= AllTrim(SC5->C5_YORIGEM)=="WM"

Private _lRet 		:= .T.
Private _dVencto    := Ctod("")


U_NC110Del(SC5->C5_NUM)
If  !lWMPedido .And.  !lPedidoSite .And.  !(lCondPag .And. SC5->C5_XSTAPED == "15")
	Return
EndIf

Pr110Validade(@cHoraVenc,@dDtVencto,@dDtAlert,lPedidoSite,lWMPedido)

If lPedidoSite .Or. lWMPedido
	
	cHoraVenc		:= "23:59:59"
	cSolicit		:= "ECOMMERCE"
	
	If SC5->(FieldPos("C5_YPREVEN"))>0 .And. SC5->C5_YPREVEN=="S"
		dDtVencto	:= Ctod("31/12/2049")
	EndIf
	
EndIf
SC0->(DbSetOrder(1))//C0_FILIAL+C0_NUM+C0_PRODUTO+C0_LOCAL

SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
SC6->(DbSeek(xFilial("SC6")+SC5->C5_NUM ))

Do While SC6->(!Eof() ) .And. SC6->(C6_FILIAL+C6_NUM)==xFilial("SC6")+SC5->C5_NUM
	
	lTemSC0	:= SC0->(DbSeek(xFilial("SC0")+SC6->C6_NUM+SC6->C6_PRODUTO+SC6->C6_LOCAL))
	
	_nQtdRes	:= SC6->C6_QTDVEN
	
	SB2->(DbSeek(xFilial("SB2")+SC6->C6_PRODUTO+SC6->C6_LOCAL))
	
	nSaldoDisp := SaldoSB2()
	
	If nSaldoDisp<=0
		SC6->(DbSkip())
		Loop
	EndIf
	
	If _nQtdRes > nSaldoDisp
		_nQtdRes := nSaldoDisp
	EndIf
	
	If _nQtdRes<=0
		SC6->(DbSkip());Loop
	EndIf
	
	
	If a430Reserva( { Iif( lTemSC0,2,1 ) ,"PD",SC5->C5_VEND1,cSolicit,cFilAnt},SC5->C5_NUM,SC6->C6_PRODUTO,SC6->C6_LOCAL,_nQtdRes,{ SC6->C6_NUMLOTE,SC6->C6_LOTECTL,SC6->C6_LOCALIZ,SC6->C6_NUMSERI})
		lReservou:=.T.
		
		If SC0->(DbSeek(xFilial("SC0")+SC5->C5_NUM+SC6->C6_PRODUTO+SC6->C6_LOCAL))
			
			SC6->(RecLock("SC6",.F.) )
			
			SC6->C6_QTDRESE	:= _nQtdRes
			SC6->C6_RESERVA	:= SC5->C5_NUM
			
			SC6->(MsUnLock())
			
			SC0->(RecLock("SC0",.F.))
			
			SC0->C0_QUANT		:= (SC0->C0_QUANT-_nQtdRes)
			SC0->C0_QTDPED	:= _nQtdRes
			
			SC0->C0_VALIDA	:= dDtVencto
			SC0->C0_XHORA		:= cHoraVenc
			SC0->C0_XVALIDA	:= dDtAlert
			SC0->C0_XALERTA	:= cHoraVenc
			SC0->C0_OBS		:= "PV "+SC5->C5_NUM+" ITEM "+SC6->C6_ITEM
			
			SC0->(MsUnlock())
			
		EndIf
	EndIf
	SC6->(DbSkip())
EndDo

If !lReservou  .And. !lPedidoSite
	MsgInfo("Não há saldo em estoque de nenhum poruduto para reservar PV: "+SC5->C5_NUM)
EndIf


RestArea(_aAreaC0)
RestArea(aAreaSC6)
RestArea(aAreaAtu)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NC110Del  ºAutor  ³Microsiga           º Data ³  12/08/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Chama a patrão para deletar a reserva de estoque            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NC110Del(cNum)
Local aAreaAtu	:= GetArea()
Local aAreaSC6	:= SC6->(GetArea())
Local aAreaSC0	:= SC0->(GetArea())
Local cTipoRes	:= ""
Local cDocRes		:= ""
Local cSolicit	:= ""
Local cFilRes		:= xFilial("SC0")


Begin Transaction

SC0->(dbSetOrder(1)) //C0_FILIAL+C0_NUM+C0_PRODUTO+C0_LOCAL
If SC0->(MsSeek(xFilial("SC0")+cNum))
	
	cSolicit	:= SC0->C0_SOLICIT
	cDocRes	:= SC0->C0_DOCRES
	cTipoRes	:= SC0->C0_TIPO
	
	While  SC0->(!Eof()) .And.  SC0->C0_FILIAL == xFilial("SC0") .And. SC0->C0_NUM  == cNum
		
		SC0->(RecLock("SC0",.F.))
		
		SC0->C0_QUANT:=SC0->C0_QUANT+SC0->C0_QTDPED
		
		a430Reserv({3,cTipoRes,cDocRes,cSolicit,cFilRes},;
		cNum, SC0->C0_PRODUTO, SC0->C0_LOCAL, SC0->C0_QUANT,;
		{ SC0->C0_NUMLOTE, SC0->C0_LOTECTL, SC0->C0_LOCALIZ, SC0->C0_NUMSERI})
		SC0->(MsUnLock())
		
		SC0->(DbSkip())
	EndDo
	
	SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
	SC6->(MsSeek(xFilial("SC6")+cNum))
	
	Do While SC6->( !Eof()) .And. SC6->C6_FILIAL+SC6->C6_NUM == xFilial("SC6")+cNum
			SC6->(RecLock("SC6",.F.))
			
			SC6->C6_RESERVA	:= ""
			SC6->C6_QTDRESE	:= 0
			SC6->C6_QTDEMP	:= 0
			SC6->C6_QTDEMP2	:= 0
			
			SC6->(MsUnLock())
		
		SC6->(DbSkip())
		
	EndDo
	
EndIf

End Transaction

RestArea(aAreaSC0)
RestArea(aAreaSC6)
RestArea(aAreaAtu)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR110  ºAutor  ³Microsiga           º Data ³  12/19/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR110Validade(cHoraVenc,dDtVencto,dDtAlert,lPedidoSite,lWMPedido)
Local nHrReser	:= U_MyNewSX6("MV_NCHRES","48","N","Horas de validade para as reservas (Salvo Ecommerce EC_NCG0018)"," "," ",.F. )
Local nHrResEco	:= U_MyNewSX6("EC_NCG0018","6000","N","Horas que permanecera a reserva do pedido de venda E-commerce"," "," ",.F. )
Local nHrAlert	:= U_MyNewSX6("MV_NCHALER","24","N","Numero de horas que o cliente/vendedor será informado sobre a sua reserva"," "," ",.F. )
Local nHrResWM	:= U_MyNewSX6("NCG_000087","120","N","Horas que o cliente será alertado sobre o fim da reserva"," "," ",.F. )

Local nDiaVenc	:= Int(nHrReser) / 24
Local nDiaAlert	:= Int(nHrAlert) / 24

Local dDataIni	:= MsDate()
Local nHrAux

If lPedidoSite
	nHrReser	:= nHrResEco
	nDiaVenc	:= Int(nHrResEco) / 24
	nDiaAlert	:= (Int(nHrResEco) / 24)-1
EndIf

If lWMPedido
	nHrReser	:= nHrResWM
	nDiaVenc	:= Int(nHrResWM) / 24
	nDiaAlert	:= (Int(nHrResWM) / 24)-1
EndIf  
If !(nDiaVenc > nDiaAlert)
	nDiaVenc := nDiaAlert
EndIf

If nDiaVenc > 0
	
	dDtAlert 	:= dDataIni + nDiaAlert
	dDtVencto 	:= dDataIni + nDiaVenc
	
	/*	Validação de data  	*/
	dDtAlert	:= DataValida(dDtAlert,.T.)
	dDtVencto	:= DataValida(dDtVencto,.T.)
	/*	Fim de validação		*/
	
	If !lPedidoSite .or. !lWMPedido
		/*	Validação de horas	*/
		If (nHrReser / 24) > 1
			nHrAux 	:= SomaHoras( int( int( Seconds() / 60) / 60), Ceiling( ( (nHrReser / 24 - nDiaVenc)* 24 ) ) )
			
			cHoraVenc 	:= AllTrim(Str(nHrAux)) + ":" + SubStr(time(),4,2) + ":" + SubStr(Time(),7,2)
			
		Else
			
			nHrAux 	:= SomaHoras( int( int( Seconds() / 60) / 60), Ceiling( nHrReser * 24 )   )
			
			cHoraVenc 	:= AllTrim(Str(nHrAux)) + ":" + SubStr(time(),4,2) + ":" + SubStr(Time(),7,2)
			
		EndIf
	EndIf
Else
	
	nHrAux 	:=  int( int( Seconds() / 60) / 60) + Ceiling( ( nHrReser / 24)* 24 )
	
	If nHrAux > 24
		
		nHrAux 	:= nHrAux - 24
		dDtAlert	:= DataValida(++dDataIni,.T.)
		dDtVencto	:= DataValida(++dDataIni,.T.)
		
	EndIf
	
	cHoraVenc 	:= AllTrim(Str(nHrAux)) + ":" + SubStr(time(),4,2) + ":" + SubStr(Time(),7,2)
	
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR110  ºAutor  ³Microsiga           º Data ³  12/19/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR110DEPURA(cParam)
Local aAreaAtu		:= GetArea()
Local cAliasQuery		:= GetNextAlias()

Local cQuery
Local cTimeAtu		:= Time()
Local dDataAtu		:= MsDate()


cQuery:=" Select SC0.R_E_C_N_O_ RecSC0"
cQuery+=" From "+RetSqlName("SC0")+" SC0"
cQuery+=" Where SC0.C0_FILIAL='"+xFilial("SC0")+"'"
cQuery+=" And SC0.C0_QTDPED>0 "
cQuery+=" And SC0.C0_XVALIDA='"+Dtos(dDataAtu)+"'"
cQuery+=" And SC0.C0_YENVIAD=' '"
cQuery+=" And SC0.D_E_L_E_T_=' '"

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQuery, .F., .F.)

Do While (cAliasQuery)->(!Eof())
	
	SC0->(DbGoTo((cAliasQuery)->RecSC0  ) )
	
	IncProc("Depurando Reserva: "+SC0->C0_NUM)
	
	U_NC110MAIL()
	
	SC0->(Reclock("SC0",.F.))
	
	SC0->C0_YENVIAD := "E"
	
	SC0->(MsUnlock())
	
	(cAliasQuery)->(dbSkip())
	
EndDo

(cAliasQuery)->(DbCloseArea())

cAliasQuery	:= GetNextAlias()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³	RESERVA VENCIDAS   												   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cQuery:=" Select SC0.R_E_C_N_O_ RecSC0"
cQuery+=" From "+RetSqlName("SC0")+" SC0"
cQuery+=" Where SC0.C0_FILIAL='"+xFilial("SC0")+"'"
cQuery+=" And SC0.C0_QTDPED > 0 "
cQuery+=" And SC0.D_E_L_E_T_=' '"
cQuery+=" And ( SC0.C0_VALIDA < '"+Dtos(dDataAtu)+"' Or SC0.C0_VALIDA = '"+Dtos(dDataAtu)+"' AND SC0.C0_XHORA <= '"+cTimeAtu+"' )"
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQuery, .F., .F.)


Do While (cAliasQuery)->(!Eof())
	
	SC0->(DbGoTo((cAliasQuery)->RecSC0  ) )
	
	IncProc("Depurando Reserva: "+SC0->C0_NUM)
	
	U_NC110Del(SC0->C0_NUM)
	
	(cAliasQuery)->(dbSkip())
	
EndDo

(cAliasQuery)->(DbCloseArea())

RestArea(aAreaAtu)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR110  ºAutor  ³Microsiga           º Data ³  03/11/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Ma410Impos( nOpc, lRetTotal, aRefRentab)
Local aArea		:= GetArea()
Local aAreaSA1	:= SA1->(GetArea())
Local aFisGet	:= {}
Local aFisGetSC5:= {}

Local aDupl     := {}
Local aVencto   := {}
Local aEntr     := {}
Local aDuplTmp  := {}
Local aNfOri    := {}
Local aRentab   := {}
Local nPLocal   := aScan(aHeader,{|x| AllTrim(x[2])=="C6_LOCAL"})
Local nPTotal   := aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALOR"})
Local nPValDesc := aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALDESC"})
Local nPPrUnit  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRUNIT"})
Local nPPrcVen  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCVEN"})
//Local nPQtdVen  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDVEN"})
Local nPQtdVen  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDRESE"})
Local nPDtEntr  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_ENTREG"})
Local nPProduto := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO"})
Local nPTES     := aScan(aHeader,{|x| AllTrim(x[2])=="C6_TES"})
Local nPCodRet  := Iif(cPaisLoc=="EQU",aScan(aHeader,{|x| AllTrim(x[2])=="C6_CONCEPT"}),"")
Local nPNfOri   := aScan(aHeader,{|x| AllTrim(x[2])=="C6_NFORI"})
Local nPSerOri  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_SERIORI"})
Local nPItemOri := aScan(aHeader,{|x| AllTrim(x[2])=="C6_ITEMORI"})
Local nPIdentB6 := aScan(aHeader,{|x| AllTrim(x[2])=="C6_IDENTB6"})
Local nPItem    := aScan(aHeader,{|x| AllTrim(x[2])=="C6_ITEM"})
Local nPProvEnt := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PROVENT"})
Local nPosCfo	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_CF"})
Local nPAbatISS := aScan(aHeader,{|x| AllTrim(x[2])=="C6_ABATISS"})
Local nPLote    := aScan(aHeader,{|x| AllTrim(x[2])=="C6_LOTECTL"})
Local nPSubLot	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_NUMLOTE"})
Local nPClasFis := aScan(aHeader,{|x| AllTrim(x[2])=="C6_CLASFIS"})
Local nPSuframa := 0
Local nUsado    := Len(aHeader)
Local nX        := 0
Local nX1       := 0
Local nAcerto   := 0
Local nPrcLista := 0
Local nValMerc  := 0
Local nDesconto := 0
Local nAcresFin := 0	// Valor do acrescimo financeiro do total do item
Local nQtdPeso  := 0
Local nRecOri   := 0
Local nPosEntr  := 0
Local nItem     := 0
Local nY        := 0
Local nPosCpo   := 0
Local nPropLot  := 0
Local lDtEmi    := SuperGetMv("MV_DPDTEMI",.F.,.T.)
Local dDataCnd  := M->C5_EMISSAO
Local oDlg
Local oDupl
Local oFolder
Local oRentab
Local lCondVenda := .F. // Template GEM
Local aRentabil := {}
Local cProduto  := ""
Local nTotDesc  := 0
Local lSaldo    := .F.
Local nQtdEnt   := 0
Local lM410Ipi	:= ExistBlock("M410IPI")
Local lM410Icm	:= ExistBlock("M410ICM")
Local lM410Soli	:= ExistBlock("M410SOLI")
Local lUsaVenc  := .F.
Local lIVAAju   := .F.
Local lRastro	 := ExistBlock("MAFISRASTRO")
Local lRastroLot := .F.
Local lPParc	:=.F.
Local aSolid	:= {}
Local nLancAp	:=	0
Local aHeadCDA		:=	{}
Local aColsCDA		:=	{}
Local aTransp	:= {"",""}
Local aSaldos	:= {}
Local aInfLote	:= {}
Local a410Preco := {}  // Retorno da Project Function P_410PRECO com os novos valores das variaveis {nValMerc,nPrcLista}
Local nAcresUnit:= 0	// Valor do acrescimo financeiro do valor unitario
Local nAcresTot := 0	// Somatoria dos Valores dos acrescimos financeiros dos itens
Local dIni		:= Ctod("//")
Local cEstado	:= SuperGetMv("MV_ESTADO")
Local cTesVend  :=  SuperGetMv("MV_TESVEND",,"")
Local cCliPed   := ""
Local lCfo      := .F.
Local nlValor	:= 0
Local nValRetImp:= 0
Local cImpRet 	:= ""
Local cNatureza :=""
Local lM410FldR := .T.
Local aTotSolid := {}
Local nValTotal := 0 //Valor total utilizado no retorno quando lRetTotal for .T.
Local INCLUI:=.T.
Local ALTERA:=.F.
Default lRetTotal := .F.
Default aRefRentab := {}

PRIVATE oLancApICMS
PRIVATE _nTotOper_ := 0		//total de operacoes (vendas) realizadas com um cliente - calculo de IB - Argentina
Private _aValItem_ := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Busca referencias no SC6                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Busca referencias no SC5                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

SA4->(dbSetOrder(1))
If SA4->(dbSeek(xFilial("SA4")+M->C5_TRANSP))
	aTransp[01] := SA4->A4_EST
	aTransp[02] := Iif(SA4->(FieldPos("A4_TPTRANS")) > 0,SA4->A4_TPTRANS,"")
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a funcao fiscal                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³A Consultoria Tributária, por meio da Resposta à Consulta nº 268/2004, determinou a aplicação						   							³
// das seguintes alíquotas nas Notas Fiscais de venda emitidas pelo vendedor remetente:                                                             ³
//³1) no caso previsto na letra "a" (venda para SP e entrega no PR) - aplicação da alíquota 														³
// interna do Estado de São Paulo, visto que a operação entre o vendedor remetente e o adquirente originário é interna;                             ³
//³2) no caso previsto na letra "b" (venda para o DF e entrega no PR) - aplicação da alíquota interestadual 										³
// prevista para as operações com o Paraná, ou seja, 12%, visto que a circulação da mercadoria se dá entre os Estado de São Paulo e do Paraná.      ³
//³3) no caso previsto na letra "c" (venda para o RS e entrega no SP) - aplicação da alíquota interna do Estado de 									³
//São Paulo, uma vez que se considera interna a operação, quando não se comprovar a saída da mercadoria do território do Estado de São Paulo,		³
//³ conforme previsto no art. 36, § 4º do RICMS/SP 																									³                                                                                                                                                                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If len(aCols) > 0
	If cEstado == 'SP'
		If !Empty(M->C5_CLIENT) .And. M->C5_CLIENT <> M->C5_CLIENTE
			For nX := 1 To Len(aCols)
				If Alltrim(aCols[nX][nPTES])$ Alltrim(cTesVend)
					lCfo:= .T.
				EndIf
			Next
			If lCfo
				dbSelectArea(IIF(M->C5_TIPO$"DB","SA2","SA1"))
				dbSetOrder(1)
				MsSeek(xFilial()+M->C5_CLIENTE+M->C5_LOJAENT)
				If Iif(M->C5_TIPO$"DB", SA2->A2_EST,SA1->A1_EST) == 'SP'
					cCliPed := M->C5_CLIENTE
				Else
					cCliPed := M->C5_CLIENT
				EndIf
			EndIf
		EndIf
	EndIf
EndIf

MaFisSave()
MaFisEnd()
MaFisIni(IIf(!Empty(cCliPed),cCliPed,Iif(Empty(M->C5_CLIENT),M->C5_CLIENTE,M->C5_CLIENT)),;// 1-Codigo Cliente/Fornecedor
M->C5_LOJAENT,;		// 2-Loja do Cliente/Fornecedor
IIf(M->C5_TIPO$'DB',"F","C"),;				// 3-C:Cliente , F:Fornecedor
M->C5_TIPO,;				// 4-Tipo da NF
M->C5_TIPOCLI,;		// 5-Tipo do Cliente/Fornecedor
Nil,;
Nil,;
Nil,;
Nil,;
"MATA461",;
Nil,;
Nil,;
Nil,;
Nil,;
Nil,;
Nil,;
Nil,;
aTransp)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Realiza alteracoes de referencias do SC5         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aFisGetSC5) > 0
	dbSelectArea("SC5")
	For nY := 1 to Len(aFisGetSC5)
		If !Empty(&("M->"+Alltrim(aFisGetSC5[ny][2])))
			MaFisAlt(aFisGetSC5[ny][1],&("M->"+Alltrim(aFisGetSC5[ny][2])),,.F.)
		EndIf
	Next nY
Endif

//Na argentina o calculo de impostos depende da serie.
If cPaisLoc == 'ARG'
	SA1->(DbSetOrder(1))
	SA1->(MsSeek(xFilial()+IIf(!Empty(M->C5_CLIENT),M->C5_CLIENT,M->C5_CLIENTE)+M->C5_LOJAENT))
	MaFisAlt('NF_SERIENF',LocXTipSer('SA1',MVNOTAFIS))
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Tratamento de IB para monotributistas - Argentina           ³
	³ AGIP 177/2009                                               ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If SA1->A1_TIPO == "M"
		dIni := (dDatabase + 1) - 365
		_nTotOper_ := RetTotOper(SA1->A1_COD,SA1->A1_LOJA,"C",dIni,dDatabase,1)
	Endif
ElseIf cPaisLoc=="EQU"
	SA1->(DbSetOrder(1))
	SA1->(MsSeek(xFilial()+IIf(!Empty(M->C5_CLIENT),M->C5_CLIENT,M->C5_CLIENTE)+M->C5_LOJAENT))
	cNatureza:=SA1->A1_NATUREZ
	
	lPParc:=Posicione("SED",1,xFilial("SED")+cNatureza,"ED_RATRET")=="1"
Endif

If cPaisLoc<>"BRA"
	MaFisAlt('NF_MOEDA',M->C5_MOEDA)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Agrega os itens para a funcao fiscal         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nPTotal > 0 .And. nPValDesc > 0 .And. nPPrUnit > 0 .And. nPProduto > 0 .And. nPQtdVen > 0 .And. nPTes > 0
	For nX := 1 To Len(aCols)
		nQtdPeso := 0
		
		nItem++
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Tratamento de IB para monotributistas - Argentina           ³
		³ AGIP 177/2009                                               ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If cPaisLoc == "ARG"
			If SA1->A1_TIPO == "M"
				Aadd(_aValItem_,{nItem,.F.,xmoeda(aCols[nX][nPPrcVen],SC5->C5_MOEDA ,1,)})
			Endif
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Posiciona Registros                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lSaldo .And. nPItem > 0
			dbSelectArea("SC6")
			dbSetOrder(1)
			MsSeek(xFilial("SC6")+M->C5_NUM+aCols[nX][nPItem]+aCols[nX][nPProduto])
			nQtdEnt := IIf(!SubStr(SC6->C6_BLQ,1,1)$"RS" .And. Empty(SC6->C6_BLOQUEI),SC6->C6_QTDENT,SC6->C6_QTDVEN)
		Else
			lSaldo := .F.
		EndIf
		
		cProduto := aCols[nX][nPProduto]
		MatGrdPrRf(@cProduto)
		SB1->(dbSetOrder(1))
		If SB1->(MsSeek(xFilial("SB1")+cProduto))
			nQtdPeso := If(lSaldo,aCols[nX][nPQtdVen]-nQtdEnt,aCols[nX][nPQtdVen])*SB1->B1_PESO
		EndIf
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
		SB2->(dbSetOrder(1))
		SB2->(MsSeek(xFilial("SB2")+SB1->B1_COD+aCols[nX][nPLocal]))
		SF4->(dbSetOrder(1))
		SF4->(MsSeek(xFilial("SF4")+aCols[nX][nPTES]))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calcula o preco de lista                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nValMerc  := If(aCols[nX][nPQtdVen]==0,aCols[nX][nPTotal],If(lSaldo,(aCols[nX][nPQtdVen]-nQtdEnt)*aCols[nX][nPPrcVen],aCols[nX][nPTotal]))
		nPrcLista := aCols[nX][nPPrUnit]
		If ( nPrcLista == 0 )
			nValMerc  := If(aCols[nX][nPQtdVen]==0,aCols[nX][nPTotal],If(lSaldo,(aCols[nX][nPQtdVen]-nQtdEnt)*aCols[nX][nPPrcVen],aCols[nX][nPTotal]))
		EndIf
		nAcresUnit:= A410Arred(aCols[nX][nPPrcVen]*M->C5_ACRSFIN/100,"D2_PRCVEN")
		nAcresFin := A410Arred(If(lSaldo,aCols[nX][nPQtdVen]-nQtdEnt,aCols[nX][nPQtdVen])*nAcresUnit,"D2_TOTAL")
		nAcresTot += nAcresFin
		nValMerc  += nAcresFin
		nDesconto := a410Arred(nPrcLista*If(lSaldo,aCols[nX][nPQtdVen]-nQtdEnt,aCols[nX][nPQtdVen]),"D2_DESCON")-nValMerc
		nDesconto := IIf(nDesconto<=0,aCols[nX][nPValDesc],nDesconto)
		nDesconto := Max(0,nDesconto)
		nPrcLista += nAcresUnit
		//Para os outros paises, este tratamento e feito no programas que calculam os impostos.
		If cPaisLoc=="BRA" .or. GetNewPar('MV_DESCSAI','1') == "2"
			nValMerc  += nDesconto
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica a data de entrega para as duplicatas³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ( nPDtEntr > 0 )
			If ( dDataCnd > aCols[nX][nPDtEntr] .And. !Empty(aCols[nX][nPDtEntr]) )
				dDataCnd := aCols[nX][nPDtEntr]
			EndIf
		Else
			dDataCnd  := M->C5_EMISSAO
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Tratamento do IVA Ajustado                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SB1->(dbSetOrder(1))
		If SB1->(MsSeek(xFilial("SB1")+cProduto))
			lIVAAju := IIF(SB1->(FieldPos("B1_IVAAJU")) > 0 .And. SB1->B1_IVAAJU == '1' .And. (IIF(lRastro,lRastroLot := ExecBlock("MAFISRASTRO",.F.,.F.),Rastro(cProduto,"S"))),.T.,.F.)
		EndIf
		dbSelectArea("SC6")
		dbSetOrder(1)
		MsSeek(xFilial("SC6")+M->C5_NUM)
		If lIVAAju
			dbSelectArea("SC9")
			dbSetOrder(1)
			If MsSeek(xFilial("SC9")+SC6->C6_NUM+SC6->C6_ITEM)
				If ( SC9->C9_BLCRED $ "  10"  .And. SC9->C9_BLEST $ "  10")
					While ( !Eof() .And. SC9->C9_FILIAL == xFilial("SC9") .And.;
						SC9->C9_PEDIDO == SC6->C6_NUM .And.;
						SC9->C9_ITEM   == SC6->C6_ITEM )
						
						aadd(aSaldos,{SC9->C9_LOTECTL,SC9->C9_NUMLOTE,,,SC9->C9_QTDLIB})
						
						dbSelectArea("SC9")
						dbSkip()
					EndDo
				Else
					dbSelectArea("SC6")
					dbSetOrder(1)
					MsSeek(xFilial("SC6")+M->C5_NUM)
					lUsaVenc:= If(!Empty(SC6->C6_LOTECTL+SC6->C6_NUMLOTE),.T.,(SuperGetMv('MV_LOTVENC')=='S'))
					aSaldos := SldPorLote(aCols[nX][nPProduto],aCols[nX][nPLocal],aCols[nX][nPQtdVen]/* nQtdLib*/,0/*nQtdLib2*/,SC6->C6_LOTECTL,SC6->C6_NUMLOTE,SC6->C6_LOCALIZ,SC6->C6_NUMSERI,NIL,NIL,NIL,lUsaVenc,nil,nil,dDataBase)
				EndIf
			Else
				dbSelectArea("SC6")
				dbSetOrder(1)
				MsSeek(xFilial("SC6")+M->C5_NUM)
				lUsaVenc:= If(!Empty(SC6->C6_LOTECTL+SC6->C6_NUMLOTE),.T.,(SuperGetMv('MV_LOTVENC')=='S'))
				aSaldos := SldPorLote(aCols[nX][nPProduto],aCols[nX][nPLocal],aCols[nX][nPQtdVen]/* nQtdLib*/,0/*nQtdLib2*/,SC6->C6_LOTECTL,SC6->C6_NUMLOTE,SC6->C6_LOCALIZ,SC6->C6_NUMSERI,NIL,NIL,NIL,lUsaVenc,nil,nil,dDataBase)
			EndIf
			For nX1 := 1 to Len(aSaldos)
				nPropLot := aSaldos[nX1][5]
				If lRastroLot
					dbSelectArea("SB8")
					dbSetOrder(5)
					If MsSeek(xFilial("SB8")+cProduto+aSaldos[nX][01])
						aadd(aInfLote,{SB8->B8_DOC,SB8->B8_SERIE,SB8->B8_CLIFOR,SB8->B8_LOJA,nPropLot})
					EndIf
				Else
					dbSelectArea("SB8")
					dbSetOrder(2)
					If MsSeek(xFilial("SB8")+aSaldos[nX][02]+aSaldos[nX][01])
						aadd(aInfLote,{SB8->B8_DOC,SB8->B8_SERIE,SB8->B8_CLIFOR,SB8->B8_LOJA,nPropLot})
					EndIf
				EndIf
				dbSelectArea("SF3")
				dbSetOrder(4)
				If !Empty(aInfLote)
					If MsSeek(xFilial("SF3")+aInfLote[nX1][03]+aInfLote[nX1][04]+aInfLote[nX1][01]+aInfLote[nX1][02])
						aadd(aNfOri,{SF3->F3_ESTADO,SF3->F3_ALIQICM,aInfLote[nX1][05],0})
					EndIf
				EndIf
			Next nX1
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Agrega os itens para a funcao fiscal         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MaFisAdd(cProduto,;   	// 1-Codigo do Produto ( Obrigatorio )
		aCols[nX][nPTES],;	   	// 2-Codigo do TES ( Opcional )
		IIf(lSaldo,aCols[nX][nPQtdVen]-nQtdEnt,aCols[nX][nPQtdVen]),;  	// 3-Quantidade ( Obrigatorio )
		nPrcLista,;		  	// 4-Preco Unitario ( Obrigatorio )
		nDesconto,; 	// 5-Valor do Desconto ( Opcional )
		"",;	   			// 6-Numero da NF Original ( Devolucao/Benef )
		"",;				// 7-Serie da NF Original ( Devolucao/Benef )
		nRecOri,;					// 8-RecNo da NF Original no arq SD1/SD2
		0,;					// 9-Valor do Frete do Item ( Opcional )
		0,;					// 10-Valor da Despesa do item ( Opcional )
		0,;					// 11-Valor do Seguro do item ( Opcional )
		0,;					// 12-Valor do Frete Autonomo ( Opcional )
		nValMerc,;			// 13-Valor da Mercadoria ( Obrigatorio )
		0,;					// 14-Valor da Embalagem ( Opiconal )
		,;					// 15
		,;					// 16
		Iif(nPItem>0,aCols[nX,nPItem],""),; //17
		0,;					// 18-Despesas nao tributadas - Portugal
		0,;					// 19-Tara - Portugal
		aCols[nX,nPosCfo],; // 20-CFO
		aNfOri,;            // 21-Array para o calculo do IVA Ajustado (opcional)
		Iif(cPaisLoc=="EQU",aCols[nX,nPCodRet],""),;// 22-Codigo Retencao - Equador
		IIF(nPAbatISS>0,aCols[nX,nPAbatISS],0),; //23-Valor Abatimento ISS
		aCols[nX,nPLote],; // 24-Lote Produto
		aCols[nX,nPSubLot],;	// 25-Sub-Lote Produto
		,;
		,;
		Iif(Len(Alltrim(aCols[nX,nPClasFis]))==3,aCols[nX,nPClasFis],"")) // 28-Classificação fiscal
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Chamada de funcao via Project Function para manipulacao das variaveis nValMerc e nPrcLista       ³
		//³ exclusivamente para o projeto MOTOROLA, nao deve ser utilizado por clientes.                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If FindFunction("P_410PRECO")
			a410Preco := P_410PRECO( nX , nValMerc , nPrcLista )
			If Valtype(a410Preco) == "A"
				nValMerc  := a410Preco[1]
				nPrcLista := a410Preco[2]
			EndIf
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Tratamento do IVA Ajustado                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lIVAAju
			For nX1 := 1 To Len(aNfOri)
				MaFisAddIT("IT_ANFORI2",{aNfOri[nX1][__UFORI],aNfOri[nX1][__ALQORI],aNfOri[nX1][__PROPOR],0},nItem,nX1==1)
			Next nX1
			aSaldos :={}
			aNfOri  :={}
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Provincia de entrega - Ingresos Brutos       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cPaisLoc == "ARG"
			If nPProvEnt > 0
				MaFisAlt("IT_PROVENT",aCols[nX,nPProVent],nItem)
			Endif
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calculo do ISS                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SF4->(dbSetOrder(1))
		SF4->(MsSeek(xFilial("SF4")+aCols[nX][nPTES]))
		If ( M->C5_INCISS == "N" .And. M->C5_TIPO == "N")
			If ( SF4->F4_ISS=="S" )
				nPrcLista := a410Arred(nPrcLista/(1-(MaAliqISS(nItem)/100)),"D2_PRCVEN")
				nValMerc  := a410Arred(nValMerc/(1-(MaAliqISS(nItem)/100)),"D2_PRCVEN")
				MaFisAlt("IT_PRCUNI",nPrcLista,nItem)
				MaFisAlt("IT_VALMERC",nValMerc,nItem)
			EndIf
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Altera peso para calcular frete              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MaFisAlt("IT_PESO",nQtdPeso,nItem)
		MaFisAlt("IT_PRCUNI",nPrcLista,nItem)
		MaFisAlt("IT_VALMERC",nValMerc,nItem)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Analise da Rentabilidade                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SF4->F4_DUPLIC=="S"
			nTotDesc += MaFisRet(nItem,"IT_DESCONTO")
			nY := aScan(aRentab,{|x| x[1] == aCols[nX][nPProduto]})
			If nY == 0
				aadd(aRenTab,{aCols[nX][nPProduto],0,0,0,0,0})
				nY := Len(aRenTab)
			EndIf
			If cPaisLoc=="BRA"
				aRentab[nY][2] += (nValMerc - nDesconto)
			Else
				aRentab[nY][2] += nValMerc
			Endif
			aRentab[nY][3] += If(lSaldo,aCols[nX][nPQtdVen]-nQtdEnt,aCols[nX][nPQtdVen])*SB2->B2_CM1
		Else
			If GetNewPar("MV_TPDPIND","1")=="1"
				nTotDesc += MaFisRet(nItem,"IT_DESCONTO")
			EndIf
		EndIf
		
		If aCols[nX][nUsado+1]
			MaFisDel(nItem,aCols[nX][nUsado+1])
		EndIf
		
	Next nX
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Indica os valores do cabecalho               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ]
If ( ( cPaisLoc == "PER" .Or. cPaisLoc == "COL" ) .And. M->C5_TPFRETE == "F" ) .Or. ( cPaisLoc != "PER" .And. cPaisLoc != "COL" )
	MaFisAlt("NF_FRETE",M->C5_FRETE)
EndIf
MaFisAlt("NF_VLR_FRT",M->C5_VLR_FRT)
MaFisAlt("NF_SEGURO",M->C5_SEGURO)
MaFisAlt("NF_AUTONOMO",M->C5_FRETAUT)
MaFisAlt("NF_DESPESA",M->C5_DESPESA)
If cPaisLoc == "PTG"
	MaFisAlt("NF_DESNTRB",M->C5_DESNTRB)
	MaFisAlt("NF_TARA",M->C5_TARA)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Indenizacao por valor                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If M->C5_PDESCAB > 0
	MaFisAlt("NF_DESCONTO",A410Arred(MaFisRet(,"NF_VALMERC")*M->C5_PDESCAB/100,"C6_VALOR")+MaFisRet(,"NF_DESCONTO"))
EndIf

If M->C5_DESCONT > 0
	MaFisAlt("NF_DESCONTO",Min(MaFisRet(,"NF_VALMERC")-0.01,nTotDesc+M->C5_DESCONT),/*nItem*/,/*lNoCabec*/,/*nItemNao*/,GetNewPar("MV_TPDPIND","1")=="2" )
EndIf

If lM410Ipi .Or. lM410Icm .Or. lM410Soli
	nItem := 0
	aTotSolid := {}
	For nX := 1 To Len(aCols)
		nItem++
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Ponto de Entrada M410IPI para alterar os valores do IPI referente a palnilha financeira           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lM410Ipi
			VALORIPI    := MaFisRet(nItem,"IT_VALIPI")
			BASEIPI     := MaFisRet(nItem,"IT_BASEIPI")
			QUANTIDADE  := MaFisRet(nItem,"IT_QUANT")
			ALIQIPI     := MaFisRet(nItem,"IT_ALIQIPI")
			BASEIPIFRETE:= MaFisRet(nItem,"IT_FRETE")
			MaFisAlt("IT_VALIPI",ExecBlock("M410IPI",.F.,.F.,{ nItem }),nItem,.T.)
			MaFisLoad("IT_BASEIPI",BASEIPI ,nItem)
			MaFisLoad("IT_ALIQIPI",ALIQIPI ,nItem)
			MaFisLoad("IT_FRETE"  ,BASEIPIFRETE,nItem,"11")
			MaFisEndLoad(nItem,1)
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Ponto de Entrada M410ICM para alterar os valores do ICM referente a palnilha financeira           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lM410Icm
			_BASEICM    := MaFisRet(nItem,"IT_BASEICM")
			_ALIQICM    := MaFisRet(nItem,"IT_ALIQICM")
			_QUANTIDADE := MaFisRet(nItem,"IT_QUANT")
			_VALICM     := MaFisRet(nItem,"IT_VALICM")
			_FRETE      := MaFisRet(nItem,"IT_FRETE")
			_VALICMFRETE:= MaFisRet(nItem,"IT_ICMFRETE")
			_DESCONTO   := MaFisRet(nItem,"IT_DESCONTO")
			ExecBlock("M410ICM",.F.,.F., { nItem } )
			MaFisLoad("IT_BASEICM" ,_BASEICM    ,nItem)
			MaFisLoad("IT_ALIQICM" ,_ALIQICM    ,nItem)
			MaFisLoad("IT_VALICM"  ,_VALICM     ,nItem)
			MaFisLoad("IT_FRETE"   ,_FRETE      ,nItem)
			MaFisLoad("IT_ICMFRETE",_VALICMFRETE,nItem)
			MaFisLoad("IT_DESCONTO",_DESCONTO   ,nItem)
			MaFisEndLoad(nItem,1)
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Ponto de Entrada M410SOLI para alterar os valores do ICM Solidario referente a palnilha financeira³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lM410Soli
			ICMSITEM    := MaFisRet(nItem,"IT_VALICM")		// variavel para ponto de entrada
			QUANTITEM   := MaFisRet(nItem,"IT_QUANT")		// variavel para ponto de entrada
			BASEICMRET  := MaFisRet(nItem,"IT_BASESOL")	    // criado apenas para o ponto de entrada
			MARGEMLUCR  := MaFisRet(nItem,"IT_MARGEM")		// criado apenas para o ponto de entrada
			aSolid := ExecBlock("M410SOLI",.f.,.f.,{nItem})
			aSolid := IIF(ValType(aSolid) == "A" .And. Len(aSolid) == 2, aSolid,{})
			If !Empty(aSolid)
				MaFisLoad("IT_BASESOL",NoRound(aSolid[1],2),nItem)
				MaFisLoad("IT_VALSOL" ,NoRound(aSolid[2],2),nItem)
				MaFisEndLoad(nItem,1)
				AAdd(aTotSolid, { nItem , NoRound(aSolid[1],2) , NoRound(aSolid[2],2)} )
			Endif
		EndIf
	Next
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Realiza alteracoes de referencias do SC6         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC6")
If Len(aFisGet) > 0
	For nX := 1 to Len(aCols)
		If Len(aCols[nX])==nUsado .Or. !aCols[nX][Len(aHeader)+1]
			For nY := 1 to Len(aFisGet)
				nPosCpo := aScan(aHeader,{|x| AllTrim(x[2])==Alltrim(aFisGet[ny][2])})
				If nPosCpo > 0
					If !Empty(aCols[nX][nPosCpo])
						MaFisAlt(aFisGet[ny][1],aCols[nX][nPosCpo],nX,.F.)
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Quando o ponto de Entrada M410SOLI retornar valores forcar o recalculo pois o MaFisAlt acima      ³
						//³recalculava os valores retornados pelo ponto anulando a sua acao.                                 ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If lM410Soli .And. !Empty(aTotSolid)
							nPosSolid := Ascan(aTotSolid,{|x| x[1] == nX })
							If nPosSolid > 0
								MaFisLoad("IT_BASESOL", aTotSolid[nPosSolid,02] ,nX )
								MaFisLoad("IT_VALSOL" , aTotSolid[nPosSolid,03] ,nX )
								MaFisEndLoad(nX,1)
							EndIf
						Endif
					Endif
				EndIf
			Next nY
		Endif
	Next nX
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Realiza alteracoes de referencias do SC5 Suframa ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nPSuframa:=aScan(aFisGetSC5,{|x| x[1] == "NF_SUFRAMA"})
If !Empty(nPSuframa)
	dbSelectArea("SC5")
	If !Empty(&("M->"+Alltrim(aFisGetSC5[nPSuframa][2])))
		MaFisAlt(aFisGetSC5[nPSuframa][1],Iif(&("M->"+Alltrim(aFisGetSC5[nPSuframa][2])) == "1",.T.,.F.),nItem,.F.)
	EndIf
Endif
If ExistBlock("M410PLNF")
	ExecBlock("M410PLNF",.F.,.F.)
EndIf
MaFisWrite(1)

/*------------------------------------------------------------------------------//
// Template GEM - Gestao de Empreendimentos Imobiliarios							//
//																							//
// Verifica se a condicao de pagamento tem vinculacao com uma condicao de venda	//
//-------------------------------------------------------------------------------*/
If ExistTemplate("GMCondPagto")
	lCondVenda := .F.
	lCondVenda := ExecTemplate("GMCondPagto",.F.,.F.,{M->C5_CONDPAG,} )
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calcula os venctos conforme a condicao de pagto  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !M->C5_TIPO == "B"
	If lDtEmi
		dbSelectarea("SE4")
		dbSetOrder(1)
		MsSeek(xFilial("SE4")+M->C5_CONDPAG)
		If ((SE4->E4_TIPO=="9".AND.!(INCLUI.OR.ALTERA)).OR.SE4->E4_TIPO<>"9")
			
			If SFB->FB_JNS == 'J' .And. cPaisLoc == 'COL'
				dbSelectArea("SFC")
				dbSetOrder(2)
				If dbSeek(xFilial("SFC") + SF4->F4_CODIGO + "RV0" )
					nValRetImp 	:= MaFisRet(,"NF_VALIV2")
					Do Case
						Case FC_INCDUPL == '1'
							nlValor := MaFisRet(,"NF_BASEDUP") - nValRetImp
						Case FC_INCDUPL == '2'
							nlValor :=MaFisRet(,"NF_BASEDUP") + nValRetImp
						Otherwise
							nlValor :=MaFisRet(,"NF_BASEDUP")
					EndCase
				Elseif dbSeek(xFilial("SFC") + SF4->F4_CODIGO + "RF0" )
					nValRetImp 	:= MaFisRet(,"NF_VALIV4")
					Do Case
						Case FC_INCDUPL == '1'
							nlValor := MaFisRet(,"NF_BASEDUP") - nValRetImp
						Case FC_INCDUPL == '2'
							nlValor :=MaFisRet(,"NF_BASEDUP") + nValRetImp
						Otherwise
							nlValor :=MaFisRet(,"NF_BASEDUP")
					EndCase
				Elseif dbSeek(xFilial("SFC") + SF4->F4_CODIGO + "RC0" )
					nValRetImp 	:= MaFisRet(,"NF_VALIV7")
					Do Case
						Case FC_INCDUPL == '1'
							nlValor := MaFisRet(,"NF_BASEDUP") - nValRetImp
						Case FC_INCDUPL == '2'
							nlValor :=MaFisRet(,"NF_BASEDUP") + nValRetImp
						Otherwise
							nlValor :=MaFisRet(,"NF_BASEDUP")
					EndCase
				Endif
			Else
				nlValor := MaFisRet(,"NF_BASEDUP")
			EndIf
			
			aDupl := Condicao(nlValor,M->C5_CONDPAG,MaFisRet(,"NF_VALIPI"),dDataCnd,MaFisRet(,"NF_VALSOL"),,,nAcresTot)
			If Len(aDupl) > 0
				If ! lCondVenda
					For nX := 1 To Len(aDupl)
						nAcerto += aDupl[nX][2]
					Next nX
					aDupl[Len(aDupl)][2] += MaFisRet(,"NF_BASEDUP") - nAcerto
				EndIf
				
				aVencto := aClone(aDupl)
				For nX := 1 To Len(aDupl)
					aDupl[nX][2] := TransForm(aDupl[nX][2],PesqPict("SE1","E1_VALOR"))
				Next nX
			Endif
		Else
			aDupl := {{Ctod(""),TransForm(MaFisRet(,"NF_BASEDUP"),PesqPict("SE1","E1_VALOR"))}}
			aVencto := {{dDataBase,MaFisRet(,"NF_BASEDUP")}}
		EndIf
	Else
		nItem := 0
		For nX := 1 to Len(aCols)
			If Len(aCols[nX])==nUsado .Or. !aCols[nX][nUsado+1]
				If nPDtEntr > 0
					nItem++
					nPosEntr := Ascan(aEntr,{|x| x[1] == aCols[nX][nPDtEntr]})
					If nPosEntr == 0
						Aadd(aEntr,{aCols[nX][nPDtEntr],MaFisRet(nItem,"IT_BASEDUP"),MaFisRet(nItem,"IT_VALIPI"),MaFisRet(nItem,"IT_VALSOL")})
					Else
						aEntr[nPosEntr][2]+= MaFisRet(nItem,"IT_BASEDUP")
						aEntr[nPosEntr][3]+= MaFisRet(nItem,"IT_VALIPI")
						aEntr[nPosEntr][4]+= MaFisRet(nItem,"IT_VALSOL")
					EndIf
				Endif
			Endif
		Next
		dbSelectarea("SE4")
		dbSetOrder(1)
		MsSeek(xFilial("SE4")+M->C5_CONDPAG)
		If !(SE4->E4_TIPO=="9")
			For nY := 1 to Len(aEntr)
				nAcerto  := 0
				
				If SFB->FB_JNS $ 'J/S' .And. cPaisLoc == 'COL'
					
					dbSelectArea("SFC")
					dbSetOrder(2)
					If dbSeek(xFilial("SFC") + SF4->F4_CODIGO + "RV0" )
						nValRetImp 	:= MaFisRet(,"NF_VALIV2")
						Do Case
							Case FC_INCDUPL == '1'
								nlValor := aEntr[nY][2] - nValRetImp
							Case FC_INCDUPL == '2'
								nlValor :=aEntr[nY][2] + nValRetImp
							Otherwise
								nlValor :=aEntr[nY][2]
						EndCase
					Elseif dbSeek(xFilial("SFC") + SF4->F4_CODIGO + "RF0" )
						nValRetImp 	:= MaFisRet(,"NF_VALIV4")
						Do Case
							Case FC_INCDUPL == '1'
								nlValor := aEntr[nY][2] - nValRetImp
							Case FC_INCDUPL == '2'
								nlValor :=aEntr[nY][2] + nValRetImp
							Otherwise
								nlValor :=aEntr[nY][2]
						EndCase
					Elseif dbSeek(xFilial("SFC") + SF4->F4_CODIGO + "RC0" )
						nValRetImp 	:= MaFisRet(,"NF_VALIV7")
						Do Case
							Case FC_INCDUPL == '1'
								nlValor := aEntr[nY][2] - nValRetImp
							Case FC_INCDUPL == '2'
								nlValor :=aEntr[nY][2] + nValRetImp
							Otherwise
								nlValor :=aEntr[nY][2]
						EndCase
					Endif
				ElseIf cPaisLoc=="EQU" .And. lPParc
					DbSelectArea("SFC")
					SFC->(dbSetOrder(2))
					If DbSeek(xFilial("SFC") + SF4->F4_CODIGO + "RIR") //Retenção IVA
						cImpRet		:= SFC->FC_IMPOSTO
						DbSelectArea("SFB")
						SFB->(dbSetOrder(1))
						If SFB->(DbSeek(xFilial("SFB")+AvKey(cImpRet,"FB_CODIGO")))
							nValRetImp 	:= MaFisRet(,"NF_VALIV"+SFB->FB_CPOLVRO)
						Endif
						DbSelectArea("SFC")
						If SFC->FC_INCDUPL == '1'
							nlValor	:=aEntr[nY][2] - nValRetImp
						ElseIf SFC->FC_INCDUPL == '2'
							nlValor :=aEntr[nY][2] + nValRetImp
						EndIf
					Endif
				Else
					nlValor := aEntr[nY][2]
				EndIf
				
				
				aDuplTmp := Condicao(nlValor,M->C5_CONDPAG,aEntr[nY][3],aEntr[nY][1],aEntr[nY][4],,,nAcresTot)
				If Len(aDuplTmp) > 0
					If ! lCondVenda
						If cPaisLoc=="EQU"
							For nX := 1 To Len(aDuplTmp)
								If nX==1
									If SFC->FC_INCDUPL == '1'
										aDuplTmp[nX][2]+= nValRetImp
									ElseIf SFC->FC_INCDUPL == '2'
										aDuplTmp[nX][2]-= nValRetImp
									Endif
								Endif
							Next nX
						Else
							For nX := 1 To Len(aDuplTmp)
								nAcerto += aDuplTmp[nX][2]
							Next nX
							aDuplTmp[Len(aDuplTmp)][2] += aEntr[nY][2] - nAcerto
						Endif
					EndIf
					
					aVencto := aClone(aDuplTmp)
					For nX := 1 To Len(aDuplTmp)
						aDuplTmp[nX][2] := TransForm(aDuplTmp[nX][2],PesqPict("SE1","E1_VALOR"))
					Next nX
					aEval(aDuplTmp,{|x| Aadd(aDupl,{aEntr[nY][1],x[1],x[2]})})
				EndIf
			Next
		Else
			aDupl := {{Ctod(""),TransForm(MaFisRet(,"NF_BASEDUP"),PesqPict("SE1","E1_VALOR"))}}
			aVencto := {{dDataBase,MaFisRet(,"NF_BASEDUP")}}
		EndIf
	EndIf
Else
	aDupl := {{Ctod(""),TransForm(0,PesqPict("SE1","E1_VALOR"))}}
	aVencto := {{dDataBase,0}}
EndIf
//
// Template GEM - Gestao de empreendimentos Imobiliarios
// Gera os vencimentos e valores das parcelas conforme a condicao de venda
//
If lCondVenda
	If ExistBlock("GMMA410Dupl")
		aVencto := ExecBlock("GMMA410Dupl",.F.,.F.,{M->C5_NUM ,M->C5_CONDPAG,dDataCnd,,MaFisRet(,"NF_BASEDUP") ,aVencto}, .F., .F.)
	ElseIf ExistTemplate("GMMA410Dupl")
		aVencto := ExecTemplate("GMMA410Dupl",.F.,.F.,{M->C5_NUM ,M->C5_CONDPAG,dDataCnd,,MaFisRet(,"NF_BASEDUP") ,aVencto})
	Endif
	aDupl := {}
	aEval(aVencto ,{|aTitulo| aAdd( aDupl ,{transform(aTitulo[1],x3Picture("E1_VENCTO")) ,transform(aTitulo[2],x3Picture("E1_VALOR"))}) })
EndIf

If Len(aDupl) == 0
	aDupl := {{Ctod(""),TransForm(MaFisRet(,"NF_BASEDUP"),PesqPict("SE1","E1_VALOR"))}}
	aVencto := {{dDataBase,MaFisRet(,"NF_BASEDUP")}}
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Analise da Rentabilidade - Valor Presente    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aRentabil := {}//a410RentPV( aCols ,nUsado ,@aRenTab ,@aVencto ,nPTES,nPProduto,nPLocal,nPQtdVen, M->C5_EMISSAO )



nValTotal := MaFisRet(,"NF_TOTAL")


MaFisEnd()
MaFisRestore()

RestArea(aAreaSA1)
RestArea(aArea)

aRefRentab := aRentabil

If SuperGetMv("MV_RSATIVO",.F.,.F.)
	lPlanRaAtv := .T.
EndIf
Return nValTotal

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR110  ºAutor  ³Microsiga           º Data ³  06/05/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function EnvMail(cCartaDep,cReserva,cMensagem)
Local oDlg
Local oCarta
Local oReserva

Local cServer	:= GetNewPar("MV_RELSERV","")
Local cAccount	:= GetNewPar("MV_RELACNT","")
Local cPassword	:= GetNewPar("MV_RELAPSW","")
Local lMailAuth	:= GetNewPar("MV_RELAUTH",.F.)

Local cEmailTo	:= AllTrim(SC5->C5_XDESPVV)
Local cEmailCc	:= Padr( AllTrim(UsrRetMail(__cUserId)),250)
Local cAssunto	:= ""

Local cPreNota	:= U_NC110GetArq()
Local cErro		:= ""
Local lFranqueado	:=	FWIsInCallStack("U_WM001Send")
Local oFont		:= TFont():New( "Arial",,20,,.T.,,,,,.T. )
Local lEnviar	:=.F.

Local aSize 	:= MsAdvSize()
Local aObjects	:= {}
Local aInfo		:= {}
Local aPosObj	:= {}
Local aPosFld	:= {}
Local aObjFld	:= {}
Default cMensagem		:= ""


aSizeAut	:= MsAdvSize(,.F.,400)
AAdd( aObjects, { 0,    60, .T., .F. } )
AAdd( aObjects, { 100, 100, .T., .T. } )


aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )
nGd1 := aPosObj[2,1]
nGd2 := aPosObj[2,2]
nGd3 := aPosObj[2,3]-20
nGd4 := aPosObj[2,4]


If lFranqueado
	cAssunto:=Padr( "Pedido de Venda "+SC5->C5_NUM+" e Reserva de Produtos",250)
	lEnviar	:= .F. //.T. enviar email em todas as gravações de pedido...
	If !Empty(cEmailCc)
		cEmailCc := Alltrim(cEmailCc)+";"+Alltrim(U_MyNewSX6("NCG_000089","rciambarella@ncgames.com.br","C","E-mail dos usuários que irão realizar a gestão das lojas","","",.F. )) 
	Else 
		cEmailCc := Alltrim(U_MyNewSX6("NCG_000089","rciambarella@ncgames.com.br","C","E-mail dos usuários que irão realizar a gestão das lojas","","",.F. ))
	EndIf
Else
	cAssunto		:=Padr( IIf(INCLUI,"Inclusão","Alteração")+" do Pedido de Venda "+SC5->C5_NUM+" e Reserva de Produtos",250)
	DEFINE MSDIALOG oDlg TITLE OemtoAnsi("Venda a Vista") From  aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL
	
	TSay():New( aPosObj[1,1],    aPosObj[2,2],{||  "Para   :"},oDlg,,oFont,.F.,.F.,.F.,.T.,,,,,.F.,.F.,.F.,.F.,.F.,.F. )
	TSay():New( aPosObj[1,1]+20, aPosObj[2,2],{||  "CC     :"},oDlg,,oFont,.F.,.F.,.F.,.T.,,,,,.F.,.F.,.F.,.F.,.F.,.F. )
	TSay():New( aPosObj[1,1]+40, aPosObj[2,2],{||  "Assunto:"},oDlg,,oFont,.F.,.F.,.F.,.T.,,,,,.F.,.F.,.F.,.F.,.F.,.F. )
	
	
	@aPosObj[1,1],70    Get cEmailTo Size 250,05
	@aPosObj[1,1]+20,70 Get cEmailCc Size 250,05
	@aPosObj[1,1]+40,70 Get cAssunto Size 250,05
	
	oFoldItens := TFolder():New(aPosObj[2,1],aPosObj[2,2],{"Carta Deposito","Reserva"},{'','','','',''},oDlg,,,,.T.,.F.,(aPosObj[2,4]-aPosObj[2,2]),(aPosObj[2,3]-aPosObj[2,1]-20 ))
	
	nGd1:=1
	nGd2:=1
	nGd3 := aPosObj[2,3]-aPosObj[2,1]-25
	nGd4 := aPosObj[2,4]-aPosObj[2,2]-4
	
	oCarta:=TSimpleEditor():New(nGd1,nGd2,oFoldItens:aDialogs[1],nGd3, nGd4,,.T. )
	oCarta:Load(cCartaDep)
	
	oReserva:=TSimpleEditor():New(nGd1,nGd2,oFoldItens:aDialogs[2],nGd3, aPosObj[2,4],,.T. )
	oReserva:Load(cReserva)
	
	Activate Dialog oDlg Centered On Init EnchoiceBar(oDlg,{|| lEnviar:=.T., oDlg:End() },{|| lEnviar:=.F.,oDlg:End() })
	
	
EndIf
If lEnviar
	
	If MailSmtpOn( cServer, cAccount, cPassword )
		If lMailAuth
			If ! ( lRetorno := MailAuth(cAccount,cPassword) )
				lRetorno := MailAuth(SubStr(cAccount,1,At("@",cAccount)-1),cPassword)
			EndIf
		Endif
		
		aAnexos:={"\spool\"+cPreNota+".pdf"}
		
		If !lFranqueado
			MemoWrite("\Spool\Reserva_Pedido_"+SC5->C5_NUM+".html",cReserva)
			cMensagem:=cCartaDep
			AADD(aAnexos,"\Spool\Reserva_Pedido_"+SC5->C5_NUM+".html")
		EndIf
		
		
		If lRetorno
			If !MailSend(cAccount,{cEmailTo},{cEmailCc},{},cAssunto,cMensagem,aAnexos,.F.)
				cErro := "Erro na tentativa de e-mail para " + cEmailTo + ". " + Mailgeterr()
			EndIf
		Else
			cErro := "Erro na tentativa de autenticação da conta " + cAccount + ". "
		EndIf
		MailSmtpOff()
	Else
		cErro := "Erro na tentativa de conexão com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
	EndIf
	
	If !Empty(cErro)
		MsgStop(cErro)
	Else
		MsgInfo("E-mail enviado com sucesso.")
	EndIf
	
	
	SC5->(RecLock("SC5",.F.))
	SC5->C5_XDESPVV :=cEmailTo
	SC5->(MsUnlock())
	
EndIf

FErase(GETTEMPPATH()+"totvsprinter\"+SC5->C5_NUM+".pdf")

Return
