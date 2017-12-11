#Include "PROTHEUS.CH "
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGINT001 ºAutor  ³Microsiga           º Data ³  06/19/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGINT001()
Local aAreaAtu :=GetArea()
Local aAreaSF1 :=SF1->(GetArea())
Local aAreaSD1 :=SD1->(GetArea())
Local cLojaWM	:=""                
Local cNomeWM	:=""
Local aProdutos:={}

If INT001VldNf(aProdutos,@cLojaWM,@cNomeWM) .And. MsgYesNo("Enviar Nota Fiscal "+SF1->(AllTrim(F1_DOC)+"-"+F1_SERIE)+" para Loja "+cLojaWM+"-"+cNomeWM+"?","NcGames")
	INT001Integra(aProdutos,cLojaWM)
EndIf

RestArea(aAreaSF1)
RestArea(aAreaSD1)
RestArea(aAreaAtu)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGINT001 ºAutor  ³Microsiga           º Data ³  06/20/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function INT001VldNf(aProdutos,cLojaWM,cNomeWM)
Local aAreaAtu		:=GetArea()
Local cQryAlias	:=GetNextAlias()
Local cFilSD1		:=xFilial("SD1")
Local cMensagem	:=""
Local lRetorno:=.F.
Local nAscan
Local aDadosWM:=U_INT001LJMW()
Local nTotUnit  
Local cCfopPerm:=Alltrim(U_MyNewSX6("NC_NCINT01","1102*1403*1910*2102*2403*2910","C","CFOPS que serão enviadas WM.","","",.F. ))


cLojaWM:=aDadosWM[1]
cNomeWM:=aDadosWM[2]

If !cEmpAnt$"03*40"    
	lRetorno:=.F.
ElseIf JaExiste(cLojaWM,@cMensagem)
	//cMensagem:="Nota Fiscal já enviada em "+DTOC(SF1->F1_YDENVWM)+" ás "+SF1->F1_YHENVWM+"."
	lRetorno:=.F.
ElseIf Empty(cLojaWM)
	cMensagem+="Não foi possível verificar qual loja destino do WebManager"+CRLF+" Envio da Nota Fiscal cancelado."
	lRetorno:=.F.
ElseIf Empty(SF1->F1_YCODMOV)

	SD1->(DbSetOrder(1))//D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM
	SD1->(MsSeek(cFilSD1+SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA) ))
	
	Do While SD1->(!Eof()) .And. SD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA)==cFilSD1+SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA)
		
		If !SD1->D1_TP=="PA" .Or. AvalTes(SD1->D1_TES,"N") .Or. !AllTrim(SD1->D1_CF)$cCfopPerm
			SD1->(DbSkip());Loop
		EndIf
		                                               
		nTotUnit:=SD1->((D1_TOTAL+D1_VALIPI+D1_ICMSRET+D1_VALFRE+D1_SEGURO+D1_DESPESA-D1_VALDESC)/D1_QUANT)

		//Verifica se o produto ja foi utilizado para não haver duplicidade 
		If (nAscan:=Ascan(aProdutos,{|a|a[1]==SD1->D1_COD}  )) != 0
			aProdutos[nAscan,2]	+= SD1->D1_QUANT
			aProdutos[nAscan,3]	+= nTotUnit
			aProdutos[nAscan,4]	+= SD1->D1_PICM
		
		ElseIf(nAscan:=Ascan(aProdutos,{|a|a[1]==SD1->D1_COD .And. a[4]==SD1->D1_PICM }  ))==0
			SD1->(AADD(aProdutos,{D1_COD,D1_QUANT,nTotUnit,D1_PICM,D1_VUNIT} ))
		Else
			aProdutos[nAscan,2]	+=SD1->D1_QUANT
			aProdutos[nAscan,3]	+=nTotUnit
		EndIF

		
		/*If (nAscan:=Ascan(aProdutos,{|a|a[1]==SD1->D1_COD .And. a[4]==SD1->D1_PICM }  ))==0
			SD1->(AADD(aProdutos,{D1_COD,D1_QUANT,nTotUnit,D1_PICM,D1_VUNIT} ))
		Else
			aProdutos[nAscan,2]+=SD1->D1_QUANT
			aProdutos[nAscan,3]+=nTotUnit
		EndIF*/
		
		SD1->(DbSkip())
	EndDo
	
	If Len(aProdutos)==0
		cMensagem:="Não foram encontrado nenhum produto para envio ao WM."+CRLF+" Envio da Nota Fiscal cancelado."
		lRetorno:=.F.
	Else
		lRetorno:=.T.
	EndIf
	
