#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWF102  �Autor  �Hermes Ferreira     � Data �  10/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina manual de aprova��o/reprova��o de al�ada de t�tulo do���
���          �tipo NCC e a pagar que estejam relacionado a um VPC/VERBA   ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function NCGWF102()

Local aCores		:= {}
Local aFixes:={}
Private aRotina		:= MenuDef()
Private cCadastro	:= "Aprova��o de Al�adas"
Private cUserLog	:= Alltrim(__cUserId)

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

aCores := {	 {"P0B->P0B_STATUS == '01' "	,"BR_AMARELO"   };
,{"P0B->P0B_STATUS == '02' "	,"BR_LARANJA"	};
,{"P0B->P0B_STATUS == '03' "	,"BR_AZUL"		};
,{"P0B->P0B_STATUS == '04' "	,"BR_VERDE"		};
,{"P0B->P0B_STATUS == '05' "	,"BR_VERMELHO"	}}
                  

dbSelectArea("SX3")
dbSetOrder(2)

Begin Sequence

dbSelectArea("P0B")
P0B->(dbSetOrder(1))

If SX3->(dbSeek( "P0B_FILIAL" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_FILIAL"})
EndIf
If SX3->(dbSeek( "P0B_STATUS" ))
	AADD(aFixes, {"Status","P0B_STATUS"})
EndIf
If SX3->(dbSeek( "P0B_PREFIX" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_PREFIX"   })
EndIf

If SX3->(dbSeek( "P0B_NUMTIT" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_NUMTIT"   })
EndIf

If SX3->(dbSeek( "P0B_VLRTIT" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_VLRTIT"   })
EndIf

If SX3->(dbSeek( "P0B_CODCLI" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_CODCLI" })
EndIf

If SX3->(dbSeek( "P0B_LOJA" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_LOJA" })
EndIf

If SX3->(dbSeek( "P0B_NOMECL" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_NOMECL" })
EndIf

If SX3->(dbSeek( "P0B_EMITIT" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_EMITIT" })
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
P0B->(dbSetOrder(1))

mBrowse( 6, 1,22,75,'P0B',aFixes,,,,,aCores,,,,,,,," P0B_FILIAL = '"+xFilial("P0B")+"' AND P0B_TIPO <> 'PAL' AND P0B_STATUS <> '  ' AND P0B_USER = '"+Alltrim(cUserLog)+"'"  )

End Sequence

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MenuDef   �Autor  �Hermes Ferreira     � Data �  03/10/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Menu da rotina de cadastro                                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Nc Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MenuDef()

Local alRotina := {  {"Pesquisar"		,"AxPesqui"			,0,1} ,;
{"Visualizar"		,"U_WF102ATU()"		,0,2} ,;
{"Aprovar"			,"U_WF102ATU(1)"	,0,4} ,;
{"Reprovar"		,"U_WF102ATU(2)"	,0,4} ,;
{"Legenda"			,"U_WF102LEG"		,0,6} }

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

Return alRotina


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WF102ATU  �Autor  �Hermes		         � Data �  15/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Atualiza o processo de al�ada. Aprova ou reprova uma al�ada ���
���          �de VPC / VERBA                                              ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function WF102ATU(nOpc)

Local aAreaP0b 		:= P0B->(GetArea())
Local nRet			:= 2
Default	nOpc		:= 0

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

If nOpc > 0
	
	If P0B->P0B_STATUS == '01'
		
		nRet := MnTelaWF2(nOpc)
		
		If nRet == 1
			
			If nOpc == 1 // Aprova
				
				U_WF102APR()
				
			ElseIf nOpc == 2 // Reprova
				
				U_WF102REPR()
				
			EndIf
			
		EndIf
		
	Else
		
		Aviso("NCGWF102 - 01","S� permitido aprovar/reprovar caso esteja aguardando alguma a��o para seu usu�rio.",{"Ok"},3)
		
	EndIf
	
Else
	MnTelaWF2(nOpc)
EndIf

RestArea(aAreaP0b)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWF102  �Autor  �Microsiga           � Data �  12/19/12   ���
�������������������������������������������������������������������������͹��
���Desc.     � Fun��o de aprova��o de Al�ada de VPC/Verba                 ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Nc Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function WF102APR()

Local llNextNivel 	:= .F.
Local llMesmoNivel	:= .F.
Local aAreaAux 		:= {}
Local cTipoAlc		:= P0B->P0B_TIPO
Local cNumDoc		:= P0B->P0B_NUM
Local cNivel		:= P0B->P0B_NIVEL
Local cTabOrig		:= P0B->P0B_TABORI
Local cPreCampo		:= Right(cTabOrig,2)

llMesmoNivel := ExstMemNiv(AllTrim(P0B->P0B_NUM),Alltrim(P0B->P0B_NIVEL))

If llMesmoNivel // Agurada aprova��o mesmo nivel
	
	P0B->(RecLock("P0B",.F.))
	
	P0B->P0B_STATUS := '02'
	
	P0B->(MsUnLock())
	
Else // Proximo Nivel
	
	llNextNivel := GetNextNivel(AllTrim(P0B->P0B_NUM),Alltrim(P0B->P0B_NIVEL))
	
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
				
				P0B->(MsUnLock())
				
				P0B->(dbSkip())
				
			EndDo
			
		EndIf
		
		RestArea(aAreaAux)
		
		// Libera o Titulo
		dbSelectArea(cTabOrig)
		
		&(cTabOrig)->(dbSetOrder(P0B->P0B_INDCHO))
		If &(cTabOrig)->(dbSeek(xFilial(cTabOrig)+ P0B->P0B_CHVIND ))
			
			If &(cTabOrig)->(RecLock(cTabOrig,.F.))
				
				If cTabOrig == "SE1"
					
					SE1->E1_YBLQVPC	:= 'N'
					
				ElseIf cTabOrig == "SE2"
					
					SE2->E2_DATALIB	:= MSDate()
					
				EndIf
				
				&(cTabOrig)->(MsUnLock())
				cVpcVerTit	:= (cTabOrig)->&(cPreCampo+"_YVPC")
				cVersaoVV	:= (cTabOrig)->&(cPreCampo+"_YVERVPC")
				
			EndIf
			
		EndIf
		
		// Encerra Verba
		If !Empty(cVpcVerTit) .AND. !Empty(cVersaoVV) .AND. cTabOrig == "SE2"
			
			dbSelectArea("P01")
			P01->(dbSetOrder(1))
			If P01->(dbSeek(xFilial("P01")+cVpcVerTit+cVersaoVV))
				If P01->P01_STATUS == "1"
					
					If RecLock("P01",.F.)
						
						P01->P01_TOTCON += (cTabOrig)->&(cPreCampo+"_VALOR")
						
						If P01->P01_TOTCON == P01->P01_TOTVAL
							P01->P01_STATUS := "2"
						EndIf
						
						P01->(MsUnLock())
					EndIf
					
				EndIf
			EndIf
			
		EndIf
		
		
	EndIf
	
EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MnTelaWF2 �Autor  �Hermes Ferreira     � Data �  10/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Tela de aprova��o/Reprova��o de uma al�ada de VPC/Verba	  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MnTelaWF2(nOpc)

Local oFont01   	:=TFont():New( "Courier New",,20,,.F.,,,20,,,,,,,,)
Local cTitulo		:= "Tela para "+IIf(nOpc == 1, "Aprovar",(IIF(nOpc == 2,"Reprovar","")))+" Al�ada."
Local alPosCab		:= {}
Local alPosTot		:= {}
Local nlResoluc		:= oMainWnd:nClientWidth
Local alCoord		:= MsAdvSize(.T.,.F.,0)
Local aButtons		:= {}
Local aCamposV		:= {}
Local aCamposTot	:= {}
Local alCmpAlt		:= {}
Local alPrc			:= {}
Local odlgCab		:= Nil
Local odlgPed		:= Nil
Local oEncCab		:= Nil
Local olOdlg		:= Nil
Local olGridPed
Local nRet			:= 2
Local cTabOrig		:= P0B->P0B_TABORI
Local cPreCampo		:= Right(cTabOrig,2)
Local _CodVPC		:= ""
Local _VERVPC		:= ""

Private aTela[0][0]
Private aGets[0]
Private aHeadPed := {}
Private aColsPed := {}


Private opLayer		:= FWLayer():New()

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

dbSelectArea(cTabOrig)
&(cTabOrig)->(dbSetOrder(P0B->P0B_INDCHO))

If &(cTabOrig)->(dbSeek(xFilial(cTabOrig)+ P0B->P0B_CHVIND ))
	
	_CodVPC := (cTabOrig)->&(cPreCampo+"_YVPC")
	_VERVPC := (cTabOrig)->&(cPreCampo+"_YVERVPC")
	
	dbSelectArea("P01")
	P01->(dbSetORder(1)) //P01_FILIAL+P01_CODIGO+P01_VERSAO
	If P01->(dbSeek(xFilial("P01")+ _CodVPC  +  _VERVPC ))
		
		Aadd(aButtons,{"COMPTITL",{|| FVisuTit()},"Visualizar Titulo","Visualizar Titulo"})
		/*
		If Alltrim(P0B->P0B_TIPO) == "VER"
		
		alPrc			:= {50,50}
		Else
		*/
		
		alPrc			:= {100}
		
		//EndIf
		
		// Campos que ser�o exibidos a Enchoice
		AADD(aCamposV,"P0B_NOMAPR"	)
		AADD(aCamposV,"P0B_CODVPC"	)
		AADD(aCamposV,"P0B_DESVPC"	)
		AADD(aCamposV,"P0B_DTVPC"	)
		
		If  Alltrim(P0B->P0B_TIPO) == "VPC"
			
			AADD(aCamposV,"P0B_APURAC")
			AADD(aCamposV,"P0B_DFCAPU")
			AADD(aCamposV,"P0B_DINAPU")
			AADD(aCamposV,"P0B_DFIAPU") 
			
		ElseIf Alltrim(P0B->P0B_TIPO) == "VER"
			
			AADD(aCamposV,"P0B_TOTVER")
			AADD(aCamposV,"P0B_FILPED")
			AADD(aCamposV,"P0B_PEDIDO")
			
		EndIf
		
		AADD(aCamposV,"P0B_PREFIX"	)
		AADD(aCamposV,"P0B_NUMTIT"	)
		AADD(aCamposV,"P0B_EMITIT"	)
		AADD(aCamposV,"P0B_VLRTIT"	)
		AADD(aCamposV,"P0B_OBS"		)
		AADD(aCamposV,"NOUSER"		)
		
		RegToMemory("P0B", .F.,.T.,.T.)
		
		
		M->P0B_NOMAPR	:= Posicione("P09",1,xFilial("P09")+P0B->P0B_APROV,"P09_NOME")
		M->P0B_CODVPC	:= P01->P01_CODIGO
		M->P0B_DESVPC	:= P01->P01_DESC
		M->P0B_DTVPC	:= P01->P01_DTCRIA
		
		
		If Alltrim(P0B->P0B_TIPO) == "VPC"
			
			dbSelectArea("P04")
			P04->(dbSetOrder(1))
			If P04->(dbSeek(xFilial("P04")+(cTabOrig)->&(cPreCampo+"_YAPURAC")))
				
				M->P0B_APURAC	:= P04->P04_CODIGO
				M->P0B_DFCAPU	:= P04->P04_FECHAM
				M->P0B_DINAPU	:= P04->P04_DTINI
				M->P0B_DFIAPU	:= P04->P04_DTFIM
				
			EndIf
			
		ElseIf Alltrim(P0B->P0B_TIPO) == "VER"
			
			M->P0B_TOTVER	:= P01->P01_TOTVAL
			M->P0B_FILPED	:= P01->P01_FILPED
			M->P0B_PEDIDO	:= P01->P01_PEDVEN
			
			//M->P0B_TOTPED	:= U_TWF2PVVB( P01->P01_CODIGO  ,  P01->P01_VERSAO)
			
		EndIf
		
		M->P0B_PREFIX	:= (cTabOrig)->&(cPreCampo+"_PREFIXO")
		M->P0B_NUMTIT	:= (cTabOrig)->&(cPreCampo+"_NUM")
		M->P0B_EMITIT	:= (cTabOrig)->&(cPreCampo+"_EMISSAO")
		M->P0B_VLRTIT	:= (cTabOrig)->&(cPreCampo+"_VALOR")
		M->P0B_OBS		:= P0B->(MSMM(P0B->P0B_CODOBS,,,,3))
		
		
		olOdlg := TDialog():New(alCoord[1],alCoord[2],alCoord[6],alCoord[5],cTitulo,,,,,CLR_BLACK,CLR_WHITE,,,.T.)
		
		opLayer:Init(olOdlg,.F.)
		
		opLayer:AddCollumn("CENTRO"	,100,.F.)
		
		opLayer:AddWindow("CENTRO","CABEC"					,IIf(nOpc == 1, "Aprovar",(IIF(nOpc == 2,"Reprovar","Visualiza")))	,alPrc[1],.T.,.T.,{||},,{||})
		odlgCab	:= opLayer:GetWinPanel("CENTRO","CABEC")
		
		alPosCab	:= {0,0,0,0}
		
		oEncCab:= MSMGet():New("P0B",,IIF(nOpc >0 ,4 ,2 ),,,,aCamposV,alPosCab,,,,,,odlgCab,,,,,,,,,,,,.T.)
		oEncCab:oBox:Align := CONTROL_ALIGN_ALLCLIENT
		
		/*
		If Alltrim(P0B->P0B_TIPO) == "VER"
		
		opLayer:AddWindow("CENTRO","PEDIDOS"			,"Pedidos"													,alPrc[2],.T.,.T.,{||},,{||})
		odlgPed	:= opLayer:GetWinPanel("CENTRO","PEDIDOS")
		
		FHeadPed(_CodVPC  ,  _VERVPC )
		
		olGridPed:= MsNewGetDados():New(0,0,0,0,1,"AllWaysTrue()","AllWaysTrue()","",,,9999,"AllWaysTrue()",,,odlgPed,aHeadPed,aColsPed)
		olGridPed:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
		olGridPed:lInsert := .F.
		
		If Len(aColsPed) == 0
		olGridPed:aCols:= aColsPed
		EndIf
		
		EndIf
		*/
		Activate Msdialog olOdlg Centered On Init EnchoiceBar(olOdlg,;
		{|| IIF (Iif(nOpc > 0,Obrigatorio(aGets,aTela),.T.),  (FGRVWF2(nOpc,MsAuto2Ench("P0B")),olOdlg:End(), nRet := 1 )    ,Nil)   },;
		{|| olOdlg:End(),nRet := 2 };
		,,aButtons)
	Else
		
		Aviso("NCGWF102 - 03","N�o foi localizado o cadastra Verba/VPC. Verifique se o cadastro n�o foi exclu�do.",{"Ok"},3)
		
	EndIf
	
Else
	
	Aviso("NCGWF102 - 02","N�o foi localizado o t�tulo deste processo de al�ada. Verifique se o t�tulo n�o foi exclu�do.",{"Ok"},3)
	
EndIf

Return nRet
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FHeadPed  �Autor  �Hermes Ferreira    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Monta o Header dos pedidos relacionados a verba do titulo   ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function FHeadPed(cVerba,cVersao)

Local aCmpHeader	:= {}
Local cAlias		:= GetNextAlias()
Local cSql			:= ""
Local nI,i

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

AADD(aCmpHeader,"C5_FILIAL"		)
AADD(aCmpHeader,"C5_NUM"		)
AADD(aCmpHeader,"C5_EMISSAO"	)
AADD(aCmpHeader,"TOTPED"		)
AADD(aCmpHeader,"TOTVERBA"		)

SX3->(DbSetOrder(2))
For nI := 1 to Len(aCmpHeader)
	
	If !(aCmpHeader[nI] $ "TOTPED/TOTVERBA")
		
		If SX3->(DbSeek(aCmpHeader[nI]))
			Aadd(aHeadPed,	{	Trim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,;
			SX3->X3_TAMANHO,SX3->X3_DECIMAL,/*SX3->X3_VALID*/,;
			SX3->X3_USADO,SX3->X3_TIPO,	;
			SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,,SX3->X3_WHEN,	;
			SX3->X3_VISUAL,SX3->X3_VLDUSER, SX3->X3_PICTVAR,SX3->X3_OBRIGAT	})
		EndIf
		
	Else
		
		If aCmpHeader[nI] == "TOTPED"
			
			Aadd(aHeadPed,	{ "Total Pedido","TOTPED",PesqPict("SC6","C6_VALOR"),;
			TamSx3("C6_VALOR")[1],TamSx3("C6_VALOR")[2],"",;
			"","N",	;
			"","","",,"",	;
			"","","",""	})
			
		ElseIf aCmpHeader[nI] == "TOTVERBA"
			
			Aadd(aHeadPed,	{ "Verba","TOTVERBA",PesqPict("P01","P01_TOTVAL"),;
			TamSx3("P01_TOTVAL")[1],TamSx3("P01_TOTVAL")[2],"",;
			"","N",	;
			"","","",,"",	;
			"","","",""	})
		EndIf
		
	EndIf
	
Next nI

// Carrega Lista dos pedidos de venda que est�o relacionados a verba
cSql := U_LSTWF2PV( cVerba,cVersao )
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.)
TCSetField((cAlias),"C5_EMISSAO"	,"D",TamSx3("C5_EMISSAO")[1],TamSx3("C5_EMISSAO")[2]	)
TCSetField((cAlias),"TOTPED"   		,"N",TamSx3("C6_VALOR")[1]	,TamSx3("C6_VALOR")[2] 		)
TCSetField((cAlias),"TOTVERBA"		,"N",TamSx3("P01_TOTVAL")[1],TamSx3("P01_TOTVAL")[2]	)


(cAlias)->(dbGoTop())

If (cAlias)->(!Eof()) .and. (cAlias)->(!Bof())
	
	While (cAlias)->(!Eof())
		
		AAdd(aColsPed,Array(Len(aHeadPed)+1))
		
		For i := 1 To Len(aHeadPed)
			
			aColsPed[Len(aColsPed)][i] := (cAlias)->(&(aHeadPed[i,2]))
			
		Next i
		
		aColsPed[Len(aColsPed)][Len(aHeadPed)+1] := .F.
		
		(cAlias)->(dbSkip())
		
	EndDo
	
EndIf

(cAlias)->(dbCloseArea())

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FGRVWF2	�Autor  �Hermes Ferreira     � Data �  10/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina de Grava��o da aprova��o/reprova�a�  				  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function FGRVWF2(nOpc,aAutoCab)
Local nA
Local cMemoObs	:= ""

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

If RecLock( "P0B", .F.)
	
	For nA := 1 to Len(aAutoCab)
		
		If "FILIAL" $ aAutoCab[nA,1]
			
			P0B->(FieldPut(FieldPos(aAutoCab[nA][1]),xFilial("P0B")))
			
		Else
			
			P0B->(FieldPut(FieldPos(aAutoCab[nA][1]),aAutoCab[nA][2]))
			
		EndIf
		
	Next nA
	
	If nOpc == 1
		
		P0B->P0B_DTLIB := MsDate()
		
	ElseIf nOpc == 2
		
		P0B->P0B_DTREPR:= MsDate()
		
	EndIf
	
	cMemoObs := M->P0B_OBS
	P0B->(MSMM(,,, cMemoObs ,1,,,"P0B","P0B_CODOBS","SYP"))
	
	P0B->(MsUnlock())
	
EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ExstMemNiv�Autor  �Hermes		         � Data �  15/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se existe outro aprovador no mesmo nivel p/  atuali���
���          �zar a legenda da tela do usu�rio aprovador                  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ExstMemNiv(cNumAlc,cNivel)

Local llRet 	:= .F.
Local cSql 		:= ""
Local cAlias	:= GetNextAlias()

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

cSql	:= " SELECT "
cSql	+= " P0B_USER "
cSql	+= " FROM " +RetSqlName("P0B")+ " P0B "
cSql	+= " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
cSql	+= " AND P0B.P0B_NUM = '"+cNumAlc+"'"
cSql	+= " AND P0B.P0B_NIVEL = '"+cNivel+"'"
cSql	+= " AND P0B.P0B_USER <> '"+Alltrim(cUserLog)+"'"
cSql	+= " AND P0B.P0B_STATUS = '01'"
cSql	+= " AND P0B.D_E_L_E_T_= ' '"

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.)

(cAlias)->(dbGoTop())

If (cAlias)->(!Eof()) .AND. (cAlias)->(!Bof())
	llRet := .T.
EndIf

(cAlias)->(dbCloseArea())

Return llRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetNextNivel�Autor  �Hermes   	     � Data �  15/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se existe outro aprovador no nivel superior para   ���
���          �atualizar a legenda da tela do usu�rio aprovador            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GetNextNivel(cNumAlc,cNivel)

Local llRet 	:= .F.
Local cSql 		:= ""
Local cTabOrig	:= ""
Local _VERVPC	:= ""
Local _CodVPC	:= ""
Local cPreCampo	:= ""
Local cAlias	:= GetNextAlias()
Local aAreaP0B	:= P0B->(GetArea())

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

cSql	:= " SELECT "
cSql	+= " P0B_NUM "
cSql	+= " ,P0B_TIPO "
cSql	+= " ,P0B_USER "
cSql	+= " ,P0B_NIVEL "
cSql	+= " ,P0B_WF "
cSql	+= " FROM " +RetSqlName("P0B")+ " P0B "
cSql	+= " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
cSql	+= " AND P0B.P0B_NUM = '"+cNumAlc+"'"
cSql	+= " AND P0B.P0B_NIVEL > '"+cNivel+"'" // Proximo Nivel
cSql	+= " AND P0B.D_E_L_E_T_= ' ' "
cSql	+= " ORDER BY P0B_NIVEL "

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.)

(cAlias)->(dbGoTop())

If (cAlias)->(!Eof()) .AND. (cAlias)->(!Bof())
	
	llRet := .T.
	
	P0B->(dbSetOrder(1)) // P0B_FILIAL+P0B_TIPO+P0B_NUM+P0B_NIVEL
	
	cNextNivel := Alltrim((cAlias)->P0B_NIVEL)
	
	While (cAlias)->(!Eof())
		
		If Alltrim(cNextNivel) == Alltrim((cAlias)->P0B_NIVEL)
			If P0B->(dbSeek(xFilial("P0B")+ (cAlias)->(P0B_TIPO+P0B_NUM+P0B_NIVEL )))
				
				If P0B->(RecLock("P0B",.F.))
					P0B->P0B_STATUS := '01'
					P0B->(MsUnLock())
				EndIf
				
				// Fazer Tratamento para enviar WF para a Proxima Fase
				If (cAlias)->P0B_WF == "1"
					
					cMailDest := Posicione("P09",1,xFilial("P09")+ P0B->P0B_APROV,"P09_EMAIL" )
					cNomeAprov:= Posicione("P09",1,xFilial("P09")+ P0B->P0B_APROV,"P09_NOME")
					
					cTabOrig	:= P0B->P0B_TABORI
					cPreCampo	:= Right(cTabOrig,2)
					
					dbSelectArea(cTabOrig)
					
					&(cTabOrig)->(dbSetOrder(P0B->P0B_INDCHO))
					If &(cTabOrig)->(dbSeek(xFilial(cTabOrig)+ P0B->P0B_CHVIND ))
						
						_CodVPC := (cTabOrig)->&(cPreCampo+"_YVPC")
						_VERVPC := (cTabOrig)->&(cPreCampo+"_YVERVPC")
						
						U_ENVWF102(P0B->P0B_NUM,P0B->P0B_TIPO,cNomeAprov,cMailDest,P0B->P0B_TABORI,P0B->P0B_CHVIND,P0B->P0B_INDCHO,_CodVPC, _VERVPC)
						
					EndIf
					
				EndIf
				
			EndIf
		Else
			Exit
		EndIf
		(cAlias)->(dbSkip())
		
	EndDo
	
EndIf

(cAlias)->(dbCloseArea())

RestArea(aAreaP0B)

Return llRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WF102REPR	�Autor  �Hermes   	    	 � Data �  15/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Caso tenha sido reprovada em alguma fase, ir� atualizar o   ���
���          �status em todas as fases					                  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WF102REPR()

Local aAreaP0b 	:= P0B->(GetArea())
Local cTipoAlc	:= P0B->P0B_TIPO
Local cNumDoc	:= P0B->P0B_NUM

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

P0B->(dbGoTop())
P0B->(dbSetOrder(1))

If P0B->(dbSeek(xFilial("P0B")+ cTipoAlc +cNumDoc))
	
	While P0B->(!Eof()) .AND. cNumDoc == P0B->P0B_NUM
		
		P0B->(RecLock("P0B",.F.))
		
		P0B->P0B_STATUS := '05'
		P0B->P0B_DTREPR	:= MsDate()
		
		P0B->(MsUnLock())
		
		P0B->(dbSkip())
		
	EndDo
	
EndIf

RestArea(aAreaP0B)

Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WF102LEG  �Autor  �Hermes Ferreira      � Data �  10/12/12  ���
�������������������������������������������������������������������������͹��
���Desc.     �Legenda do Browse                                           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WF102LEG()

Local aCor := {}

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

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
���Programa  �FVisuTit  �Autor  �Hermes Ferreira      � Data �  10/12/12  ���
�������������������������������������������������������������������������͹��
���Desc.     �Fun��o para visualizar o titulo a pagar/receber que gerou   ���
���          �a al�ada                                                    ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function FVisuTit()

Local cTabOrig	:= P0B->P0B_TABORI

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

If P0B->P0B_TABORI == "SE1"
	
	FA280Visua(cTabOrig,&(cTabOrig)->(Recno()),2)
	
ElseIf P0B->P0B_TABORI == "SE2"
	
	//FA050Visua(cTabOrig,&(cTabOrig)->(Recno()),2)
	AxVisual(cTabOrig,&(cTabOrig)->(Recno()),2)
	
EndIf

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �TWF2PVVB  �Autor  �Hermes Ferreira    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o o Total ( valor) dos  pedidos de venda que estao  ���
���          �relacionados a verba do titulo, fun��o de controle de al�ada���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function TWF2PVVB(cVerba,cVersao)
Local nRet := 0
Local cSql 		:= ""
Local cAlias	:= GetNextAlias()

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

cSql := " SELECT "
cSql += " SUM(C6_VALOR) TOTPED "
cSql += " FROM " +RetSqlName("SC6")+ " SC6 "

cSql += " JOIN " + RetSqlName("SC5") + " SC5 "
cSql += " ON SC5.C5_FILIAL = SC6.C6_FILIAL "
cSql += " AND SC5.C5_NUM  = SC6.C6_NUM "
cSql += " AND SC5.C5_CLIENTE  = SC6.C6_CLI "
cSql += " AND SC5.C5_LOJACLI  = SC6.C6_LOJA "
cSql += " AND SC5.C5_YCODVPC = '"+cVerba+"'"
cSql += " AND SC5.C5_YVERVPC = '"+cVersao+"'"
cSql += " AND SC5.D_E_L_E_T_ <> ' '"

cSql += " JOIN " + RetSqlName("P01") + " P01 "
cSql += " ON P01.P01_FILIAL = '"+xFilial("P01")+"'"
cSql += " AND P01_TPCAD = '2'"
cSql += " AND P01.P01_CODIGO = SC5.C5_YCODVPC "
cSql += " AND P01.P01_VERSAO = SC5.C5_YVERVPC "
cSql += " AND P01.D_E_L_E_T_ <> ' '"

cSql += " WHERE SC6.D_E_L_E_T_ = ' '"

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.)
TCSetField((cAlias),"TOTPED"   		,"N",TamSx3("C6_VALOR")[1]	,TamSx3("C6_VALOR")[2] 		)

(cAlias)->(dbGoTop())

If (cAlias)->(!Eof()) .AND. (cAlias)->(!Bof())
	nRet := (cAlias)->TOTPED
EndIf

(cAlias)->(dbCloseArea())

Return nRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �LSTWF2PV  �Autor  �Hermes Ferreira    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna os pedidos de venda que estao relacionados a verba  ���
���          �fun��o de controle de al�ada      						  ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function LSTWF2PV(cVerba,cVersao)

Local cRet := ""

cRet := " SELECT "
cRet += " C5_FILIAL "
cRet += " ,C5_NUM "
cRet += " ,C5_EMISSAO "
cRet += " , (
cRet += " 	SELECT SUM(C6_VALOR)"
cRet += " 	FROM "+ RetSqlName("SC6")+ " SC6 "
cRet += " 	WHERE SC6.C6_FILIAL = SC5.C5_FILIAL "
cRet += " 	AND SC6.C6_NUM = SC5.C5_NUM "
cRet += "	AND SC6.C6_CLI = SC5.C5_CLIENTE  "
cRet += "	AND SC6.C6_LOJA = SC5.C5_LOJACLI  "
cRet += " 	AND SC6.D_E_L_E_T_ = ' '"
cRet += " 	) AS TOTPED "
cRet += " , P01_TOTVAL AS TOTVERBA "
cRet += " FROM " +RetSqlName("SC5")+ " SC5 "

cRet += " JOIN " + RetSqlName("P01") + " P01 "
cRet += " ON P01.P01_FILIAL = '"+xFilial("P01")+"'"
cRet += " AND P01_TPCAD = '2'"
cRet += " AND P01.P01_CODIGO = SC5.C5_YCODVPC "
cRet += " AND P01.P01_VERSAO = SC5.C5_YVERVPC "
cRet += " AND P01.D_E_L_E_T_ <> ' '"

cRet += " WHERE SC5.D_E_L_E_T_ = ' '"
cRet += " AND SC5.C5_YCODVPC = '"+cVerba+"'"
cRet += " AND SC5.C5_YVERVPC = '"+cVersao+"'"

cRet += " ORDER BY C5_FILIAL, C5_NUM , C5_EMISSAO "

Return cRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ENVWF102  �Autor  �Hermes Ferreira    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Monta o WF com as informa��es para a solicita��o de libera- ���
���          ���o de pagamento do VPC / VERBA   						  ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function ENVWF102(cNumAlc,cTpDocAlc,cNomeAprov,cMailDest,cTabOrig,ChaveInd,nInd,_CodVPC, _VERVPC )

Local clCodProces	:= ""//Nome do Processo de WorkFlow
Local clHtmlMod 	:= "" //Nome do arquivo html que ser� gerado para envio ao setor financeiro
Local clAssunto 	:= ""
Local clMailID		:= ""
Local clUserWF		:= "Administrador"
Local cPreCampo		:= Right(cTabOrig,2)
Local cAliasTMP		:= GetNextAlias()
Local aAreaP09		:= P09->(GetArea())
Local aAreaP0B		:= P0B->(GetArea())

Local clHtmlMod		:=  Alltrim(U_MyNewSX6(	"NCG_000022",;
"",;
"C",;
"Diretorio dos Html do Workflow ",;
"Diretorio dos Html do Workflow ",;
"Diretorio dos Html do Workflow ",;
.F. )   )

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

If cTpDocAlc == "VER"
	
	clHtmlMod := clHtmlMod+IIf(Right(clHtmlMod,1) <> "\", "\","")+ "liberaVerba.html"
	
Else
	
	clHtmlMod := clHtmlMod+IIf(Right(clHtmlMod,1) <> "\", "\","")+ "liberaVPC.html"
	
EndIf

clAssunto := "Aprova��o de t�tulo relacionado a um" +IIF(cTpDocAlc == " VPC",cTpDocAlc, "a Verba")+"."


dbSelectArea(cTabOrig)
&(cTabOrig)->(dbSetOrder(nInd))

If &(cTabOrig)->(dbSeek(xFilial(cTabOrig)+ ChaveInd ))
	
	dbSelectArea("P01")
	P01->(dbSetORder(1)) //P01_FILIAL+P01_CODIGO+P01_VERSAO
	If P01->(dbSeek(xFilial("P01")+ _CodVPC  +  _VERVPC ))
		
		If File(clHtmlMod)
			olProcess := TWFProcess():New(clAssunto, clAssunto) //Instancia objeto da classe TWFProcess para inicializar WF
			olProcess:NewTask(clAssunto, clHtmlMod)//Inicializa a tarefa
			olProcess:cSubject := clAssunto
			olProcess:cTo := cMailDest
			olProcess:bReturn := "U_WF102RET()"
			
			olHtml    := olProcess:oHtml
			
			
			olHtml:ValByName( "P0B_NUM"			, cNumAlc      		)
			olHtml:ValByName( "P0B_APROV"		, P0B->P0B_APROV  	)
			olHtml:ValByName( "P0B_NIVEL"		, P0B->P0B_NIVEL  	)
			olHtml:ValByName( "P0B_TIPO"		, P0B->P0B_TIPO   	)
			
			olHtml:ValByName( "NOMEAPROVADOR"	, cNomeAprov		)
			
			olHtml:ValByName( "CODVPC"			, P01->P01_CODIGO	)
			olHtml:ValByName( "DESCVPC"			, P01->P01_DESC		)
			olHtml:ValByName( "DTCRIACAOVPC"	, P01->P01_DTCRIA	)
			olHtml:ValByName( "PREFIXO"			, (cTabOrig)->&(cPreCampo+"_PREFIXO")	)
			olHtml:ValByName( "NUMTITULO"		, (cTabOrig)->&(cPreCampo+"_NUM")		)
			olHtml:ValByName( "DTEMISSATIT"		, (cTabOrig)->&(cPreCampo+"_EMISSAO")	)
			
			olHtml:ValByName( "TOTTITULO"		,	Transform( (cTabOrig)->&(cPreCampo+"_VALOR"), PesqPict("SE1","E1_VALOR") )	)
			
			If cTpDocAlc == "VPC"
				
				dbSelectArea("P04")
				P04->(dbSetOrder(1))
				If P04->(dbSeek(xFilial("P04")+(cTabOrig)->&(cPreCampo+"_YAPURAC")))
					
					olHtml:ValByName( "CODAPURAC"	, P04->P04_CODIGO	)
					olHtml:ValByName( "DTFECAPU"	, P04->P04_FECHAM	)
					olHtml:ValByName( "DTINIAPU"	, P04->P04_DTINI	)
					olHtml:ValByName( "DTFIMAPU"	, P04->P04_DTFIM	)
					
				Else
					olHtml:ValByName( "CODAPURAC"	,""					)
					olHtml:ValByName( "DTFECAPU"	,CtoD("  /  /  ")	)
					olHtml:ValByName( "DTINIAPU"	,CtoD("  /  /  ")	)
					olHtml:ValByName( "DTFIMAPU"	,CtoD("  /  /  ")	)
				EndIf
				
			ElseIf cTpDocAlc == "VER"
				olHtml:ValByName( "TOTVERBA"	, Transform( P01->P01_TOTVAL ,  PesqPict("P01","P01_TOTVAL")	) 	)
				
				olHtml:ValByName( "FILPEDVEN"		, P01->P01_FILPED 	)
				olHtml:ValByName( "NUMPEDVEN"		, P01->P01_PEDVEN  	)
				
				/*
				olHtml:ValByName( "TOTPED"		, Transform( U_TWF2PVVB(P01->P01_CODIGO  ,  P01->P01_VERSAO), PesqPict("SC6","C6_VALOR")	)  )
				
				
				
				cSql := U_LSTWF2PV( _CodVPC  ,  _VERVPC )
				
				DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAliasTMP, .F., .F.)
				TCSetField((cAliasTMP),"C5_EMISSAO"		,"D",TamSx3("C5_EMISSAO")[1],TamSx3("C5_EMISSAO")[2]	)
				TCSetField((cAliasTMP),"TOTPED"   		,"N",TamSx3("C6_VALOR")[1]	,TamSx3("C6_VALOR")[2] 		)
				TCSetField((cAliasTMP),"TOTVERBA"		,"N",TamSx3("P01_TOTVAL")[1],TamSx3("P01_TOTVAL")[2]	)
				
				
				(cAliasTMP)->(dbGoTop())
				
				If (cAliasTMP)->(!Eof()) .and. (cAliasTMP)->(!Bof())
				
				While (cAliasTMP)->(!Eof())
				
				Aadd((olHtml:ValByName("it.filial"		))	,	(cAliasTMP)->C5_FILIAL 	)
				Aadd((olHtml:ValByName("it.pedido"		))	,	(cAliasTMP)->C5_NUM 	)
				Aadd((olHtml:ValByName("it.dtemissao"	))	,	(cAliasTMP)->C5_EMISSAO )
				Aadd((olHtml:ValByName("it.totped"		))	,	 Transform( (cAliasTMP)->TOTPED ,  PesqPict("SC6","C6_VALOR")	) 	)
				Aadd((olHtml:ValByName("it.totverba"	))	,	 Transform( (cAliasTMP)->TOTVERBA,  PesqPict("P01","P01_TOTVAL")	)  	)
				
				(cAliasTMP)->(dbSkip())
				
				EndDo
				
				Else
				
				Aadd((olHtml:ValByName("it.filial"		))	,	"" 				)
				Aadd((olHtml:ValByName("it.pedido"		))	,	"" 				)
				Aadd((olHtml:ValByName("it.dtemissao"	))	,	CtoD("  /  /  "))
				Aadd((olHtml:ValByName("it.totped"		))	,	Transform( 0 ,  PesqPict("SC6","C6_VALOR")		)		)
				Aadd((olHtml:ValByName("it.totverba"	))	,	Transform( 0 ,  PesqPict("P01","P01_TOTVAL")	)		)
				
				EndIf
				
				(cAliasTMP)->(dbCloseArea())
				*/
			EndIf
			
			olHtml:ValByName( "DOCALCADA"		,cNumAlc	)
			
			
			cOldTo  := olProcess:cTo
			cOldCC  := olProcess:cCC
			cOldBCC := olProcess:cBCC
			
			//Uso um endereco invalido, apenas para criar o processo de workflow, mas sem envia-lo
			olProcess:cTo  := P0B->P0B_APROV
			olProcess:cCC  := NIL
			olProcess:cBCC := NIL
			
			clMailID := olProcess:Start()
			
			MyWFLink(clMailID,cOldTo,cOldCC,cOldBCC, olProcess:cSubject, clAssunto, Alltrim(cNomeAprov), olProcess,P0B->P0B_APROV,cNumAlc)
			
		Else
			
			Aviso("NCGWF102 - 04","N�o foi localizado o modelo HTML para envio do Workflow. Solicite ao Dpto. de Tecnologia da Informa��o para verificar os modelos HTML do Workflow do VPC/VEBA.",{"Ok"},3)
			
		EndIf
		
	EndIf
	
EndIf

RestArea(aAreaP09)
RestArea(aAreaP0B)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MyWFLink  �Autor  �Hermes Ferreira    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Envia o WF com o LIck para acessar o WF com as informa��es  ���
���          �da solicita��o de libera��o de pagamento do VPC / VERBA     ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MyWFLink(cHtmlFile, cOldTo, cOldCC, cOldBCC, cSubject, clAssunto, cNomeAprov, oObjWf, cUserWF ,cNumAlc )

Local cSrvHttpIn 	:= U_MyNewSX6("NCG_000020",;
"",;
"C",;
"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o interno (a clausula 'http://' � necess�ria ) ",;
"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o interno (a clausula 'http://' � necess�ria ) ",;
"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o interno (a clausula 'http://' � necess�ria ) ",;
.F. )
Local cSrvHttpEx 	:=  U_MyNewSX6(	"NCG_000021",;
"",;
"C",;
"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o externo (a clausula 'http://' � necess�ria )",;
"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o externo (a clausula 'http://' � necess�ria )",;
"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o externo (a clausula 'http://' � necess�ria )",;
.F. )

Local cEndHtml 		:=  U_MyNewSX6(	"NCG_000022",;
"",;
"C",;
"Diretorio do Html do Workflow",;
"Diretorio do Html do Workflow",;
"Diretorio do Html do Workflow Link  wflink.htm",;
.F.)

Local cEndArqWf		:=  U_MyNewSX6(	"NCG_000023",;
"",;
"C",;
"Endere�o dos arquivos de workflow para acesso via browser do Protheus (n�o incluir a pasta com o c�digo da empresa, pois a rotina preencher� automaticamente )",;
"Endere�o dos arquivos de workflow para acesso via browser do Protheus (n�o incluir a pasta com o c�digo da empresa, pois a rotina preencher� automaticamente )",;
"Endere�o dos arquivos de workflow para acesso via browser do Protheus (n�o incluir a pasta com o c�digo da empresa, pois a rotina preencher� automaticamente )",;
.F. )


Local cLinkInt 		:= ""
Local cLinkExt		:= ""
Local cIdWf			:= ""

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

cEndHtml := cEndHtml+IIf(Right(cEndHtml,1) <> "\", "\","")+ "wflink.htm"

If Right(cSrvHttpIn,1) == "/"
	cSrvHttpIn := Left(cSrvHttpIn,Len(cSrvHttpIn)-1)
EndIf

If Right(cSrvHttpEx,1) == "/"
	cSrvHttpEx := Left(cSrvHttpEx,Len(cSrvHttpEx)-1)
EndIf

If Right(cEndArqWf,1) == "/"
	cEndArqWf := Left(cEndArqWf,Len(cEndArqWf)-1)
EndIf

If File(cEndHtml)
	
	cLinkInt 		:= cSrvHttpIn +  cEndArqWf +cEmpAnt + "/" + cUserWF + "/" + cHtmlFile + ".htm"
	
	cLinkExt 		:= cSrvHttpEx +  cEndArqWf +cEmpAnt + "/" + cUserWF + "/" + cHtmlFile + ".htm"
	
	oObjWf:NewTask("Link de Processos De Workflow", cEndHtml)
	
	oObjWf:ohtml:ValByName("titulo"			,clAssunto	)
	oObjWf:ohtml:ValByName("nomeaprovador"	,cNomeAprov )
	oObjWf:ohtml:ValByName("proc_link"		,cLinkInt	)
	oObjWf:ohtml:ValByName("docalc"			,cNumAlc	)
	oObjWf:ohtml:ValByName("proc_link2"		,cLinkExt	)
	
	
	oObjWf:cTo  := cOldTo
	oObjWf:cCC  := cOldCC
	oObjWf:cBCC := cOldBCC
	oObjWf:csubject := cSubject
	
	cIdWf := oObjWf:start()
	
Else
	
	Aviso("NCGWF102 - 05","N�o foi localizado o modelo HTML para envio do link Workflow. Solicite ao Dpto. de Tecnologia da Informa��o para verificar os modelos HTML do Workflow do VPC/VEBA.",{"Ok"},3)
	
EndIf

Return(cIdWf)


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WF102RET  �Autor  �Hermes Ferreira    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorno do WF de libera��o de Verba                         ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function WF102RET(oProcRet)

Local cTipoAlc	:= ""
Local cDocAlc 	:= ""
Local cNivel 	:= ""
Local cAprovad	:= ""
Local _cObsWF	:= ""
Local cAprRepr	:= ""
Local _cStatus	:= ""
Local cEndHtml	:= ""
Local _MailDest	:= ""

Private cUserLog := ""

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

If oProcRet <> Nil
	
	cTipoAlc	:= oProcRet:oHtml:RetByName("P0B_TIPO")
	cDocAlc 	:= oProcRet:oHtml:RetByName("P0B_NUM")
	cNivel 		:= oProcRet:oHtml:RetByName("P0B_NIVEL")
	cAprovad	:= oProcRet:oHtml:RetByName("P0B_APROV")
	_cObsWF		:= oProcRet:oHtml:RetByName("OBS")
	cAprRepr	:= oProcRet:oHtml:RetByName("APROVAR")
	
	_cUser	:= Posicione("P09",1,xFilial("P09")+cAprovad,"P09_USER")
	
	dbSelectArea("P0B")
	P0B->(dbSetOrder(2))
	If P0B->(dbSeek(xFilial("P0B")+cTipoAlc+cDocAlc+_cUser ))
		
		cUserLog := P0B->P0B_USER
		
		If P0B->P0B_STATUS == "01"
			
			If RecLock( "P0B", .F.)
				
				If cAprRepr == "S"
					
					P0B->P0B_DTLIB := MsDate()
					
				Else
					
					P0B->P0B_DTREPR:= MsDate()
					U_WF102REPR()
					
				EndIf
				
				P0B->(MSMM(,,, _cObsWF ,1,,,"P0B","P0B_CODOBS","SYP"))
				
				P0B->(MsUnlock())
				
			EndIf
			
			If cAprRepr == "S"
				U_WF102APR()
			Else
				U_WF102REPR()
			EndIf
			
		Else
			
			
			If P0B->P0B_STATUS == '02'
				_cStatus := "Aguar. demais aprov. no mesmo n�vel"
			ElseIf P0B->P0B_STATUS == '03'
				_cStatus := "Aguardando aprova��o n�vel superior"
			ElseIf P0B->P0B_STATUS == '04'
				_cStatus := "Aprovado"
			ElseIf P0B->P0B_STATUS == '05'
				_cStatus := "Reprovado"
			EndIf
			
			_MailDest	:= Posicione("P09",1,xFilial("P09")+cAprovad,"P09_EMAIL")
			
			EnvMailStatus(_MailDest,"Retorno da libera��o de VPC/VERBA do processo: "+ cDocAlc,_cStatus)
			
		EndIf
		
	EndIf
	
	oProcRet:Finish()
	
EndIf

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �INBRWF02 �Autor  �Hermes Ferreira      � Data �  20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Fun��o do inicializador do browse do campo P0B_NUMTIT       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function INBRWF02()
Local aArea 	:= P0B->(GetArea())
Local cTabOrig	:= P0B->P0B_TABORI

cRet := Posicione((cTabOrig),P0B->P0B_INDCHO,xFilial(cTabOrig)+ P0B->P0B_CHVIND,Right(cTabOrig,2)+"_NUM" )

RestArea(aArea)
Return cRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �EnvMailStatus�Autor�Hermes Ferreira    � Data �  21/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Envia um retorno do sttus do WF, para os casos que n�o �    ���
���          �mais permitido altera��o via WF                             ���
�������������������������������������������������������������������������͹��
���Uso       �NC games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function EnvMailStatus(cEmailTo,cAssunto,_cStatus)

Local clHtmlMod		:=  Alltrim(U_MyNewSX6(	"NCG_000022",;
"",;
"C",;
"Diretorio dos Html do Workflow ",;
"Diretorio dos Html do Workflow ",;
"Diretorio dos Html do Workflow ",;
.F. )   )

clHtmlMod := clHtmlMod+IIf(Right(clHtmlMod,1) <> "\", "\","")+ "statusnaoaprova.html"


If file(clHtmlMod)
	olProcess := TWFProcess():New(cAssunto, cAssunto)
	olProcess:NewTask(cAssunto, clHtmlMod)
	olProcess:cSubject := cAssunto
	olProcess:cTo := cEmailTo
	
	olHtml    := olProcess:oHtml
	
	olHtml:ValByName( "STATUS"	, _cStatus	)
	olProcess:Start()
	
EndIf
Return
