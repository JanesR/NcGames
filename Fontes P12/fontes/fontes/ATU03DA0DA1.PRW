#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "AP5MAIL.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ATU03DA0DA1�Autor  �Microsiga           � Data �  12/08/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function ATU03DA0DA1()
Private _aUser := PswRet(1)

// PREPARE ENVIRONMENT EMPRESA '01' Filial '01' MODULO "FAT" Tables "SC5","SC6","SZH","SZJ","DA0","DA1"
//Processa ({|| ATUJADA01() })
Processa ({ || u_NCPREATUAL() })
//RESET ENVIRONMENT
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ATU03DA0DA1�Autor  �Microsiga           � Data �  12/08/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function ATUJADA01()
Private _cProduto := Space(15)
Private _cTabelas := AllTrim(SuperGetMv("MV_NCTABPR",.F.,""))
Private _aTabsOK  := {}

dbSelectArea("SZJ")
dbSetOrder(3)            // ZJ_FILIAL+ZJ_DTPROG+ZJ_CODIGO
dbSeek(xFilial("SZJ"),.T.)

Do While !Eof() .And. SZJ->ZJ_DTPROG <= dDataBase
	If SZJ->ZJ_STATUS <> "1"
		dbSkip()
		Loop
	EndIf
	If SZJ->ZJ_DTPROG > dDataBase
		dbSkip()
		Loop
	EndIf
	AADD(_aTabsOK,{SZJ->ZJ_CODIGO,AllTrim(GETADVFVAL("DA0","DA0_DESCRI",XFILIAL("DA0")+SZJ->ZJ_CODIGO,1,SPACE(30)))})
	
	dbSelectArea("SZH")
	dbSetOrder(3)           // ZH_FILIAL+ZH_CODIGO+ZH_ITEM
	dbSeek(xFilial("SZH")+SZJ->ZJ_CODIGO,.T.)
	Do While !Eof() .And. SZJ->ZJ_CODIGO == SZH->ZH_CODIGO
		//      Verifica se o produto existe na tabela XXX e nas tabelas contidas no parametro MV_NCTABPR, caso n�o exista sera criado.
		_cProduto := SZH->ZH_PRODUTO
		VrfcPrds() // VERIFICA_PRODS
		//      Fim verifica��o
		
		dbSelectArea("DA1")
		dbSetOrder(2)               // DA1_FILIAL+DA1_CODPRO+DA1_CODTAB+DA1_ITEM
		If dbSeek(xFilial("DA1")+_cProduto+"XXX",.T.)
			RecLock("DA1",.F.)
			DA1->DA1_PRCVEN  := SZH->ZH_PRV0
			MsUnlock()
		EndIf
		
		dbSelectArea("SB1")
		dbSetOrder(1)
		If dbSeek(xFilial("SB1")+SZH->ZH_PRODUTO)
			RecLock("SB1",.F.)
			SB1->B1_CONSUMI  := SZH->ZH_PRVSUG
			SB1->B1_PRV1     := SZH->ZH_PRV0
			SB1->B1_XPRV18   := SZH->ZH_PRV0 / GetAdvFVal("SZU","ZU_FATOR",xFilial("SZU")+"018",1,0.00)
			SB1->B1_XPRV12   := SZH->ZH_PRV0 / GetAdvFVal("SZU","ZU_FATOR",xFilial("SZU")+"012",1,0.00)
			SB1->B1_XPRV07   := SZH->ZH_PRV0 / GetAdvFVal("SZU","ZU_FATOR",xFilial("SZU")+"007",1,0.00)
			MsUnlock()
			//TabConsu(SZH->ZH_PRODUTO,SZH->ZH_PRVSUG)
		EndIf
		dbSelectArea("SZH")
		dbSkip()
	EndDo
	dbSelectArea("SZJ")
	RecLock("SZJ",.F.)
	SZJ->ZJ_STATUS := "2"
	MsUnlock()
	dBSkip()
