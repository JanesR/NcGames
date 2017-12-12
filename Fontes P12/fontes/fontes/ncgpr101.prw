#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

#define clr Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR101  บAutor  ณHermes Ferreira     บ Data ณ  04/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณManuten็ใo de Apura็ใo de VPC                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NCGPR101()

	Local olDlgPrc		:= Nil
	Local cTitulo		:= "Manuten็ใo de Apura็ใo de VPC."
	Local nlResoluc		:= oMainWnd:nClientWidth
	Local alCoord		:= MsAdvSize(.T.,.F.,0)
	Local nOpcNewGD 	:= 1
	Local alPrc			:= {0,0}
	Local alLeft		:= {0}
	Local alRight		:= {0}
	Local olOdlgBot		:= Nil
	Local olOdlgGrid	:= Nil
	Local nlX1 			:= 0
	Local nlX2 			:= 0
	Local nlX3			:= 0
	Local nlX4 			:= 0

	Private opLayer		:= FWLayer():New()
	Private opGridP04	:= Nil
	Private apHeadP04	:= {}
	Private apColsP04	:= {}

	Private cFiltro		:= ""
	Private cMemo		:= ""
	Private oMemo		:= Nil


//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	dbSelectArea("P04")

	If nlResoluc <= 800

		alPrc	:= {18,82}
		alLeft	:= {100}
		alRight	:= {100}

	ElseIf nlResoluc >= 1024 .And. nlResoluc < 1280

		alPrc	:= {13,87}
		alLeft	:= {100}
		alRight	:= {100}

	ElseIf nlResoluc >= 1280 .And. nlResoluc < 1300

		alPrc	:= {10,90}
		alLeft	:= {100}
		alRight	:= {100}

	ElseIf 	nlResoluc >= 1300

		alPrc	:= {10,90}
		alLeft	:= {100}
		alRight	:= {100}

	EndIf

	// Header
	FHeadP04()

	//Acols
	FColsP04()

	olDlgPrc := TDialog():New(alCoord[1],alCoord[2],alCoord[6],alCoord[5],cTitulo,,,,,CLR_BLACK,CLR_WHITE,,,.T.)

		opLayer:Init(olDlgPrc,.F.)

		opLayer:AddCollumn("ESQUERDA"	,alPrc[1],.F.)
		opLayer:AddCollumn("DIREITA"	,alPrc[2],.F.)

		opLayer:AddWindow("ESQUERDA","BOTOES"		,"Op็๕es"		,alLeft[1],.T.,.T.,{||},,{||})
		opLayer:AddWindow("DIREITA"	,"GRID"			,"Apura็ใo VPC"	,alRight[1],.T.,.T.,{||},,{||})

		olOdlgBot	:= opLayer:GetWinPanel("ESQUERDA","BOTOES")
		olOdlgGrid	:= opLayer:GetWinPanel("DIREITA","GRID")

		nlX1	:= olOdlgBot:NCLIENTWIDTH*0.47
		nlX2	:= olOdlgBot:NCLIENTHEIGHT*0.017

		nlX3	:= ((olOdlgBot:NCLIENTWIDTH*0.50)/2)-(nlX1/2)
		nlX4	:= (olOdlgBot:NCLIENTHEIGHT/60)

		oButton3 := tButton():New(nlX4,nlX3	,  "Processar"  	,olOdlgBot,{|| PR01PROP04(3)	,FATUGP04()	},nlX1,nlX2,,,,.T.)
		nlX4	:= nlX4+15		
		oButton4 := tButton():New(nlX4,nlX3	,  "Reprocessar"  	,olOdlgBot,{|| PR01REPP04()		,FATUGP04()	},nlX1,nlX2,,,,.T.)
		nlX4	:= nlX4+15		
		oButton6 := tButton():New(nlX4,nlX3	,  "Encerrar"	    ,olOdlgBot,{|| FhechaApur()		,FATUGP04()	},nlX1,nlX2,,,,.T.)				
		nlX4	:= nlX4+15

		oButton2 := tButton():New(nlX4,nlX3	,  "Visualizar"  	,olOdlgBot,{|| PR01VISP04()					},nlX1,nlX2,,,,.T.)
		nlX4	:= nlX4+15				
		oButton5 := tButton():New(nlX4,nlX3	,  "Filtro"  		,olOdlgBot,{|| PR01FILP04()					},nlX1,nlX2,,,,.T.)
		nlX4	:= nlX4+15		
		oButton1 := tButton():New(nlX4,nlX3	,  "Pesquisar"  	,olOdlgBot,{|| PR01PESP04()					},nlX1,nlX2,,,,.T.)
		nlX4	:= nlX4+15		
		oButton7 := tButton():New(nlX4,nlX3	,  "Sair"  			,olOdlgBot,{|| olDlgPrc:End()				},nlX1,nlX2,,,,.T.)



		opGridP04:= MsNewGetDados():New(000,000,000,000,nOpcNewGD,"","",,,,9999,,,,olOdlgGrid,apHeadP04,apColsP04)
		opGridP04:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
		opGridP04:lInsert		:= .F.
		opGridP04:oBrowse:BLDBLCLICK	:= {|y| MySetClick(y,opGridP04) }
		
		If Len(apColsP04) == 0
			opGridP04:aCols:= {}
		EndIf

	Activate Msdialog olDlgPrc Centered

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFHeadP04  บAutor  ณHermes Ferreira     บ Data ณ  04/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta o Header para o grid de manuten็ใo de apura็ใo        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿

*/
Static Function FHeadP04()
	Local aCmpHeader	:= {},nI

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	AADD(aCmpHeader,"P04_CODIGO"	)
	AADD(aCmpHeader,"P04_DESC"		)
	AADD(aCmpHeader,"P04_CLIENT"	)
	AADD(aCmpHeader,"P04_LOJCLI"	)
	AADD(aCmpHeader,"P04_NOMCLI"	)
	AADD(aCmpHeader,"P04_DTINI"		)
	AADD(aCmpHeader,"P04_DTFIM"		)
	AADD(aCmpHeader,"P04_VERSAO"	)
	AADD(aCmpHeader,"P04_FECHAM"	)

	aAdd(apHeadP04,{"","XLEGENDA"	,"@BMP",10,0,"","","C","","" ,"",""})

	SX3->(DbSetOrder(2))
	For nI := 1 to Len(aCmpHeader)
		If SX3->(DbSeek(aCmpHeader[nI]))
			Aadd(apHeadP04,	{	Trim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,;
			SX3->X3_TAMANHO,SX3->X3_DECIMAL,/*SX3->X3_VALID*/,;
			SX3->X3_USADO,SX3->X3_TIPO,	;
			SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,,SX3->X3_WHEN,	;
			SX3->X3_VISUAL,SX3->X3_VLDUSER, SX3->X3_PICTVAR,SX3->X3_OBRIGAT	})
		EndIf
	Next nI

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFColsP04  บAutor  ณHermes Ferreira     บ Data ณ  04/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta o Header para o grid de manuten็ใo de apura็ใo        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿

