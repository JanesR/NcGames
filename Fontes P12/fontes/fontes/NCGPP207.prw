#INCLUDE "PROTHEUS.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPP204  �Autor  �Elton Santana       � Data �  01/11/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Monitor de aprova��o de Price Protection		              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGPP207()

Local aArea 		:= GetArea()

Private cCadastro 	:= "Aprov.Price Protection"
Private oBrowse	
Private aRotina 	:= Menudef()

dbSelectArea("PZB")
dbSetOrder(1)

oBrowse := FWMBrowse():New() 
oBrowse:SetAlias("PZB")    

oBrowse:AddLegend("(Alltrim(PZB->PZB_STATUS) == '1') "	, "BR_VERDE"		, "Aprovado"  )
oBrowse:AddLegend("(Alltrim(PZB->PZB_STATUS) == '2' .Or. Alltrim(PZB->PZB_STATUS) == '4' ) "	, "BR_VERMELHO"		, "Reprovado"  )
oBrowse:AddLegend("(Alltrim(PZB->PZB_STATUS) == '3') "	, "BR_AMARELO"		, "Aguard.Aprova��o"  )

oBrowse:SetDescription(cCadastro) 
oBrowse:Activate() 
	
RestArea(aArea)
Return


/*/
���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �MenuDef   � Autor � Microsiga             � Data �00/00/0000���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Utilizacao de menu Funcional                               ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Array com opcoes da rotina.                                 ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function MenuDef()


Private aRotina := { }


AAdd(aRotina, {"Pesquisar"				, "AxPesqui"  	,0 	, 1})
AAdd(aRotina, {"Detalhe"				, "u_NCGAprPP"	, 0	, 2})
AAdd(aRotina, {"Legenda"				, "u_NCLegApr"	,0	, 6})     

Return(aRotina)


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � NCPP2Leg �Autor  �Elton C.	         � Data �  02/2014	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Legenda do browse                                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCLegApr()
Local aLegenda 	:= {}
Local aCores	:= {}

Aadd(aCores, {" (Alltrim(PZB->PZB_STATUS) == '1') "	, "BR_VERDE"		, "Aprovado"  })
Aadd(aCores, {" (Alltrim(PZB->PZB_STATUS) == '2') "	, "BR_VERMELHO"		, "Reprovado"  })
Aadd(aCores, {" (Alltrim(PZB->PZB_STATUS) == '3') "	, "BR_AMARELO"   	, "Aguard.Aprova��o"  } )


aEval(aCores, {|z| Aadd(aLegenda, {z[2], z[3]})})
BrwLegenda(cCadastro, "Legenda", aLegenda)

Return(Nil)




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � NCPP2Leg �Autor  �Elton C.	         � Data �  02/2014	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina com o detalhe da aprova��o                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGAprPP()

Local aArea := GetArea()
Local oDlg 
Local oWin01
Local oWin02
Local oFWLayer 
Local oButREnv
Local oButSair
Local aScreen 		:= GetScreenRes()
Local nWStage 		:= 800//aScreen[1]-45
Local nHStage 		:= 550//aScreen[2]-225
Local oButton		            

Local aCamposPZB	:= {"PZB_STATUS", "PZB_CODPP", "PZB_CODAPR", "PZB_NOMEUS", "PZB_MAIL", "PZB_NIVEL", "PZB_DTENV", "PZB_DTRESP", "PZB_OBS"}
Local cGet	   		:= ""     
Local aSize			:= MsAdvSize(.T.) 
Local aHeaderPZB  	:= {}
Local aColsPZB 		:= {}
Local cGet		:= ""
Local oTMultiget 			 

Private oGetDPZB  


//Preenche o aheader e o acols da tabela PZB
aHeaderPZB 	:= CriaHeader(aCamposPZB)//Cria o aheader da tabela PZB
aColsPZB 	:= CriaAcPZB(PZB->PZB_CODPP)//Cria o acols da tabela PZB


//Montagem da tela
DEFINE DIALOG oDlg TITLE "Aprova��o Price Protection" SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_OVERLAPPEDWINDOW)

//Cria instancia do fwlayer
oFWLayer := FWLayer():New()

//Inicializa componente passa a Dialog criada,o segundo parametro � para 
//cria��o de um botao de fechar utilizado para Dlg sem cabe�alho 		  
oFWLayer:Init( oDlg, .T. )

// Efetua a montagem das colunas das telas
oFWLayer:AddCollumn( "Col01", 100, .T. )


// Cria windows passando, nome da coluna onde sera criada, nome da window			 	
// titulo da window, a porcentagem da altura da janela, se esta habilitada para click,	
// se � redimensionada em caso de minimizar outras janelas e a a��o no click do split 	
oFWLayer:AddWindow( "Col01", "Win01", "Seq.Aprova��o", 50, .F., .T., ,,) 
oFWLayer:AddWindow( "Col01", "Win02", "Observa��es", 50 , .F., .T., {|| .T. },,)                           


oWin01 := oFWLayer:getWinPanel('Col01','Win01')
oWin02 := oFWLayer:getWinPanel('Col01','Win02')


//Cria a getdados da tabela PZB
oGetDPZB := MsNewGetDados():New(005,005,(aSize[4]*50/100)-45,aSize[3]-270 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeaderPZB,aColsPZB, {|| RefresDet(@oTMultiget,@cGet,Alltrim(GdFieldGet("PZB_OBS")))})

oTMultiget := TMultiGet():New( 005,005, {|u| if( Pcount()>0, cGet:= u, cGet) },oWin02,375,oWin02:nClientHeight - (oWin02:nClientHeight * 60)/100 ,,.T.,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,.T.)
                                                            

oButREnv		:= TButton():New( oWin02:nClientHeight - (oWin02:nClientHeight * 56)/100, 295, "Reenv.E-mail",oWin02,{ || u_NCWFReenv(PZB->PZB_CODPP) }, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
oButSair		:= TButton():New( oWin02:nClientHeight - (oWin02:nClientHeight * 56)/100, 350, "Sair",oWin02,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )

             
ACTIVATE DIALOG oDlg CENTERED

RestArea(aArea)
Return                                                       


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CriaHeader�Autor  �Elton C.	         � Data �  02/2014	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Cria o aHeader						                   	  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CriaHeader(aCampos)
Local aArea		:= GetArea()
Local aRet	 	:= {}
Local nIx		:= 0

Default aCampos := {}

DbSelectArea( "SX3" )
DbSetOrder(2)

For nIx := 1 To Len( aCampos )
	If SX3->( MsSeek( aCampos[ nIx ] ) )
		
		cDescCpo := X3Titulo() 		
		
		aAdd( aRet, {AlLTrim( cDescCpo)	, ;	// 01 - Titulo
						SX3->X3_CAMPO	, ;	// 02 - Campo
						SX3->X3_Picture	, ;	// 03 - Picture
						SX3->X3_TAMANHO	, ;	// 04 - Tamanho
						SX3->X3_DECIMAL	, ;	// 05 - Decimal
						SX3->X3_Valid  	, ;	// 06 - Valid
						SX3->X3_USADO  	, ;	// 07 - Usado
						SX3->X3_TIPO   	, ;	// 08 - Tipo
						SX3->X3_F3		, ;	// 09 - F3
						SX3->X3_CONTEXT	, ;	// 10 - Contexto
						SX3->X3_CBOX	, ; // 11 - ComboBox
						SX3->X3_RELACAO	} )	// 12 - Relacao
	Endif
Next

RestArea( aArea )

Return aRet




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CriaAcPZB	�Autor  �Elton C.          � Data �  02/2014	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Cria e atualiza o aCols                                     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
*/
Static Function CriaAcPZB(cCodPP)
Local aArea    		:= GetArea()
Local aStruct	 	:= {}
Local nX			:= 0
Local aRet			:= {}
Local cAliasTmp		:= ""
Local cQuery		:= ""

