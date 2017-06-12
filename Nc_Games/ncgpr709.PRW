#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³ACPD 				     º Data ³  24/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Manutenção de Apuração de VPC                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGPR709()
Local aCores  		:= 	{}

AADD(aCores,{"!Empty(ZZJ_TITULO)" , 'BR_VERDE'   })
AADD(aCores,{"ZZJ_TIPO='P'"       , 'BR_AMARELO'  })
AADD(aCores,{"Empty(ZZJ_DTFECH)"  , 'BR_AZUL'    })
AADD(aCores,{"!Empty(ZZJ_DTFECH)" , 'BR_VERMELHO'})


Private cCadastro := "Manutenção de Apuração de VPC."
Private aRotina := MenuDef()
Private dDataPgto :=dDataBase //MsDate()



mBrowse(,,,,"ZZJ",,,,,,aCores)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  11/24/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MenuDef()
Local aRotina:={ ;
{"Pesquisar"			,"AxPesqui"		,0,1} ,;
{"Visualizar"			,"U_R709Manut",0,2} ,;
{"Processar"			,"U_R709Proces",0,3} ,;
{"Reprocessar"			,"U_R709Proces",0,4} ,;
{"Valor Cliente"		,"U_R709Manut",0,4} ,;
{"Legenda"	    		,"U_R709Legenda",0,2} ,;
{"Gerar NCC"	   		,"U_R709GeraNCC",0,2} ,;
{"Encerrar"				,"U_R709Encerra",0,5}}

Return aRotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  11/24/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R709Proces()
Local aAreaAtu	:=GetArea()
Local cPerg		:="R709PROCES"
Local aMeses	:={"Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"}
Local aSays		:={}
Local aButtons	:={}
Local lProcessar:=.F.
Local cMes		:=aMeses[Month(dDataPgto)]+"/"+StrZero(Year(dDataPgto),4)
Private nOpca:=0

If INCLUI
	lProcessar:=.T.
Else
	cMes:=ZZJ->ZZJ_MESPGT
EndIf


NCPRSX1(cPerg)
Pergunte(cPerg,.T. )

If mv_par01==1
	AADD(aSays,OemToAnsi( "Este programa tem como objetivo VPC Repasse Finaceiro  "))
	AADD(aSays,OemToAnsi( "pagamento "+cMes+" de acordo com os parâmetros definidos pelo usuário."))
Else
	AADD(aSays,OemToAnsi( "Este programa tem como objetivo VPC Contrato de Crescimento  "))
	AADD(aSays,OemToAnsi( "coma a data base "+DTOC(dDataPgto)+" e de acordo com os parâmetros definidos pelo usuário."))
	
EndIf


AADD(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T. ) } } )
AADD(aButtons, { 1,.T.,{||  IIf(mv_par01==2 .And. Empty(MV_PAR06+MV_PAR07),(MsgStop("Para o Contrato de Crescimento o campo Grupo Cliente deve ser preenchido")) ,(nOpca := 1,FechaBatch() ) )}} )
AADD(aButtons, { 2,.T.,{|| nOpca := 0,FechaBatch() }} )

FormBatch( cCadastro, aSays, aButtons )   
                                                        
If mv_par01==2
	cMesCresc:=aMeses[Month(dDataPgto+1)]+"/"+StrZero(Year(dDataPgto+1),4)
EndIf	

If nOpca == 1
	Processa( { || R709Calc(lProcessar,cMes) })
EndIf


RestArea(aAreaAtu)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  11/26/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R709Calc(lProcessar,cMes)
Local aAreaAtu		:=GetArea()
Local cAliasCtr	:=GetNextAlias() //Alias para os Contratos
Local cAliasNotas	:=GetNextAlias() //Alias para as Notas Fiscais
Local aAreaZZJ		:=ZZJ->(GetArea())
Local nPerLiq
Local nPerBru
Local cClasse
Local cExcecao
Local nCountReg
Local lGravouItem
Local nZZKBruto  :=0
Local nZZKLiquido:=0
Local nZZKVlrVPC :=0
Local lGravouItem	 :=.F.
Local nZZJBruto  :=0
Local nZZJLiquido:=0
Local nZZJVlrVPC:=0
Local lProvisorio:=(MV_PAR08==1)
Local lJaProcessado
Local aTipo	:=RetSx3Box( Posicione("SX3", 2, "ZZJ_TIPO","X3CBox()" ),,,1)
Local aTabelas:={"ZZJ","ZZK","ZZL"}
Local nLenMes	:=AvSx3("ZZJ_MESPGT",3)
Local cChaveZZJ
Local cItem
Local lCalculado:=.F.
Local nVlrBrut:=0
Local nVlrLiq :=0
Local nSemestre
Local nContar
Local aVlrBase
Local aCrescimento:={0,0}
Local aFaturamento
Local aPremio		:={}
Local lPremio
Local aRecnos:={}
Private oProcess
Private lVPCFinanceiro:=(mv_par01==1)

ZZJ->(DbSetOrder(2))
lJaProcessado:=ZZJ->(DbSeek(xFilial("ZZJ")+Padr(cMes,nLenMes)+IIf(lProvisorio,"P","E" )+IIf(mv_par01==1,"F","C" )  ))


RestArea(aAreaZZJ)
If lProcessar
	
	If lJaProcessado
		MsgStop(cMes+"-"+aTipo[Ascan(aTipo,{|a| a[2]==ZZJ->ZZJ_TIPO} ),3]+" já processado!! Execute o Reprocessar se necessário.")
		Return
	EndIf
	
Else
	If !lJaProcessado
		MsgStop(cMes+"-"+aTipo[Ascan(aTipo,{|a| a[2]==ZZJ->ZZJ_TIPO} ),3]+" não processado!! Execute o Processar se necessário.")
		Return
	ElseIf !MsgYesNo("Deseja reprocessar "+cMes+"'-"+aTipo[Ascan(aTipo,{|a| a[2]==ZZJ->ZZJ_TIPO} ),3]+"?")
		Return
	EndIf
	
	cChaveZZJ:=xFilial("ZZJ")+Padr(cMes,nLenMes)+IIf(lProvisorio,"P","E" )+IIf(mv_par01==1,"F","C" )
	ZZJ->(DbSetOrder(2))
	ZZJ->(DbSeek(cChaveZZJ))
	Do While ZZJ->(!Eof() ) .And. ZZJ->(ZZJ_FILIAL+ZZJ_MESPGT+ZZJ_TIPO)==cChaveZZJ
		cCodApuracao:=ZZJ->ZZJ_CODIGO
  		For nInd:=1 To Len(aTabelas)
			cSql := " Delete From " +RetSqlName(aTabelas[1])
			cSql += " Where ZZJ_FILIAL ='"+xFilial(aTabelas[1])+"'
			cSql += " AND "+aTabelas[1]+"_CODIGO = '"+cCodApuracao+"'"
			If TcSQLExec( cSql ) < 0
				Aviso(ProcName()+"-"+StrZero(ProcLine(),5),"Ocorreu um erro, limpar os dados para Reprocessamento.",{"Ok"},3)
				Return
			Else
				TcSQLExec( "COMMIT" )
			EndIf
		Next
		
		ZZJ->(DbSkip())
	EndDo
EndIf

oProcess := MsNewProcess():New( { ||  U_R709Contr(cAliasCtr)  }, "Aguarde", "Consultando Contratos...", .T. )
oProcess:Activate()

