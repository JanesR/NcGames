#Include "PROTHEUS.CH"

#DEFINE PREFIXO 	1
#DEFINE TITULO 		2
#DEFINE TIPO 		3
#DEFINE PARCELA 	4
#DEFINE NATUREZA 	5
#DEFINE CLIENTE 	6
#DEFINE LOJA 		7
#DEFINE DTEMISSAO 	8
#DEFINE MSGERR 		9

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WMF01JOB  ºAutor  ³Microsiga           º Data ³  05/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function WMF01JOB(aDados)
Default aDados := {"01","03"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
U_NCIWMF01()
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIWMF01  ºAutor  ³Microsiga           º Data ³  05/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCIWMF01()
Local aAreaAtu		:=GetArea()
Local cQryAlias		:=GetNextAlias()
Local aDados		:={}
Local aDadosAux		:={}
Local cModo			:=""
Local cEmpPZP
Local cFilPZP
Local nInd
Local nYnd
Local aConexoes
Local nContar
Local lWait
Local cTbPZP		:= "%PZP010 " + "PZP%"

BeginSQL Alias cQryAlias
	SELECT PZP.R_E_C_N_O_ RecPZP,PZP.PZP_EMPORI,PZP.PZP_FILORI, PZP.PZP_DTMOVI, PZP.PZP_OPER
	FROM %exp:cTbPZP%
	//FROM %Table:PZP% PZP
	WHERE 
	//PZP_FILIAL = %xfilial:PZP%
	//AND 
	(PZP.PZP_PREFIX = ' ' AND PZP.PZP_NUM = ' ' )
	AND PZP.%notDel%
	ORDER BY PZP_EMPORI,PZP_FILORI, PZP_DTMOVI, PZP_OPER
EndSQL

IncProc(0)

Do While (cQryAlias)->(!Eof())
	           
	cEmpPZP	:= (cQryAlias)->PZP_EMPORI
	cFilPZP	:= (cQryAlias)->PZP_FILORI
	
	AADD(aDados,{ {cEmpPZP,cFilPZP},{} } )
	aDadosAux:=aDados[Len(aDados),2]
	
	Do While (cQryAlias)->(!Eof()) .And. (cQryAlias)->PZP_EMPORI == cEmpPZP .And. (cQryAlias)->PZP_FILORI == cFilPZP
		AADD(aDadosAux,(cQryAlias)->RecPZP)
		(cQryAlias)->(DbSkip())
	EndDo
	
EndDo
(cQryAlias)->(DbCloseArea())

For nInd:=1 To Len(aDados) 
	aDadosAux:=aDados[nInd]
	aConexoes:=GetUserInfoArray()
	nContar:=0
	AEVAL( aConexoes, {|a| IIf( (a[6]==GetEnvServer() .And. AllTrim(Upper(a[5]))=="U_WMF01Grv" ),nContar++, )   }  )
	StartJob( "U_WMF01Grv",GetEnvServer(), nContar >= 5, aDadosAux)   
	//StartJob( "U_WMF01Grv",GetEnvServer(), .T., aDadosAux)
	//U_WMF01Grv(aDadosAux)       
Next

RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WWMF01Grv ºAutor  ³Microsiga         º Data ³  05/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function WMF01Grv(aDados)
Local cModo
Local cAliasPZP
Local aRecnos		:= aDados[2]
Local nRecPZO		:= 0
Local cParcAux 		:= ""
Local nParcAux 		:= 0
Local nX			:= 0     
Local aDProc		:= {}
Local aVend			:= {}
Local aTitRA		:= {}
Local nVlOper		:= 0
Local nTotVlOper	:= 0
Local cTpTitAux		:= ""
Local lContinua		:= .F.
Local aDProcNCC		:= {}
Local cEmpAux		:= "" 

RpcClearEnv()
RpcSettype(3)
RpcSetEnv(Alltrim(aDados[1,1]),Alltrim(aDados[1,2]))
cAliasPZP	:= GetNextAlias()

cEmpAux	:= Alltrim(U_MyNewSX6("NC_NCWMEMP",;
									"01",;
									"C",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									.F. ))
                               


DbSelectArea("PZZ")
DbSetOrder(1)

DbSelectArea("PZO")
DbSetorder(1)

EmpOpenFile(cAliasPZP,"PZP",1,.T.,cEmpAux,@cModo)
                                                                                                                                 
//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_WMF01JOB", "Inclusao do movimento financeiro", "FINANCEIRO", MsDate() )

For nYnd:=1 To Len(aRecnos)
	
	(cAliasPZP)->(DbGoTo(aRecnos[nYnd]))
	                                          
	//Não gera titulo quando o tipo de operação for compra de usado
	If Alltrim((cAliasPZP)->PZP_OPER) == 'CDU'
		
		RecLock(cAliasPZP,.F.)
		(cAliasPZP)->PZP_LOGERR := "Nao existe regra definida para o tipo de operacao CDU (Compra de Usado)."
		(cAliasPZP)->(MsUnLock())		
		Loop	
	EndIf
	
	//Cria o vendedor caso não exista
	If !Empty((cAliasPZP)->PZP_CODUCO)
		aVend := U_NCIFW2VEND((cAliasPZP)->PZP_CODUCO, (cAliasPZP)->PZP_NOUCOM, "01")
	Else
		aVend := U_NCIFW2VEND((cAliasPZP)->PZP_CODUCX, (cAliasPZP)->PZP_NOMUCX, "01")	
	EndIf
	
	//Recno PZO
	nRecPZO := GetRecPZO((cAliasPZP)->PZP_CODFIN)
	If nRecPZO != 0
		PZO->(DbGoTo(nRecPZO))
		
		If Alltrim((cAliasPZP)->PZP_OPER ) = "DV"
			cTpTitAux	:= "NCC"
			nVlOper		:= (cAliasPZP)->PZP_VLOPER*-1
			nTotVlOper	:= (cAliasPZP)->PZP_TOTOPE*-1

		ElseIf Alltrim((cAliasPZP)->PZP_OPER ) == "OS"
            
            //Verifica se existe exceção para OS 
            If PZZ->(MsSeek(xFilial("PZZ") +(cAliasPZP)->PZP_CODOS ))
				cTpTitAux	:= Alltrim(PZZ->PZZ_TPTIT )
				nVlOper		:= (cAliasPZP)->PZP_VLOPER
				nTotVlOper	:= (cAliasPZP)->PZP_TOTOPE
			
			Else
				cTpTitAux	:= Alltrim(PZO->PZO_TIPO)
				nVlOper		:= (cAliasPZP)->PZP_VLOPER
				nTotVlOper	:= (cAliasPZP)->PZP_TOTOPE
			EndIf			

		Else	
			cTpTitAux	:= Alltrim(PZO->PZO_TIPO)
			nVlOper		:= (cAliasPZP)->PZP_VLOPER
			nTotVlOper	:= (cAliasPZP)->PZP_TOTOPE
		EndIf
		
		
		cParcAux := ""
		nParcAux := 0
		If Val(Alltrim((cAliasPZP)->PZP_PARCWM)) > 9
			nParcAux 	:= (Val((cAliasPZP)->PZP_PARCWM)-9)
			cParcAux	:= Alltrim(Str(9))
			
			For nX	:= 1 To nParcAux
				cParcAux 	:= soma1(cParcAux)
			Next
			
		Else
			cParcAux := (cAliasPZP)->PZP_PARCWM
		EndIf
		
				
		//Executa a rotina para gerar o titulo no modulo financeira da empresa e filial correspondente
		aDProc := GerTitulo(	PZO->PZO_PREFIX,;			//Prefixo
								(cAliasPZP)->PZP_CODMOV,;	//Codigo do movimento
								cParcAux,;					//Parcela
								cTpTitAux,; 				//Tipo do titulo
								PZO->PZO_CODCLI,;			//codigo do cliente
								PZO->PZO_LOJA,; 			//Loja
								GetNomCli(PZO->PZO_CODCLI, PZO->PZO_LOJA),; 	//nome do cliente
								PZO->PZO_NATURE,;			//natureza
								(cAliasPZP)->PZP_DTMOVI,;	//Data de emissão
								(cAliasPZP)->PZP_DTVCTO,; 	//Data de vencimento
								nVlOper,; 					//Valor
								nTotVlOper,;				//Valor total da operação
								(cAliasPZP)->PZP_QTDPAR,;	//Quantidade total de parcela da operação
								(cAliasPZP)->PZP_NOTA,;		//Cupom
								aVend[1],;					//Codigo do vendedor      
								(cAliasPZP)->PZP_CODOS,; 	//Codigo da OS
								(cAliasPZP)->PZP_TPOS,;		//Descrição da OS 
								(cAliasPZP)->PZP_CODFIN,;	//Codigo financeiro
								(cAliasPZP)->PZP_DESCFI,;	//Descrição Financeira
								(cAliasPZP)->PZP_CODLJ;		//Codigo da loja no Web Manager
								)
								
		
		//Grava os dados do titulo na tabela intermediaria
		If Empty(aDProc[MSGERR])

			RecLock(cAliasPZP,.F.)
			(cAliasPZP)->PZP_PREFIX := aDProc[PREFIXO]
			(cAliasPZP)->PZP_NUM    := aDProc[TITULO]
			(cAliasPZP)->PZP_PARCEL := aDProc[TIPO]
			(cAliasPZP)->PZP_TIPO	:= aDProc[PARCELA]
			(cAliasPZP)->PZP_NATURE	:= aDProc[NATUREZA]
			(cAliasPZP)->PZP_CODCLI	:= aDProc[CLIENTE]
			(cAliasPZP)->PZP_LOJA	:= aDProc[LOJA]
			(cAliasPZP)->PZP_EMISSA	:= aDProc[DTEMISSAO]
			(cAliasPZP)->PZP_LOGERR := " "
			(cAliasPZP)->(MsUnLock())

		Else
			RecLock(cAliasPZP,.F.)
			(cAliasPZP)->PZP_LOGERR := aDProc[MSGERR]
			(cAliasPZP)->(MsUnLock())
		EndIf

		
		
		//Procedimento utilizado para TRV ou CDU, para gerar a NCC e efetuar a compensação do titulo de forma automatica
		If Empty(aDProc[MSGERR]) .And. Alltrim(PZO->PZO_COMPEN) == "2"
			
			//Executa a rotina para gerar o titulo do titpo NCC no modulo financeira da empresa e filial correspondente
			aDProcNCC := GerTitulo(	PZO->PZO_PREFIX,;		//Prefixo
									(cAliasPZP)->PZP_CODMOV,;	//Codigo do movimento
									cParcAux,;					//Parcela
									"NCC",; 					//Tipo do titulo
									PZO->PZO_CODCLI,;			//codigo do cliente
									PZO->PZO_LOJA,; 			//loja
									GetNomCli(PZO->PZO_CODCLI, PZO->PZO_LOJA),; 	//nome do cliente
									PZO->PZO_NATURE,;			//natureza
									(cAliasPZP)->PZP_DTMOVI,;	//Data de emissão
									(cAliasPZP)->PZP_DTVCTO,;	//Data de vencimento
									nVlOper,; 					//Valor
									nTotVlOper,;				//Valor total da operação
									0,;							//Quantidade total de parcela da operação
									(cAliasPZP)->PZP_NOTA,;		//Cupom Fiscal
									aVend[1],;					//Codigo do vendedor      
									(cAliasPZP)->PZP_CODOS,; 	//Codigo da OS
									(cAliasPZP)->PZP_TPOS,;		//Descrição da OS 
									(cAliasPZP)->PZP_CODFIN,;	//Codigo financeiro
									(cAliasPZP)->PZP_DESCFI,;	//Descrição Financeira
									(cAliasPZP)->PZP_CODLJ;		//Codigo da loja no Web Manager
									)

			
			If Len(aDProc) > 0 .And. Len(aDProcNCC) > 0
				
				//Efetua a compesação do titulo
				CompTitNCC(aDProc[PREFIXO], aDProc[TITULO], aDProc[TIPO], aDProc[PARCELA],;//Dados do titulo a ser compensado pela NCC (Prefixo, Titulo, Parcela, Tipo)
							aDProcNCC[PREFIXO], aDProcNCC[TITULO], aDProcNCC[TIPO], aDProcNCC[PARCELA]	)//Dados do titulo da NCC (Prefixo, Titulo, Parcela, Tipo)
			EndIf
			
		EndIf 
		
		
		//Procedimento utilizado para TRV ou CDU, para gerar a NCC e efetuar a compensação do titulo de forma automatica
		If Empty(aDProc[MSGERR]) .And. Alltrim(PZO->PZO_COMPOS) == "2"
		 	CompTitRA(aDProc[PREFIXO], aDProc[TITULO], aDProc[TIPO], aDProc[PARCELA], (cAliasPZP)->PZP_FILORI)
		EndIf
	Else
		RecLock(cAliasPZP,.F.)
		(cAliasPZP)->PZP_LOGERR := "Regra nao encontrada. Verifique o cadastro de regras para o tipo financeiro ("+Alltrim((cAliasPZP)->PZP_CODFIN)+")."
		(cAliasPZP)->(MsUnLock())
	EndIf
Next

//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_WMF01JOB", "Inclusao do movimento financeiro", "FINANCEIRO", MsDate(), "F" )



Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetNomCli  ºAutor  ³Microsiga          º Data ³  05/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                     
Static Function GetNomCli(cCodCli, cLoja)  

Local aArea 	:= GetArea()  
Local cRetNome  := ""

Default cCodCli	:= "" 
Default cLoja	:= ""

DbSelectArea("SA1")
DbSetOrder(1)
If SA1->(MsSeek(xFilial("SA1") + Padr(cCodCli, TAMSX3("A1_COD")[1]) + Padr(cLoja,TAMSX3("A1_LOJA")[1]) ))
	cRetNome := SA1->A1_NOME                                                                              	
EndIf

RestArea(aArea)
Return cRetNome


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetRecPZO  ºAutor  ³Microsiga          º Data ³  05/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                     
Static Function GetRecPZO(cCodFinWM)

Local aArea 		:= GetArea()
Local cQryAlias		:= GetNextAlias()
Local nRecPzo		:= 0  

Default cCodFinWM 	:= ""

BeginSQL Alias cQryAlias
	SELECT PZO.R_E_C_N_O_ RecPZO
	FROM %Table:PZO% PZO
	WHERE PZO_FILIAL = %xfilial:PZO%
	AND PZO.PZO_IDFPAG = %Exp:cCodFinWM%
	AND PZO.%notDel%
EndSQL

If (cQryAlias)->(!Eof())
	nRecPzo := (cQryAlias)->RecPZO
EndIf
  
(cQryAlias)->(DbCloseArea())
RestArea(aArea)
Return nRecPzo



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GerTitulo ºAutor  ³Microsiga 	          º Data ³ 07/04/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Efetua a criação do titulo							      º±±
±±º          ³	                                                   		  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GerTitulo(cPrefixo, cCodMovWM, cParcel,cTipo, cCliente, cLoja, cNome, cNaturez, dDtEmissao, dDtVencto,;
							nValor, nValotTWN, nQtdParc, cCupom, cVend, cCodOs, cDescOS, cCodFin, cDescFin, cCodLojaWM)

Local aArea 	:= GetArea()
Local aTitulo   := {}    
Local cNumTit	:= ""
Local aProcRet	:= {}             
Local cParcAux	:= ""
                                                              
Default cPrefixo	:= ""
Default cCodMovWM	:= ""
Default cTipo		:= ""         
Default cParcel		:= ""
Default cCliente	:= ""
Default cLoja		:= ""
Default cNome		:= ""
Default cNaturez	:= ""
Default dDtEmissao	:= CTOD('')
Default dDtVencto	:= CTOD('')
Default nValor		:= 0
Default nValotTWN	:= 0
Default nQtdParc	:= 0
Default cCupom		:= ""
Default cVend		:= ""
Default cCodOs	 	:= ""	
Default cDescOS  	:= ""
Default cCodFin  	:= ""
Default cDescFin 	:= ""
Default cCodLojaWM	:= ""



//Verifica se o movimento foi parcelado, para utilizar o mesmo numero, alterando apenas a parcela.
cNumTit := GetNumTit(cCodMovWM, cCliente, cLoja)
If Empty(cNumTit)
	cNumTit := GetSXENum("SE1","E1_NUM")
	ConfirmSX8()
EndIf

//Retorna a parcela a ser utilizada no titulo
cParcAux := GetParcel(cPrefixo, cNumTit, cParcel, cTipo) 

cHist	:= Alltrim(cFilAnt)+"-"+Alltrim(cCodMovWM)+"-"+cPrefixo+"-"+cNumTit

AADD(aTitulo,	{"E1_PREFIXO"	,cPrefixo				,Nil})
AADD(aTitulo,	{"E1_NUM"		,cNumTit				,Nil})
AADD(aTitulo,	{"E1_PARCELA"	,cParcAux				,Nil})
AADD(aTitulo,	{"E1_TIPO"		,cTipo					,Nil})
AADD(aTitulo,	{"E1_NATUREZ"	,cNaturez				,Nil})
AADD(aTitulo,	{"E1_CLIENTE"	,cCliente				,Nil})
AADD(aTitulo,	{"E1_LOJA"	    ,cLoja					,Nil})
AADD(aTitulo,	{"E1_NOMCLI"	,cNome					,Nil})
AADD(aTitulo,	{"E1_EMISSAO" 	,dDtEmissao		 		,Nil})
AADD(aTitulo,	{"E1_VENCTO" 	,dDtVencto		  		,Nil})
AADD(aTitulo,	{"E1_VALOR"		,nValor					,Nil})
AADD(aTitulo,	{"E1_HIST"		,cHist					,Nil})
AADD(aTitulo,	{"E1_ORIGEM"	,"NCIWMF01"				,Nil})
//AADD(aTitulo,	{"E1_YVLWM"		,nValotTWN				,Nil})
AADD(aTitulo,	{"E1_YQPARWM"	,nQtdParc				,Nil})
AADD(aTitulo,	{"E1_YCODWM"	,cCodMovWM				,Nil})
AADD(aTitulo,	{"E1_YCUPOM"	,cCupom					,Nil})
AADD(aTitulo,	{"E1_YOSWM"  	,cCodOs					,Nil})
AADD(aTitulo,	{"E1_YDOSWM" 	,cDescOS				,Nil})
AADD(aTitulo,	{"E1_YCODFIN"	,cCodFin				,Nil})
AADD(aTitulo,	{"E1_YDESFI" 	,cDescFin				,Nil})

If !Empty(cVend)
	AADD(aTitulo,	{"E1_VEND1"	,cVend				,Nil})
EndIf

If !Empty(cVend)
	AADD(aTitulo,	{"E1_YLOJAWM" 	,cCodLojaWM			,Nil})
EndIf

                
//Executa a rotina automatica para criação do titulo no contas a receber do modulo financeiro
cMsgRet := RunGerTit(aTitulo, 3 )

If Empty(cMsgRet)
	//ConfirmSX8() 
	aProcRet := {cPrefixo, cNumTit, cParcAux, cTipo, cNaturez, cCliente, cLoja, dDtEmissao, cMsgRet}
Else	
	//RollBackSx8()	                                        
	aProcRet := {"", "", "", "", "", "", "", CTOD(''), cMsgRet}
EndIf

RestArea(aArea)
Return aProcRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetParcel ºAutor  ³Microsiga 	          º Data ³ 07/04/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna a parcela a ser utilizada no titulo.			      º±±
±±º          ³Observação												  º±±
±±º          ³Rotina utilizada para evitar erro de duplicidade na geração º±±
±±º          ³do titulo, caso o pagamento seja efetuado com mais de 1 	  º±±
±±º          ³cartão da mesma bandeira									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetParcel(cPrefixo, cNum, cParcela, cTipo)

Local aArea 	:= GetArea()
Local cRetParc  := ""
Local cQuery	:= ""
Local cArqTmp	:= ""

Default cPrefixo	:= ""
Default cNum		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""

DbSelectArea("SE1")
DbSetOrder(1)
If SE1->(MsSeek(xFilial("SE1")+	PADR(cPrefixo,TAMSX3("E1_PREFIXO")[1] )+;
								PADR(cNum,TAMSX3("E1_NUM")[1] )+;
								PADR(cParcela,TAMSX3("E1_PARCELA")[1] )+;
								PADR(cTipo,TAMSX3("E1_TIPO")[1] ) ))
    
	cArqTmp	:= GetNextAlias()
	cQuery	:= " SELECT E1_PARCELA FROM "+RetSqlName("SE1")+" SE1 "+CRLF
	cQuery	+= " WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
	cQuery	+= " AND SE1.E1_PREFIXO = '"+cPrefixo+"' "+CRLF
	cQuery	+= " AND SE1.E1_NUM = '"+cNum+"' "+CRLF
	cQuery	+= " AND SE1.E1_TIPO = '"+cTipo+"' "+CRLF
	cQuery	+= " AND SE1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= " ORDER BY E1_PARCELA "+CRLF
										                       
	dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)
	
	While (cArqTmp)->(!Eof())
		
		cRetParc := (cArqTmp)->E1_PARCELA
		
		(cArqTmp)->(DbSkip())
	EndDo
	
	cRetParc := soma1(cRetParc)
									
