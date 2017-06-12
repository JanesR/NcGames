#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณKZNCG02		 บAutor  ณAdam Diniz Lima	  บ Data ณ 17/05/12    บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Mbrowse para Manutencao de Motivos de Cancelamento de Pedido    บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ 								                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function KZNCG02()


Private cCadastro  := "Manuten็ใo de Motivos de Cancelamento"     
Private aRotina    := {{"Incluir", "U_KZMANUTZB",0,3},;
						{"Alterar", "U_KZMANUTZB",0,4},;
						{"Excluir", "U_KZMANUTZB",0,5}}  
						
						
/*-------------------------------------------------------*/
/* TABELA GENERICA ZB - Gerada via UPDATE: U_UPDNCG02()  */
/*-------------------------------------------------------*/
MBrowse(6, 1, 22, 75,"SX5",,,,,,,,,,,,,,"X5_TABELA = 'ZB'") 

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณKZMANUTZB		 บAutor  ณAdam Diniz Lima	  บ Data ณ 17/05/12    บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela de Opcoes da Mbrowse. Incluir, Alterar e Excluir  		   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ	cAlias - Alias da Mbrowse (SX5)								   บฑฑ
ฑฑบ			 ณ	nReg - Registro posicionado									   บฑฑ
ฑฑบ			 ณ	nOpc - 1=Incluir, 2=Alterar, 3= Excluir						   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ 								                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function KZMANUTZB(cAlias,nReg,nOpc)

Local oDlg		:= Nil
Local olDesc	:= Nil
Local clChave	:= Space(2)
Local clDesc	:= Space(40)
Local clTitulo	:= ""

If nOpc != 1 // inclusao
	clChave := SX5->X5_CHAVE
	clDesc  := SX5->X5_DESCRI
EndIf

If nOpc == 1
	clTitulo := "Inclusใo"
ElseIf nOpc == 2
	clTitulo := "Altera็ใo"
Else
	clTitulo := "Exclusใo"
EndIf
clTitulo += " de Motivos de Cancelamento de Pedidos"

DEFINE MSDIALOG oDlg TITLE clTitulo FROM  15,6 TO 150,366 PIXEL OF oMainWnd

	@ 4, 2 TO 48, 179 OF oDlg  PIXEL
	
	@ 08,05 SAY     OemToAnsi("Chave")               SIZE 22, 07 OF oDlg PIXEL
	@ 07,53 MSGET   clChave Picture "@!"   SIZE 21, 10 OF oDlg PIXEL When (nOpc == 1) Valid {|| clChave := PadL(AllTrim(clChave),2,"0"),KzVldDsc(clChave) }
	
	@ 21,05 SAY     OemToAnsi("Descricao")    SIZE 46, 07 OF oDlg PIXEL
	
	If nOpc == 3 // Exclusao
   		@ 20,53 MSGET  olDesc  VAR clDesc ReadOnly  Picture "@!" SIZE 80, 10 OF oDlg Valid {|| KzVldDsc(clDesc) } PIXEL 
	Else
		@ 20,53 MSGET  olDesc  VAR clDesc Picture "@!" SIZE 80, 10 OF oDlg Valid {|| KzVldDsc(clDesc) } PIXEL 
	EndIf
	
	DEFINE SBUTTON FROM 51,124 TYPE 1 ENABLE OF oDlg ACTION {|| Iif(KzBtnOk(nOpc, clChave, clDesc),oDlg:End(),)} 
	DEFINE SBUTTON FROM 51,152 TYPE 2 ENABLE OF oDlg ACTION {|| oDlg:End() }

ACTIVATE MSDIALOG oDlg CENTERED

Return 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณKzVldDsc		 บAutor  ณAdam Diniz Lima	  บ Data ณ 17/05/12    บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que valida caracteres especiais na digitacao da descricao บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณclDesc - Descri็ใo digitada									   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ llRet - Logico informando se esta OK a digitacao	               บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KzVldDsc(clDesc)

Local nlI 		:= 1
Local llRet		:= .T.
Local clCarac	:= "'`~-=_+[]{}\|/?,.<>;’:”!@#$%^&*()"+'"'

For nlI := 1 to Len(clDesc) 
	If SubStr(clDesc,nlI,1) $ clCarac
		MsgAlert("Nใo ้ permitido o uso de caracteres especiais")
		llRet := .F.
		Exit		
	EndIf
Next nlI     

Return llRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณKzBtnOk		 บAutor  ณAdam Diniz Lima	  บ Data ณ 17/05/12    บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAcao do Botao Ok, podendo Incluir, alterar ou excluir registros  บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณnOpc - 1=Incluir, 2=Alterar, 3= Excluir						   บฑฑ
ฑฑบ			 ณclChave - Chave Digitada na tela de Inc, alt ou exc			   บฑฑ
ฑฑบ			 ณclDesc  - Descricao a ser incluida na Sx5						   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ llRet - Logico informando se foi concluido ou nao               บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KzBtnOk(nOpc, clChave, clDesc)

	Local alArea	:= GetArea()
	Local llRet		:=	.F.

	// Verifica se os campos foram preenchidos
	If Empty(clChave) .or. Empty(clDesc)
		MsgStop("Os campos Chave e Descricao devem ser preenchidos")
		Return llRet
	EndIf

	If nOpc == 1 
		SX5->(DbSetOrder(1))
		//Verifica se chave informada ja existe
		If SX5->(dbSeek(xFilial("SX5")+"ZB"+avKey(clChave,"X5_CHAVE")))
			Help(" ", 1, "JAGRAVADO")
			Return llRet
		EndIf
		//Incluir
		Begin Transaction
			If Reclock("SX5",.T.)
				SX5->X5_FILIAL 	:= xFilial("SX5")
				SX5->X5_TABELA 	:= "ZB"
				SX5->X5_CHAVE  	:= clChave
				SX5->X5_DESCRI 	:= clDesc
				SX5->X5_DESCSPA	:= clDesc
				SX5->X5_DESCENG	:= clDesc
				SX5->(MsUnLock())
				llRet := .T.
			EndIf
		End Transaction
		
	ElseIf nOpc == 2
		//Alterar
		Begin Transaction
			If Reclock("SX5",.F.)
				SX5->X5_FILIAL 	:= xFilial("SX5")
				SX5->X5_TABELA 	:= "ZB"
				SX5->X5_CHAVE  	:= clChave
				SX5->X5_DESCRI 	:= clDesc
				SX5->X5_DESCSPA	:= clDesc
				SX5->X5_DESCENG	:= clDesc
				SX5->(MsUnLock())
				llRet := .T.
			EndIf
		End Transaction
		
	Elseif nOpc == 3
		//Excluir
		If MsgNoYes("Deseja Realmente Excluir o Registro Selecionado?")
			Begin Transaction
				If Reclock("SX5",.F.)
					SX5->(DbDelete())
					SX5->(MsUnLock())
					llRet := .T.
				EndIf
			End Transaction
		EndIf
	EndIf 

	RestArea(alArea)

Return llRet
