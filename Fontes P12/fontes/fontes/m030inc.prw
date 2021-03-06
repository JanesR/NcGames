#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#Include "Protheus.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MALTCLI   � Autor � Rodrigo Okamoto    � Data �  05/03/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de entrada para realizar altera��es na altera��o     ���
���          � do cadastro de clientes                                    ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function MALTCLI

	Local aAreaAtu	:= GetArea()
	Local aDados		:= {}
	Local cMObs030	:= ""
	
	_lRet	:= .T.

	If !Empty(SA1->A1_ZCODCIA)
		U_EcomHtm7("ALTERACAO")
	EndIf
	
	//lCliEcom := U_M001B2C(SA1->A1_VEND) //Verifica se � cliente ecommcerce
	
	M030GTrb()//Fun��o responsavel pela config. de Grp de tributa��o
	
	aadd(aDados,"Aviso de altera��o do Cadastro de Clientes")
	aadd(aDados,"Filial: "+xFilial("SA1"))
	aadd(aDados,"Nome:"+SA1->A1_NREDUZ)
	aadd(aDados,"Cliente: "+SA1->A1_COD)
	aadd(aDados,"Loja: "+SA1->A1_LOJA)
	aadd(aDados,"Conta Contabil: "+SA1->A1_CONTA)
	aadd(aDados,"Alterado por: "+cUsername)
	MEnviaMail("Z04",aDados)

	//Gravar Mensagem de altera��o financeira.
	cMObs030 := u_GetSA1Fin()
	If !Empty(cMObs030)
		SA1->(RecLock("SA1",.F.))
		SA1->A1_PRF_OBS := cMObs030
		SA1->(MsUnlock())
	EndIf

	RestArea(aAreaAtu)

Return(_lRet)


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M030INC   �Autor  �Microsiga           � Data �  03/30/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada que faz as altera��es na inclus�o do 	  ���
���          �  cliente                                                   ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M030INC

	Local cOldConTrib
	Local cConTrib

	Local aAliasM30	:= GetNextAlias()
	Local cQry			:= ""

	If SA1->(Eof())
		Return
	EndIf
	
	//lCliEcom := U_M001B2C(SA1->A1_VEND) //Verifica se � cliente ecommcerce
	
	M030GTrb()//Fun��o responsavel pela config. de Grp de tributa��o

	// Grava��o da numera��o do usu�rio
	cQry := " SELECT MAX(A1_YCODWMS) PROXNUM FROM "+RetSqlName("SA1")
	cQry += " WHERE D_E_L_E_T_ = ' '
	
	IIf(Select(aAliasM30) > 0,(aAliasM30)->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),aAliasM30  ,.F.,.T.)


	//O campo A1_YCODWMS receber� apenas 0, devido n�o ser utilizado no WMS. Obs. caso retorne a regra, o coment�rio dever� ser retirado.
	If Empty(Alltrim(SA1->A1_YCODWMS))
		SA1->(reclock("SA1",.F.))
		SA1->A1_YCODWMS := 0//(aAliasM30)->PROXNUM+1
		SA1->(msunlock())
	Endif

	(aAliasM30)->(dbCloseArea())

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M030INC   �Autor  �Microsiga           � Data �  05/05/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M30CodBar()

	Local aAreaAtu	:= GetArea()
	Local aAreaSA1	:= SA1->(GetArea())
	Local aAreaQry	:= GetNextAlias()
	Local lRet		:= .T.

	Local cCodBar	:= AllTrim(M->B1_CODBAR)
	Local cQry		:= ""

	If !(cCodBar $"PENDENTE/0") .Or. !Empty(cCodBar)
	
		cQry += "SELECT * FROM "+RetSqlName("SB1")+" SB1"+CRLF
		cQry += "WHERE B1_CODBAR LIKE '%"+cCodBar+"%'"+CRLF
		cQry += "AND B1_FILIAL = '"+xFilial("SB1")+"'"+CRLF
		cQry += "AND D_E_L_E_T_ = ' '"+CRLF
		cQry += "AND B1_TIPO = 'PA'"+CRLF
		cQry += "AND B1_DESC NOT like 'SOFTWARE%'"+CRLF
		cQry += "AND B1_XUSADO <> '1'"+CRLF
	
		cQry := ChangeQuery(cQry)
	
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),aAreaQry, .F., .F.)
	
		cMsg := "C�d. de barras j� utilizado em outro(s) produto(s)"+ CRLF
		Do While (aAreaQry)->(!Eof())
		
			If !((aAreaQry)->B1_COD == M->B1_COD)
				cMsg += "Produto: "+ AllTrim((aAreaQry)->B1_COD) +" - "+ AllTrim((aAreaQry)->B1_CODBAR) +" - "+ Alltrim((aAreaQry)->B1_XDESC) + CRLF
				lRet := .F.
			EndIf
			(aAreaQry)->(DbSkip())
		EndDo
	
	EndIf

	If !lRet
		MsgAlert( cMsg)
	EndIf

	(aAreaQry)->(DbCloseArea())

	RestArea(aAreaSA1)
	RestArea(aAreaAtu)