EndDo
//
//  Atualiza todas as TABELAS BASE contidas no par�metro MV_NCTABPR, a partir da tabela "XXX"
//
Private _nIndice   := 0.00
Private _cTabBase  := "XXX"

dbSelectArea("DA0")
dbSetOrder(1)            // DA0_FILIAL+DA0_CODTAB
dbSeek(xFilial("DA0"),.T.)
Do While !Eof() .And. DA0->DA0_CODTAB <= "100"
	If DA0->DA0_CODTAB == "XXX" .Or. Empty(DA0->DA0_TABBAS)
		dbSkip()
		Loop
	EndIf
	If DA0->DA0_TABBAS <> "XXX"
		dbSkip()
		Loop
	EndIf
	If !(AllTrim(DA0->DA0_CODTAB) $ _cTabelas)
		dbSkip()
		Loop
	EndIf

	dbSelectArea("SZU")
	dbSetOrder(1)               // ZU_FILIAL+ZU_CODTAB
	If dbSeek(xFilial("SZU")+DA0->DA0_CODTAB)
		_cTabBase := "XXX"
		_nIndice  := SZU->ZU_FATOR
	EndIf
	
	Private _nPrcVen 		:= 0.00

	cQry := " "
	cQry += " UPDATE DA1010 TB SET "
	cQry += " TB.DA1_PRCVEN = Round((SELECT max(DA1_PRCVEN) / "+alltrim(str(_nIndice))+" FROM DA1010 BS "
	cQry += " 												WHERE BS.D_E_L_E_T_ = ' ' "
	cQry += " 												AND BS.DA1_FILIAL = '"+xFilial("DA1")+"' "
	cQry += " 												AND BS.DA1_CODPRO = TB.DA1_CODPRO "
	cQry += " 												AND BS.DA1_CODTAB = '"+_cTabBase+"'),2) "
	cQry += " WHERE TB.D_E_L_E_T_ = ' ' "
	cQry += " AND TB.DA1_CODTAB = '"+ALLTRIM(DA0->DA0_CODTAB)+"' "
	cQry += " AND TB.DA1_FILIAL = '"+xFilial("DA1")+"' "
	cQry += " AND (SELECT max(DA1_PRCVEN) / "+alltrim(str(_nIndice))+" FROM DA1010 BS "
	cQry += " 									WHERE BS.D_E_L_E_T_ = ' ' "
	cQry += " 									AND BS.DA1_FILIAL = '"+xFilial("DA1")+"' "
	cQry += " 									AND BS.DA1_CODPRO = TB.DA1_CODPRO "
	cQry += " 									AND BS.DA1_CODTAB = '"+_cTabBase+"') IS NOT NULL "
	
	TCSQLEXEC(cQry)
	
	TCSQLEXEC("COMMIT")

	dbSelectArea("DA0")
	dbSkip()
EndDo


//  Atualiza todas as tabelas overprice com base em suas tabelas base
Private _nIndice  := 0.00
Private _cTabBase := Space(03)

