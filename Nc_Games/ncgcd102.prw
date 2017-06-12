#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#define clr Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGCD102  บAutor  ณHermes Ferreira     บ Data ณ  03/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de Cadastro de VPC / Verba                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NCGCD102()

	Local aCores		:= {}
	Private aRotina		:= MenuDef()
	Private cCadastro	:= "Cadastro VPC/Verba"
	Private cTpCadVPC	:= 	""

	aCores := {	 {"P01->P01_STATUS == '1' "	,"BR_VERDE"   	};
				,{"P01->P01_STATUS == '2' "	,"BR_VERMELHO"	}}

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	Begin Sequence

		dbSelectArea("P01")
		P01->(dbSetOrder(1))

		dbSelectArea("P02")
		P02->(dbSetOrder(1))

		mBrowse( 6, 1,22,75,'P01',,,,,,aCores,,,,,,,,)

	End Sequence

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMenuDef   บAutor  ณHermes Ferreira     บ Data ณ  03/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMenu da rotina de cadastro                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MenuDef()

	Local aRotina := {}

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	AADD(aRotina,{"Pesquisar"	,"PesqBrw"		,0,1})
	AADD(aRotina,{"Visualizar"	,"u_AxCad002"	,0,2})
	AADD(aRotina,{"Incluir"		,"u_AxCad002"	,0,3})
	AADD(aRotina,{"Alterar"		,"u_AxCad002"	,0,4})
	AADD(aRotina,{"Excluir"		,"u_AxCad002"	,0,5})
	AADD(aRotina,{"Legenda"		,"U_NCLegd02"	,0,6})
	AADD(aRotina,{"Aprovador 1"	,"U_CD02APRV(1)",0,7})
	AADD(aRotina,{"Aprovador 2"	,"U_CD02APRV(2)",0,7})
	AADD(aRotina,{"Aprovador 3"	,"U_CD02APRV(3)",0,7})
	AADD(aRotina,{"Motivo Reprova","U_CD02MTRP"	,0,7})
	AADD(aRotina,{"Leg. Aprov."	,"U_NCLegAP2"	,0,6})


Return aRotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCLegd02  บAutor  ณHermes Ferreira     บ Data ณ  03/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLegenda do Browse                                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCLegd02()

	Local aCor := {}

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	aAdd(aCor,{"BR_VERDE"	,"Ativo"   		})
	//aAdd(aCor,{"BR_LARANJA"	,"Suspenso" 	})
	aAdd(aCor,{"BR_VERMELHO","Encerrado" 	})

	BrwLegenda(,"Status",aCor)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAxCad002  บAutor  ณHermes Ferreira     บ Data ณ  03/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFun็ใo auxiliar para o Cadastro. Antes de incluir um novo   บฑฑ
ฑฑบ          ณregistro, verifica o tipo de cadastro VPC ou Verba          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function AxCad002(clAlias,nlReg,nlOpcx)

	Local nOpcTp	:= 1
	Local llOk		:= .T.

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	If nlOpcx == 3

		nOpcTp := Aviso("NCGCD102 - 01","Qual o tipo do registro:"+clr+"1-Acordo e Contratos(VPC)"+clr+"2-Verba Extra",{"1","2"},3)

 	Else

	 	nOpcTp :=	Val(P01->P01_TPCAD )

 	EndIf

 	If nlOpcx == 4
 		llOk := FVdlAlt(IIf(nOpcTp==1,"1","2"))
 	EndIf

 	If llOk

		cTpCadVPC := IIf(nOpcTp==1,"1","2")	
	 	Proces02(clAlias,nlReg,nlOpcx,IIf(nOpcTp==1,"1","2"))
	 	
 	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณProces02  บAutor  ณHermes Ferreira     บ Data ณ  03/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณProcessamento para o cadastro, Apresenta a tela de inclusใo/บฑฑ
