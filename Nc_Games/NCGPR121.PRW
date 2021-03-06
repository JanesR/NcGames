#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR121  �Autor  �Microsiga           � Data �  02/08/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGPR121()

Local cFiltro		:= ""
Local aCores		:= {}
Local cPerg			:= "NCGPR121"
Local cUser			:= RetCodUsr(Substr(cUsuario,1,6))
Local cUserPer 	:= Alltrim(U_MyNewSX6("EC_NCG0009","000307;000086","C","Usuario Adm. produtos E-commerce","","",.F. )   )

Private aRotina	:= MenuDef()
Private cCadastro	:= "Produtos - Importar p/ site"
Private cMark		:= GetMark()
Private lInverte  := .F.
Private aHeader	:= {}
Private aCols		:= {}


aCores := {	{"ZC3->ZC3_STATUS == '01'" ,"BR_VERDE"		},;
{"ZC3->ZC3_STATUS == '02'"	,"BR_VERMELHO"	},;
{"ZC3->ZC3_STATUS == '03'"	,"BR_LARANJA"	},;
{"ZC3->ZC3_STATUS == '04'"	,"BR_AMARELO"	}}


dbSelectArea("ZC3")
ZC3->(dbSetOrder(1))


cUserPer := Alltrim(SuperGetMv("EC_NCG0009",.t.,""))

If cUser $ cUserPer
	
	If  !Pergunte(cPerg)
		Return
	EndIF
Else
	Alert("Usu�rio voc� n�o possue acesso a este menu, solicitar ao Administrador do sistema.")
	Return
EndIf


cFiltro:= PR121Filte()

//MarkBrow (cAlias,cCampo,cCpo,aCampos,lInverte,cMarca,cCtrlM,uPar8,cExpIni,cExpFim,cAval,bParBloco,cExprFilTop,uPar14,aColors,uPar16)
MarkBrow( "ZC3","ZC3_OK",,,lInverte,cMark,,,,,,,cFiltro,,aCores)


Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR121  �Autor  �Microsiga           � Data �  02/08/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function MenuDef()

Local alRotina := {}

aAdd(alRotina, {"Pesquisar"	,"AxPesqui"				,0,1})
aAdd(alRotina, {"Visualizar"	,"U_PR121Brw('V')"	,0,2})
aAdd(alRotina, {"Alterar"		,"U_PR121Brw('A')"	,0,4})
aAdd(alRotina, {"Marcar Sim"	,"U_PR121Ok('S')"	,0,5})
aAdd(alRotina, {"Marcar N�o"	,"U_PR121Ok('N')"	,0,5})
aAdd(alRotina, {"Atualizar pre�o site"	,"U_Pr121Prc()"	,0,5})
aAdd(alRotina, {"Legenda"		,"U_PR121LEG()"		,0,4})

Return alRotina

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR121  �Autor  �Microsiga           � Data �  02/10/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function PR121LEG()

Local aCor := {}

aAdd(aCor,{"BR_VERDE"	,"Produto vai para Site"   	})	// 01
aAdd(aCor,{"BR_VERMELHO","Produto n�o vai para Site"	})	// 02
aAdd(aCor,{"BR_AMARELO"	,"Aguardando classifica��o"	})	// 04
aAdd(aCor,{"BR_LARANJA"	,"Aguardando altera��o"			})	// 03

BrwLegenda(,"Status",aCor)


Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR121  �Autor  �Microsiga           � Data �  02/10/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function PR121Filte(lSetFilter)

Local cPerg		:= "NCGPR121"

Default lSetFilter:=.F.

cFiltro	:= "ZC3_FILIAL = '"+xFilial("ZC3")+"'"

PutSX1(cPerg, "01", "Vai para Site?", "", "", "mv_ch1", "N", 1, 0, 3, "C", "", "", "", "", "mv_par01",;
"Sim", "Sim", "Sim", "",;
"N�o", "N�o", "N�o",;
"Pend. Alteracao","Pend. Alteracao","Pend. Alteracao",;
"Pendente", "Pendente", "Pendente",;
"Sem Filtro","Sem Filtro","Sem Filtro",,,, )

If mv_par01==1//Sim
	cFiltro+=" AND ZC3_STATUS ='01'"