dbSelectArea("DA0")
dbSetOrder(1) // DA0_FILIAL+DA0_CODTAB
dbSeek(xFilial("DA0")+"101",.T.)
Do While !Eof() .And. DA0->DA0_CODTAB > "100" .And. DA0->DA0_CODTAB < "XXX"
	If DA0->DA0_CODTAB >= "XXX" .Or. Empty(DA0->DA0_TABBAS)
		dbSkip()
		Loop
	EndIf
	If DA0->DA0_TABBAS == "XXX"
		dbSkip()
		Loop
	EndIf
	
	dbSelectArea("SZK")
	dbSetOrder(3)               // ZK_FILIAL+ZK_TABAATU
	If dbSeek(xFilial("SZK")+DA0->DA0_CODTAB)
		_cTabBase := SZK->ZK_TABBASE
		_nIndice  := SZK->ZK_INDICE
	EndIf
	
	If DA0->DA0_TABBAS <> _cTabBase
		//Alert("Dados divergentes...  Tabela Base informada na Tabela de preco e na Amarracao para atualizacao nao sao as mesmas...")
		dbSelectArea("DA0")
		dbSkip()
		Loop
	EndIf
	
	Private _nPrcVen := 0.00
	
	cQry := " "
	cQry += " UPDATE DA1010 TB SET "
	cQry += " TB.DA1_PRCVEN = ROUND((SELECT max(DA1_PRCVEN) / (1 - ("+alltrim(str(_nIndice))+"/100)) FROM DA1010 BS "
	cQry += " 												WHERE BS.D_E_L_E_T_ = ' ' "
	cQry += " 												AND BS.DA1_FILIAL = '"+xFilial("DA1")+"' "
	cQry += " 												AND BS.DA1_CODPRO = TB.DA1_CODPRO "
	cQry += " 												AND BS.DA1_CODTAB = '"+_cTabBase+"'),2) "
	cQry += " WHERE TB.D_E_L_E_T_ = ' ' "
	cQry += " AND TB.DA1_CODTAB = '"+ALLTRIM(DA0->DA0_CODTAB)+"' "
	cQry += " AND TB.DA1_FILIAL = '"+xFilial("DA1")+"' "
	cQry += " AND TB.DA1_YATUPR <> 'N' "
	cQry += " AND (SELECT max(DA1_PRCVEN) / (1 - ("+alltrim(str(_nIndice))+"/100)) FROM DA1010 BS "
	cQry += " 									WHERE BS.D_E_L_E_T_ = ' ' "
	cQry += " 									AND BS.DA1_FILIAL = '"+xFilial("DA1")+"' "
	cQry += " 									AND BS.DA1_CODPRO = TB.DA1_CODPRO "
	cQry += " 									AND BS.DA1_CODTAB = '"+_cTabBase+"') IS NOT NULL "
	
	TCSQLEXEC(cQry)
	
	TCSQLEXEC("COMMIT")

	dbSelectArea("DA0")
	dbSkip()
EndDo
//Alert("Atualizacao Concluida... Favor conferir tabelas envolvidas nesse periodo de testes para posterior subtituicao dessa mensagem...")
If Len(_aTabsOK) > 0
	Env_AtuMail()
EndIf
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VrfcPrds 	�Autor  �Microsiga           � Data �  12/08/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VrfcPrds()
Private _cItem    := Space(04)
Private _cTabAtu  := "XXX"   // Space(03)
Private _nI       := 0

dbSelectArea("DA1")
dbSetOrder(2)               // DA1_FILIAL+DA1_CODPRO+DA1_CODTAB+DA1_ITEM
If !(dbSeek(xFilial("DA1")+_cProduto+_cTabAtu,.T.))
	IncSB1() // Inclui_Prods
EndIf

For _nI := 1  To  Len(_cTabelas)  Step 4
	_cTabAtu := Substr(_cTabelas,_nI,3)
	
	dbSelectArea("DA1")
	dbSetOrder(2)               // DA1_FILIAL+DA1_CODPRO+DA1_CODTAB+DA1_ITEM
	If !(dbSeek(xFilial("DA1")+_cProduto+_cTabAtu,.T.))
		INCSB1() // Inclui_Prods
	EndIf
Next
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �INCSB1	�Autor  �Microsiga           � Data �  12/08/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function INCSB1()
Private _cItem     := Space(04)
Private _cProxItem := Space(04)

dbSelectArea("DA1")
dbSetOrder(3)               // DA1_FILIAL+DA1_CODTAB+DA1_ITEM
dbSeek(xFilial("DA1")+_cTabAtu,.T.)
Do While !Eof() .And. DA1->DA1_CODTAB == _cTabAtu
	_cItem := DA1->DA1_ITEM
	dbSkip()
EndDo
_cProxItem := Soma1(_cItem,4)

RecLock("DA1",.T.)