(cAliasCtr)->(dbGoTop())
Do While (cAliasCtr)->(!Eof())
	
	ZZ7->(DbGoTo( (cAliasCtr)->RECZZ7 ) )
	
	cExcecao:=""
	ZZ9->(DbSeek(xFilial("ZZ9")+ZZ7->(ZZ7_CODIGO+ZZ7_VERSAO)+'2' )  )
	Do While ZZ9->(!Eof()) .And. ZZ9->(ZZ9_FILIAL+ZZ9_CODIGO+ZZ9_VERSAO+ZZ9_FLAG)==xFilial("ZZ9")+ZZ7->(ZZ7_CODIGO+ZZ7_VERSAO)+'2'
		cExcecao+=ZZ9->ZZ9_PRODUT+";"
		ZZ9->(DbSkip())
	EndDo
	cExcecao:=Left(cExcecao,Len(cExcecao)-1)
	
	cClasse:=""
	ZZ9->(DbSeek(xFilial("ZZ9")+ZZ7->(ZZ7_CODIGO+ZZ7_VERSAO)+'3' )  )
	Do While ZZ9->(!Eof()) .And. ZZ9->(ZZ9_FILIAL+ZZ9_CODIGO+ZZ9_VERSAO+ZZ9_FLAG)==xFilial("ZZ9")+ZZ7->(ZZ7_CODIGO+ZZ7_VERSAO)+'3'
		cClasse+=ZZ9->ZZ9_CLASSE+";"
		ZZ9->(DbSkip())
	EndDo
	cClasse:=Left(cClasse,Len(cClasse)-1)
	
	Begin Transaction
	
	If lVPCFinanceiro
		
		cChaveCtr:=(cAliasCtr)->(ZZ8_CODIGO+ZZ8_VERSAO)
		
		Do While (cAliasCtr)->(!Eof()) .And. (cAliasCtr)->(ZZ8_CODIGO+ZZ8_VERSAO)==cChaveCtr
			cPeriodo	:=(cAliasCtr)->ZZ8_PERIOD
			aDatas	:=U_R709Periodo(dDataPgto,cPeriodo,.T.)  
			//aDatas	:={CTOD("03/12/2013"),CTOD("03/12/2013")}
			R709QryNotas(cAliasNotas,aDatas,cPeriodo,cClasse,cExcecao,lProvisorio)
			//aFaturamento:=PR709VlrBase(cAliasNotas,.F.)			
			nCountReg:=0
			(cAliasNotas)->(dbGoTop())
			//(cAliasNotas)->(DbEval({|| nCountReg++ }))
			//oProcess:SetRegua2( nCountReg )
			cCodApuracao:=GetSXENum("ZZJ","ZZJ_CODIGO")
			cItem		:=StrZero(0,AvSx3("ZZJ_ITEM",3) )
			
			Do While (cAliasCtr)->(!Eof()) .And. (cAliasCtr)->(ZZ8_CODIGO+ZZ8_VERSAO)==cChaveCtr .And. (cAliasCtr)->ZZ8_PERIOD==cPeriodo
				
				ZZ8->(DbGoTo( (cAliasCtr)->RECZZ8 ) )
				
				//oProcess:IncRegua1( "Apurando Contrato"+AllTrim(ZZ7->ZZ7_DESC)+" VPC:"+ZZ8->ZZ8_DESCTI  )
				
				(cAliasNotas)->( DbGoTop() )
				
				Do While (cAliasNotas)->( !Eof() )
					
					cCliNF	     :=(cAliasNotas)->F2_CLIENTE
					cLojaNF 		  :=(cAliasNotas)->F2_LOJA
					lGravouItem	  :=.F.
					
					nZZJBruto  	:=0
					nZZJLiquido	:=0
					nZZJVlrVPC	:=0
					
					Do While (cAliasNotas)->( !Eof() ) .And. (cAliasNotas)->(F2_CLIENTE+F2_LOJA)==cCliNF+cLojaNF
						
						//oProcess:IncRegua2( "Calculando....")
						
						SF2->(DbGoTo( (cAliasNotas)->SF2Recno )  )
						SD2->(DbGoTo( (cAliasNotas)->SD2Recno )  )
						
						lGravouItem:=.T.
						ZZL->(RecLock("ZZL",.T.))
						
						ZZL->ZZL_FILIAL	:=xFilial("ZZL")
						
						ZZL->ZZL_CODIGO	:=cCodApuracao
						ZZL->ZZL_TPNOTA	:="S"
						ZZL->ZZL_CONTRA	:=ZZ7->ZZ7_CODIGO
						ZZL->ZZL_VERSAO	:=ZZ7->ZZ7_VERSAO
						ZZL->ZZL_CODVPC	:=ZZ8->ZZ8_TIPO
						ZZL->ZZL_DESVPC	:=ZZ8->ZZ8_DESCTI
						ZZL->ZZL_PERCEN	:=ZZ8->ZZ8_PERCEN
						ZZL->ZZL_TPFAT 	:=ZZ8->ZZ8_TPFAT
						ZZL->ZZL_PERIOD   :=ZZ8->ZZ8_PERIOD
						ZZL->ZZL_ENTREG	:=	Posicione("SZ1",1,xFilial("SZ1")+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA),"Z1_DTENTRE")
						
						nVlrBrut:=0
						nVlrLiq :=0
						GrvZZL(@nVlrBrut,@nVlrLiq)
						ZZL->ZZL_VLRVPC	:=ZZ8->ZZ8_PERCEN/100*IIf( ZZ8->ZZ8_TPFAT =="1",nVlrBrut,nVlrLiq)
						ZZL->(MsUnLock())
						
						nZZJBruto  +=nVlrBrut
						nZZJLiquido+=nVlrLiq
						nZZJVlrVPC +=ZZL->ZZL_VLRVPC
						
						nZZKBruto  +=nVlrBrut
						nZZKLiquido+=nVlrLiq
						nZZKVlrVPC +=ZZL->ZZL_VLRVPC
						(cAliasNotas)->(DbSkip())
					EndDo
					
					
					If lGravouItem
						
						lCalculado:=.T.
						ZZK->(RecLock("ZZK",.T.))
						ZZK->ZZK_FILIAL	:=xFilial("ZZK")
						
						ZZK->ZZK_CODIGO	:=cCodApuracao
						
						ZZK->ZZK_CONTRA	:=ZZ7->ZZ7_CODIGO
						ZZK->ZZK_VERSAO	:=ZZ7->ZZ7_VERSAO
						ZZK->ZZK_CODVPC	:=ZZ8->ZZ8_TIPO
						ZZK->ZZK_DESVPC	:=ZZ8->ZZ8_DESCTI
						ZZK->ZZK_PERCEN	:=ZZ8->ZZ8_PERCEN
						ZZK->ZZK_TPFAT 	:=ZZ8->ZZ8_TPFAT
						ZZK->ZZK_PERIOD :=ZZ8->ZZ8_PERIOD
						ZZK->ZZK_DTINIC	:=aDatas[1]
						ZZK->ZZK_DTFIM 	:=aDatas[2]
						ZZK->ZZK_VLRBRU	:=nZZKBruto
						ZZK->ZZK_VLRLIQ	:=nZZKLiquido
						ZZK->ZZK_VLRVPC	:=nZZKVlrVPC
						ZZK->ZZK_CLIENT :=cCLiNF
						ZZK->ZZK_LOJA  	:=cLojaNF
						ZZK->(MsUnLock())
						
						nZZKBruto:=0
						nZZKLiquido:=0
						nZZKVlrVPC:=0
					EndIf
					
					If lGravouItem
						
						cItem:=Soma1(cItem)
						SA1->(DbSetOrder(1))
						SA1->(DbSeek(xFilial("SA1")+cCLiNF+cLojaNF  ))
						
						ZZJ->(RecLock("ZZJ",.T.))
						ZZJ->ZZJ_FILIAL	:=xFilial("ZZJ")
						ZZJ->ZZJ_CODIGO	:=cCodApuracao
						ZZJ->ZZJ_ITEM	:=cItem
						ZZJ->ZZJ_CONTRA	:=ZZ7->ZZ7_CODIGO
						ZZJ->ZZJ_VERSAO	:=ZZ7->ZZ7_VERSAO
						ZZJ->ZZJ_DESC	:=ZZ7->ZZ7_DESC
						ZZJ->ZZJ_GRPCLI	:=SA1->A1_GRPVEN
						ZZJ->ZZJ_DESGRU	:=Posicione("ACY",1,xFilial("ACY")+SA1->A1_GRPVEN,"ACY_DESCRI")
						ZZJ->ZZJ_CLIENT	:=SA1->A1_COD
						ZZJ->ZZJ_LOJA  	:=SA1->A1_LOJA
						ZZJ->ZZJ_DESCLI	:=SA1->A1_NOME
						ZZJ->ZZJ_MESPGT	:=cMes
						ZZJ->ZZJ_TIPO	:=IIf(lProvisorio,"P","E" )
						
						ZZJ->ZZJ_VLRBRU	:=nZZJBruto
						ZZJ->ZZJ_VLRLIQ	:=nZZJLiquido
						ZZJ->ZZJ_VLRVPC	:=nZZJVlrVPC
						ZZJ->ZZJ_DTAPUR	:=dDataPgto
						ZZJ->ZZJ_DTHORA	:=Time()
						ZZJ->ZZJ_USUAPU	:=cUserName
						ZZJ->ZZJ_TPVPC 	:=IIf(mv_par01==1,"F","C" )
						ZZJ->(MsUnLock())
						ConfirmSX8()
					Else
						RollBackSX8()
					EndIf
				Enddo
				
				
				(cAliasCtr)->(DbSkip())
			EndDo
		EndDo
		
	Else
		
		cChaveCtr:=(cAliasCtr)->(ZZA_CODIGO+ZZA_VERSAO)
		aVlrBase:={0,0}
		aCrescimento:={0,0}
		nSkip:=0
		lGravouItem:=.F.
		If (cAliasCtr)->ZZA_REFERE=="1"//Mensal
			nSkip:= Month(dDataPgto)-1
		ElseIf (cAliasCtr)->ZZA_REFERE=="2"//Bimestre
			nMesPgto:=StrZero( Month(dDataPgto),2)
			nSkip:=0
			If nMesPgto$"03*04"
				nSkip:=1
			ElseIf nMesPgto$"05*06"
				nSkip:=2
			ElseIf nMesPgto$"07*08"
				nSkip:=3
			ElseIf nMesPgto$"09*10"
				nSkip:=4
			ElseIf nMesPgto$"11*12"
				nSkip:=5
			EndIf
		ElseIf (cAliasCtr)->ZZA_REFERE=="3"//Trimestral
			cQuery:="SELECT TO_CHAR(TO_DATE('"+Dtos(dDataPgto)+"', 'yyyymmdd'), 'Q') quarter FROM dual"
			DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"PR709TRI", .F., .F.)
			nSkip:=Val(PR709TRI->QUARTER)-1
			PR709TRI->(DbCloseArea())
		ElseIf (cAliasCtr)->ZZA_REFERE=="4"//Semestral
			If Month(dDataPgto)>6
				nSkip:=1
			EndIf
		EndIf
		
		For nInd:=1 To nSkip
			(cAliasCtr)->(DbSkip())
		Next
		
		If !(cAliasCtr)->(Eof())
			
			aDatas:=U_R709Periodo(dDataPgto,(cAliasCtr)->ZZA_REFERE,.F.)
			If (cAliasCtr)->ZZA_BASE==0
				dDtAux:=CTOD( StrZero(Day(dDataPgto),2)+"/"+StrZero(Month(dDataPgto),2)+"/"+StrZero(Year(dDataPgto)-1,4))
				aDtBase:=U_R709Periodo(dDtAux,(cAliasCtr)->ZZA_REFERE,.F.)
				//aDatas	:={CTOD("03/12/2013"),CTOD("03/12/2013")}
				R709QryNotas(cAliasNotas,aDtBase,"",cClasse,cExcecao,lProvisorio)
				aVlrBase:=PR709VlrBase(cAliasNotas,.t.)
			Else
				aVlrBase[ Val( (cAliasCtr)->ZZA_TPFAT) ]	:=(cAliasCtr)->ZZA_BASE
			EndIf
			
			cCodApuracao:=GetSXENum("ZZJ","ZZJ_CODIGO")
			cItem		   :=StrZero(0,AvSx3("ZZJ_ITEM",3) )
			R709QryNotas(cAliasNotas,aDatas,"",cClasse,cExcecao,lProvisorio)
			aFaturamento:=PR709VlrBase(cAliasNotas,.F.)
			
			aCrescimento[1]:=aFaturamento[ Val( (cAliasCtr)->ZZA_TPFAT) ]-aVlrBase[ Val( (cAliasCtr)->ZZA_TPFAT) ]  //Crescimento em Valor
			aCrescimento[2]:=(aCrescimento[1] /aVlrBase[ Val( (cAliasCtr)->ZZA_TPFAT) ])*100                    //Crescimento em %
			
			ZZB->(DbSetOrder(1))//ZZB_FILIAL+ZZB_CODIGO+ZZB_VERSAO
			ZZB->(DbSeek(xFilial("ZZB")+cChaveCtr ))
			
			lPremio:=.F.
			aPremio:={0,0}   
			aRecnos:={}
			lGravouItem:=.F.
			Do While ZZB->(!Eof() )  .And. ZZB->(ZZB_FILIAL+ZZB_CODIGO+ZZB_VERSAO)==xFilial("ZZB")+cChaveCtr
				If (aCrescimento[1]>=ZZB->ZZB_VLRINI .And. aCrescimento[1]<=ZZB->ZZB_VLRFIM) .Or. (aCrescimento[2]>=ZZB->ZZB_PERINI .And. aCrescimento[2]<=ZZB->ZZB_PERFIM)
					aPremio:={ZZB->ZZB_PERCEN,ZZB->ZZB_VALOR,ZZB->(Recno()) }
					lPremio:=.T.
					Exit
				EndIf
				ZZB->(DbSkip())
			EndDo
			
			lPremio:=.t.
			(cAliasNotas)->(DbGoTop())
			
			Do While (cAliasNotas)->( !Eof() ) .And. lPremio
				
				//oProcess:IncRegua2( "Calculando....")
				
				SF2->(DbGoTo( (cAliasNotas)->SF2Recno )  )
				SD2->(DbGoTo( (cAliasNotas)->SD2Recno )  )
				
				cCliNF	     :=(cAliasNotas)->F2_CLIENTE				
				cLojaNF 		  :=(cAliasNotas)->F2_LOJA

				
				lGravouItem:=.T.
				ZZL->(RecLock("ZZL",.T.))
				
				ZZL->ZZL_FILIAL	:=xFilial("ZZL")
				
				ZZL->ZZL_CODIGO	:=cCodApuracao
				ZZL->ZZL_TPNOTA	:="S"
				ZZL->ZZL_CONTRA	:=ZZ7->ZZ7_CODIGO
				ZZL->ZZL_VERSAO	:=ZZ7->ZZ7_VERSAO
				ZZL->ZZL_CODVPC	:=""
				ZZL->ZZL_DESVPC	:="Crescimento"
				ZZL->ZZL_PERIOD   :=(cAliasCtr)->ZZA_REFERE
				ZZL->ZZL_TPFAT 	:=(cAliasCtr)->ZZA_TPFAT
				//ZZL->ZZL_ENTREG	:=	Posicione("SZ1",1,xFilial("SZ1")+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA),"Z1_DTENTRE")
				
				nVlrBrut:=0
				nVlrLiq :=0
				GrvZZL(@nVlrBrut,@nVlrLiq)
				
				If aPremio[1]>0
					ZZL->ZZL_VLRVPC	:=aPremio[1]/100*IIf( (cAliasCtr)->ZZA_TPFAT =="1",nVlrBrut,nVlrLiq)
					ZZL->ZZL_PERCEN	:=aPremio[1]
					nZZJVlrVPC +=ZZL->ZZL_VLRVPC
					nZZKVlrVPC +=ZZL->ZZL_VLRVPC
				Else
					AADD(aRecnos,ZZO->(Recno())  )
					nZZJVlrVPC :=ZZL->ZZL_VLRVPC
					nZZKVlrVPC :=ZZL->ZZL_VLRVPC
				EndIf
				nZZJBruto  +=nVlrBrut
				nZZJLiquido+=nVlrLiq			
				
				
				nZZKBruto  +=nVlrBrut
				nZZKLiquido+=nVlrLiq
				
				(cAliasNotas)->(DbSkip())				
				
			EndDo
			
			For nInd:=1 To Len(aRecnos)
				ZZL->(DbGoTo(aRecnos[nInd]))				
				ZZL->(RecLock("ZZL",.F.))
				
				If (cAliasCtr)->ZZA_TPFAT =="1"
					ZZL->ZZL_VLRVPC	:=(ZZL->ZZL_VLRBRU/nZZKBruto)*nZZKVlrVPC
					ZZL->ZZL_PERCEN	:=  (nZZKBruto/ZZL->ZZL_VLRVPC)*100
				Else
					ZZL->ZZL_VLRVPC	:=(ZZL->ZZL_VLRLIQ/nZZKLiquido)*nZZKVlrVPC				
					ZZL->ZZL_PERCEN	:=(nZZKLiquido/ZZL->ZZL_VLRVPC)*100					
				EndIf	
				ZZL->(MsUnLock())
			Next			
			
			If lGravouItem
				
				//ZZB->(DbGoTo(aPremio[3]))
				
				lCalculado:=.T.
				ZZK->(RecLock("ZZK",.T.))
				ZZK->ZZK_FILIAL	:=xFilial("ZZK")
				
				ZZK->ZZK_CODIGO	:=cCodApuracao
				
				ZZK->ZZK_CONTRA	:=ZZ7->ZZ7_CODIGO
				ZZK->ZZK_VERSAO	:=ZZ7->ZZ7_VERSAO
				//ZZK->ZZK_CODVPC	:=ZZ8->ZZ8_TIPO
				ZZK->ZZK_DESVPC	:="Crescimento"				
				ZZK->ZZK_PERCEN	:=aPremio[1]
				ZZK->ZZK_TPFAT 	:=(cAliasCtr)->ZZA_TPFAT
				ZZK->ZZK_PERIOD   :=(cAliasCtr)->ZZA_REFERE
				ZZK->ZZK_DTINIC	:=aDatas[1]
				ZZK->ZZK_DTFIM 	:=aDatas[2]
				ZZK->ZZK_VLRBRU	:=nZZKBruto
				ZZK->ZZK_VLRLIQ	:=nZZKLiquido
				ZZK->ZZK_VLRVPC	:=nZZKVlrVPC
				ZZK->ZZK_CLIENT   :=cCLiNF
				ZZK->ZZK_LOJA  	:=cLojaNF
				ZZK->(MsUnLock())
				
				nZZKBruto:=0
				nZZKLiquido:=0
				nZZKVlrVPC:=0
			EndIf
			
			If lGravouItem
				
				cItem:=Soma1(cItem)
				SA1->(DbSetOrder(1))
				SA1->(DbSeek(xFilial("SA1")+cCLiNF+cLojaNF  ))
				
				ZZJ->(RecLock("ZZJ",.T.))
				ZZJ->ZZJ_FILIAL	:=xFilial("ZZJ")
				ZZJ->ZZJ_CODIGO	:=cCodApuracao
				ZZJ->ZZJ_ITEM	   :=cItem
				ZZJ->ZZJ_CONTRA	:=ZZ7->ZZ7_CODIGO
				ZZJ->ZZJ_VERSAO	:=ZZ7->ZZ7_VERSAO
				ZZJ->ZZJ_DESC  	:=ZZ7->ZZ7_DESC
				ZZJ->ZZJ_GRPCLI	:=SA1->A1_GRPVEN
				ZZJ->ZZJ_DESGRU	:=Posicione("ACY",1,xFilial("ACY")+SA1->A1_GRPVEN,"ACY_DESCRI")
				ZZJ->ZZJ_CLIENT	:=SA1->A1_COD
				ZZJ->ZZJ_LOJA  	:=SA1->A1_LOJA
				ZZJ->ZZJ_DESCLI	:=SA1->A1_NOME
				ZZJ->ZZJ_MESPGT	:=cMesCresc
				
				ZZJ->ZZJ_VLRBRU	:=nZZJBruto
				ZZJ->ZZJ_VLRLIQ	:=nZZJLiquido
				ZZJ->ZZJ_VLRVPC	:=nZZJVlrVPC
				ZZJ->ZZJ_DTAPUR	:=dDataPgto
				ZZJ->ZZJ_DTHORA	:=Time()
				ZZJ->ZZJ_USUAPU	:=cUserName
				ZZJ->ZZJ_TPVPC 	:=IIf(mv_par01==1,"F","C" )
				ZZJ->ZZJ_TIPO	   :=IIf(lProvisorio,"P","E" )				
				ZZJ->ZZJ_VLRBAS	:=aVlrBase[ Val( (cAliasCtr)->ZZA_TPFAT) ]	
				ZZJ->ZZJ_VLRCRE  :=aCrescimento[1]				
				ZZJ->ZZJ_PERCRE  :=aCrescimento[2]
				ZZJ->(MsUnLock())
				ConfirmSX8()
			Else
				RollBackSX8()
			EndIf
			
		EndIf
		
		(cAliasCtr)->( DbEval( {|| .T. } ,{|| .T. },{||  (ZZA_CODIGO+ZZA_VERSAO)==cChaveCtr}  )   )
		
	EndIf
	
	
	
	End Transaction