Default cCodPP 	:= ""


cAliasTmp := GetNextAlias()

cQuery :=  "SELECT PZB_CODPRO,PZB_STATUS, PZB_CODPP, PZB_CODAPR, PZB_NOMEUS, PZB_MAIL, PZB_NIVEL, PZB_DTENV, PZB_DTRESP, 
cQuery +=  " utl_raw.cast_to_varchar2(DBMS_LOB.SUBSTR(PZB_OBS,2000,1)) PZB_OBS FROM "+RetSqlName("PZB")
cQuery +=  " WHERE PZB_FILIAL = '"+xFilial("PZB")+"'  "
cQuery +=  " AND PZB_CODPP = '"+cCodPP+"' "
cQuery +=  " AND D_E_L_E_T_ = ' ' "
cQuery +=  " ORDER BY PZB_CODPRO, PZB_NIVEL, PZB_NOMEUS "

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

aStruct   := PZB->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX
 
aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())

	aAdd(aRet,{ (cAliasTmp)->PZB_STATUS,;
				(cAliasTmp)->PZB_CODPP,;
				(cAliasTmp)->PZB_CODAPR,;
				(cAliasTmp)->PZB_NOMEUS,;
				(cAliasTmp)->PZB_MAIL,;
				(cAliasTmp)->PZB_NIVEL,;
				(cAliasTmp)->PZB_DTENV,;
				(cAliasTmp)->PZB_DTRESP,;
				(cAliasTmp)->PZB_OBS,;								
				.F.})

	(cAliasTmp)->(dbSkip())
EndDo

If Len(aRet) == 0
	aAdd(aRet,{"",;
				"",;
				"",;
				"",;
				"",;
				CTOD(''),;
				CTOD(''),;
				"",;
				.F.})
	
EndIf

(cAliasTmp)->(DbCloseArea())

RestArea( aArea )
Return aRet     


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RefresDet�Autor  �Elton C.	         � Data �  02/2014	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Atualiza o campo de detalhe do monitor, na mudan�a de linha ���
���          �do acols                                                    ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RefresDet(oTMultiget,cGet,cObs)

Local aArea 	:= GetArea()

Default cObs	:= ""

cGet := Alltrim(cObs)
oTMultiget:Refresh()

RestArea(aArea)
Return