EndIf

If !Empty(cMensagem)
	MsgStop(cMensagem,"NcGames-"+ProcName(0))
EndIf

RestArea(aAreaAtu)
Return lRetorno
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGINT001 ºAutor  ³Microsiga           º Data ³  06/20/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function INT001Integra(aProdutos,cLojaWM)
Local aAreaAtu		:=GetArea()
Local aAreaSD1		:=GetArea()
Local cQryAlias	:=GetNextAlias()
Local cProdWM
Local cErro			:=""
Local cChaveSD1

INT001EnvNF(cLojaWM,aProdutos)


RestArea(aAreaSD1)
RestArea(aAreaAtu)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGINT001 ºAutor  ³Microsiga           º Data ³  06/20/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function INT001LJMW(cCNPJ)
Local aAreaAtu	:=GetArea() 
Local cAliasQry:=GetNextAlias()
Local aLojaAux	:= {}
Local cTabela	:="00006"
Local aRetorno	:={"",""}
Local cModo		:=""
Local aRet		:={}        
Local aCombo	:= {}
Local aDescLj	:= {}
Local cNomeLj	:= ""
Local cLjDest	:= ""
Local cQuery	:= ""
Local cAliasQry := GetNextAlias()
Local cEmpAux	:= Alltrim(U_MyNewSX6("NC_NCWMEMP",;
									"01",;
									"C",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									.F. ))


Default cCNPJ:=SM0->M0_CGC

cQuery	:= " SELECT ZX5.ZX5_CHAVE,ZX5.ZX5_DESCRI FROM "+RetFullName("ZX5", cEmpAux)+" ZX5 "+CRLF

cQuery	+= " WHERE  ZX5_FILIAL = '"+xFilial("ZX5")+"'  "+CRLF
cQuery	+= " AND ZX5.ZX5_DESCRI LIKE '%"+cEmpAnt+";"+cFilAnt+"%' "+CRLF
cQuery	+= " AND ZX5.ZX5_TABELA= '"+cTabela+"'  "+CRLF
cQuery	+= " AND ZX5.D_E_L_E_T_= ' '  "+CRLF
cQuery	+= " ORDER BY  1 "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasQry , .F., .T.)

Do While (cAliasQry)->(!Eof())
	                  
	cNomeLj := ""	
	aDescLj := {}	
	aDescLj := Separa((cAliasQry)->ZX5_DESCRI,";")
	
	If Len(aDescLj) >= 3
		cNomeLj := Alltrim(aDescLj[3])
	Else
		cNomeLj := ""	
	EndIf		
	
	AADD(aCombo, (cAliasQry)->ZX5_CHAVE+"="+cNomeLj )

	(cAliasQry)->(DbSkip())
EndDo 

If Len(aCombo)==1

	aLojaAux := separa(aCombo[1],"=")
	
	If Len(aLojaAux)>0
		cLjDest		:= Alltrim(aLojaAux[1])
	Else
		cLjDest := ""	
	EndIf

	aRetorno[1]:= cLjDest

Elseif Len(aCombo)>1
 	cLjDest := PergLjDest(aCombo)	
	aRetorno[1] := cLjDest

Endif
                         

(cAliasQry)->(DbCloseArea())
RestArea(aAreaAtu)
Return aRetorno   




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³PergRel	ºAutor  ³Microsiga	     º Data ³  17/02/2012 	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
	±±ºDesc.     ³ 																        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PergLjDest(aCombo)

