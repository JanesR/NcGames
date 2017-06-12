#INCLUDE "PROTHEUS.CH" 
#INCLUDE 'FWMVCDEF.CH'   

#DEFINE OPER_CONFPUB   		1//Confirma็ใo do Publisher
#DEFINE OPER_CREDITNOTE		2//Credit Note

Static __nOper 		:= 0 	// Operacao da rotina

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun็ใo    ณ NCGPP35  ณ Autor ณ Elton C			    ณ Data ณ12.12.2014ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri็ใo ณ Verba Publisher								              ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ NCGPP35()                                                  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Void                                                       ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function NCGPP35()
Local oBrowse  

DbSelectArea('PZE')
DbSelectArea('PZF')

//Cria o objeto do tipo FWMBrowse
oBrowse := FWMBrowse():New()     

//Alias ta tabela a ser utilizada no browse
oBrowse:SetAlias('PZE') 

//Legenda
oBrowse:AddLegend("Empty(PZE->PZE_DTACEI) .And. Empty(PZE->PZE_DTEFET) .And. Empty(PZE->PZE_FLAGAR)"	, "BR_VERDE"	, "VP Em Aberto"  )
oBrowse:AddLegend("!Empty(PZE->PZE_DTACEI) .And. Empty(PZE->PZE_DTEFET) .And. (Empty(PZE->PZE_FLAGAR) .Or. PZE->PZE_FLAGAR == 'R') ", "BR_VERMELHO", "Aguard.Aprova็ใo"  )
oBrowse:AddLegend("Empty(PZE->PZE_DTACEI) .And. Empty(PZE->PZE_DTEFET) .And. PZE->PZE_FLAGAR == 'R' "	, "BR_PRETO", "Reprovado"  )
oBrowse:AddLegend("!Empty(PZE->PZE_DTEFET) .And. !Empty(PZE->PZE_DTACEI)"	, "BR_AZUL"		, "Aprovado"  )

//Descri็ใo da rotina
oBrowse:SetDescription("Verba Publisher")

oBrowse:Activate()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณModelDef  บAutor  ณFabrica             บ Data ณ  10/12/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDefine o modelo de dados                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGPP35                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ModelDef() 

// Cria a estrutura a ser usada no Model
Local oStruPZE := FWFormStruct( 1, 'PZE', /*bAvalCampo*/, /*lViewUsado*/ ) 
Local oStruPZF := FWFormStruct( 1, 'PZF', /*bAvalCampo*/, /*lViewUsado*/ ) 
Local oModel

//No caso de confirma็ใo do Publisher, apenas o campo PZE_DTACEI estarแ liberado para digita็ใo
If __nOper == OPER_CONFPUB

	// Bloqueia todos os campos menos do PZE_DTACEI
	oStruPZE:SetProperty( '*' , MODEL_FIELD_WHEN , {|| .F. } )
	
	//Libera o campo PZE_DTACEI para digita็ใo
	If  PZE->(FieldPos("PZE_DTACEI")) > 0
		oStruPZE:SetProperty("PZE_DTACEI" , MODEL_FIELD_WHEN , {|| .T. } )
	EndIf

ElseIf __nOper == OPER_CREDITNOTE

	// Bloqueia todos os campos menos do PZE_CREDNO
	oStruPZE:SetProperty( '*' , MODEL_FIELD_WHEN , {|| .F. } )
	
	//Libera o campo PZE_CREDNO para digita็ใo
	If  PZE->(FieldPos("PZE_CREDNO")) > 0
		oStruPZE:SetProperty("PZE_CREDNO" , MODEL_FIELD_WHEN , {|| .T. } )
	EndIf	

Else
	oStruPZE:SetProperty("PZE_DTACEI" , MODEL_FIELD_WHEN , {|| .F. } )		
EndIf


//Cria o objeto do Modelo de Dados
oModel := MPFormModel():New( 'NCGPP35M', /*bPreValidacao*/, /*bPosValidacao*/, { |oModel| GRVDCOMP( oModel ) }/*bCommit*/, /*bCancel*/ ) 

//Adiciona ao modelo uma estrutura de formulแrio de edi็ใo por campo (antiga enchoice)
oModel:AddFields( 'PZEMASTER', /*cOwner*/, oStruPZE, ) 

//Adiciona ao modelo uma estrutura de formulแrio de edi็ใo por grid (antiga getdados)
oModel:AddGrid( 'PZFDETAIL', 'PZEMASTER', oStruPZF, /*bLinePre*/, /*bLinePost*/, /*bPreVal*/, /*bPosVal*/, /*BLoad*/ ) 

//Totais dos itens
oModel:AddCalc( 'PZFCALC1', 'PZEMASTER', 'PZFDETAIL', 'PZF_VALOR', 'PZF__VALOR', 'SUM',,,"Valor Recebido" ) 
oModel:AddCalc( 'PZFCALC1', 'PZEMASTER', 'PZFDETAIL', 'PZF_VLDOLA','PZF__VLDOLA', 'SUM',,,"Valor Recebido $" )  

//Faz relaciomaneto entre os compomentes do model
oModel:SetRelation("PZFDETAIL",{{"PZF_FILIAL","xFilial('PZF')"},{"PZF_CODVP","PZE_CODVP"}},PZF->(IndexKey()))

//Chave Primaria
oModel:SetPrimaryKey({"PZE_CODVP"})      