EndDo

If lCalculado
	MsgInfo("Apuração "+cMes+" finalizada com sucesso.")
Else
	Help(" ",1,"EICSEMREG")
EndIf


If Select("cAliasCtr")>0
	(cAliasCtr)->(DbCloseArea())
EndIf

If Select("cAliasNotas")>0
	(cAliasNotas)->(DbCloseArea())
EndIf

RestArea(aAreaZZJ)
RestArea(aAreaAtu)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  11/26/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R709Contr(cAlias,dDtPgto)
Local cQuery 		:= ""
Local nCountReg	:=0

Default dDtPgto	:=dDataPgto


cQuery:=" Select ZZ7.R_E_C_N_O_ RecZZ7,"
If lVPCFinanceiro
	cQuery+="ZZ8.R_E_C_N_O_ RecZZ8,ZZ8_CODIGO,ZZ8_VERSAO,ZZ8_PERIOD "+ CRLF
Else
	cQuery+="ZZA.R_E_C_N_O_ RecZZA,ZZA_CODIGO,ZZA_VERSAO,ZZA_REFERE,ZZA_BASE,ZZA_TPFAT,ZZA_APURAC"+ CRLF
EndIf


cQuery+=" From "+RetSqlName("ZZ7")+" ZZ7,"
If lVPCFinanceiro
	cQuery+=RetSqlName("ZZ8")+" ZZ8"+ CRLF