DA1->DA1_FILIAL  := xFilial("DA1")
DA1->DA1_ITEM    := _cProxItem
DA1->DA1_CODTAB  := _cTabAtu
DA1->DA1_CODPRO  := _cProduto
DA1->DA1_GRUPO   := SPACE(04)
DA1->DA1_REFGRD  := SPACE(26)
DA1->DA1_PRCVEN  := 0.00
DA1->DA1_VLRDES  := 0.00
DA1->DA1_PERDES  := 0.0000
DA1->DA1_ATIVO   := "1"
DA1->DA1_FRETE   := 0.00
DA1->DA1_ESTADO  := SPACE(02)
DA1->DA1_TPOPER  := "4"
DA1->DA1_QTDLOT  := 999999.99
DA1->DA1_INDLOT  := "000000000999999.99"
DA1->DA1_MOEDA   := 1
DA1->DA1_DATVIG  := CtoD("20140101")
DA1->DA1_ITEMGR  := SPACE(03)
DA1->DA1_PRCMAX  := 0.00
DA1->DA1_XMOT    := SPACE(06)
DA1->DA1_XMOTD   := SPACE(60) 

MsUnlock()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ATU03DA0DA1�Autor  �Microsiga           � Data �  12/08/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function Env_ATUMail()
Private _cServer   := GetNewPar("MV_RELSERV","")             // "mail.emd.com.br:587"
Private _cAccount  := GetNewPar("MV_RELACNT","")             // "avisoprotheus@emd.com.br"
Private _cEnvia    := GetNewPar("MV_RELACNT","")             // "avisoprotheus@emd.com.br"
Private _cPassword := GetNewPar("MV_RELAPSW","")             // 'emdavisop367'
Private _lMailAuth := GetNewPar("MV_RELAUTH",.F.)
Private _cUserAp   := GetNewPar("MV_NCAPTAB","")             // Usuario aprovador.
Private _cCRLF     := Chr(13) + Chr(10)

Private _nI        := 0
Private _cUser     := RetCodUsr(Substr(cUsuario,1,6))
Private _cNomeusr  := UsrRetName(_cUser)
Private _cRecebe   := UsrRetMail(AllTrim(_cUserAp))

Private _cVendedor := Space(06)
Private _cEMailVen := Space(30)
Private _cVenEMail := Space(01)

Private _cTabs     := Space(06)
Private _cDescri   := Space(30)

Private _cAssunto  := "ATUALIZA��O DE TABELA(S) INTERMEDIARIA(S)"
Private _cMensagem := ""

_cMensagem += '<html>'
_cMensagem += '<head>'
_cMensagem += '<title> Sem Titulo </title>'
_cMensagem += '</head>' + _cCRLF
_cMensagem += '<BODY>'  + _cCRLF
_cMensagem += '<DIV>'   + _cCRLF
_cMensagem += '<DIV><IMG alt="" hspace=0 src="C:\Logo Email.jpg" border=0></DIV>'
_cMensagem += '<DIV> <hr color=CC0000> </DIV>' + _cCRLF + _cCRLF

_cMensagem += '<font size="3" face="Verdana">O usu�rio '+AllTrim(_cNomeusr)+' em '+Dtoc(dDataBase)+' efetivou a(s) Tabela(s) de Pre�o Intermediaria  </font>'   + _cCRLF
_cMensagem += '<font size="3" face="Verdana">Tabela(s) Intermedi�rias: </font>' + _cCRLF + _cCRLF

//Abre Tabela
_cMensagem += '<table border="0" width="100%" bgcolor="#EEE9E9">'
_cMensagem += '<tr>'
_cMensagem += '<td width="006%">'
_cMensagem += '<b><font size="2" face="Verdana">Tabela</font></b></td>'
_cMensagem += '<td width="024%">'
_cMensagem += '<b><font size="2" face="Verdana">Descri��o</font></b></td>'
_cMensagem += '</tr></table>'