// Liga o controle de nao repeticao de linha
oModel:GetModel("PZFDETAIL"):SetUniqueLine({"PZF_FILIAL","PZF_CODVP","PZF_CLIENT","PZF_LOJA"})         

//O preenchimento da grid ้ opcional (Nใo ้ obrigatorio)
//oModel:GetModel("PZFDETAIL"):SetOptional(.T.)


//Bloqueia a altera็ใo da grid 
If (__nOper == OPER_CONFPUB) .Or. (__nOper == OPER_CREDITNOTE)

	oModel:GetModel("PZFDETAIL"):SetNoInsertLine( .T. )
	oModel:GetModel("PZFDETAIL"):SetNoUpdateLine( .T. )
	oModel:GetModel("PZFDETAIL"):SetNoDeleteLine( .T. )

EndIf

//Adiciona a descricao do Modelo de Dados
oModel:SetDescription("Verba Publisher") 

//Adiciona a descricao do Componente do Modelo de Dados
oModel:GetModel( 'PZEMASTER' ):SetDescription( 'Master' ) 
oModel:GetModel( 'PZFDETAIL' ):SetDescription( 'Detail'  ) 

Return oModel


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณViewDef   บAutor  ณFabrica             บ Data ณ  10/12/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDefine a interface para cadastro                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGPP35                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ViewDef()      

// Cria um objeto de Modelo de Dados baseado no ModelDef do fonte informado 
Local oModel   	 :=  FWLoadModel( 'NCGPP35' ) 
Local oView

// Cria a estrutura a ser usada na View
Local oStruPZE 	:= FWFormStruct( 2, 'PZE' ) 
Local oStruPZF 	:= FWFormStruct( 2, 'PZF' )
Local oCalc1 	:= FWCalcStruct( oModel:GetModel('PZFCALC1') )



// Cria o objeto de View
oView := FWFormView():New() 

// Define qual o Modelo de dados serแ utilizado
oView:SetModel( oModel ) 

//Adiciona no nosso View um controle do tipo FormFields(antiga enchoice)
oView:AddField( 'VIEW_PZE', oStruPZE, 'PZEMASTER' )                     

//Adiciona na View um controle do tipo
oView:AddField( 'VIEW_CALC', oCalc1, 'PZFCALC1' )

//Adiciona no nosso View um controle do tipo FormGrid(antiga newgetdados)
oView:AddGrid(  'VIEW_PZF', oStruPZF, 'PZFDETAIL' ) 

//Adiciona botใo para importa็ใo de arquivo .CSV
oView:AddUserButton( 'Importa็ใo VP', 'CLIPS', {|oView| NCGPP3IMP()} )

// Criar "box" horizontal para receber algum elemento da view
oView:CreateHorizontalBox( 'SUPERIOR'  	, 40)
oView:CreateHorizontalBox( 'TOTAL'  	, 10) 
oView:CreateHorizontalBox( 'INFERIOR'  	, 50) 

// Relaciona o ID da View com o "box" para exibicao
oView:SetOwnerView( 'VIEW_PZE', 'SUPERIOR'   ) 
oView:SetOwnerView( 'VIEW_CALC', 'TOTAL' )
oView:SetOwnerView( 'VIEW_PZF', 'INFERIOR'     )                                     

Return oView        


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    |MenuDef   ณ Autor ณ Fabrica		        ณ Data ณ10/12/14  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Funcao de defini็ใo do aRotina                             ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ aRotina   retorna a array com lista de aRotina             ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ SIGAFAT                                                    ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function MenuDef() 
Local aRotina := {} 

ADD OPTION aRotina Title "Pesquisar"  				Action 'PesqBrw'         	OPERATION 1 ACCESS 0
ADD OPTION aRotina Title "Visualizar" 				Action 'VIEWDEF.NCGPP35' 	OPERATION 2 ACCESS 0
ADD OPTION aRotina Title "Incluir"	    			Action 'VIEWDEF.NCGPP35' 	OPERATION 3 ACCESS 0
ADD OPTION aRotina Title "Alterar"  				Action 'u_NCVPALT'		 	OPERATION 4 ACCESS 0
ADD OPTION aRotina Title "Excluir"					Action 'u_NCVPEXC' 			OPERATION 5 ACCESS 0 
ADD OPTION aRotina Title "Confirma็ใo Publisher" 	Action 'u_NCVPCFPUB'	 	OPERATION 6 ACCESS 0 
ADD OPTION aRotina Title "Credit Note Publisher" 	Action 'u_NCVPCRNO' 		OPERATION 7 ACCESS 0 
ADD OPTION aRotina Title "Repasse Cred.Cliente" 	Action 'u_NCGPP306' 		OPERATION 8 ACCESS 0 
ADD OPTION aRotina Title "Visualizar WF" 			Action 'u_NCVVWFVP' 		OPERATION 9 ACCESS 0 
ADD OPTION aRotina Title "Legenda" 					Action 'u_NCVP35Leg' 		OPERATION 9 ACCESS 0 