Else
	cQuery+=RetSqlName("ZZA")+" ZZA"+ CRLF
EndIf

cQuery+=" Where ZZ7.ZZ7_FILIAL = '"+xFilial("ZZ7")+"'"+ CRLF
cQuery+=" And ZZ7.ZZ7_FLAG='1'"+CRLF

If !Empty(MV_PAR06) .or. !Empty(MV_PAR07)
	cQuery+= "  And ZZ7.ZZ7_GRPCLI BETWEEN '"	+MV_PAR06+"' AND '"+MV_PAR07+"'"	+ CRLF
Else
	cQuery+= "  And ZZ7.ZZ7_CLIENT BETWEEN '"	+MV_PAR02+"' AND '"+MV_PAR04+"'"+ CRLF
	cQuery+= " And ZZ7.ZZ7_LOJA BETWEEN '"	+MV_PAR03+"' AND '"+MV_PAR05+"'"+ CRLF
EndIf
cQuery+=" And ZZ7.ZZ7_STATUS='3'"+CRLF
cQuery+=" And ZZ7.ZZ7_DTALTE=' ' "+CRLF
cQuery+=" And '"+Dtos(dDtPgto)+"' Between ZZ7.ZZ7_DTVINI And ZZ7.ZZ7_DTVFIM"+ CRLF
cQuery+=" And ZZ7.D_E_L_E_T_= ' '"+ CRLF