*/
Static Function FColsP04()

	Local cQry 		:= ""
	Local nPosCli:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_CLIENT"})
	Local nPosLoj:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_LOJCLI"})
 	Local i
	Local clAlias 	:= GetNextAlias()

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	cQry := " SELECT "			+ clr
	cQry += " P04_STATUS "		+ clr
	cQry += " ,P04_CODIGO "		+ clr
	cQry += " ,P04_DESC "		+ clr
	cQry += " ,P04_CLIENT "		+ clr
	cQry += " ,P04_LOJCLI "		+ clr
	cQry += " ,P04_DTINI "		+ clr
	cQry += " ,P04_DTFIM "		+ clr
	cQry += " ,P04_VERSAO "		+ clr
	cQry += " ,P04_FECHAM "		+ clr
	cQry += " FROM " +RetSqlName("P04")+ " P04 "				+ clr
	cQry += " WHERE P04.P04_FILIAL = '"+xFilial("P04") +"'"		+ clr

	If !Empty(cFiltro)
		cQry 	+= " AND " + Alltrim(cFiltro)
	EndIf

	cQry += " AND P04.D_E_L_E_T_= ' '"							+ clr

	TcQuery cQry New Alias &(clAlias)

	TCSetField((clAlias),"P04_DTINI"	,"D",TamSx3("P04_DTINI")[1],TamSx3("P04_DTINI")[2]		)
	TCSetField((clAlias),"P04_DTFIM"	,"D",TamSx3("P04_DTFIM")[1],TamSx3("P04_DTFIM")[2]		)
	TCSetField((clAlias),"P04_FECHAM"	,"D",TamSx3("P04_FECHAM")[1],TamSx3("P04_FECHAM")[2]	)

	(clAlias)->(dbGoTop())

	apColsP04 := {}

	If (clAlias)->(!Eof())

		While (clAlias)->(!Eof())

			AAdd(apColsP04,Array(Len(apHeadP04)+1))

			For i := 1 To Len(apHeadP04)

				If 	Alltrim(apHeadP04[i,2]) =="XLEGENDA"

					//If (clAlias)->P04_STATUS == "2"
					If !Empty((clAlias)->P04_FECHAM)
						apColsP04[Len(apColsP04)][i] := "BR_VERDE"//"BR_VERMELHO"
					Else
						apColsP04[Len(apColsP04)][i] := "BR_AZUL"
					EndIf

				ElseIf Alltrim(apHeadP04[i,2]) <> "P04_NOMCLI"

					apColsP04[Len(apColsP04)][i] := (clAlias)->(&(apHeadP04[i,2]))

				Else
					apColsP04[Len(apColsP04)][i] := Posicione("SA1",1,xFilial("SA1")+apColsP04[Len(apColsP04)][nPosCli]+apColsP04[Len(apColsP04)][nPosLoj],"A1_NOME")

				EndIf
			Next i

			apColsP04[Len(apColsP04)][Len(apHeadP04)+1] := .F.

			(clAlias)->(dbSkip())
		EndDo

	EndIf

	(clAlias)->(dbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPR01VISP04บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza a tela de manuten็ใo de apura็ใo                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FATUGP04()

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	FColsP04()
	opGridP04:aCols:= apColsP04
	opGridP04:Refresh()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPR01VISP04บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFun็ใo de visualiza็ใo da apura็ใo                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR01VISP04()

	Local nOpcaoVis := 1
	Local clQRYVis 	:= GetNextAlias()
	Local nPosCodApu:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_CODIGO"})
	Local nPosVersao:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_VERSAO"})
	Local nPosClient:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_CLIENT"})
	Local nPosLojCli:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_LOJCLI"})
	Local cCodApu	:= ""
	Local cVersao	:= ""
	Local cCliente	:= ""
	Local cLojCli	:= ""


	If Len(opGridP04:aCols) > 0
		cCodApu	:= opGridP04:aCols[opGridP04:NAT,nPosCodApu]
		cVersao	:= opGridP04:aCols[opGridP04:NAT,nPosVersao]
		cCliente:= opGridP04:aCols[opGridP04:NAT,nPosClient]
		cLojCli	:= opGridP04:aCols[opGridP04:NAT,nPosLojCli]


//		ErrorBlock( { |oErro| U_MySndError(oErro) } )

		If Aviso("NCGPR101-02","Deseja visualizar a apura็ใo somente do cliente selecionado ou de todos?",{"Todos","Cliente"},3) == 1
			nOpcaoVis := 1
		Else
			nOpcaoVis := 2
		EndIf

		dbSelectArea("P04")
		P04->(dbSetOrder(1))
		P04->(dbSeek(xFilial("P04")+cCodApu+cVersao))

		oProcess := MsNewProcess():New( { || FQryVISA(clQRYVis,nOpcaoVis,cCodApu,cVersao,cCliente,cLojCli,oProcess) }, "Aguarde", "Consultando base...", .T. )
		oProcess:Activate()

		PR01PROP04(2,clQRYVis)

		(clQRYVis)->(dbCloseArea())
	Else
		Aviso("NCGPR101 - 06","ษ necessแrio posicionar em um resgistro para visualizar.",{"Ok"},3)
	EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFQryVISA  บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTratamento para visualiza็ใo da apura็ใo                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FQryVISA(clQRYVis,nOpcaoVis,cCodApu,cVersao,cCliente,cLojCli,oProcess)

	Local cQry	:= ""
	Local nCOuntReg	:= 0

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	cQry := " SELECT "					+clr
	cQry += " P04_CLIENT AS CLIENTE"	+clr
	cQry += " ,P04_LOJCLI AS LOJA"		+clr
	cQry += " ,A1_NOME AS NOME"			+clr
	//cQry += " ,P04_CODVEN AS VEND"		+clr
	cQry += " ,P04_TPFAT AS TPFAT"		+clr
	cQry += " ,P04_FATBRU AS TOTBRUTO"	+clr
	cQry += " ,P04_FATLIQ AS TOTLIQUIDO"+clr
	cQry += " ,P04_PERCEN AS TOTPER"	+clr
	cQry += " ,P04_CODVPC AS CODVPC"	+clr
	cQry += " ,P04_VERVPC AS VERVPC"	+clr

	cQry += "  FROM "+RetSqlName("P04")+" P04 "				+clr

	cQry += "  JOIN "+RetSqlName("SA1")+" SA1 "				+clr
	cQry += "  ON SA1.A1_FILIAL = '"+xFilial("SA1")+"'"		+clr
	cQry += "  AND SA1.A1_COD = P04_CLIENT "				+clr
	cQry += "  AND SA1.A1_LOJA = P04_LOJCLI "				+clr
	cQry += "  AND SA1.D_E_L_E_T_= ' '"						+clr

	cQry += "  WHERE P04.P04_FILIAL = '"+xFilial("P04")+"'"	+clr

	cQry += "  AND P04.P04_CODIGO = '"+cCodApu+"'"			+clr
	cQry += "  AND P04.P04_VERSAO = '"+cVersao+"'"			+clr
	If nOpcaoVis == 2
		cQry += "  AND P04.P04_CLIENT = '"+cCliente+"'"		+clr
		cQry += "  AND P04.P04_LOJCLI = '"+cLojCli+"'"		+clr
	EndIf
	cQry += "  AND P04.D_E_L_E_T_= ' '"						+clr

	TcQuery cQry New Alias &(clQRYVis)

	TCSetField((clQRYVis),"TOTBRUTO"		,"N",TamSx3("F2_VALBRUT")[1],TamSx3("F2_VALBRUT")[2]	)
	TCSetField((clQRYVis),"TOTLIQUIDO"		,"N",TamSx3("F2_VALMERC")[1],TamSx3("F2_VALMERC")[2]	)
	TCSetField((clQRYVis),"TOTPER"			,"N",TamSx3("P01_TOTPER")[1],TamSx3("P01_TOTPER")[2]	)

	(clQRYVis)->(dbGoTop())
	(clQRYVis)->(DbEval({|| nCOuntReg++ }))
	oProcess:SetRegua1( nCOuntReg )

	(clQRYVis)->(dbGoTop())
	(clQRYVis)->(DbEval({|| oProcess:IncRegua1( "Consultando dados" ) }))

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPR01PROP04บAutor  ณHermes Ferreira     บ Data ณ  04/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExibe os parโmetros para realizar processamento da apuracao บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function PR01PROP04(nOpc,clQRYVis)

	Local clPerg	:= Padr("NCGPR101",Len(SX1->X1_GRUPO))
	Local clQRYAPR 	:= ""
	Local llOk		:= .T.
	Local oProcess	:= Nil
	Local oProcT	:= Nil
	Private cDocQry	:= ""
	Private cTEMPD	:= GetNextAlias()

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	NCPRSX1(clPerg)

	If nOpc == 2

		oProcT := MsNewProcess():New( { ||  FTLAPURA(nOpc,clQRYVis,oProcT)  }, "Aguarde", "Criando Tela...", .T. )
		oProcT:Activate()
		Return

	ElseIf nOpc == 3

		If Pergunte(clPerg, .T. )
			llOk := .T.
		Else
			llOk := .F.
		EndIf

	ElseIf nOpc == 4
		llOk := .T.
		//nOpc := 3
	EndIf

	If llOk

		clQRYAPR 	:= GetNextAlias()

		oProcess := MsNewProcess():New( { ||  FQryPR01(nOpc,clQRYAPR,oProcess)  }, "Aguarde", "Consultando base...", .T. )
		oProcess:Activate()


		(clQRYAPR)->(dbGoTop())
		If (clQRYAPR)->(!Eof())

			Begin Sequence

				oProcT := MsNewProcess():New( { ||  FTLAPURA(nOpc,clQRYAPR,oProcT)  }, "Aguarde", "Criando Tela...", .T. )
				oProcT:Activate()
				
			End Sequence
		Else
			Aviso("NCGPR01-04","Nใo foram localizados registros para realizar a apura็ใo. Verifique os parโmetros.",{"Ok"},3)
		EndIf
		(clQRYAPR)->(dbCloseArea())

	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPR01REPP04บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTratamento para realizar o reprocessamento da apura็ใo      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR01REPP04()

	Local nOpcaoRep := 1
	Local cParam	:= ""
	Local aParamen	:= {}
	Local nPosCodApu:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_CODIGO"})
	Local nPosVersao:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_VERSAO"})
	Local nPosClient:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_CLIENT"})
	Local nPosLojCli:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_LOJCLI"})
	Local nPosDtFecha:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_FECHAM"})
	Local nPosLegend:= aScan(apHeadP04,{|x| AllTrim(x[2])=="XLEGENDA"})
	Local cCodApu	:= ""
	Local cVersao	:= ""
	Local cCliente	:= ""
	Local cLojCli	:= ""
	Local cLegenda	:= ""
	Local dDtFecha	:= CtoD("  /  /  ")
	Local llContinua:= .T.
	Local dUltFecApu:=  ""
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	dUltFecApu := GetMv("NCG_000028")
								
	If Len(opGridP04:aCols) > 0

		cCodApu	:= opGridP04:aCols[opGridP04:NAT,nPosCodApu]
		cVersao	:= opGridP04:aCols[opGridP04:NAT,nPosVersao]
		cCliente:= opGridP04:aCols[opGridP04:NAT,nPosClient]
		cLojCli	:= opGridP04:aCols[opGridP04:NAT,nPosLojCli]
		cLegenda:= opGridP04:aCols[opGridP04:NAT,nPosLegend]
		dDtFecha:= opGridP04:aCols[opGridP04:NAT,nPosDtFecha]

		If Empty(dDtFecha) .OR. dDtFecha > dUltFecApu  //Alltrim(cLegenda) == "BR_AZUL"
		
			nOpcaoRep := 1
			
			/*
			If Aviso("NCGPR101-03","Deseja reprocessar a apura็ใo somente do cliente selecionado ou de todos?",{"Todos","Cliente"},3) == 1
				nOpcaoRep := 1
			Else
				nOpcaoRep := 2
			EndIf
    		*/        
	
			dbSelectArea("P04")
			P04->(dbSetOrder(1))
			If P04->(dbSeek(xFilial("P04")+cCodApu+cVersao))
				
				cParam := Alltrim(P04->P04_PARAME)
				aParamen := Separa(cParam,"|")
	
				If nOpcaoRep == 1
					MV_PAR01	:= StoD(aParamen[1])
					MV_PAR02	:= StoD(aParamen[2])
					MV_PAR03	:= aParamen[3]
					MV_PAR04	:= aParamen[4]
					MV_PAR05	:= aParamen[5]
					MV_PAR06	:= aParamen[6]
					MV_PAR07	:= aParamen[7]
					MV_PAR08	:= aParamen[8]
					//MV_PAR09	:= aParamen[9]
					//MV_PAR10	:= aParamen[10]
				Else
					MV_PAR01	:= StoD(aParamen[1])
					MV_PAR02	:= StoD(aParamen[2])
					MV_PAR03	:= cCliente
					MV_PAR04	:= cLojCli
					MV_PAR05	:= cCliente
					MV_PAR06	:= cLojCli
					MV_PAR07	:= Space(TamSx3("P01_GRPCLI")[1])
					MV_PAR08	:= Space(TamSx3("P01_GRPCLI")[1])
					//MV_PAR09	:= Space(TamSx3("P01_GRPCLI")[1])
					//MV_PAR10	:= Space(TamSx3("P01_GRPCLI")[1])
				EndIf
	
				If MsgYesNo("Tem certeza que deseja reprocessar esta apura็ใo ("+Alltrim(cCodApu)+")?")
	
					//llContinua := FPR1DELAPU(cCodApu,cVersao)
					MsgRun("Limpando registros da Apura็ใo anterior","Aguarde...", {|| FPR1DELAPU(cCodApu,cVersao,@llContinua)    } )
					
					If llContinua
						PR01PROP04(4)
					EndIf
	
				EndIf
			EndIf
	    Else
	    	//Aviso("NCGPR101-05","Nใo ้ permitido reprocessar uma apura็ใo que nใo seja a ultima versใo.",{"Ok"},3)
	    	Aviso("NCGPR101-05","Nใo ้ permitido reprocessar essa apura็ใo, pois a Data de Fechamento ้ inferior ao ultimo fechamento."+clr+"Solicite ao Depto. de Tecnologia da Informa็ใo para verificar o parโmetro NCG_000028.",{"Ok"},3)
	    EndIf
    Else
	    Aviso("NCGPR101 - 07","ษ necessแrio posicionar em um resgistro para reprocessar.",{"Ok"},3)
    EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFQryPR01  บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณQuery para carregar a tela de apura็ใo                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FQryPR01(nOpc,clQRYAPR,oProcess)

	Local cQry 		:= ""
	Local cQryInter	:= ""
	Local nCOuntReg	:= 0

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	cQry += " SELECT CLIENTE"		+ clr
	cQry += "  ,LOJA"				+ clr
	cQry += "  ,NOME "				+ clr
	//cQry += "  ,VEND"				+ clr
	cQry += "  ,TPFAT"				+ clr
	cQry += "  ,TOTPER"				+ clr
	cQry += "  ,CODVPC"				+ clr
	cQry += "  ,VERVPC"				+ clr
	cQry += "  ,SUM(NVL(BRUTO,0)) AS TOTBRUTO"		+ clr
	cQry += "  ,SUM(NVL(LIQUIDO,0)) AS TOTLIQUIDO"	+ clr
	cQry += "   FROM ( "			+ clr
		// Notas de Saํda
	cQryInter += " 			SELECT "	   					+ clr

	cQryInter += " 			F2_FILIAL AS FILIAL"			+ clr
	cQryInter += " 			,'S' AS TIPONF"	   				+ clr
	cQryInter += " 			,F2_TIPO AS TIPO "	 			+ clr
	cQryInter += " 			,F2_SERIE AS SERIE "			+ clr
	cQryInter += " 			,F2_DOC AS DOC "				+ clr

	cQryInter += " 			,F2_CLIENTE AS CLIENTE"			+ clr
	cQryInter += " 			,F2_LOJA AS LOJA"				+ clr
	cQryInter += "  			,A1_NOME AS NOME "			+ clr
	//cQryInter += "  			,F2_VEND1 AS VEND"			+ clr
	cQryInter += "  			,P01_TPFAT AS TPFAT" 		+ clr
	cQryInter += "  			,P01_TOTPER AS TOTPER "		+ clr
	cQryInter += "  			,P01_CODIGO AS CODVPC "		+ clr
	cQryInter += "  			,P01_VERSAO AS VERVPC "		+ clr
	cQryInter += "  			,( SELECT "					+ clr
	cQryInter += "  					(SUM (SUBBT.D2_TOTAL + SUBBT.D2_ICMSRET + SUBBT.D2_VALIPI +  SUBBT.D2_DESPESA + SUBBT.D2_SEGURO + SUBBT.D2_VALFRE  ))  AS BRUT "	+ clr
	cQryInter += "  					FROM "+RetSqlName("SD2")+" SUBBT "			+ clr
	cQryInter += "  					WHERE SUBBT.D_E_L_E_T_ <> '*'"				+ clr
	cQryInter += "  					AND SUBBT.D2_FILIAL		= SF2.F2_FILIAL"	+ clr
	cQryInter += "  					AND SUBBT.D2_CLIENTE	= SF2.F2_CLIENTE"	+ clr
	cQryInter += "  			 		AND SUBBT.D2_LOJA		= SF2.F2_LOJA"		+ clr
	cQryInter += "  			 		AND SUBBT.D2_TIPO		= SF2.F2_TIPO"		+ clr
	cQryInter += "  			 		AND SUBBT.D2_DOC		= SF2.F2_DOC"		+ clr
	cQryInter += "  			 		AND SUBBT.D2_SERIE		= SF2.F2_SERIE"		+ clr
	cQryInter += "  			 		AND EXISTS ( SELECT 1 FROM "+RetSqlName("SF4") +" SF4 WHERE SF4.F4_FILIAL='"+xFilial("SF4")+"' AND SF4.F4_DUPLIC='S' AND SF4.F4_CODIGO=SUBBT.D2_TES AND SF4.D_E_L_E_T_=' ')"	+ clr
	
	cQryInter += "  			 	) AS BRUTO "									+ clr

	cQryInter += " 			,( SELECT "						+ clr                                     
	cQryInter += " 				((SUM (SUBD2.D2_TOTAL + SUBD2.D2_ICMSRET + SUBD2.D2_VALIPI +   SUBD2.D2_DESPESA + SUBD2.D2_SEGURO + SUBD2.D2_VALFRE  ))  -  (SUM(SUBD2.D2_VALICM+SUBD2.D2_VALIMP6+SUBD2.D2_VALIMP5+SUBD2.D2_VALIPI+SUBD2.D2_ICMSRET+SUBD2.D2_DESPESA+SUBD2.D2_SEGURO+SUBD2.D2_VALFRE))) AS LIQ " 	+ clr
	cQryInter += " 				FROM "+RetSqlName("SD2")+ " SUBD2 "			+ clr
	cQryInter += " 				WHERE SUBD2.D_E_L_E_T_ <> '*'"				+ clr
	cQryInter += " 				AND SUBD2.D2_FILIAL		= SF2.F2_FILIAL"	+ clr
	cQryInter += " 				AND SUBD2.D2_CLIENTE	= SF2.F2_CLIENTE"	+ clr
	cQryInter += " 				AND SUBD2.D2_LOJA		= SF2.F2_LOJA"		+ clr
	cQryInter += " 				AND SUBD2.D2_TIPO		= SF2.F2_TIPO"		+ clr
	cQryInter += " 				AND SUBD2.D2_DOC		= SF2.F2_DOC"		+ clr
	cQryInter += " 				AND SUBD2.D2_SERIE		= SF2.F2_SERIE"		+ clr
	cQryInter += "  			 AND EXISTS ( SELECT 1 FROM "+RetSqlName("SF4") +" SF4 WHERE SF4.F4_FILIAL='"+xFilial("SF4")+"' AND SF4.F4_DUPLIC='S' AND SF4.F4_CODIGO=SUBD2.D2_TES AND SF4.D_E_L_E_T_=' ')"	+ clr	
	cQryInter += " 				)  LIQUIDO "								+ clr

	cQryInter += "  			FROM "+RetSqlName("SF2")+" SF2 "+ clr

	cQryInter += "  			JOIN "+RetSqlName("SA1")+" SA1 "+ clr
	cQryInter += "  			ON SA1.A1_FILIAL = '"+xFilial("SA1")+"'"	+ clr
	cQryInter += "  			AND SA1.A1_COD = SF2.F2_CLIENTE"+ clr
	cQryInter += "  			AND SA1.A1_LOJA = SF2.F2_LOJA "	+ clr
	If !Empty(MV_PAR07) .or. !Empty(MV_PAR08)
		cQryInter += "  			AND SA1.A1_GRPVEN BETWEEN '"	+MV_PAR07+"' AND '"+MV_PAR08+"'"	+ clr
	Else
		If  !Empty(MV_PAR03) .and. !Empty(MV_PAR05) .or. Empty(MV_PAR03) .and. !Empty(MV_PAR05)
			cQryInter += "   			AND SA1.A1_COD BETWEEN '"	+MV_PAR03+"' AND '"+MV_PAR05+"'"+ clr
			If  !Empty(MV_PAR06)
				cQryInter += " 			AND SA1.A1_LOJA BETWEEN '"	+MV_PAR04+"' AND '"+MV_PAR06+"'"+ clr
			EndIf
		EndIf
	EndIf
	cQryInter += " 			AND SA1.D_E_L_E_T_= ' '"												+ clr

	cQryInter += " 			JOIN "+RetSqlName("P01")+" P01 "										+ clr
	cQryInter += " 			ON P01.P01_FILIAL = '"+xFilial("P01")+"'"								+ clr
	If !Empty(MV_PAR07) .or. !Empty(MV_PAR08)
		cQryInter += " 			AND P01.P01_GRPCLI = SA1.A1_GRPVEN "								+ clr
	Else
		cQryInter += " 			AND P01.P01_CODCLI = SA1.A1_COD "							   		+ clr
		cQryInter += " 			AND P01.P01_LOJCLI = (CASE WHEN P01.P01_LOJCLI = '  ' THEN  '  '  ELSE SA1.A1_LOJA END )"+ clr
	EndIf

	//cQryInter += " 			AND P01.P01_STATUS <> '2'"												+ clr
	cQryInter += " 			AND P01.P01_TPCAD = '1'"												+ clr
	cQryInter += " 			AND P01.P01_REPASS <> '2'"												+ clr
	cQryInter += " 			AND P01.P01_STSAPR = '1'"												+ clr // Aprovado
	cQryInter += " 			AND ( P01.P01_DTVINI <= '"+DtoS(MV_PAR01)+"'"							+ clr
	cQryInter += " 			AND   P01.P01_DTVFIM >= '"+DtoS(MV_PAR02)+"'"							+ clr
	cQryInter += " 				)"																	+ clr
	cQryInter += " 			AND P01.D_E_L_E_T_= ' '"												+ clr


	cQryInter += " 			WHERE SF2.F2_FILIAL ='"+xFilial("SF2")+"'"								+ clr
	If !Empty(MV_PAR03) .or. !Empty(MV_PAR05)
		cQryInter += " 			AND SF2.F2_CLIENTE BETWEEN '"	+MV_PAR03+"' AND '"+MV_PAR05+"'"	+ clr
		cQryInter += "  			AND SF2.F2_LOJA BETWEEN '"	+MV_PAR04+"' AND '"+MV_PAR06+"'"		+ clr
	Else
		cQryInter += "  			AND SF2.F2_CLIENTE BETWEEN '"+Replicate(" ",TamSx3("F2_CLIENTE")[1])+"' AND '"+Replicate("Z",TamSx3("F2_CLIENTE")[1])+"'"	+ clr
		cQryInter += "  			AND SF2.F2_LOJA BETWEEN '"	+Replicate(" ",TamSx3("F2_LOJA")[1])+"' AND '"+Replicate("Z",TamSx3("F2_LOJA")[1])+"'"				+ clr
	EndIf

	//cQryInter += "  			AND SF2.F2_VEND1 BETWEEN '"	+MV_PAR07+"' AND '"+MV_PAR08+"'"			+ clr
	cQryInter += "  			AND SF2.F2_TIPO = 'N'"													+ clr

	//If nOpc == 3
		cQryInter += "  			AND SF2.F2_YAPURAC = ' ' "											+ clr
		cQryInter += "  			AND SF2.F2_YVERAPU = ' ' "											+ clr
	//EndIf

	cQryInter += "  			AND EXISTS(	SELECT "													+ clr
	cQryInter += " 			 					Z1_DOC"												+ clr
	cQryInter += " 						  	FROM "+RetSqlName("SZ1")+ " SZ1 "						+ clr
	cQryInter += " 			             	WHERE SZ1.Z1_FILIAL = SF2.F2_FILIAL"					+ clr
	cQryInter += " 			             	AND SZ1.Z1_DOC = SF2.F2_DOC "							+ clr
	cQryInter += " 			             	AND SZ1.Z1_SERIE = SF2.F2_SERIE "						+ clr
	cQryInter += " 			             	AND SZ1.Z1_CLIENTE = SF2.F2_CLIENTE"					+ clr
	cQryInter += " 			             	AND SZ1.Z1_LOJA = SF2.F2_LOJA"							+ clr
	cQryInter += " 			             	AND SZ1.Z1_DTENTRE BETWEEN '"+DtoS(MV_PAR01)+"' AND '"+DtoS(MV_PAR02)+"'"	+ clr
	cQryInter += " 			             	AND SZ1.D_E_L_E_T_= ' ')"								+ clr
	cQryInter += "  			AND SF2.D_E_L_E_T_= ' '"												+ clr

	//cQryInter += "  			GROUP BY  F2_FILIAL,F2_TIPO,F2_SERIE,F2_DOC,F2_CLIENTE,F2_LOJA,A1_NOME,F2_VEND1,P01_TPFAT,P01_TOTPER,P01_CODIGO,P01_VERSAO  "		+ clr
	cQryInter += "  			GROUP BY  F2_FILIAL,F2_TIPO,F2_SERIE,F2_DOC,F2_CLIENTE,F2_LOJA,A1_NOME,P01_TPFAT,P01_TOTPER,P01_CODIGO,P01_VERSAO  "		+ clr

	// Devolu็๕es
	cQryInter += "  			UNION "								+ clr

	cQryInter += "  			SELECT "							+ clr
	cQryInter += "  			F1_FILIAL AS FILIAL "				+ clr
	cQryInter += " 		   		,'E' AS TIPONF"	  	 				+ clr
	cQryInter += "  			,F1_TIPO AS TIPO "					+ clr
	cQryInter += "  			,F1_SERIE AS SERIE "				+ clr
	cQryInter += "  			,F1_DOC AS DOC "					+ clr
	cQryInter += "  			,F1_FORNECE AS CLIENTE"				+ clr
	cQryInter += "  			,F1_LOJA AS LOJA "					+ clr
	cQryInter += "  			,A1_NOME AS NOME "					+ clr
	//cQryInter += "  			,F2_VEND1 AS VEND "					+ clr
	cQryInter += "  			,P01_TPFAT AS TPFAT " 				+ clr
	cQryInter += "  			,P01_TOTPER AS TOTPER "				+ clr
	cQryInter += "  			,P01_CODIGO AS CODVPC "				+ clr
	cQryInter += " 			,P01_VERSAO AS VERVPC "			 		+ clr
	//cQryInter += "  			, - 0 AS BRUTO"		+ clr

	cQryInter += "  			,( SELECT  "						+ clr
	cQryInter += "  				( (Sum ((SUBD0.D1_TOTAL + SUBD0.D1_VALIPI + SUBD0.D1_ICMSRET + SUBD0.D1_DESPESA + SUBD0.D1_SEGURO + SUBD0.D1_VALFRE ) - SUBD0.D1_VALDESC ))  * -1 )  "	+ clr
	cQryInter += "  				FROM "+RetSqlName("SD1")+" SUBD0 "			+ clr
	cQryInter += "  				WHERE SUBD0.D_E_L_E_T_ <> '*' "				+ clr
	cQryInter += "  				AND SUBD0.D1_FILIAL		= SF1.F1_FILIAL "	+ clr
	cQryInter += "  				AND SUBD0.D1_FORNECE	= SF1.F1_FORNECE "	+ clr
	cQryInter += "  				AND SUBD0.D1_LOJA		= SF1.F1_LOJA "		+ clr
	cQryInter += "  				AND SUBD0.D1_TIPO		= SF1.F1_TIPO "		+ clr
	cQryInter += "  				AND SUBD0.D1_DOC		= SF1.F1_DOC " 		+ clr
	cQryInter += "  				AND SUBD0.D1_SERIE		= SF1.F1_SERIE "	+ clr
	cQryInter += "  			 )  AS  BRUTO "									+ clr
	
	
	cQryInter += "  			,( SELECT  "									+ clr
	cQryInter += "  				( (Sum ((SUBD1.D1_TOTAL + SUBD1.D1_VALIPI + SUBD1.D1_ICMSRET + SUBD1.D1_DESPESA + SUBD1.D1_SEGURO + SUBD1.D1_VALFRE ) - (SUBD1.D1_VALDESC) )  - SUM(SUBD1.D1_VALICM+SUBD1.D1_VALIMP6+SUBD1.D1_VALIMP5+SUBD1.D1_VALIPI+SUBD1.D1_ICMSRET+ SUBD1.D1_DESPESA + SUBD1.D1_SEGURO + SUBD1.D1_VALFRE) )  * -1 )	AS LIQ "	+ clr

	cQryInter += "  				FROM "+RetSqlName("SD1")+" SUBD1 "			+ clr
	cQryInter += "  				WHERE SUBD1.D_E_L_E_T_ <> '*' "				+ clr
	cQryInter += "  				AND SUBD1.D1_FILIAL		= SF1.F1_FILIAL "	+ clr
	cQryInter += "  				AND SUBD1.D1_FORNECE	= SF1.F1_FORNECE "	+ clr
	cQryInter += "  				AND SUBD1.D1_LOJA		= SF1.F1_LOJA "		+ clr
	cQryInter += "  				AND SUBD1.D1_TIPO		= SF1.F1_TIPO "		+ clr
	cQryInter += "  				AND SUBD1.D1_DOC		= SF1.F1_DOC " 		+ clr
	cQryInter += "  				AND SUBD1.D1_SERIE		= SF1.F1_SERIE "	+ clr
	cQryInter += "  			 )  LIQUIDO "									+ clr

	cQryInter += " 			 FROM "+ RetSqlName("SF1")+ " SF1 "	+ clr

	cQryInter += "  		JOIN "+RetSqlName("SD1")+ " SD1 "	+ clr
	cQryInter += " 			ON SD1.D1_FILIAL = SF1.F1_FILIAL"	+ clr
	cQryInter += " 			AND SD1.D1_DOC = SF1.F1_DOC"		+ clr
	cQryInter += " 			AND SD1.D1_SERIE = SF1.F1_SERIE"	+ clr
	cQryInter += " 			AND SD1.D1_FORNECE = SF1.F1_FORNECE"+ clr
	cQryInter += "  		AND SD1.D1_LOJA = SF1.F1_LOJA"   	+ clr
	cQryInter += " 			AND SD1.D1_TIPO = SF1.F1_TIPO"		+ clr
	cQryInter += "  		AND SD1.D1_DTDIGIT = SF1.F1_DTDIGIT"+ clr
	cQryInter += "  		AND SD1.D_E_L_E_T_= ' '"			+ clr

	cQryInter += " 			JOIN "+RetSqlName("SD2")+ " SD2 "	+ clr
	cQryInter += " 			ON SD2.D2_FILIAL = SD1.D1_FILIAL"	+ clr
	cQryInter += " 			AND SD2.D2_DOC = SD1.D1_NFORI"		+ clr
	cQryInter += " 			AND SD2.D2_SERIE = SD1.D1_SERIORI"	+ clr
	cQryInter += " 			AND SD2.D2_CLIENTE = SD1.D1_FORNECE"+ clr
	cQryInter += " 			AND SD2.D2_LOJA = SD1.D1_LOJA"		+ clr
	cQryInter += " 			AND SD2.D2_COD = SD1.D1_COD"		+ clr
	cQryInter += " 			AND SD2.D_E_L_E_T_= ' '"			+ clr

	cQryInter += " 			JOIN " +RetSqlName("SF2")+" SF2 "	+ clr
	cQryInter += " 			ON SF2.F2_FILIAL = SD2.D2_FILIAL "	+ clr
	cQryInter += " 			AND SF2.F2_DOC = SD2.D2_DOC "		+ clr
	cQryInter += " 			AND SF2.F2_SERIE = SD2.D2_SERIE "	+ clr
	cQryInter += " 			AND SF2.F2_CLIENTE = SD2.D2_CLIENTE"+ clr
	cQryInter += " 			AND SF2.F2_LOJA  = SD2.D2_LOJA "	+ clr
	//cQryInter += " 			AND SF2.F2_VEND1 BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"'"+ clr
	cQryInter += " 			AND SF2.D_E_L_E_T_= ' '"			+ clr
	
	cQryInter += "  			AND EXISTS(	SELECT "													+ clr
	cQryInter += " 			 					Z1_DOC"												+ clr
	cQryInter += " 						  	FROM "+RetSqlName("SZ1")+ " SZ1 "						+ clr
	cQryInter += " 			             	WHERE SZ1.Z1_FILIAL = SF2.F2_FILIAL"					+ clr
	cQryInter += " 			             	AND SZ1.Z1_DOC = SF2.F2_DOC "							+ clr
	cQryInter += " 			             	AND SZ1.Z1_SERIE = SF2.F2_SERIE "						+ clr
	cQryInter += " 			             	AND SZ1.Z1_CLIENTE = SF2.F2_CLIENTE"					+ clr
	cQryInter += " 			             	AND SZ1.Z1_LOJA = SF2.F2_LOJA"							+ clr
	cQryInter += " 			             	AND SZ1.Z1_DTENTRE <>' '"			+ clr
	cQryInter += " 			             	AND SZ1.D_E_L_E_T_= ' ')"								+ clr
	

	cQryInter += " 			JOIN "+RetSqlName("SA1")+" SA1 "	+ clr
	cQryInter += " 			ON SA1.A1_FILIAL = '"+xFilial("SA1")+"'"	+ clr
	cQryInter += "  			AND SA1.A1_COD = SF1.F1_FORNECE"		+ clr
	cQryInter += " 			AND SA1.A1_LOJA = SF1.F1_LOJA "		+ clr
	If !Empty(MV_PAR07) .or. !Empty(MV_PAR08)
		cQryInter += "  			AND SA1.A1_GRPVEN BETWEEN '"	+MV_PAR07+"' AND '"+MV_PAR08+"'"		+ clr
	Else
		If  !Empty(MV_PAR03) .and. !Empty(MV_PAR05) .or. Empty(MV_PAR03) .and. !Empty(MV_PAR05)
			cQryInter += "   			AND SA1.A1_COD BETWEEN '"	+MV_PAR03+"' AND '"+MV_PAR05+"'"	+ clr
			If  !Empty(MV_PAR06)
				cQryInter += "   			AND SA1.A1_LOJA BETWEEN '"	+MV_PAR04+"' AND '"+MV_PAR06+"'"+ clr
			EndIf
		EndIf

	EndIf
	cQryInter += "  			AND SA1.D_E_L_E_T_= ' '"								+ clr

	cQryInter += "   			JOIN "+RetSqlName("P01")+" P01 "					+ clr
	cQryInter += "   			ON P01.P01_FILIAL = '"+xFilial("P01")+"'"			+ clr
	If !Empty(MV_PAR07) .or. !Empty(MV_PAR08)
		cQryInter += "   			AND P01.P01_GRPCLI = SA1.A1_GRPVEN "			+ clr
	Else
		cQryInter += "   			AND P01.P01_CODCLI = SA1.A1_COD "				+ clr
		cQryInter += "   			AND P01.P01_LOJCLI = (CASE WHEN P01.P01_LOJCLI = '  ' THEN  '  '  ELSE SA1.A1_LOJA END )"+ clr
	EndIf

	//cQryInter += "   			AND P01.P01_STATUS <> '2'"							+ clr
	cQryInter += "   			AND P01.P01_TPCAD = '1'"							+ clr
	cQryInter += "   			AND P01.P01_REPASS <> '2'"							+ clr
	cQryInter += "   			AND P01.P01_STSAPR = '1'"							+ clr
	cQryInter += "   			AND ( P01.P01_DTVINI <= '"+DtoS(MV_PAR01)+"'"		+ clr
	cQryInter += "        			AND   P01.P01_DTVFIM >= '"+DtoS(MV_PAR02)+"'"	+ clr
	cQryInter += "        			)"												+ clr
	cQryInter += "   			AND P01.D_E_L_E_T_= ' '"							+ clr

	cQryInter += "  			WHERE SF1.F1_FILIAL = '"+xFilial("SF1")+"'"				+ clr
	cQryInter += "  			AND SF1.F1_DOC      BETWEEN '"+Replicate(" ",TamSx3("F1_DOC")[1])+"' AND '"+Replicate("Z",TamSx3("F1_DOC")[1])+"'"		+ clr
	cQryInter += "  			AND SF1.F1_SERIE    BETWEEN '"+Replicate(" ",TamSx3("F1_SERIE")[1])+"' AND '"+Replicate("Z",TamSx3("F1_SERIE")[1])+"'"	+ clr
	If !Empty(MV_PAR03) .or. !Empty(MV_PAR05)
		cQryInter += "  			AND SF1.F1_FORNECE BETWEEN '"	+MV_PAR03+"' AND '"+MV_PAR05+"'"	+ clr
		cQryInter += " 			AND SF1.F1_LOJA BETWEEN '"	+MV_PAR04+"' AND '"+MV_PAR06+"'"		+ clr
	Else
		cQryInter += "  			AND SF1.F1_FORNECE BETWEEN '"	+Replicate(" ",TamSx3("F1_FORNECE")[1])+"' AND '"+Replicate("Z",TamSx3("F1_FORNECE")[1])+"'"	+ clr
		cQryInter += "  			AND SF1.F1_LOJA BETWEEN '"	+Replicate(" ",TamSx3("F1_LOJA")[1])+"' AND '"+Replicate("Z",TamSx3("F1_LOJA")[1])+"'"				+ clr
	EndIf
	cQryInter += "  			AND SF1.F1_TIPO = 'D'"		   		+ clr
	cQryInter += "  			AND SF1.F1_DTDIGIT  BETWEEN '"+DtoS(MV_PAR01)+"' AND '"+DtoS(MV_PAR02)+"'"	+ clr

	//If nOpc == 3
		cQryInter += "  			AND SF1.F1_YAPURAC = ' ' "		+ clr
		cQryInter += "  			AND SF1.F1_YVERAPU = ' ' "		+ clr
	//EndIf

	cQryInter += "  			AND SF1.D_E_L_E_T_= ' '"			+ clr

	//cQryInter += "  			GROUP BY F1_FILIAL,F1_TIPO,F1_SERIE,F1_DOC,F1_FORNECE,F1_LOJA,A1_NOME,F2_VEND1,P01_TPFAT,P01_TOTPER,P01_CODIGO,P01_VERSAO "	+ clr
	cQryInter += "  			GROUP BY F1_FILIAL,F1_TIPO,F1_SERIE,F1_DOC,F1_FORNECE,F1_LOJA,A1_NOME,P01_TPFAT,P01_TOTPER,P01_CODIGO,P01_VERSAO "	+ clr

	cQry += cQryInter

	cQry += " ) TAB "										+ clr
	cQry += " HAVING (SUM(BRUTO)>0 Or SUM(LIQUIDO)>0) "+ clr
	
	/*
	//	Conforme solicitado em  11/12/12 - Pelo Sr Lucas, foi comentado o Filtro Abaixo
	If nOpc == 3 // Somente no processamento, verifica se ja nใo existe o VPC na apura็ใo. // 
	
		cQry += " WHERE NOT EXISTS ("						+ clr

		cQry += "               SELECT P04_CODVPC,P04_VERVPC"				+ clr
		cQry += "               FROM "+RetSqlName("P04")+" P04 "			+ clr
		cQry += "               WHERE P04.P04_FILIAL = '"+xFilial("P04")+"'"+ clr
		cQry += "               AND P04.P04_CODVPC = TAB.CODVPC "			+ clr
		cQry += "               AND P04.P04_VERVPC = TAB.VERVPC "			+ clr
		cQry += "               AND P04.D_E_L_E_T_= ' '"					+ clr
		cQry += "                   )"		 								+ clr
	EndIf
	*/
	//cQry += " GROUP BY TAB.CLIENTE,TAB.LOJA,TAB.NOME,TAB.VEND,TAB.TPFAT,TAB.TOTPER,TAB.CODVPC,TAB.VERVPC "+ clr
	cQry += " GROUP BY TAB.CLIENTE,TAB.LOJA,TAB.NOME,TAB.TPFAT,TAB.TOTPER,TAB.CODVPC,TAB.VERVPC "+ clr

	//cQry += " ORDER BY CLIENTE,LOJA,VEND "		+ clr
	cQry += " ORDER BY CLIENTE,LOJA "		+ clr

	TcQuery cQry New Alias &(clQRYAPR)

	TCSetField((clQRYAPR),"TOTBRUTO"		,"N",TamSx3("F2_VALBRUT")[1],TamSx3("F2_VALBRUT")[2]	)
	TCSetField((clQRYAPR),"TOTLIQUIDO"		,"N",TamSx3("F2_VALMERC")[1],TamSx3("F2_VALMERC")[2]	)
	TCSetField((clQRYAPR),"TOTPER"			,"N",TamSx3("P01_TOTPER")[1],TamSx3("P01_TOTPER")[2]	)

	(clQRYAPR)->(dbGoTop())
	(clQRYAPR)->(DbEval({|| nCOuntReg++ }))
	oProcess:SetRegua1( nCOuntReg )
	//oProcess:SetRegua1( 0 )

	(clQRYAPR)->(dbGoTop())
	(clQRYAPR)->(DbEval({|| oProcess:IncRegua1( "Consultando dados" ) }))

    // Query a ser utilizada para flagar as notas usadas no calculo, sem o grup by

	cQryInter += " ORDER BY TIPONF "
	TcQuery cQryInter New Alias &(cTEMPD)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFTLAPURA  บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria a tela de apura็ใo                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FTLAPURA(nOpc,clAlias,oProcT)

	Local oDlgApu		:= Nil
	Local cTitulo		:= "Apura็ใo de VPC."
	Local nlResoluc		:= oMainWnd:nClientWidth
	Local alCoord		:= MsAdvSize(.T.,.F.,0)
	Local nOpcNewGD 	:= 1
	Local alPrc			:= {0,0}
	Local alLeft		:= {0}
	Local alRight		:= {0}
	Local oCabec		:= Nil
	Local oApurCli		:= Nil
	Local oAnalitico	:= Nil
	Local alPosCab		:= {}
	Local aCamposV		:= {}
	Local nPosTpFat		:= 0
	Local nPosFatBru	:= 0
	Local nPosFatLiq	:= 0
	Local oEnchoice		:= Nil

	Private aTela[0][0]
	Private aGets[0]
	Private opLayer		:= FWLayer():New()
	Private apHeadAPUR	:= {}
	Private apColsAPUR	:= {}

	Private apHeadANA	:= {}
	Private apColsANA	:= {}

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	dbSelectArea("P04")

	If nlResoluc <= 800

		alPrcPrinc 		:= {023,038,037}
		alPrc			:= {100}

	ElseIf nlResoluc >= 1024 .And. nlResoluc < 1280

		alPrcPrinc 		:= {023,038,037}
		alPrc			:= {100}

	ElseIf nlResoluc >= 1280 .And. nlResoluc < 1300

		alPrcPrinc 		:= {023,038,037}
		alPrc			:= {100}

	ElseIf 	nlResoluc >= 1300

		alPrcPrinc 		:= {023,038,037}
		alPrc			:= {100}

	EndIf


	// Campos que serใo exibidos a Enchoice
	dbSelectArea("SX3")
	SX3->(DbSetOrder(1))
	If SX3->(dbSeek("P04"))
		While SX3->(!Eof()) .AND. SX3->X3_ARQUIVO == "P04"
			If (Alltrim(SX3->X3_CAMPO) $ "P04_CODIGO/P04_DESC/P04_DTINI/P04_DTFIM/P04_VERSAO")

				AADD(aCamposV,SX3->X3_CAMPO)

			EndIf
			SX3->(dbSkip())
		EndDo
	EndIf
	AADD(aCamposV,"NOUSER")

	// aHeader e aCols para APURAวรO
	HeadAPUR()
	ColsAPUR(clAlias,oProcT)

	// aHeader e aCols para ANALITICO
	FHeadANA()

	nPosTpFat	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_TPFAT"	})
	nPosFatBru	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_FATBRU"})
	nPosFatLiq	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_FATLIQ"})

	oDlgApu := TDialog():New(alCoord[1],alCoord[2],alCoord[6],alCoord[5],cTitulo,,,,,CLR_BLACK,CLR_WHITE,,,.T.)

		opLayer:Init(oDlgApu,.F.)

		opLayer:AddCollumn("CENTRO"	,alPrc[1],.F.)

		opLayer:AddWindow("CENTRO","CABEC"					,"Apura็ใo De VPC"					,alPrcPrinc[1],.T.,.T.,{||},,{||})
		opLayer:AddWindow("CENTRO","APURCLIENTE"			,"Apura็ao Cliente"					,alPrcPrinc[2],.T.,.T.,{||},,{||})
		opLayer:AddWindow("CENTRO","ANALITICO"				,"Analitico Por Tipo"				,alPrcPrinc[3],.T.,.T.,{||},,{||})

		oCabec		:= opLayer:GetWinPanel("CENTRO","CABEC")
		oApurCli	:= opLayer:GetWinPanel("CENTRO","APURCLIENTE")
		oAnalitico	:= opLayer:GetWinPanel("CENTRO","ANALITICO")

		alPosCab	:= {alCoord[1],alCoord[2],alCoord[1]+50,opLayer:ALINES[1]:NHEIGHT}

		RegToMemory("P04", nOpc == 3,.T.)
		If nOpc == 3
			M->P04_DTINI := MV_PAR01
			M->P04_DTFIM := MV_PAR02
		EndIf

		M->P04_VERSAO := "01"
		
        /*
        If nOpc == 3
        	M->P04_VERSAO := "01"
		ElseIf nOpc == 4
			M->P04_VERSAO := Soma1(P04->P04_VERSAO)
		EndIf
		*/
		
		oEnchoice	:= MSMGet():New("P04",,nOpc,,,,aCamposV,alPosCab,,,,,,oCabec ,,,,,,,,,)

		oEnchoice:oBox:Align := CONTROL_ALIGN_ALLCLIENT

		opGrdAPUC:= MsNewGetDados():New(000,000,000,000,nOpcNewGD,"","",,,,9999,,,,oApurCli,apHeadAPUR,apColsAPUR)
		opGrdAPUC:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
		opGrdAPUC:bChange:= {|| U_FPR01ANA(opGrdAPUC:NAT, IIf (opGrdAPUC:aCols[opGrdAPUC:NAT][nPosTpFat] == "1",opGrdAPUC:aCols[opGrdAPUC:NAT][nPosFatBru],opGrdAPUC:aCols[opGrdAPUC:NAT][nPosFatLiq])  )}

		opGrdAPUC:lInsert		:= .F.

		opGrdP05:= MsNewGetDados():New(000,000,000,000,nOpcNewGD,"","",,,,9999,,,,oAnalitico,apHeadANA,apColsANA)
		opGrdP05:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
		opGrdP05:lInsert		:= .F.

	Activate Msdialog oDlgApu Centered On Init EnchoiceBar(oDlgApu,;
																 {|| IIF (Iif(nOpc==3 .Or. nOpc==4,Obrigatorio(aGets,aTela),.T.),;
																 		(  IIF( FVldAPU(nOpc),(oDlgApu:End()),Nil ) ),Nil)   },;
																 {|| /*IIF(nOpc==3,P04->(RollBackSX8()),Nil),*/oDlgApu:End() };
																 ,,)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFVldAPU   บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida็ใo antes da grava็ao da apura็ใo                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FVldAPU(nOpc)
	Local lRet := .F.
	Local oProcess	:= Nil

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	If nOpc <> 2
		If Aviso("NCGPR101-01","Deseja gravar a apura็ใo?",{"Sim","Nใo"},3) == 1
			lRet := .T.

			oProcess := MsNewProcess():New( { ||  FGRVPR01(nOpc,oProcess)  }, "Aguarde", "Consultando base...", .T. )
			oProcess:Activate()

		EndIf
	Else
		lRet := .T.
	EndIf

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFGRVPR01  บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava a apura็ใo                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FGRVPR01(nOpcX,oProcess)
	Local nX
	Local llGrv		:= .F.
	Local llNewAlt 	:= .F.
	Local cCodAux	:= ""
	Local aAreaP04Aux	:= {}
    Local nY
	Local nCOuntReg	:= 0

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )


	(cTEMPD)->(dbGoTop())
	(cTEMPD)->(DbEval({|| nCOuntReg++ }))
	oProcess:SetRegua2( nCOuntReg )
	(cTEMPD)->(dbGoTop())

	If nOpcX == 3 .Or. nOpcX == 4

		If nOpcX == 4
			FNewVer()
			nOpcX := 3
			llNewAlt := .T.
		EndIf

		//Grava cabecalho
		DbSelectArea("P04")
		lNewRec := (nOpcX==3)

		oProcess:SetRegua1( Len(apColsAPUR)-1 )

		cCodAux := M->P04_CODIGO
		
		If !llNewAlt // Se for Inclusใo, tratamento no c๓digo

			aAreaP04Aux := P04->(GetArea())
			
			P04->(dbSetOrder(1))
			
			lLoop := .T.
			
			While lLoop
				
				If P04->(dbSeek(xFilial("P04")+ cCodAux  ))
					cCodAux:= Soma1(cCodAux)
				Else
					lLoop := .F.
				EndIf
				
				Loop
				
			EndDo
			
			RestArea(aAreaP04Aux)
		
		EndIf
						

		For nX := 1 to Len(apColsAPUR)-1

			If RecLock( "P04", lNewRec)

				If !apColsAPUR[nX][Len(apHeadAPUR)+1]
					For nY := 1 to Len(apHeadAPUR)
						If ( apHeadAPUR[nY,10] <> "V" )
							FieldPut( FieldPos( apHeadAPUR[nY,2] ), apColsAPUR[nX,nY] )
			            Endif
			    	Next nY
			    EndIf
			    
			    P04->P04_FILIAL := xFilial("P04")
				P04->P04_CODIGO	:= cCodAux
				P04->P04_DESC  	:= M->P04_DESC
				P04->P04_DTINI 	:= M->P04_DTINI
				P04->P04_DTFIM 	:= M->P04_DTFIM
				P04->P04_VERSAO	:= M->P04_VERSAO
				P04->P04_PARAME := DtoS(MV_PAR01)+"|"+DtoS(MV_PAR02)+"|"+MV_PAR03+"|"+MV_PAR04+"|"+MV_PAR05+"|"+MV_PAR06+"|"+MV_PAR07+"|"+MV_PAR08//+"|"+MV_PAR07+"|"+MV_PAR08
				P04->P04_STATUS	:= "1"
				P04->(MsUnlock())
				llGrv := .T.
			EndIf

			oProcess:IncRegua1( "Gravando registro Apura็ใo" )

		Next nX

		//If llGrv
		//	P04->(ConfirmSx8())
		//EndIF

	EndIf

	// Flaga os campos das Notas que foram apuradas, nใo nใo serem usadas nas demais apura็๕es
	If llGrv

		dbSelectArea("SF1")
		SF1->(dbSetOrder(1))

		dbSelectArea("SF2")
		SF2->(dbSetOrder(1))

		(cTEMPD)->(dbGoTop())
		While (cTEMPD)->(!Eof())

			oProcess:IncRegua2( "Atualizando notas de Entrada e Saํda" )

			_cAlias := IIF( (cTEMPD)->TIPONF == "E", "SF1", "SF2")

			If (_cAlias)->(dbSeek(xFilial(_cAlias)+(cTEMPD)->DOC+(cTEMPD)->SERIE+(cTEMPD)->CLIENTE+(cTEMPD)->LOJA   ))
			
			
				If Abs((cTEMPD)->BRUTO)>0 .Or. Abs((cTEMPD)->LIQUIDO)>0

					If (_cAlias)->(RecLock(_cAlias,.F.))

				  		(_cAlias)->&(Right(_cAlias,2)+"_YAPURAC") 	:=  M->P04_CODIGO
						(_cAlias)->&(Right(_cAlias,2)+"_YVERAPU")	:=  M->P04_VERSAO
						(_cAlias)->(MsUnLock())
					EndIf
				EndIf	

			EndIf

			(cTEMPD)->(dbSkip())

		EndDo

	EndIf

	(cTEMPD)->(dbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณColsAPUR  บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta o aHeader do grid de apura็ใo por Cliente             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function HeadAPUR()
    Local nI
	Local aCmpHeader	:= {}

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	AADD(aCmpHeader,"P04_CLIENT"	)
	AADD(aCmpHeader,"P04_LOJCLI"	)
	AADD(aCmpHeader,"P04_NOMCLI"	)
	//AADD(aCmpHeader,"P04_CODVEN"	)
	AADD(aCmpHeader,"P04_TPFAT"		)
	AADD(aCmpHeader,"P04_FATBRU"	)
	AADD(aCmpHeader,"P04_FATLIQ"	)
	AADD(aCmpHeader,"P04_CODVPC"	)
	AADD(aCmpHeader,"P04_VERVPC"	)
	AADD(aCmpHeader,"P04_PERCEN"	)
	AADD(aCmpHeader,"P04_TOTAL1"	)

	SX3->(DbSetOrder(2))
	For nI := 1 to Len(aCmpHeader)
		If SX3->(DbSeek(aCmpHeader[nI]))
			Aadd(apHeadAPUR,	{	Trim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,;
			SX3->X3_TAMANHO,SX3->X3_DECIMAL,/*SX3->X3_VALID*/,;
			SX3->X3_USADO,SX3->X3_TIPO,	;
			SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,,SX3->X3_WHEN,	;
			SX3->X3_VISUAL,SX3->X3_VLDUSER, SX3->X3_PICTVAR,SX3->X3_OBRIGAT	})
		EndIf
	Next nI

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณColsAPUR  บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta o aCols do grid de apura็ใo por Cliente               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ColsAPUR(clAlias,oProcT)

	Local nPosCli	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_CLIENT"})
	Local nPosLoj	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_LOJCLI"})
	Local nPosNom	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_NOMCLI"})
	//Local nPosVen	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_CODVEN"})
	Local nPosTpFat	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_TPFAT"	})
	Local nPosFatBru:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_FATBRU"})
	Local nPosFatLiq:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_FATLIQ"})
	Local nPosPer	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_PERCEN"})
	Local nPosCodVPC:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_CODVPC"})
	Local nPosVerVPC:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_VERVPC"})
	Local nPosTot1	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_TOTAL1"})
	Local nTotBruto			:= 0
	Local nTotLiquido		:= 0
	//Local nTotPercentual	:= 0
	Local nTotal1			:= 0
	Local nCOuntReg			:= 0
	

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	(clAlias)->(dbGoTop())
	(clAlias)->(DbEval({|| nCOuntReg++ }))
	oProcT:SetRegua1( nCOuntReg )


	(clAlias)->(dbGoTop())
	If (clAlias)->(!Eof()) .and. (clAlias)->(!Bof())

		While(clAlias)->(!Eof())

			oProcT:IncRegua1( "Criando Tela" )

			AAdd(apColsAPUR,Array(Len(apHeadAPUR)+1))

			apColsAPUR[Len(apColsAPUR)][nPosCli]	:= (clAlias)->CLIENTE
			apColsAPUR[Len(apColsAPUR)][nPosLoj]	:= (clAlias)->LOJA
			apColsAPUR[Len(apColsAPUR)][nPosNom]	:= (clAlias)->NOME
			//apColsAPUR[Len(apColsAPUR)][nPosVen]	:= (clAlias)->VEND
			apColsAPUR[Len(apColsAPUR)][nPosTpFat]	:= (clAlias)->TPFAT
			apColsAPUR[Len(apColsAPUR)][nPosFatBru]	:= (clAlias)->TOTBRUTO
			apColsAPUR[Len(apColsAPUR)][nPosFatLiq]	:= (clAlias)->TOTLIQUIDO
			apColsAPUR[Len(apColsAPUR)][nPosPer]	:= (clAlias)->TOTPER
			apColsAPUR[Len(apColsAPUR)][nPosCodVPC]	:= (clAlias)->CODVPC
			apColsAPUR[Len(apColsAPUR)][nPosVerVPC]	:= (clAlias)->VERVPC
			apColsAPUR[Len(apColsAPUR)][nPosTot1]	:= (IIF( (clAlias)->TPFAT == "1",(clAlias)->TOTBRUTO,(clAlias)->TOTLIQUIDO)*(clAlias)->TOTPER) /100

			apColsAPUR[Len(apColsAPUR)][Len(apHeadAPUR)+1] := .F.

			nTotBruto		+= (clAlias)->TOTBRUTO
			nTotLiquido		+= (clAlias)->TOTLIQUIDO
			//nTotPercentual	+= (clAlias)->TOTPER
			nTotal1			+= (IIF( (clAlias)->TPFAT == "1",(clAlias)->TOTBRUTO,(clAlias)->TOTLIQUIDO)*(clAlias)->TOTPER) /100

			(clAlias)->(dbSkip())

		EndDo

		AAdd(apColsAPUR,Array(Len(apHeadAPUR)+1))
		apColsAPUR[Len(apColsAPUR)][nPosCli]	:= "Total II"
		apColsAPUR[Len(apColsAPUR)][nPosFatBru]	:= nTotBruto
		apColsAPUR[Len(apColsAPUR)][nPosFatLiq]	:= nTotLiquido
		//apColsAPUR[Len(apColsAPUR)][nPosPer]	:= nTotPercentual
		apColsAPUR[Len(apColsAPUR)][nPosTot1]	:= nTotal1

		apColsAPUR[Len(apColsAPUR)][Len(apHeadAPUR)+1] := .F.

	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFHeadANA  บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta o AHEADER do grid analitico de apura็ใo               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FHeadANA()
    Local nI
	Local aCmpHeader	:= {}

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	AADD(aCmpHeader,"P04_CODVPC"	)
	AADD(aCmpHeader,"P00_DESC"		)
	AADD(aCmpHeader,"P04_PERCEN"	)
	AADD(aCmpHeader,"P04_TOTAL1"	)

	SX3->(DbSetOrder(2))
	For nI := 1 to Len(aCmpHeader)
		If SX3->(DbSeek(aCmpHeader[nI]))

			Aadd(apHeadANA,	{ IIF (Alltrim(SX3->X3_CAMPO)=="P04_TOTAL1","Total III",Trim(X3Titulo())) ,SX3->X3_CAMPO,SX3->X3_PICTURE,;
			SX3->X3_TAMANHO,SX3->X3_DECIMAL,/*SX3->X3_VALID*/,;
			SX3->X3_USADO,SX3->X3_TIPO,	;
			SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,,SX3->X3_WHEN,	;
			SX3->X3_VISUAL,SX3->X3_VLDUSER, SX3->X3_PICTVAR,SX3->X3_OBRIGAT	})
		EndIf
	Next nI

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณColsANA   บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta o acols do grid analitico de apura็ใo                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ColsANA(clAlias,nValFat)

	Local nPosTPVPC	:= aScan(apHeadANA,{|x| AllTrim(x[2])=="P04_CODVPC"	})
	Local nPosDesc	:= aScan(apHeadANA,{|x| AllTrim(x[2])=="P00_DESC"	})
	Local nPosPerc	:= aScan(apHeadANA,{|x| AllTrim(x[2])=="P04_PERCEN"	})
	Local nPosTot3	:= aScan(apHeadANA,{|x| AllTrim(x[2])=="P04_TOTAL1"	})
	Local nPercen	:= 0
	Local nTotal3	:= 0

	apColsANA := {}

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	(clAlias)->(dbGoTop())
	While (clAlias)->(!Eof())

		AAdd(apColsANA,Array(Len(apHeadANA)+1))

		apColsANA[Len(apColsANA)][nPosTPVPC]:= (clAlias)->P02_CODTP
		apColsANA[Len(apColsANA)][nPosDesc]	:= Posicione("P00",1,xFilial("P00")+(clAlias)->P02_CODTP,"P00_DESC")
		apColsANA[Len(apColsANA)][nPosPerc]	:= (clAlias)->P02_PERCEN
		apColsANA[Len(apColsANA)][nPosTot3]	:= nValFat * (clAlias)->P02_PERCEN/100
		apColsANA[Len(apColsANA)][Len(apHeadANA)+1] := .F.

		nPercen	+=(clAlias)->P02_PERCEN
		nTotal3	+= nValFat * (clAlias)->P02_PERCEN/100

		(clAlias)->(dbSkip())
	EndDo

	AAdd(apColsANA,Array(Len(apHeadANA)+1))
	apColsANA[Len(apColsANA)][nPosTPVPC]:= "Total IV"
	apColsANA[Len(apColsANA)][nPosPerc]	:= nPercen
	apColsANA[Len(apColsANA)][nPosTot3]	:= nTotal3
	apColsANA[Len(apColsANA)][Len(apHeadANA)+1] := .F.

	opGrdP05:aCols := (apColsANA)
	opGrdP05:Refresh()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFPR01ANA  บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณQuery para atualiza็ใo do grid Analitico da apura็ao        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FPR01ANA(LinhaApur,nValFat)

	Local cQry := ""
	Local nPosCodVPC	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_CODVPC"})
	Local nPosVerVPC	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_VERVPC"})
	Local clAlias 		:= GetNextAlias()
	Local _cTipoVPC		:= ""
	Local _VerVPC		:= ""

	Default LinhaApur := 1

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	_cTipoVPC := Alltrim(opGrdAPUC:aCols[LinhaApur,nPosCodVPC])
	_VerVPC := Alltrim(opGrdAPUC:aCols[LinhaApur,nPosVerVPC])


	cQry := " SELECT "		+clr
	cQry += " P02_CODTP "	+clr
	cQry += " ,P02_PERCEN "	+clr
	cQry += " FROM "+RetSqlName("P01")+" P01 "			+clr
	cQry += " JOIN "+RetSqlName("P02")+" P02 "			+clr
	cQry += " ON P02.P02_FILIAL = P01.P01_FILIAL"		+clr
	cQry += " AND P02.P02_CODVPC = P01.P01_CODIGO"		+clr
	//cQry += " AND P02.P02_ATIVO = '1'"					+clr
	cQry += " AND P02.D_E_L_E_T_= ' '"					+clr

	cQry += " WHERE P01_FILIAL = '"+xFilial("P01")+"'"	+clr
	cQry += " AND P01.P01_CODIGO = '"+_cTipoVPC+"'"		+clr
	cQry += " AND P01.P01_VERSAO = '"+_VerVPC+"'"		+clr
	cQry += " AND P01.P01_STSAPR = '1'"	   				+clr
	cQry += " AND P01.D_E_L_E_T_ = ' '"					+clr

	TcQuery cQry New Alias &(clAlias)
	TCSetField((clAlias),"P02_PERCEN"	,"N",TamSx3("P02_PERCEN")[1],TamSx3("P02_PERCEN")[2]	)

	(clAlias)->(dbGoTop())

	ColsANA(clAlias,nValFat)

	(clAlias)->(dbCloseArea())
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFNewVer   บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualizada o resgistro anterior, para identificar que houve บฑฑ
ฑฑบ          ณum reprocessamento da apura็ใo,pos ira gerar uma nova versaoบฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FNewVer()
   	Local nX
	Local aAreaP04	:= P04->(GetArea())
	Local cCodApu	:= P04->P04_CODIGO
	Local cVersao	:= P04->P04_VERSAO
	Local nPosCli	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_CLIENT"})
	Local nPosLoj	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_LOJCLI"})
	//Local nPosVen	:= aScan(apHeadAPUR,{|x| AllTrim(x[2])=="P04_CODVEN"})

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	P04->(dbSetOrder(2))

	For nX := 1 to Len(apColsAPUR)-1
		If P04->(dbSeek(xFilial("P04")+cCodApu+cVersao+apColsAPUR[nX,nPosCli]+apColsAPUR[nX,nPosLoj]/*+apColsAPUR[nX,nPosVen] */))
			If RecLock("P04",.F.)
				P04->P04_STATUS := "2"
				P04->(MsUnLock())
			EndIf
		EndIf
	Next nX

	RestArea(aAreaP04)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPR01FILP04บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTela de filtro para o grid de apura็ใo                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR01FILP04()

	Local olLayer		:= FWLayer():New()
	Local olLayerBus	:= FWLayer():New()
	Local olLayerBnt	:= FWLayer():New()
	Local alCoord		:= MsAdvSize(.F.,.F.,0)
	Local olDlg			:= Nil
	Local olDlgBut		:= Nil
	Local olDlgBut1		:= Nil
	Local olDlgBut2		:= Nil
	Local nlX1			:= 0
	Local nlX2			:= 0
	Local nlX3 			:= 0
	Local nlX4			:= 0
	Local olCombo1		:= Nil
	Local olCombo2		:= Nil
	Local olGet			:= Nil
	Local alItens1		:= {"P04_CODIGO=Cod Apura็ใo","P04_VERSAO=Versใo","P04_DESC=Descri็ใo","P04_CLIENT= Cod Cliente","P04_LOJCLI=Loja Cliente","P04_DTINI=Data Inicio","P04_DTFIM=Data Fim"}
	Local alItens2		:= {"1=Igual","2=Diferente","3=Contido em","4=Contem"}
	Local clCombo1		:= ""
	Local clCombo2		:= ""
	Local clGet			:= Space(200)
	Local olDlg1		:= Nil
	Local olDlg2		:= Nil
	Local olDlg3		:= Nil

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	olDlg := TDialog():New(alCoord[1],alCoord[2],alCoord[6]*0.65,alCoord[5]*0.75,"Filtro",,,,,CLR_BLACK,CLR_WHITE,,,.T.)

	olLayer:Init(olDlg,.F.)

	olLayer:AddCollumn("CENTRAL",100,.F.)

	olLayer:AddWindow("CENTRAL","BUSCA"		,"Busca"				,033.33,.T.,.T.,{||},,{||})
	olLayer:AddWindow("CENTRAL","FILTRO"	,"Filtro"				,033.33,.T.,.T.,{||},,{||})
	olLayer:AddWindow("CENTRAL","BOTOES"	,"Bot๕es funcionais"	,033.33,.T.,.T.,{||},,{||})

	olDlgBus	:= olLayer:GetWinPanel("CENTRAL","BUSCA")
	olDlgFil	:= olLayer:GetWinPanel("CENTRAL","FILTRO")
	olDlgBut	:= olLayer:GetWinPanel("CENTRAL","BOTOES")


	olLayerBus:Init(olDlgBus,.F.)

	olLayerBus:AddCollumn("ESQUERDA",033.33,.F.)
	olLayerBus:AddCollumn("CENTRO"	,033.33,.F.)
	olLayerBus:AddCollumn("DIREITA"	,033.33,.F.)

	olLayerBus:AddWindow("ESQUERDA"	,"COMBO1"	,"Campo"			,100,.T.,.T.,{||},,{||})
	olLayerBus:AddWindow("CENTRO"	,"COMBO2"	,"Operador"			,100,.T.,.T.,{||},,{||})
	olLayerBus:AddWindow("DIREITA"	,"GET1"		,"Valor"	,100,.T.,.T.,{||},,{||})

	olDlg1	:= olLayerBus:GetWinPanel("ESQUERDA","COMBO1")
	olDlg2	:= olLayerBus:GetWinPanel("CENTRO"	,"COMBO2")
	olDlg3	:= olLayerBus:GetWinPanel("DIREITA"	,"GET1")

	nlX1	:= olDlg1:NCLIENTWIDTH*0.50
	nlX2	:= olDlg1:NCLIENTHEIGHT*0.70

	nlX3	:= ((olDlg1:NCLIENTWIDTH*0.50)/2)-(nlX1/2)
	nlX4	:= (olDlg1:NCLIENTHEIGHT/1.89)-(nlX2/2)

	olCombo1 := TComboBox():New(nlX4,nlX3,{|u| If(PCount()>0,Eval({|x| clCombo1:=x },u),clCombo1)},alItens1,nlX1,nlX2,olDlg1,,{|| },,,,.T.,,,,,,,,,"clCombo1")

	nlX1	:= olDlg2:NCLIENTWIDTH*0.50
	nlX2	:= olDlg2:NCLIENTHEIGHT*0.70

	nlX3	:= ((olDlg2:NCLIENTWIDTH*0.50)/2)-(nlX1/2)
	nlX4	:= (olDlg2:NCLIENTHEIGHT/1.89)-(nlX2/2)

	olCombo2 := TComboBox():New(nlX4,nlX3,{|u| If(PCount()>0,Eval({|x| clCombo2:=x },u),clCombo2)},alItens2,nlX1,nlX2,olDlg2,,{|| },,,,.T.,,,,,,,,,"clCombo2")

	nlX1	:= olDlg3:NCLIENTWIDTH*0.50
	nlX2	:= olDlg3:NCLIENTHEIGHT*0.10

	nlX3	:= 001
	nlX4	:= (olDlg3:NCLIENTHEIGHT*0.45/2)-(nlX2/2)

	olGet := TGet():New(nlX4,nlX3,{|u| if(PCount()>0,clGet:=u,clGet)},olDlg3 ,nlX1,nlX2,"",,0,,,.F.,,.T.,,.T.,,.T.,.T.,,.F.,.F.,,clGet,,,, )

	oMemo		:= TMultiget():Create(olDlgFil,{|u|if(Pcount()>0, cMemo := u,cMemo )},000,000,000,000,,,,,,.T.)
	oMemo:Align := CONTROL_ALIGN_ALLCLIENT
	oMemo:EnableHScroll(.T.)
	oMemo:EnableVScroll(.T.)
	oMemo:lWordWrap	:= .T.
	oMemo:lReadOnly	:= .T.

	olLayerBnt:Init(olDlgBut,.F.)

	olLayerBnt:AddCollumn("BOTAO01"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO02"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO03"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO04"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO05"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO06"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO07"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO08"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO09"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO10"	,10,.F.)

	olLayerBnt:AddWindow("BOTAO07","LIMPEZA","Lim.",100,.T.,.T.,{||},,{||})
	olLayerBnt:AddWindow("BOTAO08","ADICAO","Adi.",100,.T.,.T.,{||},,{||})
	olLayerBnt:AddWindow("BOTAO09","CONFIRMACAO","Con.",100,.T.,.T.,{||},,{||})
	olLayerBnt:AddWindow("BOTAO10","CANCELAR"	,"Can."	,100,.T.,.T.,{||},,{||})

	olDlgBut4 	:= olLayerBnt:GetWinPanel("BOTAO07"	,"LIMPEZA")
	olDlgBut3 	:= olLayerBnt:GetWinPanel("BOTAO08"	,"ADICAO")
	olDlgBut2 	:= olLayerBnt:GetWinPanel("BOTAO09"	,"CONFIRMACAO")
	olDlgBut1 	:= olLayerBnt:GetWinPanel("BOTAO10"	,"CANCELAR")

	nlX1		:= olDlgBut3:NCLIENTWIDTH*0.90
	nlX2		:= olDlgBut3:NCLIENTHEIGHT*0.90

	nlX3		:= (olDlgBut3:NCLIENTWIDTH/2)-(nlX1/2)
	nlX4		:= (olDlgBut3:NCLIENTHEIGHT/2)-(nlX2/2)

	TBtnBmp2():New(nlX4,nlX3,nlX1,nlX2,"S4WB004N",,,,{|| cMemo := "", oMemo:Refresh(),  cFiltro := ""  },olDlgBut4,"Limpar",,.T. )

	nlX1		:= olDlgBut3:NCLIENTWIDTH*0.90
	nlX2		:= olDlgBut3:NCLIENTHEIGHT*0.90

	nlX3		:= (olDlgBut3:NCLIENTWIDTH/2)-(nlX1/2)
	nlX4		:= (olDlgBut3:NCLIENTHEIGHT/2)-(nlX2/2)

	TBtnBmp2():New(nlX4,nlX3,nlX1,nlX2,"NOVACELULA",,,,{|| PR01INMEMO(clCombo1, clCombo2, Alltrim(UPPER(clGet))) },olDlgBut3,"Adicionar",,.T. )

	nlX1		:= olDlgBut2:NCLIENTWIDTH*0.90
	nlX2		:= olDlgBut2:NCLIENTHEIGHT*0.90

	nlX3		:= (olDlgBut2:NCLIENTWIDTH/2)-(nlX1/2)
	nlX4		:= (olDlgBut2:NCLIENTHEIGHT/2)-(nlX2/2)

	TBtnBmp2():New(nlX4,nlX3,nlX1,nlX2,"PCOFXOK",,,,{|| FATUGP04(), olDlg:End() },olDlgBut2,"Confirmar",,.T. )

	nlX1		:= olDlgBut1:NCLIENTWIDTH*0.90
	nlX2		:= olDlgBut1:NCLIENTHEIGHT*0.90

	nlX3		:= (olDlgBut1:NCLIENTWIDTH/2)-(nlX1/2)
	nlX4		:= (olDlgBut1:NCLIENTHEIGHT/2)-(nlX2/2)

	TBtnBmp2():New(nlX4,nlX3,nlX1,nlX2,"PCOFXCANCEL",,,,{|| olDlg:End() },olDlgBut1,"Cancelar",,.T. )

	Activate Msdialog olDlg Centered

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPR01INMEMOบAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPopula a variacel a ser utilizada no Filtro da tela de apuraบฑฑ
ฑฑบ          ณcao                                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR01INMEMO(cMyCampo, cMyOperador, cMyValor)

	Local cAux	:= ""
	Local cAux2	:= ""

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	If Alltrim(cMyCampo) == "P04_CODIGO"
		cAux 	+= " Cod Apura็ใo "
		cAux2	+= " P04_CODIGO "
	ElseIf Alltrim(cMyCampo) == "P04_VERSAO"
		cAux 	+= " Versใo "
		cAux2	+= " P04_VERSAO "
	ElseIf Alltrim(cMyCampo) == "P04_CLIENT"
		cAux 	+= " Cliente "
		cAux2	+= " P04_CLIENT "
	ElseIf Alltrim(cMyCampo) == "P04_LOJCLI"
		cAux 	+= " Loja Cliente "
		cAux2	+= " P04_LOJCLI "
	ElseIf Alltrim(cMyCampo) == "P04_DESC"
		cAux 	+= " Descri็ใo"
		cAux2	+= " P04_DESC "
	ElseIf Alltrim(cMyCampo) == "P04_DTINI"
		cAux 	+= " Data Inicial "
		cAux2	+= " P04_DTINI "
	ElseIf Alltrim(cMyCampo) == "P04_DTFIM"
		cAux 	+= " Data Fim "
		cAux2	+= " P04_DTFIM "
	EndIf

	If Alltrim(cMyOperador) == "1"
		cAux    += " igual a "
		cAux2	+= " = "
	ElseIf Alltrim(cMyOperador) == "2"
		cAux 	+= " diferente de "
		cAux2	+= " <> "
	ElseIf Alltrim(cMyOperador) == "3"
		cAux 	+= " contido em "
		cAux2	+= " IN "
	ElseIf Alltrim(cMyOperador) == "4"
		cAux 	+= " contem "
		cAux2	+= " LIKE "
	EndIf

	If Alltrim(cMyOperador) == "1"
		cAux 	+= Space(1) + cMyValor
		cAux2	+= " '" + Padr(cMyValor,TamSx3(Alltrim(cMyCampo))[1]) + "' "
	ElseIf Alltrim(cMyOperador) == "2"
		cAux 	+= Space(1) + cMyValor
		cAux2	+= " '" + Padr(cMyValor,TamSx3(Alltrim(cMyCampo))[1]) + "' "
	ElseIf Alltrim(cMyOperador) == "3"
		cAux 	+= Space(1) + cMyValor
		cAux2	+= FormatIn(cMyValor,",")
	ElseIf Alltrim(cMyOperador) == "4"
		cAux 	+= Space(1) + cMyValor
		cAux2	+= " '%"+cMyValor+"%'"
	EndIf

	If !Empty(cMemo)
		cMemo 	:= Alltrim(cMemo) + " E " + cAux
		cFiltro := Alltrim(cFiltro) + " AND " + cAux2
	Else
		cMemo 	:= cAux
		cFiltro := cAux2
	EndIf

	oMemo:Refresh()

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPR01PESP04บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTela de pesquisa da apura็ใo                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR01PESP04()

	Local olLayer		:= FWLayer():New()
	Local olLayerBus	:= FWLayer():New()
	Local olLayerBnt	:= FWLayer():New()
	Local alCoord		:= MsAdvSize(.F.,.F.,0)
	Local olDlg			:= Nil
	Local olDlgBut		:= Nil
	Local olDlgBut1		:= Nil
	Local olDlgBut2		:= Nil
	Local nlX1			:= 0
	Local nlX2			:= 0
	Local nlX3 			:= 0
	Local nlX4			:= 0
	Local olCombo1		:= Nil
	Local olCombo2		:= Nil
	Local olGet			:= Nil
	Local alItens1		:= {}
	Local clCombo1		:= ""
	Local clCombo2		:= ""
	Local clGet			:= Space(200)
	Local olDlg1		:= Nil
	Local olDlg2		:= Nil
	Local olDlg3		:= Nil

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	AADD(alItens1,"1=Cod Apura็ใo+Versใo")
	AADD(alItens1,"2=Descri็ใo")
	AADD(alItens1,"3=Cod Apura็ใo+Versใo+Cod Cli+Loja")
	AADD(alItens1,"4=Data Inicial (dd/mm/aaaa)")
	AADD(alItens1,"5=Data Final (dd/mm/aaaa)")

	olDlg := TDialog():New(alCoord[1],alCoord[2],alCoord[6]*0.45,alCoord[5]*0.75,"Pesquisa",,,,,CLR_BLACK,CLR_WHITE,,,.T.)

	olLayer:Init(olDlg,.F.)

	olLayer:AddCollumn("CENTRAL",100,.F.)

	olLayer:AddWindow("CENTRAL","BUSCA"		,"Busca"				,50,.T.,.T.,{||},,{||})
	olLayer:AddWindow("CENTRAL","BOTOES"	,"Bot๕es funcionais"	,50,.T.,.T.,{||},,{||})

	olDlgBus	:= olLayer:GetWinPanel("CENTRAL","BUSCA")
	olDlgBut	:= olLayer:GetWinPanel("CENTRAL","BOTOES")


	olLayerBus:Init(olDlgBus,.F.)

	olLayerBus:AddCollumn("ESQUERDA",50,.F.)
	olLayerBus:AddCollumn("DIREITA"	,50,.F.)

	olLayerBus:AddWindow("ESQUERDA"	,"COMBO1"	,"Chave"			,100,.T.,.T.,{||},,{||})
	olLayerBus:AddWindow("DIREITA"	,"GET1"		,"Conteudo"	,100,.T.,.T.,{||},,{||})

	olDlg1	:= olLayerBus:GetWinPanel("ESQUERDA","COMBO1")
	olDlg3	:= olLayerBus:GetWinPanel("DIREITA"	,"GET1")


	nlX1	:= olDlg1:NCLIENTWIDTH*0.50
	nlX2	:= olDlg1:NCLIENTHEIGHT*0.70

	nlX3	:= ((olDlg1:NCLIENTWIDTH*0.50)/2)-(nlX1/2)
	nlX4	:= (olDlg1:NCLIENTHEIGHT/1.89)-(nlX2/2)

	olCombo1 := TComboBox():New(nlX4,nlX3,{|u| If(PCount()>0,Eval({|x| clCombo1:=x },u),clCombo1)},alItens1,nlX1,nlX2,olDlg1,,{|| },,,,.T.,,,,,,,,,"clCombo1")


	nlX1	:= olDlg3:NCLIENTWIDTH*0.50
	nlX2	:= olDlg3:NCLIENTHEIGHT*0.10

	nlX3	:= 001
	nlX4	:= (olDlg3:NCLIENTHEIGHT*0.45/2)-(nlX2/2)

	olGet := TGet():New(nlX4,nlX3,{|u| if(PCount()>0,clGet:=u,clGet)},olDlg3 ,nlX1,nlX2,"",,0,,,.F.,,.T.,,.T.,,.T.,.T.,,.F.,.F.,,clGet,,,, )

	olLayerBnt:Init(olDlgBut,.F.)

	olLayerBnt:AddCollumn("BOTAO01"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO02"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO03"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO04"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO05"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO06"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO07"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO08"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO09"	,10,.F.)
	olLayerBnt:AddCollumn("BOTAO10"	,10,.F.)

	olLayerBnt:AddWindow("BOTAO09","CONFIRMACAO","Con.",100,.T.,.T.,{||},,{||})
	olLayerBnt:AddWindow("BOTAO10","CANCELAR"	,"Can."	,100,.T.,.T.,{||},,{||})

	olDlgBut2 	:= olLayerBnt:GetWinPanel("BOTAO09"	,"CONFIRMACAO")
	olDlgBut1 	:= olLayerBnt:GetWinPanel("BOTAO10"	,"CANCELAR")

	nlX1		:= olDlgBut2:NCLIENTWIDTH*0.90
	nlX2		:= olDlgBut2:NCLIENTHEIGHT*0.90

	nlX3		:= (olDlgBut2:NCLIENTWIDTH/2)-(nlX1/2)
	nlX4		:= (olDlgBut2:NCLIENTHEIGHT/2)-(nlX2/2)

	TBtnBmp2():New(nlX4,nlX3,nlX1,nlX2,"PCOFXOK",,,,{|| FRETPES(clCombo1, clGet), olDlg:End() },olDlgBut2,"Confirmar",,.T. )

	nlX1		:= olDlgBut1:NCLIENTWIDTH*0.90
	nlX2		:= olDlgBut1:NCLIENTHEIGHT*0.90

	nlX3		:= (olDlgBut1:NCLIENTWIDTH/2)-(nlX1/2)
	nlX4		:= (olDlgBut1:NCLIENTHEIGHT/2)-(nlX2/2)

	TBtnBmp2():New(nlX4,nlX3,nlX1,nlX2,"PCOFXCANCEL",,,,{|| olDlg:End() },olDlgBut1,"Cancelar",,.T. )

	Activate Msdialog olDlg Centered


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFRETPES   บAutor  ณHermes Ferreira     บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRealiza a pesquisa, no grid da tela de apura็๕es. Posiciona บฑฑ
ฑฑบ          ณno registro                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function FRETPES(cIndice, cConteudo)

	Local aChave		:= {}
	Local nPosIni		:= 1
	Local nPosGrid		:= 1

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	Begin Sequence

		cConteudo := UPPER(cConteudo)

		If cIndice == "1"

			 nPosGrid := aScan(opGridP04:aCols,{|x|  x[aScan(apHeadP04,{|y| Alltrim(y[2]) == "P04_CODIGO" })]  ;
			        + x[aScan(apHeadP04,{|y| Alltrim(y[2]) == "P04_VERSAO" })] ;
			        == Alltrim(cConteudo) })

		ElseIf cIndice == "2"

			 nPosGrid := aScan(opGridP04:aCols,{|x| Alltrim(cConteudo) ;
			        $  x[aScan(apHeadP04,{|y| Alltrim(y[2]) == "P04_DESC" })] })

		ElseIf cIndice == "3"

			 nPosGrid := aScan(opGridP04:aCols,{|x|  x[aScan(apHeadP04,{|y| Alltrim(y[2]) == "P04_CODIGO" })]  ;
					 + x[aScan(apHeadP04,{|y| Alltrim(y[2]) == "P04_VERSAO" })] ;
					 + x[aScan(apHeadP04,{|y| Alltrim(y[2]) == "P04_CLIENT" })] ;
					 + x[aScan(apHeadP04,{|y| Alltrim(y[2]) == "P04_LOJCLI" })] ;
			        == Alltrim(cConteudo) })

		ElseIf cIndice == "4"

			 nPosGrid := aScan(opGridP04:aCols,{|x|  x[aScan(apHeadP04,{|y| Alltrim(y[2]) == "P04_DTINI" })]  ;
			        == CtoD(Alltrim(cConteudo)) })

		ElseIf cIndice == "5"

			 nPosGrid := aScan(opGridP04:aCols,{|x|  x[aScan(apHeadP04,{|y| Alltrim(y[2]) == "P04_DTFIM" })]  ;
			        == CtoD(Alltrim(cConteudo)) })

		EndIf

		If nPosGrid > 0
			opGridP04:GoTo(nPosGrid)
		EndIf

	End Sequence

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCPRSX1   บAutor  ณHermes Ferreira     บ Data ณ  04/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria o grupo de perguntas                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NCPRSX1( clPerg )

Local alAreaAtu	:= GetArea()
Local alAux		:= {}

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

aAdd( alAux, {	"01",;		  					// 01-Ordem da Pergunta (2)
"Da Data",;					  					// 02-Descri็ใo em Portugues (30)
"Da Data",;				  						// 03-Descri็ใo em Espanhol (30)
"Da Data",;				  						// 04-Descri็ใo em Ingles (30)
"mv_ch1",;							  			// 05-Nome da Variแvel (6)
"D",;											// 06-Tipo da Variแvel (1)
8,;												// 07-Tamanho da Variแvel (2)
0,;												// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressใo de Valida็ใo da Variแvel (60)
"",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR01",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Da Data Inicial   						 ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Da Data Inicial   						 ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Da Data Inicial   						 ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )


aAdd( alAux, {	"02",;		  					// 01-Ordem da Pergunta (2)
"Ate Data",;					  				// 02-Descri็ใo em Portugues (30)
"Ate Data",;				  					// 03-Descri็ใo em Espanhol (30)
"Ate Data",;				  					// 04-Descri็ใo em Ingles (30)
"mv_ch2",;							  			// 05-Nome da Variแvel (6)
"D",;											// 06-Tipo da Variแvel (1)
8,;												// 07-Tamanho da Variแvel (2)
0,;												// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressใo de Valida็ใo da Variแvel (60)
"",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR02",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Ate Data Inicial   					 ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Ate Data Inicial   					 ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Ate Data Inicial   					 ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )


aAdd( alAux, {	"03",;		  					// 01-Ordem da Pergunta (2)
"Do Cliente",;					  				// 02-Descri็ใo em Portugues (30)
"Do Cliente",;				  					// 03-Descri็ใo em Espanhol (30)
"Do Cliente",;				  					// 04-Descri็ใo em Ingles (30)
"mv_ch3",;							  			// 05-Nome da Variแvel (6)
"C",;											// 06-Tipo da Variแvel (1)
TamSx3("A1_COD")[1],;							// 07-Tamanho da Variแvel (2)
TamSx3("A1_COD")[2],;							// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"Empty(MV_PAR07).and.Empty(MV_PAR08) .or. VAZIO()",;// 11-Expressใo de Valida็ใo da Variแvel (60)
"SA1",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR03",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Informe o c๓digo inicial do cliente     ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o c๓digo inicial do cliente     ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o c๓digo inicial do cliente     ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"04",;		  									// 01-Ordem da Pergunta (2)
"Da Loja",;						  				// 02-Descri็ใo em Portugues (30)
"Da Loja",;				  						// 03-Descri็ใo em Espanhol (30)
"Da Loja",;				  						// 04-Descri็ใo em Ingles (30)
"mv_ch4",;							  			// 05-Nome da Variแvel (6)
"C",;											// 06-Tipo da Variแvel (1)
TamSx3("A1_LOJA")[1],;							// 07-Tamanho da Variแvel (2)
TamSx3("A1_LOJA")[2],;							// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressใo de Valida็ใo da Variแvel (60)
"",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR04",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Informe o c๓digo inicial da loja do clie",;
"nte                                     ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o c๓digo inicial da loja do clie",;
"nte                                     ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o c๓digo inicial da loja do clie",;
"nte                                     ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"05",;		  									// 01-Ordem da Pergunta (2)
"At้ o Cliente",;					  			// 02-Descri็ใo em Portugues (30)
"At้ o Cliente",;				  					// 03-Descri็ใo em Espanhol (30)
"At้ o Cliente",;				  					// 04-Descri็ใo em Ingles (30)
"mv_ch5",;							  			// 05-Nome da Variแvel (6)
"C",;											// 06-Tipo da Variแvel (1)
TamSx3("A1_COD")[1],;							// 07-Tamanho da Variแvel (2)
TamSx3("A1_COD")[2],;							// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"Empty(MV_PAR07).and.Empty(MV_PAR08) .or. VAZIO()",;			// 11-Expressใo de Valida็ใo da Variแvel (60)
"SA1",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR05",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Informe o c๓digo final do cliente       ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o c๓digo final do cliente       ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o c๓digo final do cliente       ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"06",;		  									// 01-Ordem da Pergunta (2)
"Ate a Loja",;						  				// 02-Descri็ใo em Portugues (30)
"Ate a Loja",;				  						// 03-Descri็ใo em Espanhol (30)
"Ate a Loja",;				  						// 04-Descri็ใo em Ingles (30)
"mv_ch6",;							  			// 05-Nome da Variแvel (6)
"C",;											// 06-Tipo da Variแvel (1)
TamSx3("A1_LOJA")[1],;							// 07-Tamanho da Variแvel (2)
TamSx3("A1_LOJA")[2],;							// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressใo de Valida็ใo da Variแvel (60)
"",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR06",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Informe o c๓digo final da loja do client",;
"e                                       ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o c๓digo final da loja do client",;
"e                                       ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o c๓digo final da loja do client",;
"e                                       ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

/*
aAdd( alAux, {	"07",;		  									// 01-Ordem da Pergunta (2)
"Do vendedor",;						  				// 02-Descri็ใo em Portugues (30)
"Do vendedor",;				  						// 03-Descri็ใo em Espanhol (30)
"Do vendedor",;				  						// 04-Descri็ใo em Ingles (30)
"mv_ch7",;							  			// 05-Nome da Variแvel (6)
"C",;											// 06-Tipo da Variแvel (1)
TamSx3("A3_COD")[1],;							// 07-Tamanho da Variแvel (2)
TamSx3("A3_COD")[2],;							// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressใo de Valida็ใo da Variแvel (60)
"SA3",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR07",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Informe o c๓digo inicial do vendedor    ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o c๓digo inicial do vendedor    ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o c๓digo inicial do vendedor    ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"08",;		  									// 01-Ordem da Pergunta (2)
"At้ o vendedor",;						  		// 02-Descri็ใo em Portugues (30)
"At้ o vendedor",;				  				// 03-Descri็ใo em Espanhol (30)
"At้ o vendedor",;				  				// 04-Descri็ใo em Ingles (30)
"mv_ch8",;							  			// 05-Nome da Variแvel (6)
"C",;											// 06-Tipo da Variแvel (1)
TamSx3("A3_COD")[1],;							// 07-Tamanho da Variแvel (2)
TamSx3("A3_COD")[2],;							// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressใo de Valida็ใo da Variแvel (60)
"SA3",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR08",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Informe o c๓digo final do vendedor      ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o c๓digo final do vendedor      ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o c๓digo final do vendedor      ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

*/
aAdd( alAux, {	"07",;							// 01-Ordem da Pergunta (2)
"Do Grupo Cliente",;					  		// 02-Descri็ใo em Portugues (30)
"Do Grupo Cliente",;			  				// 03-Descri็ใo em Espanhol (30)
"Do Grupo Cliente",;			  				// 04-Descri็ใo em Ingles (30)
"mv_ch7",;							  			// 05-Nome da Variแvel (6)
"C",;											// 06-Tipo da Variแvel (1)
TamSx3("A1_GRPVEN")[1],;						// 07-Tamanho da Variแvel (2)
TamSx3("A1_GRPVEN")[2],;						// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"Empty(MV_PAR03).and.Empty(MV_PAR05) .or. VAZIO()",;			// 11-Expressใo de Valida็ใo da Variแvel (60)
"ACY",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR07",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Informe o c๓digo incial do Grupo Cliente",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o c๓digo incial do Grupo Cliente",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o c๓digo incial do Grupo Cliente",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"08",;							// 01-Ordem da Pergunta (2)
"At้ Grupo Cliente",;					  		// 02-Descri็ใo em Portugues (30)
"At้ Grupo Cliente",;				  			// 03-Descri็ใo em Espanhol (30)
"At้ Grupo Cliente",;				  			// 04-Descri็ใo em Ingles (30)
"mv_ch8",;							  			// 05-Nome da Variแvel (6)
"C",;											// 06-Tipo da Variแvel (1)
TamSx3("A1_GRPVEN")[1],;						// 07-Tamanho da Variแvel (2)
TamSx3("A1_GRPVEN")[2],;						// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"Empty(MV_PAR03).and.Empty(MV_PAR05) .or. VAZIO()",;			// 11-Expressใo de Valida็ใo da Variแvel (60)
"ACY",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR08",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Informe o c๓digo final do Grupo Cliente",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o c๓digo final do Grupo Cliente",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o c๓digo final do Grupo Cliente",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

U_MyNewX1( { clPerg, aClone( alAux ) } )

RestArea( alAreaAtu )

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetP04NextบAutor  ณHermes Ferreira     บ Data ณ  11/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o proximo numero para cadastro (Substitui SXE e SXF)บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNc Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GetP04Next()

	Local cRet := Strzero(1,TamSx3("P04_CODIGO")[1])
	Local cSql := ""
	Local cAlias := GetNextAlias()
	
	cSql := " SELECT "
	cSql += " MAX(P04_CODIGO) CODIGO "
	cSql += " FROM "+RetSqlName("P04")+ " P04 "
	cSql += " WHERE P04.P04_FILIAL = '"+xFilial("P04")+"'"
	cSql += " AND P04.D_E_L_E_T_= ' ' "
	TcQuery cSql New Alias &(cAlias)	

	(cAlias)->(dbGoTop())
	
	If (cAlias)->(!Eof()) .and. (cAlias)->(!Bof())
		cRet := Soma1((cAlias)->CODIGO)
	EndIf
	
	(cAlias)->(dbCloseArea())
	
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFPR1DELAPUบAutor  ณHermes Ferreira     บ Data ณ  28/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina deleta a ultima apura็ใo e limpa as notas de entrada บฑฑ
ฑฑบ			 ณe saida que foram marcadas na ultima apura็ใo 			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNc Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FPR1DELAPU(cCodApu,cVersao,lRet)

	Local cSql 	:= ""
	//Local lRet	:= .T.

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	
	// Limpa as Notas de Saida
	
	cSql := " UPDATE " +RetSqlName("SF2")
	cSql += " SET F2_YAPURAC = ' ', F2_YVERAPU = ' '"
	//cSql += " WHERE F2_FILIAL = '"+xFilial("SF2")+"'"
	cSql += " WHERE F2_FILIAL BETWEEN '  ' AND 'ZZ' "
	cSql += " AND F2_YAPURAC = '"+cCodApu+"'"
	cSql += " AND F2_YVERAPU = '"+cVersao+"'"
	cSql += " AND D_E_L_E_T_ <> '*'"
	
	If TcSQLExec( cSql ) < 0
		Aviso("NCGPR101 - 08","Ocorreu um erro, e nใo foi possํvel limpar as notas de saํda que estavam marcadas que foram utilizadas nessa apura็ใo.",{"Ok"},3)
		lRet	:= .F.
	Else
		TcSQLExec( "COMMIT" )
	EndIf
	
	// Limpa as Notas de Entrada
	cSql := " UPDATE " +RetSqlName("SF1")
	cSql += " SET F1_YAPURAC = ' ', F1_YVERAPU = ' '"
	//cSql += " WHERE F1_FILIAL = '"+xFilial("SF1")+"'"
	cSql += " WHERE F1_FILIAL BETWEEN '  ' AND 'ZZ' "
	cSql += " AND F1_YAPURAC = '"+cCodApu+"'"
	cSql += " AND F1_YVERAPU = '"+cVersao+"'"
	cSql += " AND D_E_L_E_T_ <> '*'"
	
	If TcSQLExec( cSql ) < 0
		Aviso("NCGPR101 - 09","Ocorreu um erro, e nใo foi possํvel limpar as notas de entrada de devolu็ใo que estavam marcadas que foram utilizadas nessa apura็ใo.",{"Ok"},3)
		lRet	:= .F.
	Else
		TcSQLExec( "COMMIT" )
	EndIf
		
	// Apaga a ultima apura็ใo
	cSql := " UPDATE "+RetSqlName("P04") 
	cSql += " SET D_E_L_E_T_ = '*'"
	cSql += " WHERE P04_FILIAL = '"+xFilial("P04")+"'"
	cSql += " AND P04_CODIGO = '"+cCodApu+"'"
	cSql += " AND P04_VERSAO = '"+cVersao+"'"
	cSql += " AND D_E_L_E_T_ <> '*'"
	
	If TcSQLExec( cSql ) < 0
		Aviso("NCGPR101 - 10","Ocorreu um erro, e nใo foi possํvel deletar a apura็ใo anterior.",{"Ok"},3)
		lRet	:= .F.
	Else
		TcSQLExec( "COMMIT" )
	EndIf	

	// Apaga o Ultimo Fechamento da apura็ใo
	cSql := " UPDATE "+RetSqlName("P0E") 
	cSql += " SET D_E_L_E_T_ = '*'"
	cSql += " WHERE P0E_FILIAL = '"+xFilial("P0E")+"'"
	cSql += " AND P0E_CODAPU = '"+cCodApu+"'"
	cSql += " AND P0E_VERAPU = '"+cVersao+"'"
	cSql += " AND D_E_L_E_T_ <> '*'"
	
	If TcSQLExec( cSql ) < 0
		Aviso("NCGPR101 - 11","Ocorreu um erro, e nใo foi possํvel deletar o fechamanto da apura็ใo.",{"Ok"},3)
		lRet	:= .F.
	Else
		TcSQLExec( "COMMIT" )
	EndIf	
	
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFhechaApurบAutor  ณHermes Ferreira     บ Data ณ  28/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณApresenta a tela para confirmar o Fechamento da aprua็ใo    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FhechaApur()
	
	Local nPosCodApu:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_CODIGO"})
	Local nPosVersao:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_VERSAO"})
	Local nPosDescr:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_DESC"})
	Local nPosDtFecha:= aScan(apHeadP04,{|x| AllTrim(x[2])=="P04_FECHAM"})

	Local cCodApu	:= ""
	Local cVersao	:= ""
	Local cDescrAp	:= ""
	Local dDtFecha	:= CtoD("  /  /  ")

	Local olLayer		:= FWLayer():New()
	Local alCoord		:= MsAdvSize(.F.,.F.,0)
	Local olDlg			:= Nil


	Local olDlgFec		:= Nil
	Local oEncFec		:= Nil
	Local alPosCab		:= {0,0,0,0}

	Private aTela[0][0]
	Private aGets[0]
		
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	cCodApu	:= opGridP04:aCols[opGridP04:NAT,nPosCodApu]
	cVersao	:= opGridP04:aCols[opGridP04:NAT,nPosVersao]
	dDtFecha:= opGridP04:aCols[opGridP04:NAT,nPosDtFecha]
	cDescrAp:= Alltrim(opGridP04:aCols[opGridP04:NAT,nPosDescr])
	
	If Empty(dDtFecha)
		
		If Aviso("NCGPR101 - 12","Confirma o fechamento da Apura็ใo: "+cCodApu +" - "+ cDescrAp +" ?"+clr+"Ap๓s o fechamento, a mesma nใo poderแ mais ser reprocessada.",{"Sim","Nใo"},3) == 1
		
			dbSelectArea("P0E")
			P0E->(dbSetOrder(1))
			
			RegToMemory("P0E", .T.,.T.,.T.)
			
			olDlg := TDialog():New(alCoord[1],alCoord[2],alCoord[6]*0.65,alCoord[5]*0.75,"Fechamento de Apura็ใo",,,,,CLR_BLACK,CLR_WHITE,,,.T.)
		
			olLayer:Init(olDlg,.F.)
		
			olLayer:AddCollumn("CENTRAL",100,.F.)
		
			olLayer:AddWindow("CENTRAL","CABEC"		,"Fechamento de Apura็ใo"				,100,.T.,.T.,{||},,{||})
		
			olDlgFec	:= olLayer:GetWinPanel("CENTRAL","CABEC")
			
			M->P0E_CODAPU	:= cCodApu
			M->P0E_VERAPU	:= cVersao
			M->P0E_DTFECH	:= MsDate()
			M->P0E_USER		:= __cUserId
			M->P0E_NOMUSE	:= cUserName
			
			oEncFec	:= MSMGet():New("P0E",,3,,,,,alPosCab,,,,,,olDlgFec ,,,,,,,,,)
	
			oEncFec:oBox:Align := CONTROL_ALIGN_ALLCLIENT	
		
			Activate Msdialog olDlg Centered On Init EnchoiceBar(olDlg,;
																	 {|| IIF( Obrigatorio(aGets,aTela) , ( FGrvFecha(MsAuto2Ench("P0E"),cCodApu,cVersao) , olDlg:End() ) , .F.  )    },;
																	 {|| olDlg:End() };
																	 ,,)
	
		
		EndIf
	
	Else
	
		Aviso("NCGPR101 - 13","Essa apura็ใo jแ foi encerrada.",{"Ok"},3)
		
	EndIf
	
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFGrvFecha บAutor  ณHermes Ferreira     บ Data ณ  28/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para gravar o fechamento da Apura็ใo                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FGrvFecha(aAutoCab,cCodApu,cVersao)
	Local nA
	Local lGrv := .F.
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	
	If P0E->(RecLock("P0E",.T.))
	
		For nA := 1 to Len(aAutoCab)
		
			If "FILIAL" $ aAutoCab[nA,1]
	
				P0E->(FieldPut(FieldPos(aAutoCab[nA][1]),xFilial("P0E")))	
				
			Else
				
				P0E->(FieldPut(FieldPos(aAutoCab[nA][1]),aAutoCab[nA][2]))
	
			EndIf
			
	    Next nA
	    
	    lGrv := .T.
	    
		cMemoObs := M->P0E_OBS

		P0E->(MSMM(,,, cMemoObs ,1,,,"P0E","P0E_CODOBS","SYP"))
		P0E->(MsUnlock())

	EndIf
	
	If lGrv
	
		// Atualiza Parametro de Controle de Apura็ใo
		DbSelectArea('SX6')
		DbSetOrder(1)
		
		lRecLock := MsSeek( Space( Len( X6_FIL ) ) + Padr( "NCG_000028", Len( X6_VAR ) ) )
		
		If lRecLock
		
			RecLock( "SX6", .F. )
			
			SX6->X6_CONTEUD:= DtoS(MsDate())
			SX6->X6_CONTSPA:= DtoS(MsDate())
			SX6->X6_CONTENG:= DtoS(MsDate())
		
			MsUnlock()
		
		EndIf
				
		// Atualiza Registros Apurados:
		dbSelectArea("P04")
		P04->(dbSetOrder(1))
		P04->(dbGoTop())
		If P04->(dbSeek(xFilial("P04")+cCodApu+cVersao))
			
			While P04->(!Eof()) .AND. P04->(P04_CODIGO+P04_VERSAO) == cCodApu+cVersao
			
				If P04->(RecLock("P04",.F.))
					
					P04->P04_FECHAM := MsDate()
					P04->P04_STATUS := "2"
					
					P04->(MsUnLock())
				EndIf
				
				P04->(dbSkip())
			EndDo
			
		EndIf
		
	EndIf
	
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMySetClickบAutor  ณHermes Ferreira     บ Data ณ  28/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFun็ใo para exibir a legenda do farol da rotina             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MySetClick()
	
	Local aCor := {}
	
	aAdd(aCor,{"BR_AZUL"	,"Apura็ใo Aberta"   })
	aAdd(aCor,{"BR_VERMELHO","Apura็ใo Fechada"	 })

	BrwLegenda(,"Status",aCor)

Return
