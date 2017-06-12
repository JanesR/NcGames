#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGCD105  º Autor ³ FELIPE V. NAMBARA  º Data ³  27/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Controle de tabela genérica para envio ou não para o       º±±
±±º          ³ catálogo                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GHT - TECNOLOGIA DA INFORMAÇÃOO                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function NCGCD105()

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.
Private cString := "P0F"

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

Begin Sequence

	MyNewSxb()

	dbSelectArea("P0F")
	dbSetOrder(1)
		
	AxCadastro(cString,"Controle de tabela genéricia para envio ou não para o site",cVldExc,cVldAlt)
	
End Sequence

Return()

Static Function MyNewSxb()
Local aColsSxb	:= {}
Local nSxb		:= 1
Local nSxb2		:= 1

aAdd(aColsSxb,{"_SX501","1","01","RE","Selecao de Tabelas Genéricas Catálogo de Produtos","Selecao de Tabelas Genéricas Catálogo de Produtos","Selecao de Tabelas Genéricas Catálogo de Produtos"	,"SX5"				,""})
aAdd(aColsSxb,{"_SX501","2","01","01","                    	    						","                    	    						","                    	     						"	,"U_MyConPad()"   	,""})
aAdd(aColsSxb,{"_SX501","5","01","  ","						    						","						    						","						     						"	,"M->P0F_X5TAB"    	,""})

aAdd(aColsSxb,{"_SX502","1","01","RE","Selecao de Chaves Catálogo de Produtos"			,"Selecao de Chaves Catálogo de Produtos"			,"Selecao de Chaves Catálogo de Produtos"				,"SX5"				,""})
aAdd(aColsSxb,{"_SX502","2","01","01","                    	    						","                    	    						","                    	     						"	,"U_MyConPa2()"   	,""})
aAdd(aColsSxb,{"_SX502","5","01","  ","						    						","						    						","						     						"	,"M->P0F_X5CHV"    	,""})


SXB->(DbSetOrder(1))

For nSxb := 1 To Len(aColsSxb)
	
	If ! SXB->( DbSeek( Padr( aColsSxb[nSxb][1] , Len(SXB->XB_ALIAS))  + Padr( aColsSxb[nSxb][2] , Len(SXB->XB_TIPO) ) + Padr(aColsSxb[nSxb][3],Len(SXB->XB_SEQ)) + Padr(aColsSxb[nSxb][4],Len(SXB->XB_COLUNA))  ))
		
		If RecLock("SXB",.T.)
			
			For nSxb2 := 1 To SXB->(FCount())
				
				FieldPut(nSxb2,aColsSxb[nSxb][nSxb2])
				
			Next nSxb2
			
			SXB->(MsUnlock())
			
		EndIf
		
	EndIf
	
Next nSxb

Return()

User Function MyConPad()
Local cSql		:= ""
Local cAliasTmp	:= GetNextAlias()
Local llOk		:= .F.
Local aCoord	:=	MsAdvSize(.F.,.F.,0)
Local aMyHeader	:= {}   
Local aMyCols	:= {}
Local oGrid		:= Nil  
Local oDlg		:= Nil


cSql := " SELECT DISTINCT "
cSql += "			  X5_TABELA AS X5CODIGO "
cSql += "			 ,DECODE(X5_TABELA,'Z2','Gênero','ZU','Seleção','S0','Origem','02','Tipo Produto','21','Grupo Tributário','ZZ','Armazém Padrão','ZF','Classificação','Z4','Target') AS X5NOME  "
cSql += " FROM  " + RetSqlName("SX5") + " SX5 "

cSql += " WHERE X5_FILIAL = '" + xFilial("SX5") + "' "
cSql += " AND SX5.D_E_L_E_T_ = ' ' "
cSql += " AND X5_TABELA IN ('Z2','ZU','S0','02','21','ZZ','ZF','Z4') "

cSql += " ORDER BY X5_TABELA "
                                           
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAliasTmp, .F., .T.)

If (cAliasTmp)->(!Eof()) .And. (cAliasTmp)->(!Bof())
	
	While (cAliasTmp)->(!Eof())
		
		aAdd(aMyCols,{(cAliasTmp)->X5CODIGO,(cAliasTmp)->X5NOME,.F.})
		
		(cAliasTmp)->(DbSkip())
	EndDo
		
	oDlg	:= TDialog():New(aCoord[1],aCoord[2],aCoord[6]*0.30,aCoord[5]*0.30,"Selecao de Tabelas Genéricas Catálogo de Produtos" ,,,,,CLR_BLACK,CLR_WHITE,,,.T.)
		
	
	AAdd(aMyHeader,{					;
	"Tabela Genérica"					;	// X3_TITULO
	,"X5CODIGO"							;	// X3_CAMPO
	,"@!"								;	// X3_PICTURE
	,TamSx3("X5_TABELA")[1]				;	// X3_TAMANHO
	,0000								;	// X3_DECIMAL
	,""									;	// X3_VALID
	,""									;	// X3_USADO
	,"C"								;	// X3_TIPO
	,""									;	// X3_F3
	,"V"								;	// X3_CONTEXT
	,""									;	// X3_CBOX
	,""									;	// X3_RELACAO
	,""									;	// X3_WHEN
	,""									;	// X3_VISUAL
	,""									;	// X3_VLDUSER
	,""									;	// X3_PICTVAR
	,""									;	// X3_OBRIGAT
	})

	AAdd(aMyHeader,{					;
	"Nome"								;	// X3_TITULO
	,"X5NOME"							;	// X3_CAMPO
	,"@!"								;	// X3_PICTURE
	,40								;	// X3_TAMANHO
	,0000								;	// X3_DECIMAL
	,""									;	// X3_VALID
	,""									;	// X3_USADO
	,"C"								;	// X3_TIPO
	,""									;	// X3_F3
	,"V"								;	// X3_CONTEXT
	,""									;	// X3_CBOX
	,""									;	// X3_RELACAO
	,""									;	// X3_WHEN
	,""									;	// X3_VISUAL
	,""									;	// X3_VLDUSER
	,""									;	// X3_PICTVAR
	,""									;	// X3_OBRIGAT
	})
	
	
	oGrid	:= MsNewGetDados():New(0000,0000,0000,0000,1,"AllWaysTrue()","AllWaysTrue()","",,,9999,"AllWaysTrue()",,,oDlg,aClone(aMyHeader),aClone(aMyCols))
	oGrid:lInsert := .F.
	oGrid:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
	oGrid:oBrowse:BLDBLCLICK		:= {|| M->P0F_X5TAB := oGrid:aCols[oGrid:nAt][ aScan( oGrid:aHeader,{|x| Alltrim(x[2]) == "X5CODIGO"} ) ], oDlg:End() }
	oGrid:oBrowse:BRCLICKED 		:= {|| M->P0F_X5TAB := oGrid:aCols[oGrid:nAt][ aScan( oGrid:aHeader,{|x| Alltrim(x[2]) == "X5CODIGO"} ) ], oDlg:End() }
		
	oDlg:Activate(Nil,Nil,Nil,.T.,Nil,Nil,Nil,Nil,Nil)
	