Local aParamBox := {}
Local cRetLj    := ""
Local aLojaAux	 := {}
Local aParam	 := {}


aAdd(aParamBox,{2,"Informe a loja destino"			,aCombo[1]	, aCombo	,120,".T."					,.T.})

If ParamBox(aParamBox, "Parâmetros", aParam, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .t., .t.)
	
	aLojaAux := separa(aParam[1],"=")
	
	If Len(aLojaAux)>0
		cRetLj		:= Alltrim(aLojaAux[1])
	Else
		cRetLj := ""	
	EndIf

Else
	Aviso("Obrigatório ","Informação obrigatória",{"Ok"},2)	
	cRetLj := PergLjDest(aCombo)
EndIf
                              
If Empty(cRetLj)
	Aviso("Obrigatório ","Informação obrigatória",{"Ok"},2)	
	cRetLj := PergLjDest(aCombo)              
EndIf

Return cRetLj



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGINT001 ºAutor  ³Microsiga           º Data ³  06/20/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function INT001EnvNF(cLojaWM,aProdutos)
Local aAreaAtu:=GetArea()
Local nInd
Local cScript	:=""
Local cMensagem:=""
Local cQuery
Local lEnviado:=.F.
Local nCodConf:=0
Local cCodRef:=SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO)
Local cLjSemConf:=Alltrim(U_MyNewSX6("NCG_000112","3001/3009","C","lOJAS SEM CONF. CEGA","","",.F. ))

SD1->(DbSetOrder(1))
SD1->(MsSeek(xFilial("SD1")+SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA) ))


cQuery:=" Select Cod_conferencia From "+U_NCGetBWM("Conferencia_cega")
cQuery+=" Where Cod_referencia='"+cCodRef+"'"
cAliasQry:=U_NCIWMF02(cQuery,"1",@cMensagem)

If Select(cAliasQry)>0
	nCodConf:=(cAliasQry)->Cod_conferencia
	(cAliasQry)->(DbCloseArea())
EndIf

If cLojaWM $ cLjSemConf
	MsgAlert("Esta nota fiscal não será enviada para a conferência cega! Motivo: Não é uma operação entre lojas.","NCGINT001- ENV NOTA")
	RestArea(aAreaAtu)
	Return .F.
EndIF

If nCodConf>0
	MsgStop("Nota Fsical já consta na base da loja "+cLojaWM,"Nc Games")
	RestArea(aAreaAtu)
	Return .F.
