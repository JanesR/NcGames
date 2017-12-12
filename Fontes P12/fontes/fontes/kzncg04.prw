#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KZNCG04		 ºAutor  ³Adam Diniz Lima	  º Data ³ 17/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Mbrowse para Manter Regras de Inconsistencias	 			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 																   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function KZNCG04()


Private cCadastro  := "Regras de Inconsistências"                           
Private aRotina    := {{"Incluir", "U_KZMANZAB",0,3},; 
						{"Alterar", "U_KZMANZAB",0,4},;
						{"Excluir", "U_KZMANZAB",0,4}}  
						
						
/*-------------------------------------------------------*/
/* TABELA ZAB - Gerada via UPDATE: U_UPDNCG04() 		 */
/*-------------------------------------------------------*/
MBrowse(6, 1, 22, 75,"ZAB") 

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KZMANZAB		 ºAutor  ³Adam Diniz Lima	  º Data ³ 17/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de Opcoes da Mbrowse. Incluir, Alterar e Excluir  		   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³	cAlias - Alias da Mbrowse (SX5)								   º±±
±±º			 ³	nReg - Registro posicionado									   º±±
±±º			 ³	nOpc - 1=Incluir, 2=Alterar, 3= Excluir						   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function KZMANZAB(cAlias,nReg,nOpc)

Local alArea	:= GetArea()
Local oDlg		:= Nil
Local clCod		:= Space(TamSx3("ZAB_CODINC")[1])
Local clDesc	:= Space(TamSx3("ZAB_DESCR")[1])

Local olAprov	:= Nil 
Local clAprov	:= Space(1)

Local olImped	:= Nil
Local clImped	:= Space(1)

Local clTitulo	:= ""

Local alResp	:= {"1=Sim","2=Não"}

If nOpc != 1
	clCod := ZAB->ZAB_CODINC
	clAprov := ZAB->ZAB_APROVA
	clImped := ZAB->ZAB_IMPED
	KzVldCod(clCod,@clDesc)
EndIf

If nOpc == 1
	clTitulo := "Inclusão"
ElseIf nOpc == 2
	clTitulo := "Alteração"
Else
	clTitulo := "Exclusão"
EndIf
clTitulo += " de Regra de Inconsistência"

DEFINE MSDIALOG oDlg TITLE clTitulo FROM  15,6 TO 210,366 COLORS 0,16777215 PIXEL OF oMainWnd 

	@ 4, 2 TO 78, 179 OF oDlg  PIXEL
	
 	@ 08,05 SAY     OemToAnsi("Cod.Inconsistência")  SIZE 200, 07  OF oDlg PIXEL
	@ 07,53 MSGET   clCod Picture "@!"   SIZE 35, 10 F3 'ZC'  When (nOpc == 1) Valid {|| KzVldCod(clCod,@clDesc) } OF oDlg PIXEL
	
	@ 21,05 SAY     OemToAnsi("Descricao")    SIZE 46, 07 OF oDlg PIXEL
	@ 20,53 MSGET   clDesc ReadOnly  Picture "@!" SIZE 100, 10 OF oDlg PIXEL 

   	@ 34,05 SAY     OemToAnsi("Aprovação")    SIZE 46, 07 OF oDlg PIXEL
	olAprov:= TComboBox():New(034,053,{|u| if(PCount()>0,clAprov:=u,clAprov)},alResp,35,010,oDlg,,{||  },,,,.T.,,,,{|| nOpc !=3  },,,,,'clAprov')

   	@ 47,05 SAY     OemToAnsi("Impeditivo")    SIZE 46, 07 OF oDlg PIXEL
	olImped:= TComboBox():New(046,053,{|u| if(PCount()>0,clImped:=u,clImped)},alResp,35,010,oDlg,,{||  },,,,.T.,,,,{|| nOpc != 3 },,,,,'clImped')

	DEFINE SBUTTON FROM 81,124 TYPE 1 ENABLE OF oDlg ACTION {|| Iif(KzBtnOk(nOpc, clCod, clAprov, clImped),oDlg:End(), )}
	DEFINE SBUTTON FROM 81,152 TYPE 2 ENABLE OF oDlg ACTION {|| oDlg:End() }