If lVPCFinanceiro
	cQuery+=" And ZZ8.ZZ8_FILIAL = '"+xFilial("ZZ8")+"'"+ CRLF
	cQuery+=" And ZZ8.ZZ8_CODIGO=ZZ7.ZZ7_CODIGO"+ CRLF
	cQuery+=" And ZZ8.ZZ8_VERSAO=ZZ7.ZZ7_VERSAO"+ CRLF
	cQuery+=" And ZZ8.ZZ8_REPASS ='1'"+ CRLF  //Repasse Financeiro
	cQuery+=" And ZZ8.ZZ8_MES"+StrZero(Month(dDtPgto),2)+"='X'"+ CRLF
	cQuery+=" And ZZ8.D_E_L_E_T_= ' '"+ CRLF
	cQuery+=" Order By ZZ8.ZZ8_CODIGO,ZZ8.ZZ8_VERSAO,ZZ8.ZZ8_PERIOD"
Else
	cQuery+=" And ZZA.ZZA_FILIAL = '"+xFilial("ZZA")+"'"+ CRLF
	cQuery+=" And ZZA.ZZA_CODIGO=ZZ7.ZZ7_CODIGO"+ CRLF
	cQuery+=" And ZZA.ZZA_VERSAO=ZZ7.ZZ7_VERSAO"+ CRLF
	cQuery+=" And ZZA.D_E_L_E_T_= ' '"+ CRLF
	cQuery+=" Order By ZZA.R_E_C_N_O_"
Endif


DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias, .F., .F.)


(cAlias)->(dbGoTop())
(cAlias)->(DbEval({|| nCountReg++ }))

If Type("oProcess")=="O"
	oProcess:SetRegua1( nCountReg )
EndIf


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  11/26/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R709QryNotas(cAlias,aDatas,cPeriodo,cClasse,cExcecao,lProvisorio)
Local cQry 		:= ""
Local cQryInter:= ""
Local nCountReg:=0

cQuery:=" SELECT F2_CLIENTE,F2_LOJA,SF2.R_E_C_N_O_ SF2Recno,SD2.R_E_C_N_O_ SD2Recno "+CRLF
cQuery+=" FROM "+RetSqlName("SA1")+" SA1,"+RetSqlName("SF2")+" SF2, "+RetSqlName("SD2")+" SD2 "

If !Empty(cClasse)
	cQuery+=","+RetSqlName("SB1")	+" SB1 "
EndIf
cQuery+=CRLF

cQuery+=" WHERE SA1.A1_FILIAL='"+xFilial("SA1")+"'"+CRLF

If !Empty(ZZ7->ZZ7_GRPCLI)
	cQuery += " AND SA1.A1_GRPVEN ='"+ZZ7->ZZ7_GRPCLI+"'"+CRLF
Else
	cQuery += " AND SA1.A1_COD ='"+ZZ7->ZZ7_CLIENT+"'"+CRLF
	If  !Empty(ZZ7->ZZ7_LOJA)
		cQuery += " AND SA1.A1_LOJA ='"+ZZ7->ZZ7_LOJA+"'"+CRLF
	EndIf
EndIf
cQuery+=" AND SA1.D_E_L_E_T_    = ' ' "+CRLF

cQuery+=" AND SF2.F2_FILIAL='"+xFilial("SF2")+"'"+CRLF
cQuery+=" AND SF2.F2_CLIENTE=SA1.A1_COD"+CRLF
cQuery+=" AND SF2.F2_LOJA=SA1.A1_LOJA"	+CRLF
cQuery+=" AND SF2.F2_DOC  Between '"+Space(TamSx3("F2_DOC")[1])+"' And '"+Replicate("Z",TamSx3("F2_DOC")[1])+"'"+CRLF
cQuery+=" AND SF2.F2_SERIE Between '"+Space(TamSx3("F2_SERIE")[1])+"' And '"+Replicate("Z",TamSx3("F2_SERIE")[1])+"'"+CRLF

cQuery+=" AND SF2.F2_TIPO = 'N'"													+CRLF


If lProvisorio
	cQuery+=" 	AND SF2.F2_EMISSAO BETWEEN '"+DtoS(aDatas[1])+"' AND '"+DtoS(aDatas[2])+"'"	+CRLF
	
Else
	cQuery+=" AND EXISTS(	SELECT "													+CRLF
	cQuery+=" 	Z1_DOC"												+CRLF
	cQuery+=" 	FROM "+RetSqlName("SZ1")+ " SZ1 "						+CRLF
	cQuery+=" 	WHERE SZ1.Z1_FILIAL = SF2.F2_FILIAL"					+CRLF
	cQuery+=" 	AND SZ1.Z1_DOC = SF2.F2_DOC "							+CRLF
	cQuery+=" 	AND SZ1.Z1_SERIE = SF2.F2_SERIE "						+CRLF
	cQuery+=" 	AND SZ1.Z1_CLIENTE = SF2.F2_CLIENTE"					+CRLF
	cQuery+=" 	AND SZ1.Z1_LOJA = SF2.F2_LOJA"							+CRLF
	cQuery+=" 	AND SZ1.Z1_DTENTRE BETWEEN '"+DtoS(aDatas[1])+"' AND '"+DtoS(aDatas[2])+"'"	+CRLF
	cQuery+=" 	AND SZ1.D_E_L_E_T_= ' ')"								+CRLF
EndIf

cQuery+=" AND SF2.D_E_L_E_T_= ' '"												+CRLF

cQuery+=" AND SD2.D2_FILIAL     =  '"+xFilial("SD2")+"' "+CRLF
cQuery+=" AND SF2.F2_DOC        = SD2.D2_DOC "+CRLF
cQuery+=" AND SF2.F2_SERIE      = SD2.D2_SERIE "+CRLF
cQuery+=" AND SF2.F2_LOJA       = SD2.D2_LOJA "+CRLF
cQuery+=" AND SF2.F2_CLIENTE    = SD2.D2_CLIENTE "+CRLF
cQuery+=" AND SD2.D_E_L_E_T_    = ' ' "

If !Empty(cExcecao)
	cQuery+=" AND SD2.D2_COD NOT IN "+FormatIn(cExcecao,";")+CRLF
EndIf

If !Empty(cClasse)
	cQuery+=" AND SD2.D2_COD=SB1.B1_COD"+CRLF
	cQuery+=" AND SB1.B1_FILIAL='"+xFilial("SB1")+"'"+CRLF
	cQuery+=" AND SB1.B1_YCLASSE IN "+FormatIn(cClasse,";")+CRLF
	cQuery+=" AND SB1.D_E_L_E_T_    = ' ' "+CRLF
EndIf                            

cQuery+=" AND EXISTS ( SELECT 1 FROM "+RetSqlName("SF4") +" SF4 WHERE SF4.F4_FILIAL='"+xFilial("SF4")+"' AND SF4.F4_DUPLIC='S' AND SF4.F4_CODIGO=SD2.D2_TES AND SF4.D_E_L_E_T_=' ')"	+CRLF

cQuery+=" Order By F2_CLIENTE,F2_LOJA "

If Select(cAlias)>0
	(cAlias)->(DbCloseArea())
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias, .F., .F.)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  11/26/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R709Periodo(dData,cPeriodo,lFinanceiro)
Local aDatas
Local dtFinal
Local nContar:=0

If lFinanceiro
	dtFinal:=FirstDay(dData)-1
Else
	dtFinal:=dData
EndIf

If cPeriodo=="1" //Mensal
	nContar:=0
ElseIf cPeriodo=="2" //Bimestral
	nContar:=1
ElseIf cPeriodo=="3" //Trimestral
	nContar:=2
ElseIf cPeriodo=="4" //Semestral
	nContar:=5
ElseIf cPeriodo=="5" //Anual
	nContar:=11
EndIf

dtInicial:=FirstDay(dtFinal)

For nInd:=1 To nContar
	dtInicial:=FirstDay(dtInicial-1)
Next


aDatas:={dtInicial,dtFinal}
Return aDatas

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  11/26/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR709Devol(nVlrBrut,nVlrLiq,lGravar)
Local aAreaAtu	:=GetArea()
Local cAliasQry:=GetNextAlias()
Local cQuery

cQuery:=" Select  "+CRLF