Return aRotina 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVP35Leg		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLegenda da mBrowse										  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCVP35Leg()
Local aLegenda := {}       
Local aCores    := {	;
						{"Empty(PZE_DTACEI) .And. Empty(PZE_DTEFET) .And. Empty(PZE_FLAGAR)"	, "BR_VERDE"   , "VP Em Aberto"    	},;
						{"!Empty(PZE_DTACEI) .And. Empty(PZE_DTEFET) .And. (Empty(PZE_FLAGAR) .Or. PZE_FLAGAR == 'R') "	, "BR_VERMELHO", "Aguard.Aprova็ใo" },;
						{"Empty(PZE_DTACEI) .And. Empty(PZE_DTEFET) .And. PZE_FLAGAR == 'R' "	, "BR_PRETO", "Reprovado" },;
						{"!Empty(PZE_DTEFET) .And. !Empty(PZE_DTACEI)"	, "BR_AZUL"   , "Aprovado"      }}

aEval(aCores, {|z| Aadd(aLegenda, {z[2], z[3]})})
BrwLegenda("Verba Publisher", "Legenda", aLegenda)

Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    |NCVPDOLAR   ณ Autor ณ Fabrica		        ณ Data ณ10/12/14  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Gatilho para retornar o valor de repasse em dolar          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ nRet Valor de reapsse em dolar					          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ 			                                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function NCVPDOLAR()
Local oModel   	:= FWModelActive()//Retorna o objeto da area ativa
Local oModelPZE	:= oModel:GetModel("PZEMASTER")//Model do cabe็alho
Local oModelPZF	:= oModel:GetModel("PZFDETAIL")//Model da grid
Local nTxDolar 	:= oModelPZE:GetValue("PZE_TXDOLA")//Taxa do dolar
Local nValor	:= oModelPZF:GetValue("PZF_VALOR")//Valor do repasse 	
Local nRet 		:= 0

If nTxDolar != 0
	nRet := nValor / nTxDolar
Else
	nRet := 0	
EndIf

Return nRet                                       

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    |NCVPGDL   ณ Autor ณ Fabrica		        ณ Data ณ10/12/14  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Gatilho utilizado na valida็ใo do campo TX. Dolar          ณฑฑ
ฑฑณ			 ณ para ajustar o valor do dolar nos itens do documento       ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ nRet Valor de reapsse em dolar					          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ 			                                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function NCVPGDL()

Local aArea 	:= GetArea()
Local oView 	:= FWViewActive()
Local oModel   	:= FWModelActive()//Retorna o objeto da area ativa
Local oModelTot	:= oModel:GetModel("PZFCALC1")
Local oModelPZE	:= oModel:GetModel("PZEMASTER")//Model do cabe็alho
Local oModelPZF	:= oModel:GetModel("PZFDETAIL")//Model da grid
Local nTxDolar 	:= oModelPZE:GetValue("PZE_TXDOLA")//Taxa do dolar
Local nValor	:= 0
Local nX		:= 0
Local nQtdLin	:= oModelPZF:Length()
Local nValDlAux := 0
Local lRet		:= .T.

//Verifica se a tx do dolar foi alterada, para efetuar a atualiza็ใo dos itens do documento
If nTxDolar != 0
	
	//Zera o valor do totalizador
	If oModelTot:GetValue("PZF__VLDOLA") > 0
		oModelTot:LoadValue( 'PZF__VLDOLA'	, oModelTot:GetValue("PZF__VLDOLA") * -1 )
	EndIf
	
	//Atualiza็ใo do valor em dolar
	For nX := 1 To nQtdLin
		
		nValDlAux 	:= 0
		nValor 		:= 0
		oModelPZF:GoLine(nX)//Posiciona na linha do item
		
		nValor		:= oModelPZF:GetValue("PZF_VALOR")//Valor do repasse
		nValDlAux 	:= nValor / nTxDolar
		oModelPZF:LoadValue( 'PZF_VLDOLA'	, nValDlAux )//Valor de repasse em $
		oModelTot:LoadValue( 'PZF__VLDOLA'	, nValDlAux ) //Soma o valor de repasse Total em $
		
		//Atualiza็ใo da view
		oView:Refresh()
	Next
	
Else
	lRet := .F.	
	Aviso("Aten็ใo","O valor do d๓lar nใo pode ser igual a 0.",{"Ok"}, 2)
EndIf



RestArea(aArea)
Return lRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    |NCGPP35I   ณ Autor ณ Fabrica		        ณ Data ณ10/12/14  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Rotina utilizada para incluir Verba Publisher	          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ 			                                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function NCGPP3IMP()

Local aArea 		:= GetArea()
Local aBotoes		:= {}
Local aSays			:= {}
Local nOpcao		:= 0   
Local aPerg			:= {}
Local oModel   		:= FWModelActive()//Retorna o objeto da area ativa
Local nOperation 	:= oModel:GetOperation()

If !(nOperation == MODEL_OPERATION_UPDATE .OR. nOperation == MODEL_OPERATION_INSERT)
	Aviso("Aten็ใo","Rotina utilizada apenas na inclusใo ou altera็ใo do documento.",{"Ok"},2)
	Return
EndIf

//Verifica se a taxa do dolar foi preenchida
If u_VPVldCb()
	
	//Tela de aviso e acesso aos parametros
	AAdd(aSays,"[Importa็ใo Verba Publisher]")
	AAdd(aSays,"Este programa auxiliarแ na importa็ใo dos itens.")
	
	
	AAdd(aBotoes,{ 5,.T.,{|| aPerg := PergFile() 		}} )
	AAdd(aBotoes,{ 1,.T.,{|| nOpcao := 1, FechaBatch() 	}} )
	AAdd(aBotoes,{ 2,.T.,{|| FechaBatch() 				}} )
	FormBatch( "[Importa็ใo]", aSays, aBotoes )
	
	//Verifica se o parametro com o endere็o do arquivo foi preenchido
	If Len(aPerg) > 0
		
		If aPerg[1]
			If nOpcao == 1
				Processa({|| VPImpArq(aPerg[2][1]) })
			EndIf
		Else
			Aviso("Erro na importa็ใo","Erro ao ler arquivo...",{"Ok"},2)
		EndIf
	Else
		Aviso("Campo obrigat๓rio","O parโmetro com o nome do arquivo nใo foi preenchido ! ",{"Ok"},2)
	EndIf
	