EndIf

Return()

User Function MyConPa2()
Local cSql		:= ""
Local cAliasTmp	:= GetNextAlias()
Local llOk		:= .F.
Local aCoord	:=	MsAdvSize(.F.,.F.,0)
Local aMyHeader	:= {}   
Local aMyCols	:= {}
Local oGrid		:= Nil  
Local oDlg		:= Nil

cSql := " SELECT DISTINCT "
cSql += "			  X5_CHAVE AS X5CHAVE "
cSql += "			 ,X5_DESCRI AS X5DESCRI  "
cSql += " FROM  " + RetSqlName("SX5") + " SX5 "

cSql += " WHERE X5_FILIAL = '" + xFilial("SX5") + "' "
cSql += " AND SX5.D_E_L_E_T_ = ' ' "
cSql += " AND X5_TABELA = '" + M->P0F_X5TAB + "' "

cSql += " ORDER BY X5_CHAVE "
                                           
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAliasTmp, .F., .T.)

If (cAliasTmp)->(!Eof()) .And. (cAliasTmp)->(!Bof())
	
	While (cAliasTmp)->(!Eof())
		
		aAdd(aMyCols,{(cAliasTmp)->X5CHAVE,(cAliasTmp)->X5DESCRI,.F.})
		
		(cAliasTmp)->(DbSkip())
	EndDo
		
	oDlg	:= TDialog():New(aCoord[1],aCoord[2],aCoord[6]*0.30,aCoord[5]*0.30,"Selecao de Tabelas Genéricas Catálogo de Produtos" ,,,,,CLR_BLACK,CLR_WHITE,,,.T.)
		
	
	AAdd(aMyHeader,{					;
	"Chave"				  				;	// X3_TITULO
	,"X5CHAVE"							;	// X3_CAMPO
	,"@!"								;	// X3_PICTURE
	,TamSx3("X5_CHAVE")[1]				;	// X3_TAMANHO
	,0000								;	// X3_DECIMAL
	,""									;	// X3_VALID
	,""									;	// X3_USADO
	,"C"								;	// X3_TIPO
	,""									;	// X3_F3
	,"V"								;	// X3_CONTEXT
	,""									;	// X3_CBOX
	,""									;	// X3_RELACAO
	,""									;	// X3_WHEN
	,""									;	// X3_VISUAL
	,""									;	// X3_VLDUSER
	,""									;	// X3_PICTVAR
	,""									;	// X3_OBRIGAT
	})

	AAdd(aMyHeader,{					;
	"Valor"								;	// X3_TITULO
	,"X5DESCRI"							;	// X3_CAMPO
	,"@!"								;	// X3_PICTURE
	,TamSx3("X5_CHAVE")[1]		  		;	// X3_TAMANHO
	,0000								;	// X3_DECIMAL
	,""									;	// X3_VALID
	,""									;	// X3_USADO
	,"C"								;	// X3_TIPO
	,""									;	// X3_F3
	,"V"								;	// X3_CONTEXT
	,""									;	// X3_CBOX
	,""									;	// X3_RELACAO
	,""									;	// X3_WHEN
	,""									;	// X3_VISUAL
	,""									;	// X3_VLDUSER
	,""									;	// X3_PICTVAR
	,""									;	// X3_OBRIGAT
	})
	
	
	oGrid	:= MsNewGetDados():New(0000,0000,0000,0000,1,"AllWaysTrue()","AllWaysTrue()","",,,9999,"AllWaysTrue()",,,oDlg,aClone(aMyHeader),aClone(aMyCols))
	oGrid:lInsert := .F.
	oGrid:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
	oGrid:oBrowse:BLDBLCLICK		:= {|| M->P0F_X5CHV := oGrid:aCols[oGrid:nAt][ aScan( oGrid:aHeader,{|x| Alltrim(x[2]) == "X5CHAVE"} ) ], oDlg:End() }
	oGrid:oBrowse:BRCLICKED 		:= {|| M->P0F_X5CHV := oGrid:aCols[oGrid:nAt][ aScan( oGrid:aHeader,{|x| Alltrim(x[2]) == "X5CHAVE"} ) ], oDlg:End() }
		
	oDlg:Activate(Nil,Nil,Nil,.T.,Nil,Nil,Nil,Nil,Nil)
	
EndIf

Return()