If !lGravar
	cQuery+=" ( (D1_TOTAL +  D1_VALIPI +  D1_ICMSRET +  D1_DESPESA +  D1_SEGURO +  D1_VALFRE ) -  D1_VALDESC ) As Bruto,"+CRLF
	cQuery+=" ((D1_TOTAL +  D1_VALIPI +  D1_ICMSRET +  D1_DESPESA +  D1_SEGURO +  D1_VALFRE  -  D1_VALDESC) - ( D1_VALICM+ D1_VALIMP6+ D1_VALIMP5+ D1_VALIPI+ D1_ICMSRET+  D1_DESPESA +  D1_SEGURO +  D1_VALFRE)) As Liquido"+CRLF
Else
	cQuery+=" R_E_C_N_O_ SD1RECNO"+CRLF
EndIf
cQuery+=" From "+RetSqlname("SD1")+" SD1 "+CRLF
cQuery+=" Where SD1.D1_FILIAL='"+xFilial("SD1")+"'"+CRLF
cQuery+=" And  SD1.D1_NFORI ='"+SD2->D2_DOC+"'"+CRLF
cQuery+=" And  SD1.D1_SERIORI='"+SD2->D2_SERIE+"'"+CRLF
cQuery+=" And  SD1.D1_FORNECE='"+SD2->D2_CLIENTE+"'"+CRLF
cQuery+=" And  SD1.D1_LOJA= '"+SD2->D2_LOJA+"'"+CRLF
cQuery+=" And  SD1.D1_COD= '"+SD2->D2_COD+"'"+CRLF
cQuery+=" And  SD1.D1_ITEMORI= '"+SD2->D2_ITEM+"'"+CRLF
cQuery+=" And  SD1.D_E_L_E_T_= ' '"+CRLF
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry, .F., .F.)

If !lGravar
	nVlrBrut-=(cAliasQry)->Bruto
	nVlrLiq-=(cAliasQry)->Liquido
Else
	Do While (cAliasQry)->(!Eof())
		SD1->(DbGoTo((cAliasQry)->SD1RECNO))
		ZZL->(RecLock("ZZL",.T.))
		ZZL->ZZL_CODIGO	:=cCodApuracao
		ZZL->ZZL_TPNOTA	:="D"
		ZZL->ZZL_CONTRA	:=ZZ7->ZZ7_CODIGO
		ZZL->ZZL_CONTRA	:=ZZ7->ZZ7_CODIGO
		ZZL->ZZL_VERSAO	:=ZZ7->ZZ7_VERSAO
		ZZL->ZZL_CODVPC	:=ZZ8->ZZ8_TIPO
		ZZL->ZZL_DESVPC	:=ZZ8->ZZ8_DESCTI
		ZZL->ZZL_PERCEN	:=ZZ8->ZZ8_PERCEN
		ZZL->ZZL_TPFAT 	:=ZZ8->ZZ8_TPFAT
		ZZL->ZZL_PERIOD :=ZZ8->ZZ8_PERIOD
		ZZL->ZZL_PRODUT	:=SD1->D1_COD
		ZZL->ZZL_ITEMNF	:=SD1->D1_ITEMORI
		ZZL->ZZL_NOTA	:=SD1->D1_NFORI
		ZZL->ZZL_SERIE	:=SD1->D1_SERIORI
		ZZL->ZZL_EMISSA	:=SD1->D1_DTDIGIT
		ZZL->ZZL_CLIENT :=SD1->D1_FORNECE
		ZZL->ZZL_LOJA  	:=SD1->D1_LOJA
		ZZL->ZZL_TOTAL	:=SD1->D1_TOTAL*-1
		ZZL->ZZL_VALIPI	:=SD1->D1_VALIPI*-1
		ZZL->ZZL_VALICM	:=SD1->D1_VALICM*-1
		ZZL->ZZL_ICMSRE	:=SD1->D1_ICMSRET*-1
		ZZL->ZZL_VALIM5	:=SD1->D1_VALIMP5*-1
		ZZL->ZZL_VALIM6	:=SD1->D1_VALIMP6*-1
		ZZL->ZZL_SEGURO	:=SD1->D1_SEGURO*-1
		ZZL->ZZL_VALFRE	:=SD1->D1_VALFRE*-1
		ZZL->ZZL_DESPES	:=SD1->D1_DESPESA*-1
		ZZL->ZZL_QUANT 	:=SD1->D1_QUANT*-1
		ZZL->(MsUnLock())
		(cAliasQry)->(DbSkip())
	EndDo
	
EndIf


(cAliasQry)->(DbCloseArea())
RestArea(aAreaAtu)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  11/28/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R709Manut(cAlias,nReg,nOpc,cOpcao)
Local aArea		:= GetArea()
Local aSize   	:= MsAdvSize()
Local aObjects	:= {}
Local aCpoCab	:= {}
Local aInfo		:= {}
Local aPosObj	:= {}
Local aPosFld	:= {}
Local aObjFld	:= {}
Local bOk		:={|| lGravar:=.T.,oDlg:End() }
Local bCancel	:={|| oDlg:End() }
Local nOpcy		:=0
Local aButtons	:={}
Local lGravar	:=.F.

Local cSeekKey	:=xFilial("ZZJ")+ZZJ->(ZZJ_CODIGO+ZZJ_CLIENT+ZZJ_LOJA)
Local bSeekWhile := {|| ZZJ_FILIAL+ZZJ_CODIGO+ZZJ_CLIENT+ZZJ_LOJA}
Local uSeekFor	:={}

DEFAULT cOpcao:=""

Private aFolders	:={OemToAnsi('VPC'),OemToAnsi('Item Nf X VPC')}
Private oDlg

Private oGetVPC
Private aHeadVPC:={}
Private aColsVPC:={}

Private oGetItem
Private aHeadItem:={}
Private aColsItem:={}

Private oFolder
Private oEnchoice


Private aTELA[0][0],aGETS[0]

Private aCols	:={}
Private aHeader:={}

RegToMemory("ZZJ",nOpc==3)

//FillGetDados ( < nOpc>, < cAlias>, [ nOrder], [ cSeekKey], [ bSeekWhile], [ uSeekFor], [ aNoFields], [ aYesFields], [ lOnlyYes], [ cQuery], [ bMontCols], [ lEmpty], [ aHeaderAux], [ aColsAux], [ bAfterCols], [ bBeforeCols], [ bAfterHeader], [ cAliasQry], [ bCriaVar], [ lUserFields], [ aYesUsado] ) --> lRet

//VPC
bSeekWhile := {|| ZZK_FILIAL+ZZK_CODIGO+ZZK_CLIENT+ZZK_LOJA}
ZZK->(FillGetDados ( nOpc, "ZZK",1, cSeekKey, bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, /*{}*/, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadVPC, aColsVPC, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., /*{}*/ ))

// Item NF X VPC
bSeekWhile := {|| ZZL_FILIAL+ZZL_CODIGO+ZZL_CLIENT+ZZL_LOJA}
ZZL->(FillGetDados ( nOpc, "ZZL",1, cSeekKey, bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, /*{}*/, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadItem, aColsItem, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., /*{}*/ ))


aSizeAut	:= MsAdvSize(,.F.,400)
AAdd( aObjects, { 100, 100, .T., .T. } )
AAdd( aObjects, { 100, 100, .T., .T. } )


aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calcula o Size para os Folders³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aadd( aObjFld, {   1  ,  1, .T., .T. } )
aInfoFld := {1,1,aPosObj[2,4] - aPosObj[2,2] ,aPosObj[2,3] - aPosObj[2,1],3,3}
aPosFld := MsObjSize( aInfoFld, aObjFld )

DEFINE MSDIALOG oDlg TITLE OemtoAnsi("Apuração - Contratos") From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL


oEnchoice:=MsMGet():New( "ZZJ", nReg, nOpc, , , , aCpoCab, {aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]},, 1, , ,"AllwaysTrue()", oDlg, .F. , .T. , .F. , , .F. , .F. )

oFolder := TFolder():New(aPosObj[2,1],aPosObj[2,2],aFolders,{'','',''},oDlg,,,,.T.,.F.,aPosObj[2,4]-aPosObj[2,2],aPosObj[2,3]-aPosObj[2,1])
nGd1 := 2
nGd2 := 2
nGd3 := aPosObj[2,3]-aPosObj[2,1]-15
nGd4 := aPosObj[2,4]-aPosObj[2,2]-4