EndIf

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPergFile	บAutor  ณElton C.		     บ Data ณ  18/10/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Pergunta com o endere็o do arquivo						  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergFile()

Local aArea 		:= GetArea()
Local alRetPath  	:= {}
Local alParamBox	:= {} 
Local llRet			:= .F.
Local alRet			:= {}		

aAdd( alParamBox ,{6,"Endere็o de arquivo","","","File(&(ReadVar()))","",100,.T.,"Arquivos .CSV |*.CSV","",GETF_LOCALHARD+GETF_NETWORKDRIVE})

//Monta a pergunta
llRet := ParamBox(alParamBox ,"Endere็o de arquivo",@alRetPath,,,.T.,50,50,				,			,.T.			,.T.)

alRet := {llRet, alRetPath}

RestArea(aArea)
Return alRet  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPP3ImpArq	บAutor  ณElton C.		     บ Data ณ  18/10/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Processamento da rotina de importacao					  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VPImpArq(cArqVp)

Local aArquivo 		:= {}
Local cLinha   		:= "" 
Local alLinha  		:= {}
Local nX			:= 0
Local nlCont		:= 1
Local aErro			:= {}
Local cValRep		:= ""

Default cArqVp := ""

If !File(cArqVp)
	Aviso("Aten็ใo", "O arquivo informado nใo foi localizado.",{"Ok"},2)
EndIf     

FT_FUse(cArqVp)
FT_FGoTop()
ProcRegua(FT_FLastRec())
FT_FGoTop()

While !FT_FEof() 
	IncProc("Efetuando a leitura do arquivo...")
    
    //Pula a primeira linha do arquivo (Cabe็alho)
    If nlCont == 1
    	nlCont++
    	FT_FSkip()
       loop
    EndIf
    
    //Inicia as variaveis com vazio
	cLinha 	:= ""
	alLinha := {}
	
	cLinha   	:= FT_FReadLn() //Le alinha    
	alLinha		:= Separa(cLinha,";") //Quebra a linha em colunas de acordo com o delimitador ';'
	
	//Verifica se o arquivo esta com a quantidade de colunas correta
	If Len(alLinha) >= 4
	
		//Adiciona a linha ao arquivo
		aAdd(aArquivo,alLinha ) 
	Else
		Aviso("Formado invแlido","Formato do arquivo invแlido, verifique o layout correto",{"Ok"},2)
		Exit
		Return
	EndIf
	
	FT_FSkip()
EndDo 

If Len(aArquivo) > 0
	ProcRegua(Len(aArquivo))
			
	For nX := 1 To Len(aArquivo)
		IncProc("Efetuando a importa็ใo...")
		
		//Obs. adicionado +1 na linha, tendo em vista a retirada do cabe็alho. Essa informa็ใo serแ utilizada no relatorio de erro
		If VldImpIt(aArquivo[nX], @aErro, nX+1)
			
			//Preenchimento das variaveis auxiliares
			cValRep		:= ""
			cValRep		:= Strtran( aArquivo[nX][4], ".", "" )
			cValRep		:= Strtran( cValRep , ",", "." )
            
            //Chama a rotina para adicionar o item 
            AddItVP(aArquivo[nX][1], aArquivo[nX][2], Val(cValRep))
		EndIf
	Next
	
	If Len(aErro) > 0
		If Aviso("Aten็ใo", "Alguns itens nใo foram importados, deseja visualizar o log de erro ? ", {"Sim","Nใo"}, 2) == 1

			//Chama a rotina para imprimir o log de importa็ใo
			CtRConOut(aErro)
		EndIf
	
	EndIf	

EndIf

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณVldImpIt	บAutor  ณElton C.		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida็ใo dos itens a serem importados					  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldImpIt(aArqImp, aErro, nLin)

Local aArea 	:= GetArea()
Local cMsgAux   := ""
Local lRet		:= .T.
Local cValAux	:= ""

Default aArqImp	:= {} 
Default aErro 	:= {}
Default nLin	:= 0

                  
//Valida็ใo do Cliente
If !Empty(aArqImp[1]) .And. !Empty(aArqImp[2])
	DbSelectArea("SA1")
	DbSetOrder(1)
	If !SA1->(MsSeek(xFilial("SA1") + PADR(aArqImp[1],TAMSX3("A1_COD")[1]) +  PADR(aArqImp[2], TAMSX3("A1_LOJA")[1]) ))
		lRet := .F.
		cMsgAux   += "-Cliente ("+aArqImp[1]+"/"+aArqImp[2]+") nใo encontrado; -Linha: "+Alltrim(Str(nLin))+CRLF
		Aadd(aErro, cMsgAux)
	EndIf
Else
	lRet := .F.
	cMsgAux   += "-C๓digo ou loja do cliente nใo preenchido;  -Linha: "+Alltrim(Str(nLin)) +CRLF
	Aadd(aErro, cMsgAux)