ElseIf mv_par01==2//N�o
	cFiltro+=" AND ZC3_STATUS ='02'"
ElseIf mv_par01==3//Pendente altera��o
	cFiltro+=" AND ZC3_STATUS ='03'"
ElseIf mv_par01==4//Pendente
	cFiltro+=" AND ZC3_STATUS ='04'"
ElseIf mv_par01==5//Sem Filtro
	cFiltro+=""
EndIf


Return cFiltro


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR121  �Autor  �Microsiga           � Data �  02/10/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function PR121Ok(cOpcSN)

Local dLote			:= Msdate()
Local dTLote		:= Time()
Local aAreaAtu		:= GetArea()
Local lMarcado 	:= .f.
Local TRB1			:= GetNextAlias()
Local lValOk		:= .F.

cSql	:= " SELECT "
cSql	+= " R_E_C_N_O_ as RecZC3 "
cSql	+= " FROM " +RetSqlName("ZC3")+ " ZC3 "
cSql	+= " WHERE ZC3.ZC3_FILIAL = '"+xFilial("ZC3")+"'"
cSql	+= " AND ZC3.ZC3_OK = '"+cMark+"'"
cSql	+= " AND ZC3.D_E_L_E_T_= ' '"

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),TRB1, .F., .F.)

If cOpcSN == 'S'
	While !((TRB1)->(EOF()))
		lMarcado := .t.
		ZC3->(DbGoTo((TRB1)->RecZC3))
		
		V121SB1(ZC3->ZC3_CODPRO)
		
		(TRB1)->(DbSkip())
	EndDo
ElseIf cOpcSN == 'N'
	While !((TRB1)->(EOF()))
		lMarcado := .t.
		ZC3->(DbGoTo((TRB1)->RecZC3))
		ZC3->(RecLock("ZC3",.F.))
		
		ZC3->ZC3_OK := ""
		ZC3->ZC3_STATUS := "02"
		
		ZC3->(MsUnlock())
		(TRB1)->(DbSkip())
	EndDo
EndIf

If lMarcado == .F.
	MsgAlert("Nenhum item foi marcado")
EndIf

(TRB1)->(DbCloseArea())

RestArea(aAreaAtu)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR121  �Autor  �Microsiga           � Data �  02/11/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PR121Brw(cManutOpc)

Local aCposZC3 := {"ZC3_CODPRO","ZC3_DESCRI","ZC3_STATUS","NOUSER"}

If cManutOpc=='A'
	AxAltera("ZC3",ZC3->(Recno()),3)//,aCposZC3)
EndIf

If cManutOpc=='V'
	AxVisual("ZC3",ZC3->(Recno()),2)//,aCposZC3)
EndIf

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR121  �Autor  �Lucas Felipe        � Data �  04/03/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Valida��o de produtos.                                     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PR121SB1(cCodpro,cMostSit)
local cAreaAtu	:= GetArea()
Local cAreaSB1	:= SB1->(GetArea())
Local cAreaDA1	:= DA1->(GetArea())
Local cAreaSB5	:= SB5->(GetArea())
Local cFilSB1	:= xFilial("SB1")
Local cFilSB1	:= xFilial("DA1")

Local cAltInc  	:= "E"
Local lTipo		:= SB1->B1_TIPO == "PA"		 // PA = Produto Acabado
Local lMostSit	:= SB1->B1_XMOSTSI $ "1|4"  // 1="SIM AMBOS"/4="SO BRASIL"
Local cStatus	:= ""

Local cTabCon	:= Alltrim(U_MyNewSX6("MV_NCTABCO","CON","C","Tabela de Pre�o consumidor","","",.F. )   )
Local cProxItem := Space(04)

Local lAtivaDA1 := .F.

ZC3->(DbSetOrder(2))
If ZC3->(DbSeek(xFilial("ZC3")+cCodPro))
	If lTipo
		If lMostSit
			If ZC3->ZC3_STATUS == "04"
				cStatus := "04"
				cAltInc := "A"
			Else
				cStatus := "03"
				cAltInc := "A"
			EndIf
		Else
			cStatus := "02"
			cAltInc := "N"
		EndIf
	EndIf
Else
	If lTipo .And. lMostSit
		cStatus := "04"
		cAltInc := "I"
	EndIf
EndIf

