#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR706  �Autor  �Microsiga           � Data �  12/12/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PR706VERBA()
U_NCGPR706("VERBA")
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR706  �Autor  �Microsiga           � Data �  08/01/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGPR706(cParam)
Local cFiltro		:=""
Local aCores		:= {}
Local aAreaX3		:= SX3->(GetArea())
Local nInterval		:=60*1000//Em milisegundos

Private aRotina		:= MenuDef()
Private cCadastro	:= "Aprova��o"
Private cUserLog	:= Alltrim(__cUserId)
Private aFixes		:= {}
Default cParam:="VPC"

aCores := {	 {"P0B->P0B_STATUS == '01' "	,"BR_AMARELO"   };
,{"P0B->P0B_STATUS == '02' "	,"BR_LARANJA"	};
,{"P0B->P0B_STATUS == '03' "	,"BR_AZUL"		};
,{"P0B->P0B_STATUS == '04' "	,"BR_VERDE"		};
,{"P0B->P0B_STATUS == '05' "	,"BR_VERMELHO"	}}



SX3->(dbSetOrder(2))
P0B->(dbSetOrder(1))

If SX3->(dbSeek( "ZZ7_CODIGO" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("ZZ7",1,xFilial("ZZ7")+P0B->P0B_CHVIND ,"ZZ7_CODIGO"  ),AvSx3("ZZ7_CODIGO",6) )  }   })
EndIf

If SX3->(dbSeek( "ZZ7_VERSAO" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("ZZ7",1,xFilial("ZZ7")+P0B->P0B_CHVIND ,"ZZ7_VERSAO"  ),AvSx3("ZZ7_VERSAO",6) )  }   })
EndIf

If SX3->(dbSeek( "ZZ7_DESC" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("ZZ7",1,xFilial("ZZ7")+P0B->P0B_CHVIND ,"ZZ7_DESC"  ),AvSx3("ZZ7_DESC",6) )  }   })
EndIf

cCadastro	:= "Aprova��o Contrato/Verba Extra"


AADD(aFixes, {"Status"+Space(20), {|| P0B->P0B_STATUS+"-"+IIf(P0B->P0B_STATUS== '01',"Aguardando sua aprova��o", IIf(P0B->P0B_STATUS == '02',"Aguar. demais aprov. no mesmo n�vel", IIf(P0B->P0B_STATUS == '03',"Aguardando aprova��o n�vel superior", IIf(P0B->P0B_STATUS == '04',"Aprovado",IIf(P0B->P0B_STATUS == '05',"Reprovado",""))) ) )  }  })

