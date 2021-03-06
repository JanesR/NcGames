#INCLUDE "PROTHEUS.CH" 
#INCLUDE 'FWMVCDEF.CH'   


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCIWMF08 �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Cadastro para agrupamento do tipo financeiro				  ���
���          �										    		  		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCIWMF08()
Local oBrowse  

DbSelectArea('PZS')
DbSelectArea('PZT')

//Cria o objeto do tipo FWMBrowse
oBrowse := FWMBrowse():New()     

//Alias ta tabela a ser utilizada no browse
oBrowse:SetAlias('PZS') 

//Descri��o da rotina
oBrowse:SetDescription("Agrupamento do Tipo Financeiro - WM")

oBrowse:Activate()

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ModelDef  �Autor  �Fabrica             � Data �  10/12/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Define o modelo de dados                                    ���
�������������������������������������������������������������������������͹��
���Uso       �NCIWMF08                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ModelDef() 

// Cria a estrutura a ser usada no Model
Local oStruPZS := FWFormStruct( 1, 'PZS', /*bAvalCampo*/, /*lViewUsado*/ ) 
Local oStruPZT := FWFormStruct( 1, 'PZT', /*bAvalCampo*/, /*lViewUsado*/ ) 
Local oModel


//Cria o objeto do Modelo de Dados
oModel := MPFormModel():New( 'NCIWMF8M', /*bPreValidacao*/, /*bPosValidacao*/, /*bCommit*/, /*bCancel*/ ) 

//Adiciona ao modelo uma estrutura de formul�rio de edi��o por campo (antiga enchoice)
oModel:AddFields( 'PZSMASTER', /*cOwner*/, oStruPZS, ) 

//Adiciona ao modelo uma estrutura de formul�rio de edi��o por grid (antiga getdados)
oModel:AddGrid( 'PZTDETAIL', 'PZSMASTER', oStruPZT, /*bLinePre*/, /*bLinePost*/, /*bPreVal*/, /*bPosVal*/, /*BLoad*/ ) 

//Faz relaciomaneto entre os compomentes do model
oModel:SetRelation("PZTDETAIL",{{"PZT_FILIAL","xFilial('PZT')"},{"PZT_COD","PZS_COD"}},PZT->(IndexKey()))

//Chave Primaria
oModel:SetPrimaryKey({"PZS_COD"})      

// Liga o controle de nao repeticao de linha
oModel:GetModel("PZTDETAIL"):SetUniqueLine({"PZT_FILIAL","PZT_COD","PZT_CODFIN"})         

//O preenchimento da grid � opcional (N�o � obrigatorio)
//oModel:GetModel("PZTDETAIL"):SetOptional(.T.)

//Adiciona a descricao do Modelo de Dados
oModel:SetDescription("Agrupamento do Tipo Financeiro - WM") 

//Adiciona a descricao do Componente do Modelo de Dados
oModel:GetModel( 'PZSMASTER' ):SetDescription( 'Master' ) 
oModel:GetModel( 'PZTDETAIL' ):SetDescription( 'Detail'  ) 

Return oModel


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ViewDef   �Autor  �Microsiga           � Data �  15/05/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Define a interface para cadastro                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �NCIWMF08                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ViewDef()      

// Cria um objeto de Modelo de Dados baseado no ModelDef do fonte informado 
Local oModel   	 :=  FWLoadModel( 'NCIWMF08' ) 
Local oView

// Cria a estrutura a ser usada na View
Local oStruPZS 	:= FWFormStruct( 2, 'PZS' ) 
Local oStruPZT 	:= FWFormStruct( 2, 'PZT' )

// Cria o objeto de View
oView := FWFormView():New() 

// Define qual o Modelo de dados ser� utilizado
oView:SetModel( oModel ) 

//Adiciona no nosso View um controle do tipo FormFields(antiga enchoice)
oView:AddField( 'VIEW_PZS', oStruPZS, 'PZSMASTER' )                     

//Adiciona no nosso View um controle do tipo FormGrid(antiga newgetdados)
oView:AddGrid(  'VIEW_PZT', oStruPZT, 'PZTDETAIL' ) 

// Criar "box" horizontal para receber algum elemento da view
oView:CreateHorizontalBox( 'SUPERIOR'  	, 40)
oView:CreateHorizontalBox( 'INFERIOR'  	, 50) 

// Relaciona o ID da View com o "box" para exibicao
oView:SetOwnerView( 'VIEW_PZS', 'SUPERIOR'   ) 
oView:SetOwnerView( 'VIEW_PZT', 'INFERIOR'     )                                     

Return oView        


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    |MenuDef   � Autor � Microsiga		        � Data �10/12/14  ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de defini��o do aRotina                             ���
�������������������������������������������������������������������������Ĵ��
���Retorno   � aRotina   retorna a array com lista de aRotina             ���
�������������������������������������������������������������������������Ĵ��
���Uso       � SIGAFAT                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function MenuDef() 
Local aRotina := {} 

ADD OPTION aRotina Title "Pesquisar"  				Action 'PesqBrw'         	OPERATION 1 ACCESS 0
ADD OPTION aRotina Title "Visualizar" 				Action 'VIEWDEF.NCIWMF08' 	OPERATION 2 ACCESS 0
ADD OPTION aRotina Title "Incluir"	    			Action 'VIEWDEF.NCIWMF08' 	OPERATION 3 ACCESS 0
ADD OPTION aRotina Title "Alterar"  				Action 'VIEWDEF.NCIWMF08'	OPERATION 4 ACCESS 0
ADD OPTION aRotina Title "Excluir"					Action 'VIEWDEF.NCIWMF08' 	OPERATION 5 ACCESS 0 

Return aRotina 