EndIf

//Valida็ใo do Valor de repasse [4]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[4], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) <= 0
	lRet := .F.
	cMsgAux   += "-Valor de repasse nใo preenchido ou menor que zero;  -Linha: "+Alltrim(Str(nLin)) +CRLF
	Aadd(aErro, cMsgAux)
EndIf                                                           


RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณAddItVP	บAutor  ณElton C.		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Adiciona os itens do VP no caso de importa็ใo			  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AddItVP(cCodCli, cLoja, nValRep)

Local aArea 		:= GetArea()
Local aAcolsAux		:= {}
Local oView 		:= FWViewActive()
Local oModel   		:= FWModelActive()
Local oModelTot		:= oModel:GetModel("PZFCALC1")
Local oModelPZE		:= oModel:GetModel("PZEMASTER")//Model do cabe็alho
Local oModelPZF		:= oModel:GetModel("PZFDETAIL")//Model dos itens
Local nTxDolar		:= oModelPZE:GetValue("PZE_TXDOLA")
Local nValDolarAux	:= 0
Local nOperation	:= oModel:GetOperation()
Local nAt			:= 0

Default cCodCli	:= "" 
Default cLoja	:= ""
Default nValRep	:= 0

If !( nOperation == MODEL_OPERATION_DELETE )  
	
	nAt := oModelPZF:nLine//Linha atual

    DbSelectArea("SA1")
	DbSetOrder(1)
    If SA1->(MsSeek(xFilial("SA1") + cCodCli + cLoja ))
		
		If nTxDolar != 0
			nValDolarAux := nValRep / nTxDolar
		Else
			nValDolarAux := 0		
		EndIf
        
        //Verifica se a linha atual foi preenchida
		If !Empty(oModelPZF:GetValue("PZF_CLIENT"))
			oModelPZF:AddLine() //Adiciona linha na grid
			oModelPZF:GoLine( oModelPZF:Length() ) //Vai para ultima linha para efetuar o preenchimento dos campos
        EndIf
		
		oModelPZF:LoadValue( 'PZF_CLIENT'  	, SA1->A1_COD )
		oModelPZF:LoadValue( 'PZF_LOJA' 	, SA1->A1_LOJA )
		oModelPZF:LoadValue( 'PZF_NOME'		, SA1->A1_NREDUZ )
		oModelPZF:LoadValue( 'PZF_VALOR'	, nValRep )//Valor de repasse
		oModelPZF:LoadValue( 'PZF_VLDOLA'	, nValDolarAux )//Soma o valor de repasse em $
	
	    oModelTot:LoadValue( 'PZF__VALOR'	, nValRep ) //Soma o valor de repasse
	    oModelTot:LoadValue( 'PZF__VLDOLA'	, nValDolarAux ) //Soma o valor de repasse em $

		oModelPZF:GoLine(nAt)
		oView:Refresh()
	EndIf

EndIf	

RestArea(aArea)
Return       


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGRVDCOMP 	บAutor  ณElton C.			 บ Data ณ  04/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Grava dados complementares			                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GRVDCOMP( oModel )

Local cCodVp	 	:= oModel:GetValue("PZEMASTER","PZE_CODVP")
Local nVlRec 		:= oModel:GetValue("PZFCALC1","PZF__VALOR")
Local nVlRecDlr		:= oModel:GetValue("PZFCALC1","PZF__VLDOLA")
Local nOperation 	:= oModel:GetOperation()

//Realiza a grava็ใo do Modelo
FWFormCommit( oModel )

If (nOperation == MODEL_OPERATION_UPDATE .OR. nOperation == MODEL_OPERATION_INSERT)
	
	//Grava os dados dos valores totais
	GrvPzeTot(cCodVp, nVlRec, nVlRecDlr)

Endif

//Envia o workflow de aprova็ใo
If __nOper == OPER_CONFPUB
	
	//Altera a flag	
	Reclock("PZE", .F.)
	PZE->PZE_FLAGAR	:= ""
	PZE->(MsUnLock())
	    
	//Envia o WF para aprova็ใo
	u_NCWFPP32(PZE->PZE_CODVP)

EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvPzeTot 	บAutor  ณElton C.		 บ Data ณ  04/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Grava dados complementares do cabe็alho                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvPzeTot(cCodVp, nVlRec, nVlRecDlr)

Local aArea := GetArea()

Default cCodVp 		:= ""          
Default nVlRec		:= 0 
Default nVlRecDlr   := 0

DbSelectArea("PZE")
DbSetOrder(1)
If PZE->(MsSeek(xFilial("PZE") + cCodVp )) 
	Reclock("PZE", .F.)
	PZE->PZE_CREDRE	:= nVlRec
	PZE->PZE_CDOLAR := nVlRecDlr
	PZE->(MsUnLock())
EndIf

RestArea(aArea)
Return
                              

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    |NCVPCFPUB   ณ Autor ณ Microsiga	        ณ Data ณ10/12/14  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Confirma็ใo do Publisher							          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ 													          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ 			                                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function NCVPCFPUB()

Local aArea 		:= GetArea()
Local cTitulo   	:= ""
Local cPrograma		:= ""
Local nOperation	:= 0

