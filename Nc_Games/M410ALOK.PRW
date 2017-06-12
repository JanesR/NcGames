#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "TOPCONN.CH"
#include "TbiConn.ch"

Static aStatus:={"",.F.}

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �A410ALTERA� Autor � ERICH BUTTNER		    � Data �24/08/2010���
�������������������������������������������������������������������������Ĵ��
��           � Executado em conjunto com os PE: MTA410, MA410DEL           ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function M410ALOK()  

Local cMensagem		:= ""
Local nRecPZ1		:= 0
LOCAL VERIF 		:= 1
Local lCpyResid		:= IsInCallStack("U_CPYRESIDUO")//Verifica se foi chamado pela copia de residuo
Local clPed			:= SC5->C5_NUM
Local clFil 		:= SC5->C5_FILIAL
Local clChave		:= clFil+clPed
Local clQry			:= ""
Local clQry3		:= ""
Local cAlias		:= GetNextAlias()
Local cAlias1		:= GetNextAlias()
Local cAlias2		:= GetNextAlias()
Local cAlias3		:= GetNextAlias()
Local llCntValid 	:= .F.
Local alCampos1		:= {}
Local alReg1		:= {}
Local alCmpChave	:= {}
Local alValChave	:= {}
Local cFiliais		:= SuperGetMV("NCG_000030",.F.,"03")
Local clUsrBD		:=	AllTrim(U_MyNewSX6("NCG_000019","WMS","C","Usu�rio para acessar a base do WMS","","",	.F. ))

Public _aRecnoC5	:= {}
Public _clQueryC5	:= ""
LRET:= .T.

If IsInCallStack("U_A008AltPV")
	l410Auto:=.F.  // Para aparecer a tela de manuten��o do pedido de venda
EndIf

If !Empty(SC5->C5_NOTA )
	cMensagem:="Pedido de Venda n�o pode ser Alterado/Exclu�do pois j� foi faturado ou eliminado res�duo! "
	aStatus:={cMensagem,.F.}
	MSgInfo(cMensagem,"ATEN��O")
	RETURN .F.
	
EndIf

IF !lCpyResid
	If ALLTRIM(SC5->C5_STAPICK) == "1"
		cMensagem:="N�O � PERMITIDO A ALTERA��O DO PEDIDO POIS EST� EM PROCESSO DE PICKING"+CHR(13)+"SOLICITE O ESTORNO AO DEPARTAMENTO DE EXPEDI��O"
		aStatus:={cMensagem,.F.}
		MSGBOX(cMensagem)
		VERIF:= 0
		LRET:= .F.
	EndIf
	
	If ALLTRIM(SC5->C5_STAPICK) == "3"
		cMensagem:="N�O � PERMITIDO A ALTERA��O DO PEDIDO POIS EST� FATURADA A NOTA FISCAL"
		aStatus:={cMensagem,.F.}
		MSGBOX(cMensagem)
		VERIF:= 0
		LRET:= .F.
	EndIf
	
	If LRET .And. !U_PR107AltPermitida(.F.,SC5->C5_NUM,.T.)
		Return .F.
	EndIf
	
EndIf