SB5->(DbSetOrder(1))
SB5->(DbSeek(xFilial("SB5")+cCodPro))

DA1->(DbSetOrder(2))//DA1_FILIAL+DA1_CODPRO+DA1_CODTAB
DA1->(DbSeek(xFilial("DA1")+cCodPro))

ZC3->(DbSetOrder(2))
If ZC3->(DbSeek(xFilial("ZC3")+cCodPro))
	ZC3->(RecLock("ZC3",.F.))
	
	ZC3->ZC3_STATUS := "02"
	ZC3->ZC3_DESCRI := SubStr(SB1->B1_XDESC,1,40)
	ZC3->ZC3_INATIV := SB1->B1_MSBLQL 	//(1=SIM;2=N�O)
	ZC3->ZC3_BLQVEN := SB1->B1_BLQVEND 	//(1=SIM;2=N�O)
	ZC3->ZC3_FRANQU	:= SB5->B5_YFRANCH
	//ZC3->ZC3_PRV18	:= Posicione("DA1",2,xFilial("DA1")+cCodPro+"018","DA1_PRCVEN")
	//ZC3->ZC3_PRV04	:= Posicione("DA1",2,xFilial("DA1")+cCodPro+"012","DA1_PRCVEN")
	
	If !cAltInc == "N"
		ZC3->(DbDelete())
	EndIf
	
	ZC3->(MsUnlock())
Endif


If lTipo .And. lMostSit
	
	ZC3->(RecLock("ZC3",.T.))
	
	ZC3->ZC3_CODPRO := cCodPro
	ZC3->ZC3_DESCRI := SubStr(SB1->B1_XDESC,1,40)
	ZC3->ZC3_STATUS := cStatus
	ZC3->ZC3_INATIV := SB1->B1_MSBLQL 	//(1=SIM;2=N�O)
	ZC3->ZC3_BLQVEN := SB1->B1_BLQVEND 	//(1=SIM;2=N�O)
	ZC3->ZC3_FRANQU	:= SB5->B5_YFRANCH
	ZC3->ZC3_MOSITE	:= SB1->B1_XMOSTSI
	ZC3->ZC3_PRV18	:= Posicione("DA1",2,xFilial("DA1")+cCodPro+"018","DA1_PRCVEN")
	ZC3->ZC3_PRV04	:= Posicione("DA1",2,xFilial("DA1")+cCodPro+"012","DA1_PRCVEN")
	
	
	ZC3->(MsUnlock())
EndIf

If lAtivaDA1
	DA1->(DbSetOrder(1))
	If DA1->(DbSeek(xFilial("DA1")+cTabCon+cCodPro))
		DA1->(Reclock("DA1",.F.))
		
		DA1->DA1_PRCVEN  := SB1->B1_CONSUMI
		DA1->DA1_DATVIG  := MsDate()
		
		DA1->(MsUnlock())
		
	Else
		DA1->(Reclock("DA1",.T.))
		
		DA1->DA1_FILIAL  := xFilial("DA1")
		DA1->DA1_ITEM    := cProxItem
		DA1->DA1_CODTAB  := cTabCon
		DA1->DA1_CODPRO  := cCodPro
		DA1->DA1_PRCVEN  := SB1->B1_CONSUMI
		DA1->DA1_ATIVO   := "1"
		DA1->DA1_TPOPER  := "4"
		DA1->DA1_QTDLOT  := 999999.99
		DA1->DA1_INDLOT  := "000000000999999.99"
		DA1->DA1_MOEDA   := 1
		DA1->DA1_DATVIG  := MsDate()
		
		DA1->(MsUnlock())
	EndIf
EndIf

ZC3->(DbSetOrder(2))
If ZC3->(DbSeek(xFilial("ZC3")+cCodPro))
	PR121WF(cCodPro,cAltInc)
EndIf


RestArea(cAreaSB5)
RestArea(cAreaDA1)
RestArea(cAreaSB1)
RestArea(cAreaAtu)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR121  �Autor  �Microsiga           � Data �  02/13/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PR121WF(cCodPro,cAltInc)

Local cAliasREC:= GetNextAlias()
Local cTitulo 	:= ""
Local cBody		:= ""
Local cMailDest:= ""

Private cErro  := ""