Return lRet


//------------------------------------------------------------------------------------------
//{Protheus.doc} M030GTrb
//Fun��o respons�vel pelo ajuste do cadasto fiscal de acordo com as informa��es do cliente.
//
//@author    Lucas Felipe
//@version   1.xx
//@since		16/06/2016

/*--------------------------------------------------------------------------------------//
// Se cliente tipo "Solid�rio e Inscri��o Estadual Diferente de ISENTO"					//
// Recebera "Grupo de tributa��o = SOL													//
// Contribuinte = 1																		// 
//																						//
// Se cliente tipo "Consumidor Final e Inscri��o Estadual igual a ISENTO"				//
// Recebera "Grupo de tributa��o = CFS													//
// Contribuinte = 2 (n�o)																//
//																						//
// Se cliente tipo "Consumidor Final e Inscri��o Estadual diferente de ISENTO"			//
// Recebera "Grupo de tributa��o = CFI													//
// Contribuinte = 1 (sim)																//
//																						//
// Cliente para exporta��o																// 
//																						//
// Se pais diferente de "BRASIL" e CNPJ igual a "vazio" e Cliente tipo "Exporta��o"		//
// Recebera "Grupo de tributa��o = EXP													//
//																						//
// Grupo de tributa��o - Suframa														//
//																						//
// Se cliente tipo "Solid�rio" e Suframa diferente de "vazio"							// 
// Receber� Grupo de tributa��o = ZFM													//
//--------------------------------------------------------------------------------------*/

Static Function M030GTrb()

	Local aAreaAtu	:= GetArea()
	
	Local cGrpOld		:= SA1->A1_GRPTRIB
	Local cGrpTrib	:= SA1->A1_GRPTRIB
	Local cPaisBac	:= SA1->A1_CODPAIS
	Local cOldConTrib	:= SA1->A1_CONTRIB
	Local cConTrib	:= SA1->A1_CONTRIB
	
	Local cMsg 		:= ""

	If !AllTrim(SA1->A1_INSCR)=="ISENTO" .And. SA1->A1_TIPO=="S"//SOLIDARIO
		cConTrib:="1"
		cGrpTrib:="SOL"
		cMsg := "Cliente Solid�rio, contribuinte SIM"
	ElseIf AllTrim(SA1->A1_INSCR)=="ISENTO" .And. SA1->A1_TIPO=="F"//PESSOAL FISICA
		cConTrib:="2"
		cGrpTrib:="CFS"
		cMsg := "Cliente Cons.Final, contribuinte N�O"
	ElseIf !AllTrim(SA1->A1_INSCR)=="ISENTO" .And. SA1->A1_TIPO=="F"//PESSOA FISICA
		cConTrib:="1"
		cGrpTrib:="CFI"
		cMsg := "Cliente Cons.Final, contribuinte SIM"
	EndIf

	/*-----------------------------------------------------------------------//
	// Exporta��o		  		                                       	       //
	//-----------------------------------------------------------------------*/
	
	If !(cPaisBac == '01058') .And. Empty(SA1->A1_CGC) .And. SA1->A1_TIPO == 'X'
		cMsg := "Cliente Exporta��o"
		cGrpTrib	:= "EXP"
	EndIf

	/*-----------------------------------------------------------------------//
	// Zona Franca de Manaus                                                 //
	//-----------------------------------------------------------------------*/
	
	If SA1->A1_TIPO == "S" .AND. !Empty(AllTrim(SA1->A1_SUFRAMA))
		cGrpTrib	:= "ZFM"
		cMsg := "Cliente Zona Franca"
	Endif
	
	MsgAlert(cMsg,"M030INC")
	
	
	SA1->(RecLock("SA1",.F.))
		
	SA1->A1_GRPTRIB	:= cGrpTrib
	SA1->A1_CONTRIB	:= cConTrib
		
	SA1->(MsUnlock())
		
	Alert("Grupo de Tributa��o Alterado para: "+cGrpTrib)
	
	
Return