Else
	
	cScript:="INSERT INTO "+u_NCGetBWM("Conferencia_cega")+CRLF
	cScript+="("+CRLF
	cScript+=" [Cod_referencia]"+CRLF
	//cScript+=",[Cod_fornecedor_WM]"+CRLF
	cScript+=",[CNPJ_fornecedor]"+CRLF
	cScript+=",[Cod_loja_WM]"+CRLF
	cScript+=",[CNPJ_loja]"+CRLF
	//cScript+=",[Cod_usuario]"+CRLF
	cScript+=",[Data_nota]"+CRLF
	cScript+=",[Numero_nota]"+CRLF
	cScript+=",[Total]"+CRLF
	//cScript+=",[Obs]"+CRLF
	cScript+=",[Estado]"+CRLF
	//cScript+=",[Data_inicio]"+CRLF
	//cScript+=",[Data_conclusao]"+CRLF
	cScript+=",[Valor_IPI]"+CRLF
	cScript+=",[Base_ICMS]"+CRLF
	cScript+=",[Valor_ICMS]"+CRLF
	cScript+=",[Base_ICMS_ST]"+CRLF
	cScript+=",[Valor_ICMS_ST]"+CRLF
	cScript+=",[CST_origem]"+CRLF
	cScript+=",[CFOP]"+CRLF
	cScript+=",[Data_cadastrou]"+CRLF
	//cScript+=",[Etapa_conferencia]"+CRLF
	cScript+=")"+CRLF
	
	cScript+="VALUES"+CRLF
	
	cScript+="("+CRLF
	
	cScript+="'"+cCodRef+"'"
	//cScript+=","+<Cod_fornecedor_WM, bigint,>
	cScript+=",'"+TransForm(Posicione("SA2",1,xFilial("SA2")+SF1->(F1_FORNECE+F1_LOJA),"A2_CGC" ),'@R 99.999.999/9999-99')+"'"
	cScript+=",'"+cLojaWM+"'"
	cScript+=",'"+Transform(SM0->M0_CGC,'@R 99.999.999/9999-99')+"'"
	//cScript+=","+<Cod_usuario, bigint,>
	cScript+=","+INT001Trans(SF1->F1_EMISSAO,"D")
	cScript+=","+SF1->F1_DOC
	cScript+=","+INT001Trans(SF1->F1_VALBRUT,"N")
	//cScript+=","+<Obs, varchar(255),>
	cScript+=","+"0"
	//cScript+=","+<Data_inicio, datetime,>
	//cScript+=","+<Data_conclusao, datetime,>
	cScript+=","+INT001Trans(SF1->F1_VALIPI,"N")
	cScript+=","+INT001Trans(SF1->F1_BASEICM,"N")
	cScript+=","+INT001Trans(SF1->F1_VALICM,"N")
	cScript+=","+INT001Trans(SF1->F1_BRICMS,"N")
	cScript+=","+INT001Trans(SF1->F1_ICMSRET,"N")
	cScript+=",'"+SubStr(SD1->D1_CLASFIS,2,1)+"'"
	cScript+=",'"+SD1->D1_CF+"'"
	cScript+=","+INT001Trans(MsDate(),"D")
	cScript+=")"+CRLF
	
	U_NCIWMF02(cScript,"2",@cMensagem)
	
	If !Empty(cMensagem)
		MsgStop(cMensagem+CRLF+" Envio da Nota Fiscal cancelado.")
		Return .F.
	EndIf
	
	cQuery:=" Select Cod_conferencia From "+U_NCGetBWM("Conferencia_cega")
	cQuery+=" Where Cod_referencia='"+cCodRef+"'"
	cAliasQry:=U_NCIWMF02(cQuery,"1",@cMensagem)
	
	If Select(cAliasQry)>0
		nCodConf:=(cAliasQry)->Cod_conferencia
		(cAliasQry)->(DbCloseArea())
	EndIf
	
	If !Empty(cMensagem)
		MsgStop(cMensagem+CRLF+" Envio da Nota Fiscal cancelado.")
		Return .F.
	EndIf
	
EndIf