If cAltInc == "A" //Altera��o
	cTitulo 	:= "Altera��o de Produto"
	cBody 	:= U_EcomHtm6(cAltInc)
	
ElseIf cAltInc == "E" //Exclus�o
	cTitulo 	:= "Exclus�o de Produto"
	cBody 	:= U_EcomHtm6(cAltInc)
	
ElseIf cAltInc == "N" //Exclus�o
	cTitulo 	:= "Altera��o de Produto"
	cBody 	:= U_EcomHtm6(cAltInc)
	
ElseIf cAltInc == "I" //Inclus�o
	cTitulo 	:= "Inclus�o de Produto"
	cBody 	:= U_EcomHtm5()
	
EndIf


//�������������������������������������������������������������������������������������Ŀ
//� Envia o Html por e-mail                                                             �
//���������������������������������������������������������������������������������������

cMailDest:= SuperGetMv("EC_NCG0006",.T.,"lfelipe@ncgames.com.br")

PR121SEND( cTitulo,cBody,{}, cMailDest, "", @cErro )


Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR121  �Autor  �Microsiga           � Data �  02/13/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PR121SEND(cAssunto, cBody, aAnexos, cEmailTo, cEmailCc, cErro)

Local lRetorno		:= .T.
Local cServer  	:= GetNewPar("MV_RELSERV","")
Local cAccount	:= GetNewPar("MV_RELACNT","")
Local cPassword	:= GetNewPar("MV_RELAPSW","")
Local lMailAuth	:= GetNewPar("MV_RELAUTH",.F.)

Default aAnexos	:= {}
Default cBody		:= ""
Default cAssunto	:= ""
Default cErro		:= ""


If !Empty(cEmailTo) .And. !Empty(cAssunto) .And. !Empty(cBody)
	If MailSmtpOn( cServer, cAccount, cPassword )
		If lMailAuth
			If ! ( lRetorno := MailAuth(cAccount,cPassword) )
				lRetorno := MailAuth(SubStr(cAccount,1,At("@",cAccount)-1),cPassword)
			EndIf
		Endif
		If lRetorno
			If !MailSend(cAccount,{cEmailTo},{cEmailCc},{},cAssunto,cBody,aAnexos,.F.)
				cErro := "Erro na tentativa de e-mail para " + cEmailTo + ". " + Mailgeterr()
				lRetorno := .F.
			EndIf
		Else
			cErro := "Erro na tentativa de autentica��o da conta " + cAccount + ". "
			lRetorno := .F.
		EndIf
		MailSmtpOff()
	Else
		cErro := "Erro na tentativa de conex�o com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
		lRetorno := .F.
	EndIf
Else
	If Empty(cEmailTo)
		cErro := "� neess�rio fornecedor o destin�tario para o e-mail. "
		lRetorno := .F.
	EndIf
	If Empty(cAssunto)
		cErro := "� neess�rio fornecer o assunto para o e-mail. "
		lRetorno := .F.
		
	EndIf
	If Empty(cBody)
		cErro := "� neess�rio fornecer o corpo do e-mail. "
		lRetorno := .F.
	EndIf
Endif

Return(lRetorno)



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR121  �Autor  �Microsiga           � Data �  04/04/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function V121SB1(cCodPro)

Local cAliasSB1:= GetArea("SB1")

Local lExistDA1:= .F.
Local lInatiSB1:= .F.
Local lTipo		:= .F.
Local lMostSit	:= .F.

Default cCodPro 	:= M->ZC3_CODPRO

SB1->(DbSetOrder(1))
SB1->(DbSeek(xFilial("SB1")+cCodPro))

lInatiSB1:= SB1->B1_MSBLQL == "1"
lTipo		:= SB1->B1_TIPO == "PA"		 // PA = Produto Acabado
lMostSit	:= SB1->B1_XMOSTSI $ "1|4"  // 1="SIM AMBOS"/4="SO BRASIL"

DA1->(DbSetOrder(2))
lExistDA1 := DA1->(DbSeek(xFilial("DA1")+cCodPro))