If Empty(PZE->PZE_DTACEI)

	cTitulo    		:= "Verba Publisher"
	cPrograma 		:= 'NCGPP35'
	nOperation 		:= 4// Alterar
	__nOper 		:= OPER_CONFPUB//Informa a opera็ใo (Confirma็ใo do Publisher)
	
	//Chama a rotina para executar a View 
	FWExecView( cTitulo , cPrograma, nOperation, /*oDlg*/, {|| .T. }/*bCloseOnOk*/, /*bOk*/ , /*nPercReducao*/, /*aEnableButtons*/, /*bCancel*/ )

ElseIf (!Empty(PZE->PZE_DTACEI) .And. Empty(PZE->PZE_DTEFET) )
	Aviso("Aten็ใo","Documento em aprova็ใo a manuten็ใo nใo ้ permitida. ",{"Ok"},2)
Else
	Aviso("Aten็ใo","Documento efetivado a manuten็ใo nใo ้ permitida. ",{"Ok"},2)
EndIf

//Volta a opera็ใo anterior, ap๓s a finaliza็ใo do processamento
__nOper 	:= 0


RestArea(aArea)
Return                        


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    |NCVPALT   ณ Autor ณ Microsiga	        ณ Data ณ10/12/14  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Altera็ใo do documento							          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ 													          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ 			                                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function NCVPALT()

Local aArea 		:= GetArea()
Local cTitulo   	:= ""
Local cPrograma		:= ""
Local nOperation	:= 0

If Empty(PZE->PZE_DTACEI)

	cTitulo    		:= "Verba Publisher"
	cPrograma 		:= 'NCGPP35'
	nOperation 		:= 4// Alterar
	
	//Chama a rotina para executar a View 
	FWExecView( cTitulo , cPrograma, nOperation, /*oDlg*/, {|| .T. }/*bCloseOnOk*/, /*bOk*/ , /*nPercReducao*/, /*aEnableButtons*/, /*bCancel*/ )
ElseIf (!Empty(PZE->PZE_DTACEI) .And. Empty(PZE->PZE_DTEFET) )
	Aviso("Aten็ใo","Documento em aprova็ใo a manuten็ใo nใo ้ permitida. ",{"Ok"},2)
Else
	Aviso("Aten็ใo","Documento efetivado a manuten็ใo nใo ้ permitida. ",{"Ok"},2)
EndIf

RestArea(aArea)
Return                        


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    |NCVPEXC   ณ Autor ณ Microsiga	        ณ Data ณ10/12/14  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Exclusใo do documento							          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ 													          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ 			                                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function NCVPEXC()

Local aArea 		:= GetArea()
Local cTitulo   	:= ""
Local cPrograma		:= ""
Local nOperation	:= 0

If Empty(PZE->PZE_DTACEI)

	cTitulo    		:= "Verba Publisher"
	cPrograma 		:= 'NCGPP35'
	nOperation 		:= 5//Excluir
	
	//Chama a rotina para executar a View 
	FWExecView( cTitulo , cPrograma, nOperation, /*oDlg*/, {|| .T. }/*bCloseOnOk*/, /*bOk*/ , /*nPercReducao*/, /*aEnableButtons*/, /*bCancel*/ )
ElseIf (!Empty(PZE->PZE_DTACEI) .And. Empty(PZE->PZE_DTEFET) )
	Aviso("Aten็ใo","Documento em aprova็ใo a manuten็ใo nใo ้ permitida. ",{"Ok"},2)
Else
	Aviso("Aten็ใo","Documento efetivado a manuten็ใo nใo ้ permitida. ",{"Ok"},2)
EndIf

RestArea(aArea)
Return                        



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    |NCVPCRNO   ณ Autor ณ Microsiga	        ณ Data ณ10/12/14  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Preenchimento do Credit Note						          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ 													          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ 			                                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function NCVPCRNO()

Local aArea 		:= GetArea()
Local cTitulo   	:= ""
Local cPrograma		:= ""
Local nOperation	:= 0

If Empty(PZE->PZE_CREDNO)

	cTitulo    		:= "Verba Publisher"
	cPrograma 		:= 'NCGPP35'
	nOperation 		:= 4// Alterar
	__nOper 		:= OPER_CREDITNOTE//Informa a opera็ใo (Confirma็ใo do Publisher)
	
	//Chama a rotina para executar a View
	FWExecView( cTitulo , cPrograma, nOperation, /*oDlg*/, {|| .T. }/*bCloseOnOk*/, /*bOk*/ , /*nPercReducao*/, /*aEnableButtons*/, /*bCancel*/ )
	
Else
	Aviso("Aten็ใo","Credit Note jแ preenchido. ",{"Ok"},2)
EndIf


//Volta a opera็ใo anterior, ap๓s a finaliza็ใo do processamento
__nOper 	:= 0

RestArea(aArea)
Return                        




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณVPVldCb	บAutor  ณElton C.		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida็ใo de campos obrigatorios a serem preenchidos	      บฑฑ
ฑฑบ          ณ no cabe็alho antes do preenchimento da grid                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VPVldCb()

Local aArea 	:= GetArea()
Local oModel   	:= FWModelActive()//Retorna o objeto da area ativa
Local oModelPZE	:= oModel:GetModel("PZEMASTER")//Model do cabe็alho
Local lRet		:= .T.
Local cMsgAux   := ""

If oModelPZE:GetValue("PZE_TXDOLA") <= 0
	cMsgAux += "-Tx.Dolar nใo preenchida"+CRLF	
	lRet := .F.
EndIf

If !lRet
	Aviso("VLDCAMPCAB","Campo obrigat๓rio nใo preenchido: "+CRLF+cMsgAux,{"Ok"},2)