ACTIVATE MSDIALOG oDlg CENTERED 

RestArea(alArea)

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzBtnOk		 ºAutor  ³Adam Diniz Lima	  º Data ³ 17/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao do Botao OK, Efetua a Inclusao, alteracao ou exclusao	   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ nOpc 	- Opcao setada na mbrowse							   º±±
±±º			 ³ clCod 	- Codigo da Inconsistencia - Tab Generica Z3		   º±±
±±º			 ³ clAprov 	- Opcao de Aprovacao via ComboBox - 1=Sim;2=Nao		   º±±
±±º			 ³ clImped 	- Opcao de Impeditivo via ComboBox - 1=Sim;2=Nao	   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ llRet - Logico, informando se foi realizada a operaco ou nao    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzBtnOk(nOpc, clCod, clAprov, clImped)
            
Local alArea	:= {}
Local llRet		:= .F.
       
If nOpc == 1 // Inclusao
	If Empty(clCod)
		MsgStop("O Campo Código de Inconsistência deve ser preenchido")
		Return llRet
	EndIf

	alArea := GetArea() 

	ZAB->(DbSetOrder(1))
	ZAB->(DbGoTop())
	If ZAB->(DbSeek(xFilial("ZAB")+clCod))
		Help(" ", 1, "JAGRAVADO")
		Return llRet
	EndIf 
	RestArea(alArea)
		
	Begin Transaction
		If RecLock("ZAB",.T.)
			ZAB->ZAB_FILIAL	:= xFilial("ZAB")
			ZAB->ZAB_CODINC	:= clCod
			ZAB->ZAB_APROVA	:= clAprov
			ZAB->ZAB_IMPED	:= clImped
			ZAB->(MsUnlock())
			llRet := .T.
		EndIf
	End Transaction

ElseIf nOpc == 2//Alteracao
	Begin Transaction
		If RecLock("ZAB",.F.)
			ZAB->ZAB_APROVA	:= clAprov
			ZAB->ZAB_IMPED	:= clImped
			ZAB->(MsUnlock())
			llRet := .T.
		EndIf
	End Transaction
	
Else // Exclusao
	If MsgNoYes("Deseja Realmente Excluir o Registro Selecionado ?")
		Begin Transaction
			If RecLock("ZAB",.F.)
				ZAB->(DbDelete())
				ZAB->(MsUnlock())
				llRet := .T.
			EndIf
		End Transaction
	EndIf
EndIf

Return llRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzVldCod		 ºAutor  ³Adam Diniz Lima	  º Data ³ 17/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de Validacao do Codigo de Inconsistencia e captura da    º±±
±±ºDesc.     ³ descricao da mesma direto na variavel recebida por parametro    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ clCod 	- Codigo da Inconsistencia para validar existencia na  º±±
±±º			 ³            tabela generica Z3								   º±±
±±º			 ³ clDesc 	- Variavel que recebera o conteudo da descricao do     º±±
±±º			 ³ 			  do Codigo da inconsistencia selecionado			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ llRet - Logico, informando se foi realizada a operacao ou nao   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzVldCod(clCod,clDesc)

Local alArea := GetArea()
Local llRet := .F.

If !Empty(clCod)
	DbSelectArea("SX5")
	SX5->(DbSetOrder(1))
	If SX5->(dbSeek(xFilial("SX5")+"ZC"+avKey(clCod,"X5_CHAVE")))
		clDesc	:= SX5->X5_DESCRI
		llRet	:= .T.
	EndIf
Else
	llRet := .T.
EndIf

RestArea(alArea)

Return llRet