If !lInatiSB1
	If lTipo
		If lMostSit
			If !lExistDA1 .And. MsgYesNo("O Produto "+cCodPro+" n�o est� cadastrado na tabela de pre�os - Protheus","Produto sem pre�o")
				
				ZC3->(RecLock("ZC3",.F.))
				
				ZC3->ZC3_OK 	:= ""
				ZC3->ZC3_STATUS:= "01"
				ZC3->ZC3_OBS	:= "Liberado sem Pre�o"
				ZC3->ZC3_DTLIB	:= MsDate()
				ZC3->ZC3_HRLIB	:= Time()
				
				ZC3->(MsUnlock())
				
			elseIf lExistDA1
				ZC3->(RecLock("ZC3",.F.))
				
				ZC3->ZC3_OK 	:= ""
				ZC3->ZC3_STATUS:= "01"
				ZC3->ZC3_OBS	:= "Liberado"
				ZC3->ZC3_DTLIB	:= MsDate()
				ZC3->ZC3_HRLIB	:= Time()
				
				ZC3->(MsUnlock())
				
			EndIf
		Else
			Alert("O Produto "+cCodPro+" deve ter o campo Most.Site = 01 ou 02, no cadastro de produtos - Protheus")
		EndIf
	Else
		Alert("O Produto "+cCodPro+" deve ter o campo Tipo = PA, no cadastro de produtos - Protheus")
	EndIf
Else
	Alert("O Produto "+cCodPro+" est� inativo no cadastro de produtos - Protheus")
EndIf


Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Valid121  �Autor  �Microsiga           � Data �  04/04/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Valid121()

Local cCodPro	:= M->ZC3_CODPRO
Local cStatus	:= M->ZC3_STATUS
Local lRet		:= .F.

SB1->(DbSetOrder(1))
SB1->(DbSeek(xFilial("SB1")+cCodPro))

lInatiSB1:= SB1->B1_MSBLQL == "1"
lTipo		:= SB1->B1_TIPO == "PA"		 // PA = Produto Acabado
lMostSit	:= SB1->B1_XMOSTSI $ "1|4"  // 1="SIM AMBOS"/4="SO BRASIL"

DA1->(DbSetOrder(2))
lExistDA1 := DA1->(DbSeek(xFilial("DA1")+cCodPro))

If cStatus == '01'
	If !lInatiSB1
		If lTipo
			If lMostSit
				If !lExistDA1 .And. MsgYesNo("O Produto "+cCodPro+" n�o est� cadastrado na tabela de pre�os - Protheus","Produto sem pre�o")
					lRet := .T.
				elseIf lExistDA1
					lRet := .T.
				EndIf
			Else
				Alert("O Produto "+cCodPro+" deve ter o campo Most.Site = 01 ou 02, no cadastro de produtos - Protheus")
			EndIf
		Else
			Alert("O Produto "+cCodPro+" deve ter o campo Tipo = PA, no cadastro de produtos - Protheus")
		EndIf
	Else
		Alert("O Produto "+cCodPro+" est� inativo no cadastro de produtos - Protheus")
	EndIf
EndIf

If cStatus $ ('02|03|04')
	lRet := .T.
EndIf

Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR121  �Autor  �Microsiga           � Data �  06/13/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Pr121Prc()

Local aAreaAtu	:= GetArea()
Local aAreaZC4	:= ZC4->(GetArea())

Local cCodPro := AllTrim(ZC3->ZC3_CODPRO)
Local cMsgYes := "Deseja executar a rotina de atualiza��o de pre�os para o produto "+cCodPro+"?"

ZC4->(DbSetOrder(5))
If ZC4->(DbSeek(xFilial("ZC4")+cCodPro))
	If MsgYesno(cMsgYes)
		Processa( { ||U_Nc04Pric(cCodPro)}, "Aguarde...", "Processando atualiza��o...",.F.)
	EndIf
Else
	MsgAlert("O produto "+cCodPro+", n�o est� na tabela de pre�os do ecommerce,O reprocessamento dever� fazer com que ele apare�a. Se o problema persistir verifique se ja existe pre�o de venda Protheus","NCGPR121")
	If MsgYesno("A Rotina de Recalculo de pre�o poder� demorar alguns minutos pois reprocessa todas as tabelas de pre�o ecommerce B2B. Deseja Prosseguir?")
		Processa( { ||U_Pr120ReCalc()}, "Aguarde...", "Processando tabela de pre�os...",.F.)
	EndIf
EndIf

RestArea(aAreaZC4)
RestArea(aAreaAtu)
Return