If nCodConf>0
	
	For nInd:=1 To Len(aProdutos)
		
		cScript:="INSERT INTO "+u_NCGetBWM("Conferencia_cega_item")+CRLF
		cScript+="("+CRLF
		cScript+="[Cod_conferencia]"+CRLF
		cScript+=",[Cod_produto_WM]"+CRLF
		cScript+=",[Quantidade_original]"+CRLF
		cScript+=",[Quantidade]"+CRLF
		cScript+=",[Qtde_aux1]"+CRLF
		cScript+=",[Qtde_aux2]"+CRLF
		cScript+=",[Qtde_aux3]"+CRLF
		cScript+=",[Valor]"+CRLF
		cScript+=",[ICMS]"+CRLF
		cScript+=",[NCM]"+CRLF
		//cScript+=",[Obs]"+CRLF
		//cScript+=",[Conferido]"+CRLF
		cScript+=",[Data_cadastrou]"+CRLF
		cScript+=")"+CRLF
		
		cScript+="VALUES"+CRLF
		cScript+="("+CRLF
		
		cScript+=""+AllTrim(Str(nCodConf))
		cScript+=","+AllTrim(aProdutos[nInd,1])
		cScript+=","+INT001Trans(aProdutos[nInd,2],"N")
		cScript+=",0"
		cScript+=",0"
		cScript+=",0"
		cScript+=",0"
		cScript+=","+INT001Trans(aProdutos[nInd,3],"N")
		cScript+=","+INT001Trans(aProdutos[nInd,4],"N")
		cScript+=",'"+AllTrim(Posicione("SB1",1,xFilial("SB1")+aProdutos[nInd,1],"B1_POSIPI"))+"'"
		//cScript+=","+AllTrim(Str(aProdutos[nInd,5]))
		//cScript+=",<Conferido, tinyint,>
		cScript+=","+INT001Trans(MsDate(),"D")
		//cScript+=","+<Etapa_conferencia, tinyint,>
		//cScript+=","+<NAO_USAR, tinyint,>)//,<Etapa_conferencia, tinyint,>
		
		cScript+=")"+CRLF
		
		U_NCIWMF02(cScript,"2",@cMensagem)
		
		If !Empty(cMensagem)
			MsgStop(cMensagem+CRLF+" Envio da Nota Fiscal cancelado.")
			Return .F.
		EndIf
		
		
	Next
	
	Begin Transaction
	SF1->(RecLock("SF1",.F.))
	SF1->F1_YDENVWM:=MsDate()
	SF1->F1_YHENVWM:=Time()
	SF1->F1_YUENVWM:=cUserName
	SF1->(MsUnLock())
	End Transaction
	MsgInfo("Nota Fiscal "+SF1->(F1_DOC+"-"+F1_SERIE)+" enviada com sucesso.","Nc Games" )
	
EndIf
RestArea(aAreaAtu)

Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGINT001 ºAutor  ³Microsiga           º Data ³  06/20/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function INT001Trans(xDado,cTipo)
Local xRetorno

If cTipo=="D"
	xRetorno:="CAST(N'"+StrZero(Year(xDado),4)+"-"+StrZero(Month(xDado),2)+"-"+StrZero(Day(xDado),2)+" 00:00:00.000' AS DateTime)"
ElseIf cTipo=="N"
	xRetorno:=AllTrim(Str(Round(xDado,2)))
EndIf



Return xRetorno
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGINT001 ºAutor  ³Microsiga           º Data ³  06/20/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function INT001DEV(aDados)
Local aAreaAtu:=GetArea()
Local cQuery
Local cMensagem
Local cAliasQry
Local cQryItem
Local nCodConf
Local lMata103
Local	aCabec
Local	aItens
Local aItensAux
Local nLenD1Item
Local nItemSD1

Default aDados:={"","",.F.}

If aDados[3] //Job
	RpcClearEnv()
	RpcSettype(3)
	RpcSetEnv(aDados[1],aDados[2])
EndIf
nLenD1Item	:=AvSx3("D1_ITEM",3)
lMata103		:=IsIncallStack("MATA103")


cQuery:=" Select Cod_conferencia,Cod_referencia
cQuery+=" From "+U_NCGetBWM("Conferencia_cega")
cQuery+=" Where Estado In (2,0)"

If lMata103
	cQuery+=" And Cod_referencia='"+SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA)+"'"
EndIf
cQuery+=" Order By Cod_conferencia"

cAliasQry:=U_NCIWMF02(cQuery,"1",@cMensagem)

If Select(cAliasQry)==0
	If lMata103
		MsgStop(cMensagem,"NcGames-"+ProcName(1))
		Return
	EndIf
EndIf

SF1->(DbSetOrder(1))//F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO
Do While (cAliasQry)->(!Eof())
	
	If !SF1->(MsSeek(xFilial("SF1")+AllTrim((cAliasQry)->Cod_referencia)))
		(cAliasQry)->(DbSkip());Loop
	EndIf
	
	cQuery:=" Select *"
	cQuery+=" From "+U_NCGetBWM("Conferencia_cega_item")
	cQuery+=" Where Cod_conferencia="+AllTrim(Str((cAliasQry)->Cod_conferencia))
	cQuery+=" Quantidade_original-Quantidade>0"
	cQuery+=" Order By Cod_conferencia"
	cQryItem:=U_NCIWMF02(cQuery,"1",@cMensagem)
	
	If Select(cQryItem)==0