EndIf

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณVPVldLj	บAutor  ณElton C.		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida็ใo da loja do cliente						 	      บฑฑ
ฑฑบ          ณ 												              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VPVldLj()

Local aArea 	:= GetArea()
Local oModel   	:= FWModelActive()//Retorna o objeto da area ativa
Local oModelPZF	:= oModel:GetModel("PZFDETAIL")//Model do cabe็alho
Local lRet		:= .T.


If Empty(oModelPZF:GetValue('PZF_CLIENT'))
	lRet := .F.
	Aviso("VLDLJCLI1","C๓digo do cliente nใo preenchido. ",{"Ok"},2)
Else
	DbSelectArea("SA1")
	DbSetOrder(1)
	If SA1->(MsSeek(xFilial("SA1") + oModelPZF:GetValue('PZF_CLIENT') + oModelPZF:GetValue('PZF_LOJA') ))
		lRet := .T.
	Else 
		lRet := .F.
		Aviso("VLDLJCLI2","Cliente e loja nใo encontrado.",{"Ok"},2)
	EndIf
EndIf

RestArea(aArea)
Return lRet
                 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณNCVVWFVP	บAutor  ณElton C.		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Visualiza็ใo do Workflow de aprova็ใo				      บฑฑ
ฑฑบ          ณ                 											  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCVVWFVP()

Local aAreaAtu	:=GetArea()
Local oDlg
Local cPath		:="\PPVIEWWF\"
Local cHtml		:="analiseWFVPcli.htm"
Local oHtml
Local cNomeArq 	:= CriaTrab(,.f.) + ".htm"
Local cCodVP 	:= PZE->PZE_CODVP 
Local cPathTemp  := GETTEMPPATH()

oHtml	:=	TWFHTML():New(Alltrim(cPath) + Alltrim(cHtml))

//Monta a tela com a simula็ใo do WF de aprova็ใo
PP305SWF(oHtml,cCodVP)