ฑฑบ          ณaltera็ใo/exclusใo                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Proces02(clAlias,nlReg,nOpc,cTipo)


	Local oFont01   	:=TFont():New( "Courier New",,20,,.F.,,,20,,,,,,,,)
	Local cTitulo		:= "Tela de cadastro de "+IIf(cTipo == "1", "VPC","Verba")+"."
	Local alPosCab		:= {}
	Local alPosTot		:= {}
	Local nlResoluc		:= oMainWnd:nClientWidth
	Local alCoord		:= MsAdvSize(.T.,.F.,0)
	Local aButtons		:= {}
	Local aCamposV		:= {}
	Local aCamposTot	:= {}
	Local alCmpAlt		:= {}
	Local nOpcNewGD 	:= Iif(nOpc==2 .Or. nOpc==5,1,GD_INSERT+GD_UPDATE+GD_DELETE)
	Local alPrcPrinc	:= {0,0,0}
	Local alPrc			:= {0}
	Local odlgCab		:= Nil
	Local odlgIte		:= Nil
	Local oEncCab		:= Nil

	Default cTipo		:= "1"

	Private aTela[0][0]
	Private aGets[0]

	Private opOdlg		:= Nil
	Private odlgTot		:= Nil
	Private oEncTot
	Private nTotPerc	:= 0
	Private opLayer		:= FWLayer():New()
	Private opGridP02	:= Nil
	Private apHeadP02	:= {}
	Private apColsP02	:= {}
	Private oSayTot		:= Nil
	Private oSayNTot	:= Nil

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	If nlResoluc <= 800

		alPrcPrinc 		:= {045,035,020}
		alPrc			:= {100}

	ElseIf nlResoluc >= 1024 .And. nlResoluc < 1280

		alPrcPrinc 		:= {045,035,020}
		alPrc			:= {100}

	ElseIf nlResoluc >= 1280 .And. nlResoluc < 1300

		alPrcPrinc 		:= {045,035,020}
		alPrc			:= {100}

	ElseIf 	nlResoluc >= 1300

		alPrcPrinc 		:= {045,035,020}
		alPrc			:= {100}

	EndIf

	// Campos que serใo exibidos a Enchoice
	dbSelectArea("SX3")
	SX3->(DbSetOrder(1))
	If SX3->(dbSeek("P01"))
		While SX3->(!Eof()) .AND. SX3->X3_ARQUIVO == "P01"
			If !(Alltrim(SX3->X3_CAMPO) $ "P01_FILIAL/P01_TPCAD/P01_CODOBS/P01_TOTPER/P01_TOTVAL/P01_TOTCON") .and. X3USO(X3_USADO)

				If (cTpCadVPC == "1" .and. (Alltrim(SX3->X3_CAMPO) $ "P01_FILPED/P01_PEDVEN"))
					SX3->(dbSkip())
					Loop
				EndIf
				AADD(aCamposV,SX3->X3_CAMPO)

			EndIf
			SX3->(dbSkip())
		EndDo
	EndIf
	//AADD(aCamposV,"P01_OBS") // For็ar para sempre ser o ultimo campo da tela
	AADD(aCamposV,"NOUSER")
	
	If cTpCadVPC == "1"
		AADD(aCamposTot,"P01_TOTPER")
	Else
		AADD(aCamposTot,"P01_TOTVAL")
		AADD(aCamposTot,"P01_TOTCON")
	EndIf
	AADD(aCamposTot,"NOUSER")


	AADD(alCmpAlt,"P02_CODTP")
	If cTpCadVPC == "1"
		AADD(alCmpAlt,"P02_PERCEN")
	Else
		AADD(alCmpAlt,"P02_VALOR")
	EndIf
	//AADD(alCmpAlt,"P02_ATIVO")

	// Monta Header do Grid
	FHeadP02(nOpc)

	// Monta Acols carregado para visualiza็ใo,altera็ใo,exclusใo
	If nOpc <> 3
		FColsP02()
	EndIf

	opOdlg := TDialog():New(alCoord[1],alCoord[2],alCoord[6],alCoord[5],cTitulo,,,,,CLR_BLACK,CLR_WHITE,,,.T.)

		opLayer:Init(opOdlg,.F.)

		opLayer:AddCollumn("CENTRO"	,alPrc[1],.F.)

		opLayer:AddWindow("CENTRO","CABEC"					,IIf(cTpCadVPC == "1", "VPC","Verba")	,alPrcPrinc[1],.T.,.T.,{||},,{||})
		opLayer:AddWindow("CENTRO","ITENS"					,"Itens"			   		   			,alPrcPrinc[2],.T.,.T.,{||},,{||})
		opLayer:AddWindow("CENTRO","TOTAL"					,"Total"			   		 			,alPrcPrinc[3],.T.,.T.,{||},,{||})

		odlgCab	:= opLayer:GetWinPanel("CENTRO","CABEC")
		odlgIte	:= opLayer:GetWinPanel("CENTRO","ITENS")
		odlgTot	:= opLayer:GetWinPanel("CENTRO","TOTAL")

		alPosCab	:= {0,0,0,0} 

		RegToMemory("P01", nOpc == 3,.T.,.T.)

		If nOpc == 3

			M->P01_VERSAO	:= "01"
			M->P01_HORA		:= Time()
			M->P01_DTCRIA	:= dDatabase
			M->P01_TPVPC	:=cTipo

		ElseIf nOpc == 4

			If P01->P01_STSAPR == "1"
			
				M->P01_VERSAO := Soma1(P01->P01_VERSAO)
				M->P01_DTCRIA := dDatabase
				
				If cTpCadVPC == "1"
					M->P01_DTVINI := dDatabase
				EndIf
				
			EndIf

		EndIf

		If nOpc <> 3
			M->P01_OBS		:= MSMM(P01->P01_CODOBS,,,,3)
		EndIf


		oEncCab:= 	MSMGet():New("P01",,nOpc,,,,aCamposV,alPosCab,,,,,,odlgCab,,,,,,,,,,,,.T.)
		oEncCab:oBox:Align := CONTROL_ALIGN_ALLCLIENT

		opGridP02:= MsNewGetDados():New(000,000,000,000,nOpcNewGD,"U_NCD02LOK()","U_NCD02TOK()",,alCmpAlt,,9999,,,,odlgIte,apHeadP02,apColsP02)
		opGridP02:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
		opGridP02:BDELOK := { |x| U_NCD02DEL() }

		alPosTot:= {0,0,0,0}

		oEncTot:= MSMGet():New("P01",,nOpc,,,,aCamposTot,alPosTot,,Nil,Nil,Nil,Nil,odlgTot,.F.,.F.,Nil,Nil,Nil,.T.,Nil,Nil,Nil)
		oEncTot:oBox:Align := CONTROL_ALIGN_ALLCLIENT

	Activate Msdialog opOdlg Centered On Init EnchoiceBar(opOdlg,;
																 {|| IIF (Iif(nOpc==3 .Or. nOpc==4,Obrigatorio(aGets,aTela),.T.),(  IIF( FVldVPC(nOpc),(U_FGRVCD02(nOpc,MsAuto2Ench("P01"),MsAuto2Gd(apHeadP02,opGridP02:aCols)),opOdlg:End()),Nil ) ),Nil)   },;
																 {|| /*IIF(nOpc==3,P02->(RollBackSX8()),Nil),*/opOdlg:End() };
																 ,,aButtons)

	MBRCHGLOOP(.F.)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFVldVPC   บAutor  ณHermes Ferreira     บ Data ณ  03/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida็ใo antes da inclusใo/Altera็ใo/Exlcusใo.            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FVldVPC(nOpc)

	Local cQry 		:= ""
	Local clAlias 	:= ""
	Local llRet		:= .T.

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	//Um VPC novo s๓ poderแ ser criado caso nใo exista nenhum outro VPC cadastrado para o mesmo:
	//grupo, c๓digo ou loja do cliente no mesmo perํodo de vig๊ncia.
	If nOpc == 3
	
		If cTpCadVPC == "1"

			clAlias 	:= GetNextAlias()

			cQry := " SELECT "		+ clr
			cQry += " P01_GRPCLI "	+ clr
			cQry += " ,P01_CODCLI "	+ clr
			cQry += " ,P01_LOJCLI "	+ clr
			cQry += " ,P01_DTVINI "	+ clr
			cQry += " ,P01_DTVFIM "	+ clr

			cQry += " FROM " +RetSqlName("P01")+ " P01 "						+ clr
			cQry += " WHERE P01.P01_FILIAL = '"	+xFilial("P01")+"'"				+ clr
			If !Empty(M->P01_GRPCLI)
				cQry += " AND P01.P01_GRPCLI = '"	+M->P01_GRPCLI+"'"			+ clr
			ElseIf !Empty(M->P01_CODCLI) .and. !Empty(M->P01_LOJCLI)
				cQry += " AND P01.P01_CODCLI = '"	+M->P01_CODCLI+"'"			+ clr
				cQry += " AND P01.P01_LOJCLI = '"	+M->P01_LOJCLI+"'"			+ clr
			Else
				cQry += " AND P01.P01_CODCLI = '"	+M->P01_CODCLI+"'"			+ clr
			EndIf

			cQry += " AND ( '"+DtoS(M->P01_DTVINI)+ "' BETWEEN P01.P01_DTVINI AND P01.P01_DTVFIM "	+ clr
			cQry += " OR   '"+DtoS(M->P01_DTVFIM)+ "' BETWEEN P01.P01_DTVINI AND P01.P01_DTVFIM "	+ clr
			cQry += " 	   )"													+ clr
			
			cQry += " AND P01.P01_TPCAD ='"+cTpCadVPC+"'"						+ clr
			cQry += " AND P01.P01_REPASS ='"+M->P01_REPASS+"'"					+ clr
			cQry += " AND P01.P01_STATUS = '1'"									+ clr
			cQry += " AND P01.P01_STSAPR = '1'"									+ clr
			cQry += " AND P01.D_E_L_E_T_= ' '"									+ clr

			TcQuery cQry New Alias &(clAlias)
			TCSetField((clAlias),"P01_DTVINI"	,"D",TamSx3("P01_DTVINI")[1],TamSx3("P01_DTVINI")[2]	)
			TCSetField((clAlias),"P01_DTVFIM"	,"D",TamSx3("P01_DTVFIM")[1],TamSx3("P01_DTVFIM")[2]	)

			(clAlias)->(DbGoTop())

			If (clAlias)->(!Eof()) .AND. (clAlias)->(!Bof())
				llRet := .F.
				Aviso("NCGCD102 - 02","Jแ existe um cadastro de "+IIF(cTpCadVPC=="1","VPC","Verba")+" para o Grupo de Cliente ou Cliente e repasse no perํodo informado.",{"Ok"},3)
			EndIf

			(clAlias)->(dbCloseArea())

        ElseIf cTpCadVPC == "2"
        
            If Empty(M->P01_LOJCLI)
	            
	            llRet := .F.
	            Aviso("NCGCD102 - 24","Para contratos de verba extra, ้ obrigatorio informar a Loja do Cliente.",{"Ok"},3)
	            
            EndIf
            
        EndIf
	EndIf
	
	If llRet
	
		If nOpc == 3 .or. nOpc == 4
		
            If cTpCadVPC == "2"
	
				clAlias 	:= GetNextAlias()
	
				cQry := " SELECT "		+ clr
				cQry += " P01_CODCLI "	+ clr
				cQry += " ,P01_LOJCLI "	+ clr
				cQry += " ,P01_DTVINI "	+ clr
				cQry += " ,P01_DTVFIM "	+ clr
	
				cQry += " FROM " +RetSqlName("P01")+ " P01 "					+ clr
				cQry += " WHERE P01.P01_FILIAL = '"	+xFilial("P01")+"'"			+ clr

				cQry += " AND P01.P01_CODCLI = '"	+M->P01_CODCLI+"'"			+ clr
				cQry += " AND P01.P01_LOJCLI = '"	+M->P01_LOJCLI+"'"			+ clr
				
				cQry += " AND P01.P01_FILPED = '"	+M->P01_FILPED+"'"			+ clr
				cQry += " AND P01.P01_PEDVEN = '"	+M->P01_PEDVEN+"'"			+ clr
	
				cQry += " AND P01.P01_TPCAD ='"+cTpCadVPC+"'"						+ clr
				cQry += " AND P01.P01_STATUS = '1'"									+ clr
				cQry += " AND P01.P01_REPASS ='"+M->P01_REPASS+"'"					+ clr
				cQry += " AND P01.P01_CODIGO || P01.P01_VERSAO <> '"+M->P01_CODIGO+M->P01_VERSAO+"'"	+ clr
				cQry += " AND P01.D_E_L_E_T_= ' '"									+ clr
	
				TcQuery cQry New Alias &(clAlias)
				TCSetField((clAlias),"P01_DTVINI"	,"D",TamSx3("P01_DTVINI")[1],TamSx3("P01_DTVINI")[2]	)
				TCSetField((clAlias),"P01_DTVFIM"	,"D",TamSx3("P01_DTVFIM")[1],TamSx3("P01_DTVFIM")[2]	)
	
				(clAlias)->(DbGoTop())
	
				If (clAlias)->(!Eof()) .AND. (clAlias)->(!Bof())
					llRet := .F.
					
					If !Empty(M->P01_FILPED) .OR. !Empty(M->P01_PEDVEN)
						Aviso("NCGCD102 - 25","Jแ existe um cadastro de Verba para Cliente+Loja+Pedido de Venda e repasse no perํodo informado.",{"Ok"},3)
					Else
						Aviso("NCGCD102 - 26","Jแ existe um cadastro de Verba para Cliente+Loja e repasse no perํodo informado.",{"Ok"},3)
					EndIf
				EndIf
	
				(clAlias)->(dbCloseArea())
            	
            EndIf
            
			If llRet
				llRet := U_NCD02TOK()
			EndIf
			
		EndIf
		
	EndIf

	If nOpc == 5

		If cTpCadVPC == "1"

			// Verifica se jแ foi realizada apura็ใo com o VPC e versใo

			clAlias 	:= GetNextAlias()

			cQry := " SELECT "					+ clr
			cQry += " P04_CODIGO"				+ clr
			cQry += " ,P04_CODVPC"				+ clr
			cQry += " FROM " +RetSqlName("P04")+ " P04 "			+ clr
			cQry += " WHERE P04.P04_FILIAL = '"+xFilial("P04")+"'"	+ clr
			cQry += " AND P04.P04_CODVPC = '"+P01->P01_CODIGO+"'"	+ clr
			cQry += " AND P04.P04_VERVPC = '"+P01->P01_VERSAO+"'"	+ clr
			cQry += " AND P04.D_E_L_E_T_= ' '"	+ clr

			
			//MsgRun("Consultando se o registro pode ser excluido","Aguarde...", {|| TcQuery cQry New Alias &(clAlias)  } )
			MsgRun("Consultando se o registro pode ser excluido","Aguarde...", {|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),clAlias, .F., .F.)    } )

			(clAlias)->(dbGoTop())

			If (clAlias)->(!Eof()) .and. (clAlias)->(!Bof())
				llRet := .F.
				Aviso("NCGCD102 - 10","Jแ existe movimenta็ใo na APURAวรO relacionado a esse VPC, e por isso nใo poderแ ser excluํdo.",{"Ok"},3)
			EndIf

			(clAlias)->(dbCloseArea())



			// Verifica se o VPC jแ foi utilizado no Pedido de Venda

			clAlias 	:= GetNextAlias()

			cQry := " SELECT " 										+ clr
			cQry += " C5_YCODVPC "									+ clr
			cQry += " FROM " +RetSqlName("SC5")+ " SC5 "			+ clr
			cQry += " WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"'"	+ clr
			cQry += " AND SC5.C5_YCODVPC = '"+P01->P01_CODIGO+"'"	+ clr
			cQry += " AND SC5.C5_YVERVPC = '"+P01->P01_VERSAO+"'"	+ clr
			cQry += " AND SC5.D_E_L_E_T_= ' '"						+ clr

			MsgRun("Consultando se o registro pode ser excluido","Aguarde...",{|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),clAlias, .F., .F.)  })

			(clAlias)->(dbGoTop())

			If (clAlias)->(!Eof()) .and. (clAlias)->(!Bof())
				llRet := .F.
				Aviso("NCGCD102 - 11","Jแ existe movimenta็ใo em Pedido de Venda relacionado a esse VPC, e por isso nใo poderแ ser excluํdo.",{"Ok"},3)
			EndIf

			(clAlias)->(dbCloseArea())


			// Verifica se o VPC ja foi utilizado para titulo NCC
            /*
			clAlias 	:= GetNextAlias()

			cQry := " SELECT "										+ clr
			cQry += " E1_YVPC "										+ clr
			cQry += " FROM " +RetSqlName("SE1")+ " SE1 "	  		+ clr
			cQry += " WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"'"	+ clr
			cQry += " AND SE1.E1_YVPC = '"+P01->P01_CODIGO+"'" 		+ clr
			cQry += " AND SE1.E1_YVERVPC = '"+P01->P01_VERSAO+"'"	+ clr
			cQry += " AND SE1.D_E_L_E_T_= ' '"						+ clr

			
			MsgRun("Consultando se o registro pode ser excluido","Aguarde...",{|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),clAlias, .F., .F.)  })
			
			(clAlias)->(dbGoTop())

			If (clAlias)->(!Eof()) .and. (clAlias)->(!Bof())
				llRet := .F.
				Aviso("NCGCD102 - 12","Jแ existe movimenta็ใo nos Tํtulos Financeiro (NCC) relacionado a esse VPC, e por isso nใo poderแ ser excluํdo.",{"Ok"},3)
			EndIf

			(clAlias)->(dbCloseArea())
             */

		Else

			// Verifica se foi utilizado no tํtulo a pagar
			clAlias 	:= GetNextAlias()

			cQry := " SELECT "										+ clr
			cQry += " E2_YVPC "										+ clr
			cQry += " FROM " +RetSqlName("SE2")+ " SE2 "	  		+ clr
			cQry += " WHERE SE2.E2_FILIAL = '"+xFilial("SE2")+"'"	+ clr
			cQry += " AND SE2.E2_YVPC = '"+P01->P01_CODIGO+"'" 		+ clr
			cQry += " AND SE2.E2_YVERVPC = '"+P01->P01_VERSAO+"'"	+ clr
			cQry += " AND SE2.D_E_L_E_T_= ' '"						+ clr

			
			MsgRun("Consultando se o registro pode ser excluido","Aguarde...",{|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),clAlias, .F., .F.) })
			(clAlias)->(dbGoTop())

			If (clAlias)->(!Eof()) .and. (clAlias)->(!Bof())
				llRet := .F.
				Aviso("NCGCD102 - 13","Jแ existe movimenta็ใo nos Tํtulos Financeiro (a Pagar) relacionado a essa Verba, e por isso nใo poderแ ser excluํdo.",{"Ok"},3)
			EndIf

			(clAlias)->(dbCloseArea())

			// Verifica se jแ foi utilizado no pedido de Venda
			clAlias 	:= GetNextAlias()

			cQry := " SELECT " 										+ clr
			cQry += " C5_YCODVPC "									+ clr
			cQry += " FROM " +RetSqlName("SC5")+ " SC5 "			+ clr
			cQry += " WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"'"	+ clr
			cQry += " AND SC5.C5_YCODVPC = '"+P01->P01_CODIGO+"'"	+ clr
			cQry += " AND SC5.C5_YVERVPC = '"+P01->P01_VERSAO+"'"	+ clr
			cQry += " AND SC5.D_E_L_E_T_= ' '"						+ clr

			
			MsgRun("Consultando se o registro pode ser excluido","Aguarde...",{|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),clAlias, .F., .F.) })
			(clAlias)->(dbGoTop())

			If (clAlias)->(!Eof()) .and. (clAlias)->(!Bof())
				llRet := .F.
				Aviso("NCGCD102 - 14","Jแ existe movimenta็ใo em Pedido de Vendas relacionado a essa Verba, e por isso nใo poderแ ser excluํdo.",{"Ok"},3)
			EndIf

			(clAlias)->(dbCloseArea())


		EndIf

	EndIf