//		MsgStop("Ocorreu um erro na busca dos itens da Conferencia "+AllTrim(Str((cAliasQry)->Cod_conferencia),"NcGames"))
		Exit
	EndIf
	
	aCabec	:={}
	aItens	:={}
	nItemSD1	:=0
	
	Do While (cQryItem)->(!Eof())
	   
		nSaldo	:=(cQryItem)->(Quantidade_original-Quantidade)
		nVlrUnit :=Val(AllTrim((cQryItem)->Obs))
		aItensAux:={}
		aadd(aItensAux,{"D1_ITEM"	,StrZero(++nItemSD1,nLenD1Item)	,Nil})
		AADD(aItensAux,{"D1_COD"	,(cQryItem)->Cod_produto_WM		,Nil})
		AADD(aItensAux,{"D1_LOCAL"	,"01"										,Nil})
		AADD(aItensAux,{"D1_QUANT"	,nSaldo									,Nil})
		AADD(aItensAux,{"D1_VUNIT",nVlrUnit									,Nil})
		AADD(aItensAux,{"D1_TOTAL"	,nVlrUnit*nSaldo						,Nil})
		
		
		/*
		aNfeOrig:=GetNFSaida((cAliasPZR)->PZR_ORIVEN, cProduto )
		
		If !Empty(aNfeOrig[1])
			AADD(aItensAux,{"D1_NFORI"	,aNfeOrig[1]								,Nil})
		EndIf
		
		If !Empty(aNfeOrig[2])
			AADD(aItensAux,{"D1_SERIORI"	,aNfeOrig[2]								,Nil})
		EndIf
		If !Empty(aNfeOrig[3])
			AADD(aItensAux,{"D1_ITEMORI"	,aNfeOrig[3]								,Nil})
		EndIf
		*/
		
		AADD(aItens, aItensAux)
		
		(cQryItem)->(DbSkip())
	EndDo
	
		AADD(aCabec,{"F1_TIPO"   	,"D"})
		AADD(aCabec,{"F1_FORMUL" 	,cFormul								})
		AADD(aCabec,{"F1_DOC"    	,cNFiscalF1  				})
		AADD(aCabec,{"F1_SERIE"  	,cNfSerie				})//(cAliasPZR)->PZR_SERIE
		AADD(aCabec,{"F1_EMISSAO"	,(cAliasPZQ)->PZQ_EMISSA			})
		AADD(aCabec,{"F1_FORNECE"	,cCliForn								})
		AADD(aCabec,{"F1_LOJA"   	,cLojaCliFor								})
		AADD(aCabec,{"F1_COND"		,"001"									})
		AADD(aCabec,{"F1_ESPECIE"	,"NFE"	})
		AADD(aCabec,{"F1_DESCONT"	,0											})
		AADD(aCabec,{"F1_DESPESA"	,0											})
		AADD(aCabec,{"F1_FRETE"		,0											})
		AADD(aCabec,{"F1_SEGURO"	,0											})
		AADD(aCabec,{"F1_YCODMOV"   ,(cAliasPZQ)->PZQ_CODMOV			})
		AADD(aCabec,{"F1_YLOJAWM"   ,(cAliasPZQ)->PZQ_CODLOJ			})
		AADD(aCabec,{"F1_YTOPER"   , (cAliasPZQ)->PZQ_OPER			})
		AADD(aCabec,{"F1_CHVNFE"	,(cAliasPZR)->PZR_CHVACE			})
	
	
	
	
	
EndDo




(cAliasQry)->(DbCloseArea())
RestArea(aAreaAtu)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGINT001 ºAutor  ³Microsiga           º Data ³  06/20/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGINT001 ºAutor  ³Microsiga           º Data ³  06/20/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function INT001BACA()