cNomeArq := Alltrim(cPath) + cNomeArq
cNomeArq := StrTran(cNomeArq,'\\','\')
oHtml:SaveFile( Alltrim(cNomeArq) )	// Grava o HTML temporario

cNomeHtml:="VP_2_"+cCodVP+StrTran(Time(),":","")+Dtos(Date())+ ".htm"
If __CopyFile(cNomeArq,cPathTemp+cNomeHtml)
	
	Define MsDialog oDlg Title "Analise: "+cCodVP FROM oMainWnd:nTop,oMainWnd:nLeft TO oMainWnd:nBottom,oMainWnd:nRight*0.98 Of oMainWnd PIXEL
	nWidth:= oDlg:nWidth/2
	nHeight:=(oDlg:nHeight/2)-10
	
	
	oTIBrowser:= TIBrowser():New(0,0,nWidth,nHeight,cPathTemp+cNomeHtml,oDlg )
	
	tButton():New(10,10	,  "Fechar"  	,oDlg,{|| oDlg:End()	},32,12,,,,.T.)
	
	ACTIVATE MSDIALOG oDlg CENTERED
	
Else
	Aviso("Erro arquivo temporแrio","Erro ao tentar gravar o arquivo temporแrio. Entre em contato com o administrador. ",{"Ok"},2)
EndIf

Ferase(cNomeArq)
RestArea(aAreaAtu)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPP305SWF  บAutor  ณMicrosiga           บ Data ณ  02/11/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function PP305SWF(oHtml,cCodVP)
Local aArea 	:= GetArea()
Local cArqTmp 	:= ""
Local cTitulo	:= ""
Local cTableCli	:= ""

Default oHtml := Nil

cArqTmp	:= GetDVP(cCodVP)//Recebe os dados do price protection


If (cArqTmp)->(!Eof()) .And. (oHtml != Nil)
	
	cTitulo			:= "Aprova็ใo de Verba Publisher"
	
	//Preenchimento dos dados do cabe็alho WF
	oHtml:ValByName( "cTiTuloHtml"	, cTitulo)
	oHtml:ValByName( "cCodVP"		, (cArqTmp)->PZE_CODVP )
	oHtml:ValByName( "cPublisher"	, (cArqTmp)->PZE_PUBLIS )
	oHtml:ValByName( "cCampanha"	, (cArqTmp)->PZE_PPPUB )
	oHtml:ValByName( "cVlTotRec"    , Transform((cArqTmp)->PZE_CREDRE,"@E 999,999,999.99" )  )
	oHtml:ValByName( "cDtProtec"  	, DTOC(STOD((cArqTmp)->PZE_DTDIGI))   )
	oHtml:ValByName( "cDtAprovP"   	, DTOC(STOD((cArqTmp)->PZE_DTACEI))  )
	oHtml:ValByName( "cCodAprov"   	, "" )
	oHtml:ValByName( "cNomAprov"   	, "" )
	
	//Preenchimento da tabela resumida dos clientes
	cTableCli := U_NGetTVPWF(cCodVP)
	oHtml:ValByName( "cTableCli"   	, cTableCli  )
	
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return 
                    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNGetTVPWFบAutor  ณElton C.		    บ Data ณ   20/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria a tabela com os itens do Workflow			 		  บฑฑ
ฑฑบ          ณ												  			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NGetTVPWF(cCodVP)

Local aArea 	:= GetArea()
Local cRet	    := ""
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()	
Local aCliente	:= GetCliVP(cCodVP)
Local nX		:= 0
Local nQtd		:= 0
Local nTotRepC	:= 0

Default cCodVP  := ""

cQuery    := " SELECT DISTINCT PZF_CLIENT, PZF_LOJA FROM "+RetSqlName("PZF")+" PZF "+CRLF
cQuery    += " WHERE PZF.PZF_FILIAL = '"+xFilial("PZF")+"' "+CRLF
cQuery    += " AND PZF.PZF_CODVP = '"+cCodVP+"' "+CRLF
cQuery    += " AND PZF.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += " ORDER BY PZF_CLIENT, PZF_LOJA "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

cRet += ' 	<table border="0" align="left" cellpadding="4" cellspacing="1" style="margin-left: 10px;"> '+CRLF
//cRet += '<table border="0" align="left" cellpadding="4" cellspacing="1" style=" font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-left: 10px;">'
cRet += '		<tr>'+CRLF
cRet += '			<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:9px; font-weight:bold; color:#FFF;"  nowrap>Cliente: </th>'+CRLF

//Preenche o cabe็alho com o nome do cliente
For nX := 1 To Len(aCliente)
	cRet += '		<th width="80px" bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:9px; font-weight:bold; color:#FFF;"  >'+aCliente[nX][3]+'</th> '+CRLF
Next

cRet += '		</tr>'

cRet += ' 		<tr> '
cRet += ' 			<th nowrap bgcolor="#efefef" style="font-family:Arial, Helvetica, sans-serif; font-size:9px; font-weight:bold;">Total R$: </th> '+CRLF

//Imprime o valor total de repasse ao cliente
For nX := 1 To Len(aCliente)
	nTotRepC 	:= 0
	nTotRepC	:= GetTRCli(cCodVP, aCliente[nX][1], aCliente[nX][2])
	cRet += ' 		<th bgcolor="#efefef" style="text-align: right; font-family:Arial, Helvetica, sans-serif; font-size:9px; font-weight:bold;">'+Transform(nTotRepC,"@E 999,999,999,999.99" )+'</th>'+CRLF
Next

cRet += ' 		</tr> '+CRLF
cRet += '	</table> '+CRLF


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return cRet
                   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetCliVP  บAutor  ณElton C.		    บ Data ณ   20/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna os clientes utilizados no PP					 	  บฑฑ
ฑฑบ          ณ															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetCliVP(cCodVP)

Local aArea 	:= GetArea()
Local aRet		:= {}
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()	

Default cCodVP := ""

cQuery    := " SELECT DISTINCT PZF_CLIENT, PZF_LOJA, PZF_NOME FROM "+RetSqlName("PZF")+" PZF "+CRLF
cQuery    += " WHERE PZF.PZF_FILIAL = '"+xFilial("PZF")+"' "+CRLF
cQuery    += " AND PZF.PZF_CODVP = '"+cCodVP+"' "+CRLF
cQuery    += " AND PZF.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += " ORDER BY PZF_NOME "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

While (cArqTmp)->(!Eof())

	Aadd(aRet, {(cArqTmp)->PZF_CLIENT, (cArqTmp)->PZF_LOJA, (cArqTmp)->PZF_NOME})

	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetTRCliบAutor  ณElton C.		    บ Data ณ   20/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o valor total de repasse ao cliente			 	  บฑฑ
ฑฑบ          ณ															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetTRCli(cCodVP, cCodCli, cLoja)

Local aArea 	:= GetArea()
Local nRet		:= 0
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()	

Default cCodVP	:= "" 
Default cCodCli := ""                 
Default cLoja	:= ""

cQuery    := " SELECT SUM(PZF_VALOR) PZF_VALOR FROM "+RetSqlName("PZF")+" PZF "+CRLF
cQuery    += " WHERE PZF.PZF_FILIAL = '"+xFilial("PZF")+"' "+CRLF
cQuery    += " AND PZF.PZF_CODVP = '"+cCodVP+"' "+CRLF
cQuery    += " AND PZF.PZF_CLIENT = '"+cCodCli+"' "+CRLF
cQuery    += " AND PZF.PZF_LOJA = '"+cLoja+"' "+CRLF
cQuery    += " AND PZF.D_E_L_E_T_ = ' ' "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

If (cArqTmp)->(!Eof())
	nRet := (cArqTmp)->PZF_VALOR
Else
	nRet := 0
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return nRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetDVP	บAutor  ณElton C.		    บ Data ณ   20/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o arquivo temporario com os dados do price 		  บฑฑ
ฑฑบ          ณprotection												  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetDVP(cCodPP)

Local aArea 	:= GetArea()      
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()	

Default cCodPP := ""


cQuery    := " SELECT PZE_CODVP, PZE_PUBLIS, PZE_PPPUB, PZE_CREDRE, PZE_CDOLAR, PZE_DTDIGI, PZE_DTACEI "+CRLF
cQuery    += " FROM "+RetSqlName("PZE")+" PZE "+CRLF

cQuery    += " WHERE PZE.PZE_FILIAL = '"+xFilial("PZE")+"' "+CRLF
cQuery    += " AND PZE.PZE_CODVP = '"+cCodPP+"' "+CRLF
cQuery    += " AND PZE.D_E_L_E_T_ = ' ' "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

(cArqTmp)->(DbGoTop())

RestArea(aArea)
Return cArqTmp

                                                                         