If  LRET .AND. clFil $ FormatIN(cFiliais,"|") .AND. ( IsInCallStack("A410ALTERA") .OR. IsInCallStack("A410DELETA") ) .and. !lCpyResid
	
	/********************************************************************************************
	| O Pedido de Venda s� pode ser Alterado/Exclu�do se o mesmo n�o estiver na tabela P0A ou 	 |
	| se ainda n�o foi exportado para o WMS, caso j� tenha sido exportado deve possuir uma 		 |
	| integra��o com a tabela TB_WMSINTERF_CANC_ENT_SAI												 |
	********************************************************************************************/
	
	clQry2 	:= " SELECT P0A_EXPORT, R_E_C_N_O_ "
	clQry2 	+= " FROM " + RetSqlName("P0A") + " P0A "
	clQry2 	+= " WHERE P0A_CHAVE = '"+ ALLTRIM(clFil) +"'||'"+ ALLTRIM(clPed) +"' "
	clQry2 	+= " AND D_E_L_E_T_=' '"
	clQry2 	+= " ORDER BY R_E_C_N_O_ DESC "
	
	
	Iif(Select(cAlias2) > 0,(cAlias2)->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry2),cAlias2  ,.F.,.T.)
	
	If (cAlias2)->(EOF())
		LRET := .T.
	Else
		If (cAlias2)->P0A_EXPORT == '2'
			LRET := .F.
			MSgInfo("Pedido de Venda n�o pode ser Alterado/Exclu�do, pois encontra-se no WMS. Solicite o estorno ao Depto. de Log�stica ","ATEN��O")
			Return lRet
		Else
			llCntValid := .T.
		EndIf
		
	EndIF
	
	If llCntValid
		/*---------------------------------------------------------------------------//
		// Verifica se o pedido esta no WMS na tabela TB_WMSINTERF_DOC_SAIDA			//
		//---------------------------------------------------------------------------*/
		clQry1 := " SELECT DPCS_COD_CHAVE, STATUS AS S_T_A_T_U_S
		clQry1	+= " FROM "+clUsrBD+".TB_WMSINTERF_DOC_SAIDA "
		clQry1	+= " WHERE DPCS_COD_CHAVE = '"+clChave+"' "
		
		Iif(Select(cAlias1) > 0,(cAlias1)->(dbCloseArea()),Nil)
		DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry1),cAlias1  ,.F.,.T.)
		
		If (cAlias1)->(!EOF())
			/*--------------------------------------------------------------------------------------------------//
			//Alterado em 08/03/16 - Pois de acordo com uma nova regra quando o pedido for processado com Erro  //
			// n�o ser� permitido altera��o a menos que seja estornado ou excluido do WMS. Lucas Felipe         //
			//--------------------------------------------------------------------------------------------------*/
			/*																												  //
			//	If (cAlias1)->S_T_A_T_U_S == 'ER'																		  //
			//		LRET := .T.																							  //
			//	//apagar os registros da interface neste momento														  //
			//	//apagar os registros da P0A neste momento															  //
			//																												  //
			//	//Else																										  */
			//		//VERIFICA SE O PEDIDO POSSUI INTEGRA��O DE EXCLUS�O NA TABELA TB_WMSINTERF_CANC_ENT_SAI
			//		clQry	:= " SELECT CES_COD_CHAVE"
			//		clQry	+= " FROM "+clUsrBD+".TB_WMSINTERF_CANC_ENT_SAI "
			//		clQry	+= " WHERE CES_COD_CHAVE = '"+clChave+"' "
			//
			//		If IsInCallStack("A410ALTERA")
			//			clQry	+= " AND STATUS IN ('NP','ER')  "
			//		ElseIF IsInCallStack("A410DELETA")
			//			clQry	+= " AND STATUS IN ('NP','PA','ER') "
			//		EndIF
			
			//		Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
			//		DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry),cAlias  ,.F.,.T.)
			
			//		If (cAlias)->(!EOF())
			
			//			aadd(alCampos1,"STATUS")
			
			//			If IsInCallStack("A410ALTERA")
			//				aadd(alReg1,"PA")
			//			ElseIF IsInCallStack("A410DELETA")
			//				aadd(alReg1,"P")
			//			EndIF
			//			clTabWMS := "TB_WMSINTERF_CANC_ENT_SAI"
			
			//			aadd(alCmpChave,"CES_COD_CHAVE")
			
			//			aadd(alValChave,ALLTRIM((cAlias)->CES_COD_CHAVE))
			
			//			clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave)
			//			_clQueryC5 := clQuery
			//			//ESTA EXCLU�O SER� REALIZADA DENTRO DO PONTO DE ENTRADA MA410DEL
			
			//		Else
			//			//MSgInfo("Pedido de Venda n�o pode ser Alterado/Exclu�do, pois n�o possui uma integra��o de exclus�o com a tabela TB_WMSINTERF_CANC_ENT_SAI do WMS ","ATEN��O")
						cMensagem:="Pedido de Venda n�o pode ser Alterado/Exclu�do, pois encontra-se no WMS. Solicite o estorno ao Depto. de Log�stica"
						aStatus:={cMensagem,.T.}
						MSgInfo(cMensagem,"ATEN��O")
			//			LRET := .F.
			//		EndIF
			//	//EndIF
			
			lRet := .F.
			
		Else
			/*-----------------------------------------------------------------------------------------//
			// Verifica se o pedido possui integracao de exclusao na tabela TB_WMSINTERF_CANC_ENT_SAI	//
			//-----------------------------------------------------------------------------------------*/
			
			clQry	:= " SELECT CES_COD_CHAVE "
			clQry	+= " FROM "+clUsrBD+".TB_WMSINTERF_CANC_ENT_SAI "
			clQry	+= " WHERE CES_COD_CHAVE = '"+clChave+"' "
			
			Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
			DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry),cAlias  ,.F.,.T.)
			
			If (cAlias)->(!EOF())
				LRET := .T.
				
				aadd(alCampos1,"STATUS")
				
				If IsInCallStack("A410ALTERA")
					aadd(alReg1,"PA")
				ElseIF IsInCallStack("A410DELETA")
					aadd(alReg1,"P")
				EndIF
				clTabWMS := "TB_WMSINTERF_CANC_ENT_SAI"
				
				aadd(alCmpChave,"CES_COD_CHAVE")
				
				aadd(alValChave,ALLTRIM((cAlias)->CES_COD_CHAVE))
				
				clQuery 	:= U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave)
				_clQueryC5	:= clQuery
				/*-------------------------------------------------------------------------------//
				// Esta exclus�o sera realizada dentro do ponto de entrada MA410DEL				 //
				//-------------------------------------------------------------------------------*/
			Else
				cMensagem:="Pedido de Venda n�o pode ser Alterado/Exclu�do, pois encontra-se no WMS. Solicite o estorno ao Depto. de Log�stica"//
				aStatus:={cMensagem,.T.}
				MSgInfo(cMensagem,"ATEN��O")
				LRET := .F.
				
			Endif
			
		EndIF
	EndIF
EndIF


nRecPZ1 := 0
If LRET .And. !IsInCallStack("U_NCGJ001") .And. IsInCallStack("A410ALTERA") .And. U_M001TemPV(xFilial("SC5"),SC5->C5_NUM,2,@nRecPZ1)
	PZ1->(DbGoTo(nRecPZ1))
	cMensagem:="Pedido de Transfer�ncia referente ao Pedido de Venda "+PZ1->PZ1_PVORIG+" na Filial "+PZ1->PZ1_FILORI+Chr(13)+" Altera��o n�o permitida!!"
	aStatus:={cMensagem,.F.}
	MSGBOX(cMensagem)
	LRET:=.F.
EndIf

If !U_PR109Canc("SC5",SC5->(C5_FILIAL+C5_NUM))
	MSgInfo("Pedido de Venda n�o pode ser Estornado, pois deve ser Estornado primeiramente no Monitor WMS Strore ","ATEN��O")
	lRet := .F.
Endif



RETURN LRET


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M410ALOK  �Autor  �Microsiga           � Data �  02/20/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function ALOKGetStat(lReset)
Local aRetorno
Default lReset:=.F.


aRetorno:=aStatus

If lReset
	aStatus:={"",.F.}
EndIf

Return aRetorno