If SX3->(dbSeek( "P0B_CODCLI" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_CODCLI" })
EndIf

If SX3->(dbSeek( "P0B_LOJA" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_LOJA" })
EndIf

If SX3->(dbSeek( "P0B_NOMECL" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_NOMECL" })
EndIf

If SX3->(dbSeek( "P0B_EMISSA" ))
	AADD(aFixes, {"Inicio Aprov","P0B_EMISSA" })
EndIf

If SX3->(dbSeek( "P0B_USER" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_USER"  })
EndIf

If SX3->(dbSeek( "P0B_NOMAPR" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_NOMAPR"})
EndIf
If SX3->(dbSeek( "P0B_DTLIB" ))
	AADD(aFixes, {"Dt. Aprovacao","P0B_DTLIB" })
EndIf

If SX3->(dbSeek( "P0B_DTREPR" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_DTREPR"  })
EndIf

cFiltro:="P0B_FILIAL = '"+xFilial("P0B")+"'"
cFiltro+=" AND P0B_TIPO = 'ZZ7' "
cFiltro+=" AND P0B_USER='"+__cUserId+"'"

//MBrowse ( [ nLin1 ] [ nCol1 ] [ nLin2 ] [ nCol2 ]cAlias [ aFixe ] [ cCpo ] [ nPar08 ] [ cFun ] [ nClickDef ] [ aColors ] [ cTopFun ] [ cBotFun ] [ nPar14 ] [ bInitBloc ] [ lNoMnuFilter ] [ lSeeAll ] [ lChgAll ] [ cExprFilTop ] [ nInterval ] [ bTimerAction ] [ uPar22 ] [ uPar23 ] )
mBrowse( 6, 1,22,75,'P0B',aFixes,,,,, aCores,,,,,,,,cFiltro, nInterval,{|| U_PR706Timer()  })

SX3->(RestArea(aAreaX3))

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR706  �Autor  �Microsiga           � Data �  08/01/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MenuDef()
Local alRotina := {  {"Pesquisar"		,"AxPesqui"			,0,1} ,;
{"Visualizar"							,"U_PR706Manut('V')"		,0,2} ,;
{"Analisar"								,"U_PR706Manut('A')"		,0,8} ,;
{"Legenda"								,"U_PR706LEG()"		,0,2} }


Return alRotina

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR706  �Autor  �Microsiga           � Data �  08/01/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PR706Manut(cOpMenu)
Local aAreaAtu	:=GetArea()
Local aAreaZZ7	:=ZZ7->(GetArea())
Local aAreaP0B :=P0B->(GetArea())
Local bAprovar	:={|| Iif(MsgYesNo("Confirmar a Aprova��o?" ) ,( cOpcao:="A",oDlgPR705:End() ),  oDlgPR705:End()  )}
Local bReprovar:={|| Iif(MsgYesNo("Confirmar a Reprova��o?") ,(  cOpcao:="R",oDlgPR705:End() ),  oDlgPR705:End()  )}
Local bSair		:={||  oDlgPR705:End()  }
Local cAliasTab	:=P0B->P0B_TABORI
Local nOrdem	:=P0B->P0B_INDCHO

Private cMemoObs:=""
Private cOpcao:=""

If cOpMenu=="A" .And. !P0B->P0B_USER == Alltrim(cUserLog)
	Aviso("NCGPR706 - 02","S� permitido Aprova��o/Reprova��o pelo aprovador "+UsrFullName(P0B->P0B_USER)+".",{"Ok"},3)
	Return
EndIf

(cAliasTab)->(DbSetOrder(nOrdem))
If (cAliasTab)->(DbSeek(xFilial(cAliasTab)+P0B->P0B_CHVIND))
   
	U_PR705SET(ZZ7->ZZ7_FLAG=="1")

	(cAliasTab)->(U_R705Manut(cAliasTab,Recno(),2,cOpMenu,bAprovar,bReprovar,bSair))
	If cOpcao$'AR'
		U_PR706APROV(cOpcao,.T.,cMemoObs)
	EndIf
Else
	Aviso("NCGPR706 - 01","Contrato/Verba Extra n�o encontrado",{"Ok"},3)
EndIf

RestArea(aAreaP0B)
RestArea(aAreaZZ7)
RestArea(aAreaAtu)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR706  �Autor  �Microsiga           � Data �  08/01/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PR706OBS()
Local cMemoObs := ""

If !Empty(P0B->P0B_CODOBS)
	cMemoObs := Msmm(P0B->P0B_CODOBS, 1000,,,3 ,,, "P0B","P0B_CODOBS" ,, ) //+ CRLF + (cAlias)->(MEMO)
	Aviso("PR706OBS - 01",@cMemoObs,{"Ok"},3,"Observa��o",,,.T.)
Else
	MsgAlert("N�o h� observa��es para este Contrato/Verba Extra.")
EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR706  �Autor  �Microsiga           � Data �  08/01/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PR706APROV(cChose,lShow,cObservacao)
Local cMemoObs	:= ""
Local llNextNivel 	:= .F.
Local llMesmoNivel	:= .F.
Local aAreaAux 		:= {}
Local cTipoAlc		:= P0B->P0B_TIPO
Local cNumDoc		:= P0B->P0B_NUM
Local cNivel		:= P0B->P0B_NIVEL
Local cTabOrig		:= P0B->P0B_TABORI
Local cCodUser		:= P0B->P0B_USEORI
Local cNomeUser      :=UsrFullName(P0B->P0B_USER)
Local lIncMemo		:= .F.
Local nRecno		:= P0B->(Recno())
Local alArea := P0B->(GetArea())
Local cAliasTab	:=P0B->P0B_TABORI
Local nOrdem	:=P0B->P0B_INDCHO

Default lShow:=.T.
Default cObservacao:=""

If P0B->P0B_STATUS<>'01'
	MsgStop(UsrFullName(P0B->P0B_USER)+"-Contrato/Verba Extra"+P0B->P0B_STATUS+"-"+IIf(P0B->P0B_STATUS== '01',"Aguardando sua aprova��o", IIf(P0B->P0B_STATUS == '02',"Aguar. demais aprov. no mesmo n�vel", IIf(P0B->P0B_STATUS == '03',"Aguardando aprova��o n�vel superior", IIf(P0B->P0B_STATUS == '04',"Aprovado",IIf(P0B->P0B_STATUS == '05',"Reprovado",""	 ))))))
	Return
EndIf

If cChose == "R"
	
	P0B->(DbSetOrder(1)) //	P0B_FILIAL+P0B_TIPO+P0B_NUM+P0B_NIVEL
	
	If P0B->(dbSeek(xfilial("P0B") + cTipoAlc + cNumDoc))
		
		Do While !P0B->(EOF()) .And. AllTrim(cNumDoc) == AllTrim(P0B->P0B_NUM)
			
			P0B->(RecLock("P0B",.F.))
			P0B->P0B_STATUS := '05'
			P0B->P0B_DTREPR	:= MsDate()
			P0B->(MsUnLock())
			
			If lIncMemo .And. cCodUser == P0B->P0B_USEORI .And. cNivel == P0B->P0B_NIVEL
				If Empty(P0B->P0B_CODOBS)
					P0B->(MSMM(,,, cMemoObs ,1,,,"P0B","P0B_CODOBS","SYP"))
				Else
					MSMM(P0B->P0B_CODOBS,1000,,AllTrim(cMemoObs),1,,,"P0B","P0B_CODOBS")
				EndIf
			EndIf
			P0B->(dbSkip())
		EndDo
		
		P0B->(MsUnlock())
		P0B->(DbGoTo(nRecno))
		
		(cAliasTab)->(DbSetOrder( P0B->P0B_INDCHO ))
		If (cAliasTab)->(DbSeek(xFilial(cAliasTab)+P0B->P0B_CHVIND))
			(cAliasTab)->(RecLock(cAliasTab,.F.))
			(cAliasTab)->&(cAliasTab+"_STATUS"):="4"
			(cAliasTab)->(MsUnLock())
		EndIf
		
		//P0B->(R705EnvMailStatus(Posicione("P09",1,xFilial("P09")+P0B_APROV,"P09_EMAIL"),"Retorno da aprova��o da Margem do Contrato de venda: "+ P0B_NUM,"Reprovado",P0B_Contrato))
		If lShow
			MsgAlert("Contrato/Verba Extra Reprovado","Contrato")
		EndIf
		
	EndIf
	
Else
	
	llMesmoNivel := U_R705ExstMemNiv(AllTrim(P0B->P0B_NUM),Alltrim(P0B->P0B_NIVEL))
	
	If llMesmoNivel // Agurada aprova��o mesmo nivel
		
		P0B->(RecLock("P0B",.F.))
		
		P0B->P0B_STATUS := '02'
		If lIncMemo .And. cCodUser == P0B->P0B_USEORI .And. cNivel == P0B->P0B_NIVEL
			If Empty(P0B->P0B_CODOBS)
				P0B->(MSMM(,,, cMemoObs ,1,,,"P0B","P0B_CODOBS","SYP"))
			Else
				MSMM(P0B->P0B_CODOBS,1000,,AllTrim(cMemoObs),1,,,"P0B","P0B_CODOBS")
			EndIf
		EndIf
		
		P0B->(MsUnLock())
		
	Else // Proximo Nivel
		
		llNextNivel := U_R705GetNextNivel(AllTrim(P0B->P0B_NUM),Alltrim(P0B->P0B_NIVEL))
		
		If llNextNivel
			
			aAreaAux := P0B->(GetArea())
			
			P0B->(RecLock("P0B",.F.))
			
			P0B->P0B_STATUS := '03'
			
			P0B->(MsUnLock())
			// Atualiza todos os status no mesmo n�vel
			P0B->(dbSetOrder(1))
			P0B->(dbGoTop())
			P0B->(dbSeek(xFilial("P0B")+cTipoAlc+cNumDoc+cNivel))
			
			While P0B->(!Eof()) .AND. cTipoAlc+cNumDoc+cNivel == P0B->(P0B_TIPO+P0B_NUM+P0B_NIVEL)
				
				P0B->(RecLock("P0B",.F.))
				P0B->P0B_STATUS := '03'
				
				If lIncMemo .And. cCodUser == P0B->P0B_USEORI .And. cNivel == P0B->P0B_NIVEL
					If Empty(P0B->P0B_CODOBS)
						P0B->(MSMM(,,, cMemoObs ,1,,,"P0B","P0B_CODOBS","SYP"))
					Else
						MSMM(P0B->P0B_CODOBS,1000,,AllTrim(cMemoObs),1,,,"P0B","P0B_CODOBS")
					EndIf
				EndIf
				P0B->(MsUnLock())
				P0B->(dbSkip())
				
			EndDo
			
			RestArea(aAreaAux)
			
			
		Else // N�o tem mais n�veis
			
			aAreaAux := P0B->(GetArea())
			
			P0B->(dbGoTop())
			P0B->(dbSetOrder(1))
			
			If P0B->(dbSeek(xFilial("P0B")+ cTipoAlc +cNumDoc))
				
				While P0B->(!Eof()) .AND. cNumDoc == P0B->P0B_NUM
					
					P0B->(RecLock("P0B",.F.))
					
					P0B->P0B_STATUS := '04'
					P0B->P0B_DTLIB	:= dDataBase
					If lIncMemo .And. cCodUser == P0B->P0B_USEORI .And. cNivel == P0B->P0B_NIVEL
						If Empty(P0B->P0B_CODOBS)
							P0B->(MSMM(,,, cMemoObs ,1,,,"P0B","P0B_CODOBS","SYP"))
						Else
							MSMM(P0B->P0B_CODOBS,1000,,AllTrim(cMemoObs),1,,,"P0B","P0B_CODOBS")
						EndIf
					EndIf
					
					P0B->(MsUnLock())
					
					P0B->(dbSkip())
					
				EndDo
				
			EndIf
			
			RestArea(aAreaAux)
			
			// Libera o Contrato
			
			P0B->(DbGoTo(nRecno))
			
			(cAliasTab)->(DbSetOrder( P0B->P0B_INDCHO ))
			If (cAliasTab)->(DbSeek(xFilial(cAliasTab)+P0B->P0B_CHVIND))
				(cAliasTab)->(RecLock(cAliasTab,.F.))
				(cAliasTab)->&(cAliasTab+"_STATUS"):="3"
				(cAliasTab)->(MsUnLock())
			EndIf
			
			//P0B->(R705EnvMailStatus(Posicione("P09",1,xFilial("P09")+P0B_APROV,"P09_EMAIL"),"Retorno da aprova��o da Margem do Contrato de venda: "+ P0B_NUM,"Aprovado",P0B_CONTRATO))
		EndIf
		
	EndIf
	
	If lShow
		MsgAlert("Contrato/Verba Extra Aprovado", "Contrato")
	EndIf
EndIf

P0B->(RestArea(alArea))

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PR706LEG  �Autor  �Hermes Ferreira      � Data �  10/12/12  ���
�������������������������������������������������������������������������͹��
���Desc.     �Legenda do Browse                                           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PR706LEG()

Local aCor := {}

aAdd(aCor,{"BR_AMARELO"	,"Aguardando sua aprova��o"   						}) 	// 01
aAdd(aCor,{"BR_LARANJA"	,"Aguar. demais aprov. no mesmo n�vel" 				})	// 02
aAdd(aCor,{"BR_AZUL"	,"Aguardando aprova��o n�vel superior"				}) 	// 03
aAdd(aCor,{"BR_VERDE"	,"Aprovado"											}) 	// 04
aAdd(aCor,{"BR_VERMELHO","Reprovado" 										})	// 05

BrwLegenda(,"Status",aCor)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR706  �Autor  �Microsiga           � Data �  03/29/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PR706Timer()
MsgRun("Atualizando dados", "Satus...", { || PR706TBrw() } )
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR706  �Autor  �Microsiga           � Data �  08/01/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PR706TBrw()
Local oObjBrow:=GetObjBrow()
oObjBrow:ResetLen()
oObjBrow:GoTop()
oObjBrow:Refresh()
Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR706  �Autor  �Microsiga           � Data �  04/25/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PR706Apr(nTipo)

If !P0B->P0B_USER == Alltrim(cUserLog)
	Aviso("NCGPR706 - PR706Apr","S� permitido analise pelo aprovador "+UsrFullName(P0B->P0B_USER)+".",{"Ok"},3)
	Return
EndIf


If nTipo==1
	u_PR706APROV("A")
Else
	u_PR706APROV("R")
EndIf

Return