Else
	cRetParc := cParcela
EndIf
RestArea(aArea)
Return cRetParc



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetNumTit ºAutor  ³Microsiga 	          º Data ³ 07/04/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o numero do tiulo em caso de venda parcelada	      º±±
±±º          ³	                                                   		  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetNumTit(cCodMovWM, cCliente, cLoja)

Local aArea 	:= GetArea()            
Local cQuery    := "" 
Local cArqTmp	:= GetNextAlias()
Local cNumTit	:= ""

Default cCodMovWM	:= "" 
Default cCliente	:= "" 
Default cLoja		:= "" 

cQuery    := " SELECT DISTINCT E1_NUM FROM "+RetSqlName("SE1")+" SE1 "+CRLF
cQuery    += " WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery    += " AND SE1.E1_CLIENTE = '"+cCliente+"' "+CRLF
cQuery    += " AND SE1.E1_LOJA = '"+cLoja+"' "+CRLF
cQuery    += " AND SE1.E1_YCODWM = '"+cCodMovWM+"' "+CRLF
cQuery    += " AND SE1.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)
                                  
If (cArqTmp)->(!Eof())
	cNumTit := (cArqTmp)->E1_NUM
Else
	cNumTit := ""	
EndIf


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return cNumTit
                    


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RunGerTit ºAutor  ³Microsiga           º Data ³  07/04/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Executa a geração de titulos							      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RunGerTit(aTitulo, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aTitulo := {} 
Default nOpc	:= 3//Inclusão

//Inicio da transação
Begin Transaction

//Verifica se os dados foram informados
If (Len(aTitulo) > 0)
	
	//Chama a rotina automatica para gravar os dados da nota de entrada
	MsExecAuto({|x,y| Fina040(x,y)}, aTitulo, nOpc)
	//Fina040(aTitulo,nOpc)
	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		//Captura a mensagem de erro
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		
		//Rollback da transação
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Dados não informados"
EndIf

//Finalisa a transação
End Transaction

RestArea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CompTitNCC ºAutor  ³Microsiga 	      º Data ³ 07/04/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Efetua a compensação de título com NCC.				      º±±
±±º          ³Obs. Rotina utilizada principalmente no processo de troca e º±±
±±º		     ³compra de usado										      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                     
Static Function CompTitNCC(cPrefixo, cNum, cParcela, cTipo,;//Dados do titulo a ser compensado pela NCC
							cPrefNcc, cNumNcc, cParcNcc, cTipoNcc	)//Dados do titulo da NCC

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local lRet		:= .F.
Local cArqTmp	:= GetNextAlias()
Local aRecCR 	:= {}
Local aRecNCC 	:= {}
                    
Default cPrefixo 	:= ""	 
Default cNum		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""
Default cPrefNcc	:= "" 
Default cNumNcc		:= "" 
Default cParcNcc	:= "" 
Default cTipoNcc	:= ""

cQuery := " SELECT R_E_C_N_O_ RECNOCP, 'CR' TIPOC FROM "+RetSqlName("SE1")+" SE1CR "+CRLF
cQuery += " WHERE SE1CR.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery += " AND SE1CR.E1_PREFIXO = '"+cPrefixo+"' "+CRLF
cQuery += " AND SE1CR.E1_NUM = '"+cNum+"' "+CRLF

If !Empty(cParcela)
	cQuery += " AND SE1CR.E1_PARCELA = '"+cParcela+"' "+CRLF
EndIf

cQuery += " AND SE1CR.E1_TIPO = '"+cTipo+"' "+CRLF
cQuery += " AND SE1CR.E1_SALDO != '0' "+CRLF//Titulo em aberto
cQuery += " AND SE1CR.D_E_L_E_T_ = ' ' "+CRLF

cQuery += " UNION ALL "+CRLF
cQuery += " SELECT R_E_C_N_O_ RECNOCP, 'NCC' TIPOC FROM "+RetSqlName("SE1")+" SE1NCC "+CRLF
cQuery += " WHERE SE1NCC.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery += " AND SE1NCC.E1_PREFIXO = '"+cPrefNcc+"' "+CRLF
cQuery += " AND SE1NCC.E1_NUM = '"+cNumNcc+"' "+CRLF

If !Empty(cParcNcc)
	cQuery += " AND SE1NCC.E1_PARCELA = '"+cParcNcc+"' "+CRLF
EndIf

cQuery += " AND SE1NCC.E1_TIPO = '"+cTipoNcc+"' "+CRLF
cQuery += " AND SE1NCC.E1_SALDO != '0' "+CRLF
cQuery += " AND SE1NCC.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

While (cArqTmp)->(!Eof())
	
	//Preenche os dados dos titulos a compensar
	If Alltrim( (cArqTmp)->TIPOC ) == "CR"
		aadd(aRecCR,(cArqTmp)->RECNOCP)
		
	Else
		aadd(aRecNCC,(cArqTmp)->RECNOCP)
		
	EndIf
	
	(cArqTmp)->(DbSkip())
EndDo

//Verifica se existe titulo a ser compensado
If Len(aRecNCC) > 0 .And. Len(aRecCR) > 0
	Begin Transaction
	
	//Chama a rotina para compensar o tituo a receber
	If MaIntBxCR(3,aRecNCC,,aRecCR,,{.F.,.F.,.F.,.F.,.F.,.F.},,,,,MsDate() )
		
		//Retorno da compensação
		lRet		:= .T.
	Else
		//Retorno da compensação
		lRet		:= .F.
		
	EndIf
	
	End Transaction
EndIf


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return lRet            


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CompTitRA ºAutor  ³Microsiga	 	      º Data ³ 07/04/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Efetua a compensação de título com PA.				      º±±
±±º          ³Obs. Rotina utilizada principalmente no processo de 		  º±±
±±º		     ³pre-venda de OS										      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                     
Static Function CompTitRA(cPrefixo, cNum, cParcela, cTipo, cFilOri )

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local lRet		:= .F.
Local cArqTmp	:= GetNextAlias()
Local aRecCR 	:= {}
Local aRecRA 	:= {}
Local nValTit	:= 0
                    
Default cPrefixo 	:= ""	 
Default cNum		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""

cQuery := " SELECT R_E_C_N_O_ RECNOCP, E1_VALOR FROM "+RetSqlName("SE1")+" SE1CR "+CRLF
cQuery += " WHERE SE1CR.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery += " AND SE1CR.E1_PREFIXO = '"+cPrefixo+"' "+CRLF
cQuery += " AND SE1CR.E1_NUM = '"+cNum+"' "+CRLF

If !Empty(cParcela)
	cQuery += " AND SE1CR.E1_PARCELA = '"+cParcela+"' "+CRLF
EndIf

cQuery += " AND SE1CR.E1_TIPO = '"+cTipo+"' "+CRLF
cQuery += " AND SE1CR.E1_SALDO != '0' "+CRLF//Titulo em aberto
cQuery += " AND SE1CR.D_E_L_E_T_ = ' ' "+CRLF


dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

//Titulo a ser compesando
While (cArqTmp)->(!Eof())
	
	nValTit += (cArqTmp)->E1_VALOR
	aadd(aRecCR,(cArqTmp)->RECNOCP)
	
	(cArqTmp)->(DbSkip())
EndDo

//Ra a ser compensada
aRecRA := GetTitCRa(cFilOri, nValTit)

//Verifica se existe titulo a ser compensado
If Len(aRecRA) > 0 .And. Len(aRecCR) > 0
	Begin Transaction
	
	//Chama a rotina para compensar o tituo a receber
	If MaIntBxCR(3,aRecRA,,aRecCR,,{.F.,.F.,.F.,.F.,.F.,.F.},,,,,MsDate() )
		
		//Retorno da compensação
		lRet		:= .T.
	Else
		//Retorno da compensação
		lRet		:= .F.
		
	EndIf
	
	End Transaction
EndIf


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return lRet                            




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetTitCRa  ºAutor  ³Microsiga          º Data ³  05/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna os dados do titulo do tipo RA a ser compensado      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                    	  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                     
Static Function GetTitCRa(cFilOri, nValTit)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local aRet		:= {}        
Local nValAux	:= 0
Local cEmpAux	:= Alltrim(U_MyNewSX6("NC_NCWMEMP",;
									"01",;
									"C",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									.F. ))


Default cFilOri := ""
Default nValTit  := 0


cQuery	:= " SELECT E1_FILORIG, PZP_NOMELJ, E1_PREFIXO, E1_NUM, E1_PARCELA,  E1_TIPO, E1_CLIENTE, E1_LOJA, "+CRLF
cQuery	+= "     E1_NOMCLI, E1_EMISSAO, E1_VALOR, E1_VENCREA, E1_YCODWM, E1_YCUPOM, SE1.R_E_C_N_O_ RECNOSE1 FROM "+RetSqlName("SE1")+" SE1 "+CRLF

cQuery	+= "  INNER JOIN "+RetFullName("PZP", cEmpAux)+" PZP "+CRLF
cQuery	+= "  ON PZP.PZP_FILIAL = '"+xFilial("PZP", cEmpAux)+"' "+CRLF
cQuery	+= "  AND PZP.PZP_CODMOV = SE1.E1_YCODWM "+CRLF
cQuery	+= "  AND PZP.PZP_PREFIX = SE1.E1_PREFIXO "+CRLF
cQuery	+= "  AND PZP.PZP_NUM = SE1.E1_NUM "+CRLF
cQuery	+= "  AND PZP.PZP_PARCEL = SE1.E1_PARCELA "+CRLF
cQuery	+= "  AND PZP.PZP_TIPO = SE1.E1_TIPO "+CRLF
cQuery	+= "  AND PZP.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= "  WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery	+= "  AND SE1.E1_TIPO = 'RA' "+CRLF
cQuery	+= "  AND SE1.E1_FILORIG = '"+cFilOri+"' "+CRLF
cQuery	+= "  AND SE1.E1_SALDO > '0' "+CRLF
cQuery	+= "  AND SE1.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " ORDER BY E1_FILORIG, E1_VALOR "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

//Retorna os dados do titulo RA
While (cArqTmp)->(!Eof())
    
    If nValAux <= nValTit
		nValAux += (cArqTmp)->E1_VALOR
		aAdd(aRet,(cArqTmp)->RECNOSE1)
	Else    
        Exit
	EndIf

	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return aRet 