//MsNewGetDados(): New ( [ nTop], [ nLeft], [ nBottom], [ nRight ], [ nStyle], [ cLinhaOk], [ cTudoOk], [ cIniCpos], [ aAlter], [ nFreeze], [ nMax], [ cFieldOk], [ cSuperDel], [ cDelOk], [ oWnd], [ aPartHeader], [ aParCols], [ uChange], [ cTela] ) --> Objeto

oGetVPC     := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy ,'AllwaysTrue()',"AllwaysTrue()",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,"AllwaysTrue()" ,oFolder:aDialogs[1],aHeadVPC,aColsVPC)
oGetItem    := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy ,'AllwaysTrue()',"AllwaysTrue()",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,"AllwaysTrue()" ,oFolder:aDialogs[2],aHeadItem,aColsItem)


ACTIVATE MSDIALOG oDlg ON INIT IIf(Empty(cOpcao),EnchoiceBar(oDlg,bOk,bCancel,,aButtons),)

If lGravar .And. ALTERA
	ZZJ->(RecLock("ZZJ",.F.))
	ZZJ->ZZJ_VLRCLI:=M->ZZJ_VLRCLI
	ZZJ->(MsUnLock())
EndIf


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  01/10/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R709Legenda()
Local aCor:={}

aAdd(aCor,{'BR_AMARELO'	   ,"Apuração Provisória"   })
aAdd(aCor,{'BR_AZUL'	   ,"Apuração Efetivo Aberta"   })
aAdd(aCor,{"BR_VERMELHO"   ,"Apuração Efetivo Fechada"	 })
aAdd(aCor,{'BR_VERDE'      ,"Apuração Efetivo NCC Gerada"	 })
BrwLegenda(,"Status",aCor)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  01/10/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R709Encerra()

If ZZJ->ZZJ_TIPO=="P"
	Aviso(ProcName()+"-"+StrZero(ProcLine(),5),"Apuração Provisoria não pode ser encerrada.",{"Ok"},3)
	Return
EndIf

If Empty(ZZJ->ZZJ_DTFECH)
	If Aviso(ProcName()+"-"+StrZero(ProcLine(),5),"Confirma o encerramento da Apuração: "+ZZJ->ZZJ_CODIGO+" - "+ ZZJ->ZZJ_MESPGT +" ?"+CRLF+"Após o fechamento, a mesma não poderá mais ser reprocessada.",{"Sim","Não"},3) == 1
		ZZJ->(RecLock("ZZJ"))
		ZZJ->ZZJ_DTFECH:=MsDate()
		ZZJ->ZZJ_ENHORA:=Time()
		ZZJ->ZZJ_ENCUSU	:=cUserName
		ZZJ->(MsUnLock())
	EndIf
Else
	Aviso(ProcName()+"-"+StrZero(ProcLine(),5),"Essa apuração já foi encerrada.",{"Ok"},3)
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  01/10/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R709GeraNCC()

Processa( {|| PR709GrvSE1() }  )


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  01/10/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR709GrvSE1()

Local cNatRec	:=U_MyNewSX6(	"NCG_PR7091", "253", "C","Natureza da NCC VPC","Natureza da NCC VPC","Natureza da NCC VPC",.F. )
Local cPrefixo	:=PadR( GetMv("NCG_000016",,"VPC"), TAMSX3( "E1_PREFIXO" )[1] )
Local cTipoTit	:=PadR( GetMv("NCG_000018",,"NCC"), TAMSX3( "E1_TIPO" )[1] )

If !Empty(ZZJ->ZZJ_TITULO)
	Aviso(ProcName()+"-"+StrZero(ProcLine(),5),"NCC já gerada para esta apuração .",{"Ok"},3)
	Return
EndIf

If Empty(ZZJ->ZZJ_DTFECH)
	Aviso(ProcName()+"-"+StrZero(ProcLine(),5),"Apuração não encerrada.",{"Ok"},3)
	Return
EndIf