Return llRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFGRVCD02  บAutor  ณHermes Ferreira     บ Data ณ  03/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava็ใo dos dados da tela, Inclusใo, altera็ใo, exclusใo   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณnOpcX     - 3=Inclusใo, 4=Altera็ใo, 5=Exclusao             บฑฑ
ฑฑบ          ณaAutoCab  - Cabe็alho (P01) do cadastro VPC                 บฑฑ
ฑฑบ          ณaAutoItens- Itens (P02)do VPC                               บฑฑ
ฑฑบ          ณllVerba   - Se for inclusใo automatica de verba,deve ser .T.บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FGRVCD02(nOpcX,aAutoCab,aAutoItens,llVerba)

	Local lNewRec	:= .F.
	Local llNewAlt	:= .F.
	Local clCodVPC	:= ""
	Local clVersao	:= ""
	Local cMemoObs	:= ""
	Local cCodAux	:= ""
	Local aHeadGrv	:= {}
	Local aColsGrv	:= {}
	Local aAreaP01Aux	:= {}
	Local nA,nJ,nX

	Default llVerba	:= .F.

	If llVerba
		cTpCadVPC	:= "2"
	EndIf

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	//Begin Transaction

	//Inicia Processo de Gravacao
	If nOpcX == 3 .Or. nOpcX == 4

		If nOpcX == 4
		
			If !Empty(P01->P01_STSAPR)
			
				FNewVer()
				nOpcX := 3
				llNewAlt := .T.
				
			EndIf
			
		EndIf
		
		//Grava cabecalho
		DbSelectArea("P01")
		lNewRec := (nOpcX==3)

		If RecLock( "P01", lNewRec)

			For nA := 1 to Len(aAutoCab)
				
				If "FILIAL" $ aAutoCab[nA,1]

					P01->(FieldPut(FieldPos(aAutoCab[nA][1]),xFilial("P01")))

				Else

					If aAutoCab[nA,1] $ "P01_CODIGO"
					    
						If nOpcX == 3 // Se for Inclusใo, tratamento no c๓digo
						
							cCodAux := aAutoCab[nA][2]
							P01->(dbSetOrder(1))
							
							lLoop := .T.
							
							aAreaP01Aux := P01->(GetArea())
							
							While lLoop
								
								If P01->(dbSeek(xFilial("P01")+ cCodAux  ))
									cCodAux:= Soma1(cCodAux)
								Else
									lLoop := .F.
								EndIf
								
								Loop
								
							EndDo
							
							RestArea(aAreaP01Aux)
							
							aAutoCab[nA][2] := cCodAux
						
						EndIf
						
						P01->(FieldPut(FieldPos(aAutoCab[nA][1]),aAutoCab[nA][2] ))
					
					ElseIf aAutoCab[nA,1] $ "P01_TOTPER/P01_TOTVAL"
					
						nValTot := aAutoCab[nA,2]
						nValTot:= IIF(ValType(nValTot)== "C",Val(nValTot),nValTot)
						P01->(FieldPut(FieldPos(aAutoCab[nA][1]),nValTot))

					Else

						P01->(FieldPut(FieldPos(aAutoCab[nA][1]),aAutoCab[nA][2]))

					EndIf

				EndIf
			Next nA

			P01->P01_TPCAD	:= cTpCadVPC
			P01->P01_DTORII	:= aAutoCab[aScan(aAutoCab,{|x| AllTrim(x[1])=="P01_DTVINI"}),2]
			P01->P01_DTORIF	:= aAutoCab[aScan(aAutoCab,{|x| AllTrim(x[1])=="P01_DTVFIM"}),2]
			P01->P01_STSAPR := ""
			P01->P01_APROV1 := ""
			P01->P01_DTAPR1 := cTod("  /  /  ")
			P01->P01_HRAPR1 := ""
			P01->P01_APROV2 := ""
			P01->P01_DTAPR2 := cTod("  /  /  ")
			P01->P01_HRAPR2 := ""
			P01->P01_APROV3 := ""
			P01->P01_DTAPR3 := cTod("  /  /  ")
			P01->P01_HRAPR3 := ""

			cMemoObs := M->P01_OBS

			P01->(MSMM(,,, cMemoObs ,1,,,"P01","P01_CODOBS","SYP"))
			
			P01->(MsUnlock())
			P01->(ConfirmSx8())
		EndIf

		If nOpcX == 3
			DbSelectArea("P02")

			For nX := 1 To Len(aAutoItens)
				If RecLock("P02",.T.)
					For nJ := 1 To Len(aAutoItens[nX])
						P02->(FieldPut(FieldPos(aAutoItens[nX][nJ][1]),aAutoItens[nX][nJ][2]))
					Next nJ

				    P02->P02_FILIAL	:= xFilial("P02")
				    P02->P02_TPCAD	:= cTpCadVPC
		    		P02->P02_CODVPC := aAutoCab[aScan(aAutoCab,{|x| AllTrim(x[1])=="P01_CODIGO"}),2]
		    		P02->P02_VERSAO := aAutoCab[aScan(aAutoCab,{|x| AllTrim(x[1])=="P01_VERSAO"}),2]
					P02->(MsUnlock())
				EndIf
			Next nX
		
		ElseIf nOpcX == 4
		
			clCodVPC := P01->P01_CODIGO
			clVersao := P01->P01_VERSAO

			DbSelectArea("P02")
			P02->(DbSetOrder(1))  //P02_FILIAL+P02_CODVPC+P02_VERSAO+P02_CODTP
			P02->(dbGoTop())
			If P02->(DbSeek(xFilial("P02")+clCodVPC+clVersao))
				While P02->(!Eof()) .And. Alltrim(P02->P02_CODVPC+P02->P02_VERSAO) == Alltrim(clCodVPC+clVersao)
					If RecLock("P02",.F.)
						P02->(DbDelete())
						P02->(MsUnLock())
					EndIf
					P02->(DbSkip())
				EndDo
			EndIf
					
			For nX := 1 To Len(aAutoItens)
				If RecLock("P02",.T.)
					For nJ := 1 To Len(aAutoItens[nX])
						P02->(FieldPut(FieldPos(aAutoItens[nX][nJ][1]),aAutoItens[nX][nJ][2]))
					Next nJ

				    P02->P02_FILIAL	:= xFilial("P02")
				    P02->P02_TPCAD	:= cTpCadVPC
		    		P02->P02_CODVPC := aAutoCab[aScan(aAutoCab,{|x| AllTrim(x[1])=="P01_CODIGO"}),2]
		    		P02->P02_VERSAO := aAutoCab[aScan(aAutoCab,{|x| AllTrim(x[1])=="P01_VERSAO"}),2]
					P02->(MsUnlock())
				EndIf
			Next nX
					
		EndIf

	ElseIf nOpcX == 5     //Exclusao

		clCodVPC := P01->P01_CODIGO
		clVersao := P01->P01_VERSAO
	    RecLock("P01",.F.)
		    P01->(DbDelete())
	    MsUnlock()

		DbSelectArea("P02")
		P02->(DbSetOrder(1))  //P02_FILIAL+P02_CODVPC+P02_VERSAO+P02_CODTP
		If P02->(DbSeek(xFilial("P02")+clCodVPC+clVersao))
			While P02->(!Eof()) .And. Alltrim(P02->P02_CODVPC+P02->P02_VERSAO) == Alltrim(clCodVPC+clVersao)
				If RecLock("P02",.F.)
					P02->(DbDelete())
					P02->(MsUnLock())
				EndIf
				P02->(DbSkip())
			EndDo
		EndIf

	EndIf

	//End Transaction

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFHeadP02  บAutor  ณHermes Ferreira     บ Data ณ  03/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta o Header para o grid de itens                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿

*/
Static Function FHeadP02(nOpc)
Local i
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	dbSelectArea("SX3")
	SX3->(DbSetOrder(1))
	If SX3->(dbSeek("P02"))
		While SX3->(!Eof()) .AND. SX3->X3_ARQUIVO == "P02"
			If !(Alltrim(SX3->X3_CAMPO) $ "P02_FILIAL/P02_CODVPC/P02_TPCAD") .and. X3USO(X3_USADO)

				If (cTpCadVPC == "1" .and. (Alltrim(SX3->X3_CAMPO) $ "P02_VALOR"))
					SX3->(dbSkip())
					Loop
				EndIf

				If (cTpCadVPC == "2" .and. (Alltrim(SX3->X3_CAMPO) $ "P02_PERCEN"))
					SX3->(dbSkip())
					Loop
				EndIf

				Aadd(apHeadP02,	{	Trim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,SX3->X3_DECIMAL,/*SX3->X3_VALID*/,;
				SX3->X3_USADO,SX3->X3_TIPO,	;
				SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,,SX3->X3_WHEN,	;
				SX3->X3_VISUAL,SX3->X3_VLDUSER, SX3->X3_PICTVAR,SX3->X3_OBRIGAT	})

			EndIf

			SX3->(dbSkip())
		EndDo

	EndIf

	if nOpc == 3

		AAdd(apColsP02,Array(Len(apHeadP02)+1))

		For i := 1 To Len(apHeadP02)

			apColsP02[Len(apColsP02)][i] := CriaVar(apHeadP02[i,2])

		Next i

		apColsP02[Len(apColsP02)][Len(apHeadP02)+1] := .F.

	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFColsP02  บAutor  ณHermes Ferreira     บ Data ณ  03/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta o aCols para o grid de itens                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FColsP02()

	Local cQry 		:= "",i
	Local clAlias 	:= GetNextAlias()
	Local nPosCod	:= aScan(apHeadP02,{|x| AllTrim(x[2])=="P02_CODTP"})

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	cQry := " SELECT "			+ clr
	cQry += " P02_CODTP "		+ clr
	If cTpCadVPC == "1"
		cQry += " ,P02_PERCEN "	+ clr
	Else
		cQry += " ,P02_VALOR "	+ clr
	EndIf
	//cQry += " ,P02_ATIVO "		+ clr
	cQry += " FROM " +RetSqlName("P02")+ " P02 "				+ clr
	cQry += " WHERE P02.P02_FILIAL = '"+xFilial("P02") +"'"		+ clr
	cQry += " AND P02.P02_CODVPC = '" + P01->P01_CODIGO + "'"	+ clr
	cQry += " AND P02.P02_VERSAO = '" + P01->P01_VERSAO + "'"	+ clr
	cQry += " AND P02.D_E_L_E_T_= ' '"							+ clr

	TcQuery cQry New Alias &(clAlias)
	If cTpCadVPC == "1"
		TCSetField((clAlias),"P02_PERCEN"	,"N",TamSx3("P02_PERCEN")[1],TamSx3("P02_PERCEN")[2]	)
	Else
		TCSetField((clAlias),"P02_VALOR"	,"N",TamSx3("P02_VALOR")[1]	,TamSx3("P02_VALOR")[2]		)
	EndIf

	(clAlias)->(dbGoTop())

	If (clAlias)->(!Eof())

		While (clAlias)->(!Eof())

			AAdd(apColsP02,Array(Len(apHeadP02)+1))

			For i := 1 To Len(apHeadP02)

				If Alltrim(apHeadP02[i,2]) <> "P02_DESCTP"

					apColsP02[Len(apColsP02)][i] := (clAlias)->(&(apHeadP02[i,2]))

				Else

					apColsP02[Len(apColsP02)][i] := Posicione("P00",1,xFilial("P00")+apColsP02[Len(apColsP02)][nPosCod],"P00_DESC")

				EndIf
			Next i

			apColsP02[Len(apColsP02)][Len(apHeadP02)+1] := .F.

			(clAlias)->(dbSkip())
		EndDo

	EndIf

	(clAlias)->(dbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCCD02TT  บAutor  ณMicrosiga           บ Data ณ  03/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao chamada pelo gatilho, para atualizar o totalizador    ฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCCD02TT()

	Local aAreaP02 	:= P02->(GetArea())
	//Local nRet		:= IIf( READVAR() == "M->P02_ATIVO", "", 0 )
	Local llOK		:= .T.

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	nRet	:= &(READVAR())

	llOK := FLTPDUPL()

	If llOK
		LOADTOT()
	Else
		nRet := 0 //IIf( READVAR() == "M->P02_ATIVO", "", 0 )
	EndIf

	RestArea(aAreaP02)

Return nRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCD02LOK  บAutor  ณMicrosiga           บ Data ณ  10/03/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSerแ executado para atualizar a quantidade do total do      บฑฑ
ฑฑบ          ณPercentual ou Valor                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNc Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function LOADTOT()

	Local aAreaP02 	:= P02->(GetArea())
	Local nC		:= 0
	Local cCampo	:= ""
	Local nPosVal	:= 3
	Local nPosAtivo	:= 4
	Local cTotCamp	:= ""

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	If cTpCadVPC == "1"
		cCampo	:= "P02_PERCEN"
		cTotCamp:= "P01_TOTPER"
	Else
		cCampo	:= "P02_VALOR"
		cTotCamp:= "P01_TOTVAL"
	EndIf

	nPosVal		:= aScan(apHeadP02,{|x| AllTrim(x[2])==cCampo})
	//nPosAtivo	:= aScan(apHeadP02,{|x| AllTrim(x[2])=="P02_ATIVO"})
	nTotPerc	:= 0
	For nC := 1 to Len(opGridP02:aCols)

		If !opGridP02:aCols[nc][Len(apHeadP02)+1] //.AND. opGridP02:aCols[nc][nPosAtivo] == "1"
			nTotPerc += opGridP02:aCols[nC][nPosVal]
		EndIf

	Next nC

	nPosQtdCur:=  AsCan(oEncTot:AENTRYCTRLS,{  |x| ALLTRIM(x:CREADVAR) == "M->"+cTotCamp})
	&("M->"+cTotCamp) := nTotPerc
	oEncTot:AENTRYCTRLS[nPosQtdCur]:ctext:= &("M->"+cTotCamp)

	RestArea(aAreaP02)

Return nTotPerc


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCD02LOK  บAutor  ณMicrosiga           บ Data ณ  10/03/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida็ใo na linha, atualiza totalizador                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNc Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCD02LOK()
	Local llOK 	:= .T.
	Local nPosVal:= 0

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	If cTpCadVPC == "1"
		cCampo	:= "P02_PERCEN"
	Else
		cCampo	:= "P02_VALOR"
	EndIf

	nPosVal		:= aScan(apHeadP02,{|x| AllTrim(x[2])==cCampo})

	llOK := FLTPDUPL()

	If opGridP02:aCols[opGridP02:NAT,nPosVal] == 0
		llOK := .F.
		Aviso("NCGCD102 - 07","Nใo ้ permitido valores zerados.",{"Ok"},3)
	EndIf

	If llOK
		LOADTOT()
	EndIf

Return llOK

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFLTPDUPL  บAutor  ณMicrosiga           บ Data ณ  10/03/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se existe o codigo de Tipo de VPC em outra linha   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNc Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FLTPDUPL()

	Local llRet := .T.
	Local nI	:= 0
	Local nPosTipo	:= aScan(apHeadP02,{|x| AllTrim(x[2])=="P02_CODTP"})

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	cTipoVPC := opGridP02:aCols[opGridP02:NAT,nPosTipo]

	For nI := 1 To Len(opGridP02:aCols)

		If !opGridP02:aCols[nI][len(apHeadP02)+1]

			If opGridP02:aCols[nI,nPosTipo] == cTipoVPC .and. opGridP02:NAT <> nI
				llRet := .F.
				Aviso("NCGCD102 - 06","Esse tipo de VPC jแ foi informado, e nใo poderแ ser informado novamente.",{"Ok"},3)
				Exit
			EndIf

		EndIf

	Next nI

Return llRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCD02DEL  บAutor  ณMicrosiga           บ Data ณ  10/03/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida็ใo do grid, atualiza totalizador                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNc Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCD02TOK()
	Local lRet		:= .T.
	Local nV		:= 0
	Local nI		:= 0
	Local nPosTipo	:= aScan(apHeadP02,{|x| AllTrim(x[2])=="P02_CODTP"})
	Local cCodTipo	:= ""
	Local nPosVal	:= 0

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	If cTpCadVPC == "1"
		cCampo	:= "P02_PERCEN"
	Else
		cCampo	:= "P02_VALOR"
	EndIf

	nPosVal:= aScan(apHeadP02,{|x| AllTrim(x[2])==cCampo})

	For nI := 1 To Len(opGridP02:aCols)

   		If !opGridP02:aCols[nI][len(apHeadP02)+1]

			cCodTipo := opGridP02:aCols[nI,nPosTipo]

			For nV := 1 to Len(opGridP02:aCols)

				If !opGridP02:aCols[nV][len(apHeadP02)+1]
					If opGridP02:aCols[nV,nPosTipo] == cCodTipo .AND. nV <> nI
						lRet := .F.
						Aviso("NCGCD102 - 08","Nใo ้ permitido ter o mesmo tipo de VPC em mais de uma linha nos itens. Verifique o Tipo VPC "+Alltrim(cCodTipo)+".",{"Ok"},3)
					EndIf
				EndIf
			Next nV

			If opGridP02:aCols[nI,nPosVal] == 0
				lRet := .F.
				Aviso("NCGCD102 - 09","Nใo ้ permitido valores zerados. Verifique o Tipo VPC "+Alltrim(cCodTipo)+".",{"Ok"},3)
			EndIf

		EndIf

	Next nI

	If lRet
		LOADTOT()
	EndIf

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCD02DEL  บAutor  ณMicrosiga           บ Data ณ  10/03/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida็ใo na Exclusใo da linha,para atulizar totalizador    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNc Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NCD02DEL()
	Local llRet		:= .T.
	Local cCampo	:= ""
	Local cTotCamp	:= ""
	Local nPosVal	:= 3
	//Local nPosAtivo	:= 4
	Local nC

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	If cTpCadVPC == "1"
		cCampo	:= "P02_PERCEN"
		cTotCamp:= "P01_TOTPER"
	Else
		cCampo	:= "P02_VALOR"
		cTotCamp:= "P01_TOTVAL"
	EndIf

	If opGridP02:aCols[opGridP02:NAT][Len(apHeadP02)+1]
		llRet:= FLTPDUPL()
	EndIf

	If llRet

		nPosVal		:= aScan(apHeadP02,{|x| AllTrim(x[2])==cCampo})
		//nPosAtivo	:= aScan(apHeadP02,{|x| AllTrim(x[2])=="P02_ATIVO"})
		nTotPerc:= 0

		For nC := 1 to Len(opGridP02:aCols)
			If opGridP02:NAT == nC
				If opGridP02:aCols[nc][Len(apHeadP02)+1] // Ta deletado e voltara
					nTotPerc += opGridP02:aCols[nC][nPosVal]
				EndIf
			Else
				If !opGridP02:aCols[nc][Len(apHeadP02)+1] //.AND. opGridP02:aCols[nc][nPosAtivo] == "1"
					nTotPerc += opGridP02:aCols[nC][nPosVal]
				EndIf
			EndIf

		Next nC

		nPosQtdCur:=  AsCan(oEncTot:AENTRYCTRLS,{  |x| ALLTRIM(x:CREADVAR) == "M->"+cTotCamp})
		&("M->"+cTotCamp) := nTotPerc
		oEncTot:AENTRYCTRLS[nPosQtdCur]:ctext:= &("M->"+cTotCamp)

	EndIf

Return llRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFVdlAlt   บAutor  ณHermes Ferreira     บ Data ณ  10/03/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida็ใo para verificar se fazer a altera็ใo               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNc Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function FVdlAlt(cTipo)

	Local llRet := .T.
	Default cTipo	:= cTpCadVPC

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	
	If P01->P01_STSAPR == "3" // Em fase de aprova็ใo 
	
		llRet := .F.
		Aviso("NCGCD102 - 16","Esse contrato estแ em fase de aprova็ใo e nใo pode ser alterado neste momento.",{"Ok"},3)
	
	Else
	
		If cTipo == "1"
			If P01->P01_STATUS == "1"
				If P01->P01_DTVINI <= dDatabase .and.  !(dDatabase <= P01->P01_DTVFIM)
					llRet := .F.
					Aviso("NCGCD102 - 05","A Data de Vig๊ncia nใo ้ vแlida para ser alterado o VPC.",{"Ok"},3)
				EndIf
			Else
				llRet := .F.
				Aviso("NCGCD102 - 03","Esse VPC estแ encerrado e nใo pode ser alterado.",{"Ok"},3)
			EndIf
		Else
			If P01->P01_STATUS == "2"
				llRet := .F.
				Aviso("NCGCD102 - 04","Essa Verba estแ encerrada e nใo pode ser alterado.",{"Ok"},3)
			EndIf
		EndIf
		
		
	EndIf
	
Return llRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFNewVer   บAutor  ณHermes Ferreira     บ Data ณ  10/03/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAltera o registro posicionado para encerrado e altera a dataบฑฑ
ฑฑบ          ณde vigencia, para gerar uma nova versใo                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNc Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FNewVer()

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	If RecLock("P01",.F.)
		P01->P01_STATUS := "2"
		If cTpCadVPC == "1"
			P01->P01_DTVFIM	:= dDatabase
		EndIf
		P01->(MsUnLock())
	EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetP01NextบAutor  ณHermes Ferreira     บ Data ณ  11/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o proximo numero para cadastro (Substitui SXE e SXF)บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNc Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GetP01Next()

	Local cRet := Strzero(1,TamSx3("P01_CODIGO")[1])
	Local cSql := ""
	Local cAlias := GetNextAlias()
	
	cSql := " SELECT "
	cSql += " MAX(P01_CODIGO) CODIGO "
	cSql += " FROM "+RetSqlName("P01")+ " P01 "
	cSql += " WHERE P01.P01_FILIAL = '"+xFilial("P01")+"'"
	cSql += " AND P01.D_E_L_E_T_= ' ' "
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
ฑฑบPrograma  ณCD02APRV  บAutor  ณHermes Ferreira     บ Data ณ  28/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para aprova็ใo do Contrato                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CD02APRV(nAprov)

	Local _cAprovador 	:= ""
	Local cComentario 	:= ""
	Local _Aprovado		:= ""
	Local llContinua 	:= .T.
		
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
		
	If nAprov == 1
	
		_cAprovador := U_MyNewSX6(	"NCG_000025",;
								"",;
								"C",;
								"Codigo do usuแrio do protheus que serแ o Aprovador 1 - Cadastro de Contrato VPC / VERBA",;
								"Codigo do usuแrio do protheus que serแ o Aprovador 1 - Cadastro de Contrato VPC / VERBA",;
								"Codigo do usuแrio do protheus que serแ o Aprovador 1 - Cadastro de Contrato VPC / VERBA",;
								.F. )
	ElseIf nAprov == 2
	
		_cAprovador := U_MyNewSX6(	"NCG_000026",;
								"",;
								"C",;
								"Codigo do usuแrio do protheus que serแ o Aprovador 2 - Cadastro de Contrato VPC / VERBA",;
								"Codigo do usuแrio do protheus que serแ o Aprovador 2 - Cadastro de Contrato VPC / VERBA",;
								"Codigo do usuแrio do protheus que serแ o Aprovador 2 - Cadastro de Contrato VPC / VERBA",;
								.F. )
	
	Else
	
		_cAprovador := U_MyNewSX6(	"NCG_000027",;
								"",;
								"C",;
								"Codigo do usuแrio do protheus que serแ o Aprovador 3 - Cadastro de Contrato VPC / VERBA",;
								"Codigo do usuแrio do protheus que serแ o Aprovador 3 - Cadastro de Contrato VPC / VERBA",;
								"Codigo do usuแrio do protheus que serแ o Aprovador 3 - Cadastro de Contrato VPC / VERBA",;
								.F. )	

	EndIf
	
	If !(__cUserId $ Alltrim(_cAprovador)  )
	
		Aviso("NCGCD102 - 14","Usuario nใo tem permissใo para aprovar!",{"Ok"},3)
		
	Else
	
		If P01->P01_STSAPR <> "2" 
		
			If nAprov == 1
			
				If !Empty(P01->P01_APROV1)
					Aviso("NCGCD102 - 17","Esse contrato jแ foi aprovado pelo o Aprovador 1",{"Ok"},3)
					Return
				EndIf
				
			ElseIf nAprov == 2
				If !Empty(P01->P01_APROV2)
					Aviso("NCGCD102 - 18","Esse contrato jแ foi aprovado pelo o Aprovador 2",{"Ok"},3)
					Return
				EndIf
			ElseIf nAprov == 3
			
				If !Empty(P01->P01_APROV3)
					Aviso("NCGCD102 - 19","Esse contrato jแ foi aprovado pelo o Aprovador 3",{"Ok"},3)
					Return
				EndIf
				
			EndIf
			
			
			If Aviso("NCGCD102 - 15",@cComentario,{"Aprovar","Reprovar"},3,"Deseja aprovar ou Reprovar o contrato "+P01->P01_CODIGO+" ?" ,,,.T.) == 1
				_Aprovado := "1"
			Else			
				_Aprovado := "2"
			EndIf
			
			If !Empty(_Aprovado)
			
				If _Aprovado == "2"
				
					If Aviso("NCGCD102 - 16","Tem certeza que deseja reprovar este contrato?",{"Sim","Nใo"},3) == 1
						llContinua := .T.
					Else
						llContinua := .F.
					EndIf
					
				EndIf
				
				If llContinua
				
					If P01->(RecLock("P01",.F.))
						
						If nAprov == 1
						
							P01->P01_APROV1 := __cUserId
							P01->P01_DTAPR1 := MsDate()
							P01->P01_HRAPR1 := Time()
							
						ElseIf nAprov == 2
						
							P01->P01_APROV2 := __cUserId
							P01->P01_DTAPR2 := MsDate()
							P01->P01_HRAPR2 := Time()
							
						Else
						
							P01->P01_APROV3 := __cUserId
							P01->P01_DTAPR3 := MsDate()
							P01->P01_HRAPR3 := Time()
							
						EndIf
			
						// Reprovador
						If _Aprovado == "2"
							
							P01->P01_STSAPR := "2"
							P01->P01_STATUS := "2"
			
							P01->(MSMM(,,, cComentario ,1,,,"P01","P01_CODREP","SYP"))
			
						Else
						
							If !Empty(P01->P01_APROV1) .and. !Empty(P01->P01_APROV2) .and. !Empty(P01->P01_APROV3)
								P01->P01_STSAPR := "1"
							Else
								P01->P01_STSAPR := "3"
							EndIf
							
						EndIf
			
						P01->(MsUnLock())
						
					EndIf
					
				EndIf
				
			EndIf
			
		Else
			Aviso("NCGCD102 - 23","Esse contrato jแ foi reprovado e nใo pode ser aprovado.",{"Ok"},3)
		EndIf
		
	EndIf
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCD02FAROL บAutor  ณHermes Ferreira     บ Data ณ  28/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o Status da AProva็ใo, se o Contrato estแ ou nใo    บฑฑ
ฑฑบ          ณaprovado                                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CD02FAROL(cCampo)

	Local cRet		:= ""
	
	If Alltrim(cCampo) == "1"
	
		cRet := "BR_VERDE"		// Aprovado
	
	ElseIf Alltrim(cCampo) == "2"
	
		cRet := "BR_VERMELHO" // Reprovado
		
	Else
		
		If Empty(P01->P01_APROV1) .and. Empty(P01->P01_APROV2) .and. Empty(P01->P01_APROV3)
		
			cRet := "BR_AMARELO" // Nใo iniciado prova็ใo
			
		ElseIf Empty(P01->P01_APROV1)
			
			cRet := "BR_AZUL" // Aguardando aprovador 1
			
		ElseIf Empty(P01->P01_APROV2) 
		
			cRet := "BR_LARANJA" // Aguardando aprovador 2

		ElseIf Empty(P01->P01_APROV3)
		
			cRet := "BR_MARROM" // Aguardando aprovador 3
			
		EndIf
		
	EndIf

Return(cRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCLegAP2  บAutor  ณHermes Ferreira     บ Data ณ  12/28/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณStatus da aprova็ใo do contrato	                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NCLegAP2()

	Local aCor := {}

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	aAdd(aCor,{"BR_VERDE"	,"Aprovado"   				})
	aAdd(aCor,{"BR_VERMELHO","Reprovado" 				})
	aAdd(aCor,{"BR_AMARELO"	,"Nใo iniciado prova็ใo" 	})
	aAdd(aCor,{"BR_AZUL"	,"Aguardando aprovador 1" 	})
	aAdd(aCor,{"BR_LARANJA"	,"Aguardando aprovador 2" 	})
	aAdd(aCor,{"BR_MARROM"	,"Aguardando aprovador 3" 	})
	
	BrwLegenda(,"Aprova็ใo do Contrato",aCor)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCD02MTRP  บAutor  ณHermes Ferreira     บ Data ณ  12/28/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณษ apresentado o motivo da reprova็ใo do contrato            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CD02MTRP()
	
	Local cTextoRep := ""
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	
	If P01->P01_STSAPR == "2"
	
		cTextoRep := MSMM(P01->P01_CODREP,,,,3)
	
		If !Empty(cTextoRep)
			Aviso("NCGCD102 - 20",cTextoRep,{"Ok"},3)
		Else
			Aviso("NCGCD102 - 21","Nใo foi informado o motivo da reprova็ใo.",{"Ok"},3)
		EndIf
		
	Else
	
		Aviso("NCGCD102 - 22","Esse contrato nใo foi Reprovado.",{"Ok"},3)
		
	EndIf
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณC102F3FIL บAutor  ณHermes Ferreira     บ Data ณ  04/01/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFun็ใo da consulta especifica do campo Filial do Pedido     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function C102F3FIL()
	Local oDlgSXB      := Nil   
	Local oListBox     := Nil
	Local aCoordenadas := MsAdvSize(.T.) 
	Local aEmpsSelec   := {} 
	Local nRecnoSM0    := 0 
	Local nOpcClick    := 0 
	Local i,j
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	
	nRecnoSM0 := SM0->(RecNo())
	SM0->(dbGoTop())
	While SM0->(!Eof())
	
		If SM0->M0_CODIGO == cEmpAnt
			If AScan(aEmpsSelec,{|x| x[2] == SM0->M0_CODFIL }) <= 0
				AAdd(aEmpsSelec,{.F.,SM0->M0_CODFIL,SM0->M0_FILIAL })
			EndIf
		EndIf
		SM0->(dbSkip())
	EndDo   
	SM0->(dbGoTo(nRecnoSM0))
	
	//Tela de consulta
	oDlgSXB := TDialog():New(aCoordenadas[7],000,aCoordenadas[6]/1.5,aCoordenadas[5]/2,OemToAnsi("Empresas Para Replicar o Cadastro"),,,,,,,,oMainWnd,.T.)
		oListBox := TWBrowse():New(001,003,oDlgSXB:nClientWidth/2-5,oDlgSXB:nClientHeight/2-50,,{" ","Codigo Filial","Filial"},,oDlgSXB,,,,,,,,,,,,.F.,,.T.,,.F.,,,)
			oListBox:SetArray(aEmpsSelec)
			oListBox:bLine := {||{	IIf(aEmpsSelec[oListBox:nAt][1],LoadBitmap( GetResources(), "CHECKED" ),LoadBitmap( GetResources(), "UNCHECKED" )),;
										aEmpsSelec[oListBox:nAt][2],;
										aEmpsSelec[oListBox:nAt][3] }}  
			oListBox:bLDblClick := {|| 	FMrkFil(aEmpsSelec,oListBox), oListBox:Refresh()  }
			
		TButton():New(oDlgSXB:nClientHeight/2-30,003,OemToAnsi("&Ok"),oDlgSXB,{|| nOpcClick := 1, oDlgSXB:End()},040,012,,,,.T.,,,,{|| })   
		TButton():New(oDlgSXB:nClientHeight/2-30,050,OemToAnsi("&Cancelar"),oDlgSXB,{|| oDlgSXB:End()},040,012,,,,.T.,,,,{|| }) 
		
	oDlgSXB:Activate(,,,.T.)
	     
	//Atualiza o campo 
	If nOpcClick == 1
		M->P01_FILPED := ""
		For i := 1 To Len(aEmpsSelec)
			If aEmpsSelec[i,1]
				M->P01_FILPED := aEmpsSelec[i,2]
			EndIf
		Next i
	EndIf

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFMrkFil   บAutor  ณHermes Ferreira     บ Data ณ  04/01/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFun็ใo Marca da consulta especifica da Filial do Pedido     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function FMrkFil(aEmpsSelec,oListBox)
	
	Local nC:= 0
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	
	aEmpsSelec[oListBox:nAt,1] := !aEmpsSelec[oListBox:nAt,1]
	
	For nC := 1 to Len(aEmpsSelec)
		If nC <> oListBox:nAt
			aEmpsSelec[nC,1] := .F.
		EndIf
	Next nC

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณC02PVVER  บAutor  ณHermes Ferreira     บ Data ณ  04/03/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFiltro da consulta padrao do campo de pedidos de venda      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function C02PVVER()
	
	Local cQry		:= ""
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	cQry += "@  C5_FILIAL ='"+M->P01_FILPED+"'"
	cQry += " AND C5_EMISSAO BETWEEN '"+DtoS(M->P01_DTVINI)+"' AND '"+DtoS(M->P01_DTVFIM)+"'"
	If !Empty(M->P01_CODCLI)
	
		cQry += " AND C5_CLIENTE = '"+M->P01_CODCLI+"'"
		
		If !Empty(M->P01_LOJCLI)
			cQry += " AND  C5_LOJACLI = '"+M->P01_LOJCLI+"'"
		EndIf
		
	Else
	
		If !Empty(M->P01_GRPCLI)
			cQry += " AND  EXISTS (SELECT A1_COD "
			cQry += " 				FROM "+RetSqlName("SA1 " )+" SA1 "
			cQry += " 				WHERE A1_FILIAL = '"+xFilial("SA1")+"'"
			cQry += " 				AND SA1.A1_GRPVEN = '"+M->P01_GRPCLI+"'"
			cQry += " 				AND SA1.A1_COD = C5_CLIENTE "
			cQry += " 				AND SA1.A1_LOJA = C5_LOJACLI "
			cQry += " 				AND SA1.D_E_L_E_T_= ' '"
			cQry += " 				)"
		EndIf

	EndIf
	
	cQry += " AND C5_YUSAVER = '1'"
	cQry += " AND ( C5_YCODVPC = ' ' OR C5_YCODVPC = '"+M->P01_CODIGO+"')"
	cQry += " AND ( C5_YVERVPC = ' ' OR C5_YVERVPC = '"+M->P01_VERSAO+"')"
	
	
Return cQry