RpcSetEnv("03","01")
DbUseArea( .T.,"DBFCDXADS" , "\base\sa7wm.dbf", "SA7WM", .F. )
SA7->(DbSetOrder(1))//A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO

SA7WM->(DbGoTop())
Do While SA7WM->(!Eof())
	lAppend:=!SA7->(MsSeek(xFilial("SA7")+"00000001"+SA7WM->A7_PRODUTO)  )
	RecLock("SA7",lAppend)
	AvReplace("SA7WM","SA7")
	SA7->A7_CLIENTE:="000000"
	SA7->A7_LOJA	:="01"
	SA7->(MsUnLock())
	SA7WM->(DbSkip())
EndDo
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGINT001 ºAutor  ³Microsiga           º Data ³  06/28/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function JaExiste(cLojaWM,cMensagem)
Local aAreaAtu :=GetArea()
Local cCodRef:=SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO)
Local cMensagem:=""
Local cCodConf
Local cScript
Local lJaExiste:=.F.
Local cQuery             


cQuery:=" Select Cod_conferencia,Estado From "+U_NCGetBWM("Conferencia_cega")
cQuery+=" Where Cod_referencia='"+cCodRef+"'"
cQuery+=" And Cod_loja_WM = '"+cLojaWM+"' "
cAliasQry:=U_NCIWMF02(cQuery,"1",@cMensagem)

If Select(cAliasQry)>0
	
	Do While (cAliasQry)->(!Eof())
		
		If (cAliasQry)->Estado<>0
			cMensagem	:="Nota Fiscal em fase de conferencia."
		Else
			If Aviso("Atenção","Conferencia cega já existe. Deseja excluir e enviar novamente?",{"Sim","Não"},2) == 1
				cCodConf:=AllTrim(Str((cAliasQry)->Cod_conferencia))			
				cScript:="DELETE FROM "+u_NCGetBWM("Conferencia_cega")+" WHERE Cod_conferencia="+cCodConf
				U_NCIWMF02(cScript,"2",@cMensagem)
				cScript:="DELETE FROM "+u_NCGetBWM("Conferencia_cega_item")+" WHERE Cod_conferencia="+cCodConf
				U_NCIWMF02(cScript,"2",@cMensagem)
			EndIf			
		EndIf		
		(cAliasQry)->(	DbSkip())
	EndDo
	
	
	
	(cAliasQry)->(DbCloseArea())
EndIf


cQuery:=" Select Count(1) Contar From "+U_NCGetBWM("Conferencia_cega")
cQuery+=" Where Cod_referencia='"+cCodRef+"'"
cQuery+=" And Cod_loja_WM = '"+cLojaWM+"' "         


cAliasQry:=U_NCIWMF02(cQuery,"1",@cMensagem)

If Select(cAliasQry)>0 
	lJaExiste:=(cAliasQry)->Contar>0
	(cAliasQry)->(DbCloseArea())
EndIf
	

RestArea(aAreaAtu)
Return lJaExiste    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGINTEX1 ºAutor  ³Microsiga           º Data ³  06/19/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³EXCLUI CONFERENCIA CEGA                                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGINTEX1()
Local aAreaAtu 	:=GetArea()
Local cQuery	:= ""
Local cLojaWM	:= ""
Local cArqTmp	:= GetNextAlias()
Local cTabela	:="00006"
Local cMensagem	:= ""
Local lExcConfC	:= .T.
Local cEmpAux	:= Alltrim(U_MyNewSX6("NC_NCWMEMP",;
									"01",;
									"C",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									.F. ))


cQuery	:= " SELECT ZX5.ZX5_CHAVE,ZX5.ZX5_DESCRI FROM "+RetFullName("ZX5", cEmpAux)+" ZX5 "+CRLF

cQuery	+= " WHERE  ZX5_FILIAL = '"+xFilial("ZX5")+"'  "+CRLF
cQuery	+= " AND ZX5.ZX5_DESCRI LIKE '%"+cEmpAnt+";"+cFilAnt+"%' "+CRLF
cQuery	+= " AND ZX5.ZX5_TABELA= '"+cTabela+"'  "+CRLF
cQuery	+= " AND ZX5.D_E_L_E_T_= ' '  "+CRLF
cQuery	+= " ORDER BY  1 "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