//Preenche Tabela
For _nX := 1  To  Len(_aTabsOK)
	_cTabs   := AllTrim(_aTabsOK[_nX,1])
	_cDescri := AllTrim(_aTabsOK[_nX,2])
	
	If Int(_nX / 2) == (_nX / 2)
		_cMensagem += '<table border="0" width="100%" bgcolor="#EEE9E9">'
		_cMensagem += '<tr>'
		_cMensagem += '<td width="06%">'
		_cMensagem += '<font size="2" face="Verdana">' + _cTabs +    '</font></td>'
		_cMensagem += '<td width="24%">'
		_cMensagem += '<font size="2" face="Verdana">' + _cDescri + '</font></td>'
		_cMensagem += '</tr></table>'
	Else
		_cMensagem += '<table border="0" width="100%" bgcolor="#FFFFFF">'
		_cMensagem += '<tr>'
		_cMensagem += '<td width="06%">'
		_cMensagem += '<font size="2" face="Verdana">' + _cTabs +    '</font></td>'
		_cMensagem += '<td width="24%">'
		_cMensagem += '<font size="2" face="Verdana">' + _cDescri + '</font></td>'
		_cMensagem += '</tr></table>'
	EndIf
Next

_cMensagem += _cCRLF
_cMensagem += '<DIV> <hr color=CC0000> </DIV>'     + _cCRLF
_cMensagem += '<font size="2" face="Verdana">E-Mail enviado automaticamente pelo sistema da ' + SM0->M0_NOMECOM + '</font>'       + _cCRLF
_cMensagem += '</body>'
_cMensagem += '</html>'

//_cRecebe   := "cnpuerta@globo.com;"
_cRecebe   := "thiago@stch.com.br;"

CONNECT SMTP SERVER _cServer ACCOUNT _cAccount PASSWORD _cPassword Result lConectou
MAILAUTH(_cAccount,_cPassword)

SEND MAIL FROM _cEnvia;
TO 				_cRecebe;
SUBJECT 			_cAssunto;
BODY 				_cMensagem;
RESULT 			lEnviado

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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �TabConsu	�Autor  �Microsiga           � Data �  03/11/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function TabConsu(cCodPro,nConsumi)

Local cTabConsu 	:= Alltrim(U_MyNewSX6("MV_NCTABCO","CON","C","Tabela de Pre�o consumidor","","",.F. )   )
Local cAliasDA1 	:= DA1->(GetArea())
Local dAtual 		:= MsDate()
Local cItem			:= Space(04)
Local cNextItem 	:= Space(04)

DA1->(DbSetOrder(1))// DA1_FILIAL+DA1_CODTAB+DA1_CODPRO
DA1->(DbSeek(xFilial("DA1")+cTabConsu))

If DA1->(DbSeek(xFilial("DA1")+cTabConsu+cCodPro))
	DA1->(RecLock("DA1",.F.))
	
	DA1->DA1_PRCVEN  := nConsumi
	DA1->DA1_DATVIG  := dAtual
	
	DA1->(MsUnlock())
Else
	Do While !Eof() .And. DA1->DA1_CODTAB == cTabConsu
		cItem := DA1->DA1_ITEM
		dbSkip()
	EndDo
	cNextItem := Soma1(cItem,4)
	
	DA1->(Reclock("DA1",.T.))
	
	DA1->DA1_FILIAL  := xFilial("DA1")
	DA1->DA1_ITEM    := cNextItem
	DA1->DA1_CODTAB  := cTabConsu
	DA1->DA1_CODPRO  := cCodPro
	DA1->DA1_PRCVEN  := nConsumi
	DA1->DA1_ATIVO   := "1"
	DA1->DA1_TPOPER  := "4"
	DA1->DA1_MOEDA   := 1             
	
	DA1->DA1_DATVIG  := dAtual
	
	DA1->(MsUnlock())
EndIf

RestArea(cAliasDA1)

Return