IncProc("Gerando NCC Apuração"+ZZJ->ZZJ_CODIGO+" Mês pagamento "+ZZJ->ZZJ_MESPGT+"-Contrato:"+ZZJ->(ZZJ_CONTRA+"/"+ZZJ->ZZJ_VERSAO))
aAuxTit	:= {}
aAdd( aAuxTit,{ "E1_FILIAL"		,xFilial("SE1")									,Nil } )
aAdd( aAuxTit,{ "E1_PREFIXO"	,cPrefixo										,Nil } )
aAdd( aAuxTit,{ "E1_NUM"		,PadR( ZZJ->ZZJ_CODIGO, TAMSX3( "E1_NUM" )[1] ),Nil } )
aAdd( aAuxTit,{ "E1_PARCELA"	,PadR( ZZJ->ZZJ_ITEM ,	TAMSX3( "E1_PARCELA" )[1] )		,Nil } )
aAdd( aAuxTit,{ "E1_TIPO"		,cTipoTit										,Nil } )
aAdd( aAuxTit,{ "E1_NATUREZ"	,cNatRec										,Nil } )
aAdd( aAuxTit,{ "E1_CLIENTE",	ZZJ->ZZJ_CLIENT									,Nil } )
aAdd( aAuxTit,{ "E1_LOJA",		ZZJ->ZZJ_LOJA									,Nil } )
aAdd( aAuxTit,{ "E1_NOMCLI",	ZZJ->ZZJ_DESCLI									,Nil } )
aAdd( aAuxTit,{ "E1_EMISSAO",	dDataBase										,Nil } )
aAdd( aAuxTit,{ "E1_VENCTO",	dDataBase  										,Nil } )
aAdd( aAuxTit,{ "E1_VENCREA",	DataValida( dDataBase + 7 )						,Nil } )
aAdd( aAuxTit,{ "E1_VALOR",		ZZJ->ZZJ_VLRVPC									,Nil } )
aAdd( aAuxTit,{ "E1_EMIS1",		dDataBase										,Nil } )
aAdd( aAuxTit,{ "E1_HIST",	"Contrato:"+ZZJ->(ZZJ_CONTRA+"/"+ZZJ->ZZJ_VERSAO) ,Nil } )
aAdd( aAuxTit,{ "E1_SALDO",		ZZJ->ZZJ_VLRVPC	,										Nil } )
aAdd( aAuxTit,{ "E1_VENCORI",	dDataBase,										Nil } )
aAdd( aAuxTit,{ "E1_MOEDA",		1,												Nil } )
aAdd( aAuxTit,{ "E1_VLCRUZ",	ZZJ->ZZJ_VLRVPC,										Nil } )
aAdd( aAuxTit,{ "E1_STATUS",	"A",											Nil } )
aAdd( aAuxTit,{ "E1_ORIGEM",	"NCGPR709",										Nil } )
aAdd( aAuxTit,{ "E1_FLUXO",		"S",											Nil } )
aAdd( aAuxTit,{ "E1_TIPODES",	"1",											Nil } )
aAdd( aAuxTit,{ "E1_MULTNAT",	"2",											Nil } )
aAdd( aAuxTit,{ "E1_YAPURAC",	ZZJ->ZZJ_CODIGO,								Nil } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variáveis de controle da Execauto                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lMsHelpAuto	:= .F.
lMsErroAuto	:= .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seta a filial de faturamento de acordo com o RDA                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa a rotina automártica                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsExecAuto( { |x,y,z| Fina040( x, y, z ) }, aAuxTit, 3 )

If lMsErroAuto
	MostraErro()
Else
	ZZJ->(RecLock("ZZJ"))
	ZZJ->ZZJ_TITULO:=SE1->E1_NUM
	ZZJ->ZZJ_PREFIX:=SE1->E1_PREFIXO
	ZZJ->(MsUnLock())
	MsgInfo("NCC gerada com sucesso.")
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  11/26/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function NCPRSX1( clPerg )
Local alAreaAtu	:= GetArea()
Local alAux		:= {}

PutSx1(clPerg,"01","Tipo VPC","Tipo VPC","Tipo VPC","mv_ch1","N",01,0,1,"C","","","","","mv_par01","Financeiro","Financeiro","Financeiro","","Crescimento","Crescimento","Crescimento","","","","","","","","","",{},{},{})

aAdd( alAux, {	"02",;		  					// 01-Ordem da Pergunta (2)
"Do Cliente",;					  				// 02-Descrição em Portugues (30)
"Do Cliente",;				  					// 03-Descrição em Espanhol (30)
"Do Cliente",;				  					// 04-Descrição em Ingles (30)
"mv_ch2",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_COD")[1],;							// 07-Tamanho da Variável (2)
TamSx3("A1_COD")[2],;							// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;// 11-Expressão de Validação da Variável (60)
"SA1",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR02",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Informe o código inicial do cliente     ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o código inicial do cliente     ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o código inicial do cliente     ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"03",;		  									// 01-Ordem da Pergunta (2)
"Da Loja",;						  				// 02-Descrição em Portugues (30)
"Da Loja",;				  						// 03-Descrição em Espanhol (30)
"Da Loja",;				  						// 04-Descrição em Ingles (30)
"mv_ch3",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_LOJA")[1],;							// 07-Tamanho da Variável (2)
TamSx3("A1_LOJA")[2],;							// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR03",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Informe o código inicial da loja do clie",;
"nte                                     ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o código inicial da loja do clie",;
"nte                                     ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o código inicial da loja do clie",;
"nte                                     ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"04",;		  									// 01-Ordem da Pergunta (2)
"Até o Cliente",;					  			// 02-Descrição em Portugues (30)
"Até o Cliente",;				  					// 03-Descrição em Espanhol (30)
"Até o Cliente",;				  					// 04-Descrição em Ingles (30)
"mv_ch4",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_COD")[1],;							// 07-Tamanho da Variável (2)
TamSx3("A1_COD")[2],;							// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;			// 11-Expressão de Validação da Variável (60)
"SA1",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR04",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Informe o código final do cliente       ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o código final do cliente       ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o código final do cliente       ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"05",;		  									// 01-Ordem da Pergunta (2)
"Ate a Loja",;						  				// 02-Descrição em Portugues (30)
"Ate a Loja",;				  						// 03-Descrição em Espanhol (30)
"Ate a Loja",;				  						// 04-Descrição em Ingles (30)
"mv_ch5",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_LOJA")[1],;							// 07-Tamanho da Variável (2)
TamSx3("A1_LOJA")[2],;							// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR05",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Informe o código final da loja do client",;
"e                                       ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o código final da loja do client",;
"e                                       ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o código final da loja do client",;
"e                                       ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )


aAdd( alAux, {	"06",;							// 01-Ordem da Pergunta (2)
"Do Grupo Cliente",;					  		// 02-Descrição em Portugues (30)
"Do Grupo Cliente",;			  				// 03-Descrição em Espanhol (30)
"Do Grupo Cliente",;			  				// 04-Descrição em Ingles (30)
"mv_ch7",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_GRPVEN")[1],;						// 07-Tamanho da Variável (2)
TamSx3("A1_GRPVEN")[2],;						// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"IIf(mv_par01==2,ExistCpo('ACY'),.T.)",;			// 11-Expressão de Validação da Variável (60)
"ACY",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR06",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Informe o código incial do Grupo Cliente",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o código incial do Grupo Cliente",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o código incial do Grupo Cliente",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"07",;							// 01-Ordem da Pergunta (2)
"Até Grupo Cliente",;					  		// 02-Descrição em Portugues (30)
"Até Grupo Cliente",;				  			// 03-Descrição em Espanhol (30)
"Até Grupo Cliente",;				  			// 04-Descrição em Ingles (30)
"mv_ch7",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_GRPVEN")[1],;						// 07-Tamanho da Variável (2)
TamSx3("A1_GRPVEN")[2],;						// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"IIf(mv_par01==2,ExistCpo('ACY'),.T.)",;			// 11-Expressão de Validação da Variável (60)
"ACY",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR07",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Informe o código final do Grupo Cliente",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o código final do Grupo Cliente",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o código final do Grupo Cliente",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

U_MyNewX1( { clPerg, aClone( alAux ) } )

PutSx1(clPerg,"08","Provisorio?","Provisorio?","Provisorio?","mv_ch8","N",01,0,1,"C","","","","","mv_par08","Sim","Sim","Sim","","Nao","Nao","Nao","","","","","","","","","",{},{},{})

RestArea( alAreaAtu )

Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  01/18/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GrvZZL(nVlrBrut,nVlrLiq)

ZZL->ZZL_QUANT 	:=SD2->D2_QUANT
ZZL->ZZL_PRODUT	:=SD2->D2_COD
ZZL->ZZL_ITEMNF	:=SD2->D2_ITEM
ZZL->ZZL_NOTA	   :=SD2->D2_DOC
ZZL->ZZL_SERIE	   :=SD2->D2_SERIE
ZZL->ZZL_EMISSA	:=SF2->F2_EMISSAO
ZZL->ZZL_CLIENT   :=SF2->F2_CLIENTE
ZZL->ZZL_LOJA  	:=SF2->F2_LOJA
ZZL->ZZL_TOTAL	   :=SD2->D2_TOTAL
ZZL->ZZL_VALIPI	:=SD2->D2_VALIPI
ZZL->ZZL_VALICM	:=SD2->D2_VALICM
ZZL->ZZL_ICMSRE	:=SD2->D2_ICMSRET
ZZL->ZZL_VALIM5	:=SD2->D2_VALIMP5
ZZL->ZZL_VALIM6	:=SD2->D2_VALIMP6
ZZL->ZZL_SEGURO	:=SD2->D2_SEGURO
ZZL->ZZL_VALFRE	:=SD2->D2_VALFRE
ZZL->ZZL_DESPES	:=SD2->D2_DESPESA

nVlrBrut:=SD2->(D2_TOTAL+D2_ICMSRET+D2_VALIPI+D2_DESPESA+D2_SEGURO+D2_VALFRE)
nVlrLiq :=nVlrBrut-(SD2->(D2_VALICM+D2_VALIMP6+D2_VALIMP5+D2_VALIPI+D2_ICMSRET+D2_DESPESA+D2_SEGURO+D2_VALFRE))

PR709Devol(@nVlrBrut,@nVlrLiq,.F.)//SD2 deve estar posicionado
ZZL->ZZL_VLRBRU	:=nVlrBrut
ZZL->ZZL_VLRLIQ	:=nVlrLiq

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR709  ºAutor  ³Microsiga           º Data ³  01/18/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR709VlrBase(cAliasNotas,lFechaArea)
Local aAreaAtu :=GetArea()
Local nVlrLiq	:=0
Local nVlrBrut	:=0
Local aRetorno


(cAliasNotas)->(DbGoTop())
Do While (cAliasNotas)->( !Eof() )
	
	SF2->(DbGoTo( (cAliasNotas)->SF2Recno )  )
	SD2->(DbGoTo( (cAliasNotas)->SD2Recno )  )
	
	nVlrBrut+=(SD2->(D2_TOTAL+D2_ICMSRET+D2_VALIPI+D2_DESPESA+D2_SEGURO+D2_VALFRE))
	nVlrLiq +=(SD2->(D2_TOTAL+D2_ICMSRET+D2_VALIPI+D2_DESPESA+D2_SEGURO+D2_VALFRE)-(SD2->(D2_VALICM+D2_VALIMP6+D2_VALIMP5+D2_VALIPI+D2_ICMSRET+D2_DESPESA+D2_SEGURO+D2_VALFRE)))
	
	PR709Devol(@nVlrBrut,@nVlrLiq,.F.)//SD2 deve estar posicionado
	
	(cAliasNotas)->(DbSkip())
EndDo
aRetorno:={nVlrBrut,nVlrLiq}
If lFechaArea
	(cAliasNotas)->(DbCloseArea())
Else
	(cAliasNotas)->(DbGoTop())
EndIf

RestArea(aAreaAtu)
Return aRetorno