If (cArqTmp)->(!Eof())
	//Loja no Web Manager
	cLojaWM := Alltrim((cArqTmp)->ZX5_CHAVE)
	
	If Aviso("Atenção","Deseja excluir o documento "+SF1->F1_DOC+" da conferência da loja "+cLojaWM+" ? ",{"Sim","Não"},2) == 1
	
		//Executa a rotina para exclusão da conferência cega	
		lExcConfC	:= ExcConfC(cLojaWM,@cMensagem)    
		
		If !lExcConfC
			Reclock("SF1", .F.)
			SF1->F1_YDENVWM := ctod('')
			SF1->F1_YHENVWM := ""
			SF1->(MsUnLock())		

			Aviso("Êxito","Conferência cega excluída com sucesso.",{"Ok"},2)
		Else
			Aviso("Atenção",cMensagem,{"Ok"},2)	
		EndIf                                                                       
	
	EndIf
	
Else
	Aviso("Atenção","Loja não cadastrada na tabela De/Para. Entre em conta com administrador (ZX5 - Tabela 00006)",{"Ok"},2)
EndIf

If Select(cArqTmp)>0 
	(cArqTmp)->(DbCloseArea())
EndIf

RestArea(aAreaAtu)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ExcConfC ºAutor  ³Microsiga           º Data ³  06/28/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ExcConfC(cLojaWM,cMensagem)
Local aAreaAtu :=GetArea()
Local cCodRef:=SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO)
Local cCodConf
Local cScript
Local lJaExiste:=.F.
Local cQuery             

Default cMensagem := ""

cQuery:=" Select Cod_conferencia,Estado From "+U_NCGetBWM("Conferencia_cega")
cQuery+=" Where Cod_referencia='"+cCodRef+"'"
cQuery+=" And Cod_loja_WM = '"+cLojaWM+"' "
cAliasQry:=U_NCIWMF02(cQuery,"1")

If Select(cAliasQry)>0
	
	Do While (cAliasQry)->(!Eof())
		
		If (cAliasQry)->Estado<>0
			If (cAliasQry)->Estado == 1
				cMensagem	:="Processo de conferência cega em andamento, nota fiscal não pode ser excluída! Entrar em contato com a Loja."
							
			ElseIf (cAliasQry)->Estado == 2
				cMensagem	:="Processo de conferência cega concluido, nota fiscal não pode ser excluída! Entrar em contato com a Loja."			
				
			Else
				cMensagem	:="Nota Fiscal em fase de conferencia."
				
			EndIf
		Else			
			cCodConf:=AllTrim(Str((cAliasQry)->Cod_conferencia))			
			cScript:="DELETE FROM "+u_NCGetBWM("Conferencia_cega")+" WHERE Cod_conferencia="+cCodConf
			U_NCIWMF02(cScript,"2")
			cScript:="DELETE FROM "+u_NCGetBWM("Conferencia_cega_item")+" WHERE Cod_conferencia="+cCodConf
			U_NCIWMF02(cScript,"2")
		EndIf		
		(cAliasQry)->(	DbSkip())
	EndDo
	
	
	
	(cAliasQry)->(DbCloseArea())
EndIf


cQuery:=" Select Count(1) Contar From "+U_NCGetBWM("Conferencia_cega")
cQuery+=" Where Cod_referencia='"+cCodRef+"'"
cQuery+=" And Cod_loja_WM = '"+cLojaWM+"' "         


cAliasQry:=U_NCIWMF02(cQuery,"1")

If Select(cAliasQry)>0 
	lJaExiste:=(cAliasQry)->Contar>0
	(cAliasQry)->(DbCloseArea())
EndIf
	

RestArea(aAreaAtu)
Return lJaExiste    
