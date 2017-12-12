#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR710  ºAutor  ³ACPD 			     º Data ³  24/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Manutenção de Apuração de VERBA                             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                     
User Function NCGPR710()
Local aCores  		:= 	{}
Private dDataPgto :=dDataBase //MsDate()

AADD(aCores,{"!Empty(ZZM_TITULO)" , 'BR_VERDE'   })
AADD(aCores,{"ZZM_TIPO='P'"       , 'BR_AMARELO'  })
AADD(aCores,{"Empty(ZZM_DTFECH)"  , 'BR_AZUL'    })
AADD(aCores,{"!Empty(ZZM_DTFECH)" , 'BR_VERMELHO'})


Private cCadastro := "Manutenção de Apuração de Verba Extra."
Private aRotina := MenuDef()


mBrowse(,,,,"ZZM",,,,,,aCores)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR710  ºAutor  ³Microsiga           º Data ³  11/24/13   º±±
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
{"Visualizar"			,"U_R710Manut",0,2} ,;
{"Processar"			,"U_R710Proces",0,3} ,;
{"Reprocessar"			,"U_R710Proces",0,4} ,;
{"Valor Cliente"		,"U_R710Manut",0,4} ,;
{"Legenda"	    		,"U_R710Legenda",0,2} ,;
{"Gerar NCC"	   		,"U_R710GeraNCC",0,2} ,;
{"Encerrar"				,"U_R710Encerra",0,5}}

Return aRotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR710  ºAutor  ³Microsiga           º Data ³  11/24/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R710Proces()
Local aAreaAtu	:=GetArea()
Local cPerg		:="R710PROCES"
Local aMeses	:={"Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"}
Local aSays		:={}
Local aButtons	:={}
Local lProcessar:=.F.
Local cMes		:=aMeses[Month(dDataPgto)]+"/"+StrZero(Year(dDataPgto),4)
Private nOpca:=0

If INCLUI
	lProcessar:=.T.
Else
	cMes:=ZZM->ZZM_MESPGT
EndIf

//If lProcessar

NCPRSX1(cPerg)                                                                                                                                                                             
PutSx1(cPerg,"01","Tipo Verba","Tipo Verba","Tipo Verba","mv_ch1","N",01,0,1,"C","","","","","mv_par01","NCC Periodica","NCC Periodica","NCC Periodica","","Pedido Venda","Pedido Venda","Pedido Venda","","","","","","","","","",{},{},{})
PutSx1(cPerg,"08","Provisorio?","Provisorio?","Provisorio?","mv_ch7","N",01,0,1,"C","","","","","mv_par07","Sim","Sim","Sim","","Nao","Nao","Nao","","","","","","","","","",{},{},{})



AADD(aSays,OemToAnsi( "Este programa tem como objetivo Verba NCC Periodica/Pedido Venda"))
AADD(aSays,OemToAnsi( "pagamento "+cMes+" de acordo com os parâmetros definidos pelo usuário."))

Pergunte(cPerg,.T. )
AADD(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T. ) } } )
AADD(aButtons, { 1,.T.,{|| nOpca := 1,FechaBatch() }} )
AADD(aButtons, { 2,.T.,{|| nOpca := 0,FechaBatch() }} )
//Else

//EndIf

FormBatch( cCadastro, aSays, aButtons )

If nOpca == 1
	Processa( { || R710Calc(lProcessar,cMes) })
EndIf


RestArea(aAreaAtu)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR710  ºAutor  ³Microsiga           º Data ³  11/26/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R710Calc(lProcessar,cMes)
Local aAreaAtu		:=GetArea()
Local cAliasVerba		:=GetNextAlias() //Alias para os Contratos
Local cAliasNotas	:=GetNextAlias() //Alias para as Notas Fiscais
Local aAreaZZM		:=ZZM->(GetArea())
Local nPerLiq
Local nPerBru
Local cClasse
Local cExcecao
Local nCountReg
Local lGravouItem
Local nZZNBruto  :=0
Local nZZNLiquido:=0
Local nZZNVLRVER :=0
Local lGravouItem	 :=.F.
Local nZZMBruto  :=0
Local nZZMLiquido:=0
Local nZZMVLRVER:=0
Local lProvisorio:=(MV_PAR08==1)
Local lJaProcessado
Local aTipo	:=RetSx3Box( Posicione("SX3", 2, "ZZM_TIPO","X3CBox()" ),,,1)
Local aTabelas:={"ZZM","ZZN","ZZO"}
Local nLenMes	:=AvSx3("ZZM_MESPGT",3)
Local cChaveZZM
Local cItem
Local lPedidoVenda:=(mv_par01==2)
Local cChaveZZM:=xFilial("ZZM")+Padr(cMes,nLenMes)+IIf(lProvisorio,"P","E" )+IIf(lPedidoVenda,"2","1" )
Local lCalculado:=.F.
Local aRecnos:={}

Private oProcess    


ZZM->(DbSetOrder(2))//ZZM_FILIAL+ZZM_MESPGT+ZZM_TIPO+ZZM_TPVERB+ZZM_CLIENT+ZZM_LOJA                              
                                                                     
lJaProcessado:=ZZM->(DbSeek(cChaveZZM))
RestArea(aAreaZZM)
If lProcessar
	If lJaProcessado
		MsgStop(cMes+"-"+aTipo[Ascan(aTipo,{|a| a[2]==ZZM->ZZM_TIPO} ),3]+" já processado!! Execute o Reprocessar se necessário.")
		Return
	EndIf
	
Else
	If !lJaProcessado
		MsgStop(cMes+"-"+aTipo[Ascan(aTipo,{|a| a[2]==ZZM->ZZM_TIPO} ),3]+" não processado!! Execute o Processar se necessário.")
		Return
	ElseIf !MsgYesNo("Deseja reprocessar "+cMes+"'-"+aTipo[Ascan(aTipo,{|a| a[2]==ZZM->ZZM_TIPO} ),3]+"?")
		Return
	EndIf
	ZZM->(DbSetOrder(2))//ZZM_FILIAL+ZZM_MESPGT+ZZM_TIPO+ZZM_TPVERB+ZZM_CLIENT+ZZM_LOJA                                                                                                   
	ZZM->(DbSeek(cChaveZZM))
	Do While ZZM->(!Eof() ) .And. ZZM->(ZZM_FILIAL+ZZM_MESPGT+ZZM_TIPO)==cChaveZZM
		cCodApuracao:=ZZM->ZZM_CODIGO
		For nInd:=1 To Len(aTabelas)
			cSql := " Delete From " +RetSqlName(aTabelas[1])
			cSql += " Where ZZM_FILIAL ='"+xFilial(aTabelas[1])+"'
			cSql += " AND "+aTabelas[1]+"_CODIGO = '"+cCodApuracao+"'"
			If TcSQLExec( cSql ) < 0
				Aviso(ProcName()+"-"+StrZero(ProcLine(),5),"Ocorreu um erro, limpar os dados para Reprocessamento.",{"Ok"},3)
				Return
			Else
				TcSQLExec( "COMMIT" )
			EndIf
		Next
		
		ZZM->(DbSkip())
	EndDo
EndIf

oProcess := MsNewProcess():New( { ||  U_R710Verba(cAliasVerba)  }, "Aguarde", "Consultando Contratos...", .T. )
oProcess:Activate()

(cAliasVerba)->(dbGoTop())
Do While (cAliasVerba)->(!Eof())
	
	ZZ7->(DbGoTo( (cAliasVerba)->RECZZ7 ) )
	cChaveCtr:=(cAliasVerba)->(ZZ8_CODIGO+ZZ8_VERSAO)
	
	Begin Transaction
	
	
	Do While (cAliasVerba)->(!Eof()) .And. (cAliasVerba)->(ZZ8_CODIGO+ZZ8_VERSAO)==cChaveCtr
		
		cClasse:=""
		ZZ9->(DbSeek(xFilial("ZZ9")+ZZ7->(ZZ7_CODIGO+ZZ7_VERSAO)+'3' )  )
		Do While ZZ9->(!Eof()) .And. ZZ9->(ZZ9_FILIAL+ZZ9_CODIGO+ZZ9_VERSAO+ZZ9_FLAG)==xFilial("ZZ9")+ZZ7->(ZZ7_CODIGO+ZZ7_VERSAO)+'3'
			cClasse+=ZZ9->ZZ9_CLASSE+";"
			ZZ9->(DbSkip())
		EndDo
		cClasse:=Left(cClasse,Len(cClasse)-1)
		
		cExcecao:=""
		ZZ9->(DbSeek(xFilial("ZZ9")+ZZ7->(ZZ7_CODIGO+ZZ7_VERSAO)+'2' )  )
		Do While ZZ9->(!Eof()) .And. ZZ9->(ZZ9_FILIAL+ZZ9_CODIGO+ZZ9_VERSAO+ZZ9_FLAG)==xFilial("ZZ9")+ZZ7->(ZZ7_CODIGO+ZZ7_VERSAO)+'2'
			cExcecao+=ZZ9->ZZ9_PRODUT+";"
			ZZ9->(DbSkip())
		EndDo
		cExcecao:=Left(cExcecao,Len(cExcecao)-1)
		
		cPeriodo	:=(cAliasVerba)->ZZ8_PERIOD
		aDatas		:=U_R710Periodo(dDataPgto,cPeriodo)
		
		//If !R710QryNotas(cAliasNotas,aDatas,cPeriodo,cClasse,cExcecao,lProvisorio,ZZ7->ZZ7_VLRMET,ZZ7->ZZ7_PEDIDO)
			//(cAliasVerba)->(DbSkip())  //Meta não atingida
		//EndIf
		
		nCountReg:=0
		(cAliasNotas)->(dbGoTop())
		(cAliasNotas)->(DbEval({|| nCountReg++ }))
		
		cCodApuracao:=GetSXENum("ZZM","ZZM_CODIGO")
		cItem		:=StrZero(0,AvSx3("ZZM_ITEM",3) )
		Do While (cAliasVerba)->(!Eof()) .And. (cAliasVerba)->ZZ8_PERIOD==cPeriodo
			
			
			ZZ8->(DbGoTo( (cAliasVerba)->RECZZ8 ) )
			
			//oProcess:IncRegua1( "Apurando Contrato"+AllTrim(ZZ7->ZZ7_DESC)+" VPC:"+ZZ8->ZZ8_DESCTI  )
			
			(cAliasNotas)->( DbGoTop() )
			aRecnos:={}
			Do While (cAliasNotas)->( !Eof() )
				
				cCliNF	:=(cAliasNotas)->F2_CLIENTE
				cLojaNF :=(cAliasNotas)->F2_LOJA
				lGravouItem	  :=.F.
				
				nZZMBruto  	:=0
				nZZMLiquido	:=0
				nZZMVLRVER	:=0
				
				
				Do While (cAliasNotas)->( !Eof() ) .And. (cAliasNotas)->(F2_CLIENTE+F2_LOJA)==cCliNF+cLojaNF
					
					//oProcess:IncRegua2( "Calculando....")
					
					SF2->(DbGoTo( (cAliasNotas)->SF2Recno )  )
					SD2->(DbGoTo( (cAliasNotas)->SD2Recno )  )
					
					lGravouItem:=.T.
					ZZO->(RecLock("ZZO",.T.))
					
					ZZO->ZZO_FILIAL	:=xFilial("ZZO")
					
					ZZO->ZZO_CODIGO	:=cCodApuracao
					ZZO->ZZO_TPNOTA	:="S"
					ZZO->ZZO_CONTRA	:=ZZ7->ZZ7_CODIGO
					ZZO->ZZO_VERSAO	:=ZZ7->ZZ7_VERSAO
					ZZO->ZZO_CODVER	:=ZZ8->ZZ8_TIPO
					ZZO->ZZO_DESVER	:=ZZ8->ZZ8_DESCTI
					ZZO->ZZO_PERCEN	:=ZZ8->ZZ8_PERCEN
					ZZO->ZZO_TPFAT 	:=ZZ8->ZZ8_TPFAT
					ZZO->ZZO_PERIOD :=ZZ8->ZZ8_PERIOD
					ZZO->ZZO_PRODUT	:=SD2->D2_COD
					ZZO->ZZO_ITEMNF	:=SD2->D2_ITEM
					ZZO->ZZO_NOTA	:=SD2->D2_DOC
					ZZO->ZZO_SERIE	:=SD2->D2_SERIE
					ZZO->ZZO_EMISSA	:=SF2->F2_EMISSAO
					ZZO->ZZO_CLIENT :=SF2->F2_CLIENTE
					ZZO->ZZO_LOJA  	:=SF2->F2_LOJA
					ZZO->ZZO_TOTAL	:=SD2->D2_TOTAL
					ZZO->ZZO_VALIPI	:=SD2->D2_VALIPI
					ZZO->ZZO_VALICM	:=SD2->D2_VALICM
					ZZO->ZZO_ICMSRE	:=SD2->D2_ICMSRET
					ZZO->ZZO_VALIM5	:=SD2->D2_VALIMP5
					ZZO->ZZO_VALIM6	:=SD2->D2_VALIMP6
					ZZO->ZZO_SEGURO	:=SD2->D2_SEGURO
					ZZO->ZZO_VALFRE	:=SD2->D2_VALFRE
					ZZO->ZZO_DESPES	:=SD2->D2_DESPESA					
					ZZO->ZZO_QUANT 	:=SD2->D2_QUANT
					
					ZZO->ZZO_ENTREG	:=	Posicione("SZ1",1,xFilial("SZ1")+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA),"Z1_DTENTRE")
					
					nVlrBrut:=SD2->(D2_TOTAL+D2_ICMSRET+D2_VALIPI+D2_DESPESA+D2_SEGURO+D2_VALFRE)
					nVlrLiq :=nVlrBrut-(SD2->(D2_VALICM+D2_VALIMP6+D2_VALIMP5+D2_VALIPI+D2_ICMSRET+D2_DESPESA+D2_SEGURO+D2_VALFRE))
					
					PR710Devol(@nVlrBrut,@nVlrLiq,.F.)//SD2 deve estar posicionado
					
					ZZO->ZZO_VLRBRU	:=nVlrBrut
					ZZO->ZZO_VLRLIQ	:=nVlrLiq

					PR710Devol(@nVlrBrut,@nVlrLiq,.F.)//SD2 deve estar posicionado					
					
					If ZZ8->ZZ8_PERCEN>0
						ZZO->ZZO_VLRVER	:=ZZ8->ZZ8_PERCEN/100*IIf( ZZ8->ZZ8_TPFAT =="1",nVlrBrut,nVlrLiq)
						nZZMVLRVER +=ZZO->ZZO_VLRVER
						nZZNVLRVER +=ZZO->ZZO_VLRVER
					Else
						AADD(aRecnos,ZZO->(Recno())  )
						nZZMVLRVER :=ZZ8->ZZ8_VLRVEB
						nZZNVLRVER :=ZZ8->ZZ8_VLRVEB
					EndIf	                            
					
					ZZO->(MsUnLock())					
					
					nZZMBruto  +=nVlrBrut
					nZZMLiquido+=nVlrLiq

					
					nZZNBruto  +=nVlrBrut
					nZZNLiquido+=nVlrLiq

					
					(cAliasNotas)->(DbSkip())
				EndDo               
				
				For nInd:=1 To Len(aRecnos)
					ZZO->(DbGoTo(aRecnos[nInd]))				
					ZZO->(RecLock("ZZO",.F.))
					ZZO->ZZO_VLRVER	:=(ZZO->ZZO_VLRBRU/nZZNBruto)*nZZNVLRVER
					ZZO->(MsUnLock())
				Next
				
				
				
				If lGravouItem
					
					lCalculado:=.T.
					ZZN->(RecLock("ZZN",.T.))
					ZZN->ZZN_FILIAL	:=xFilial("ZZN")
					
					ZZN->ZZN_CODIGO	:=cCodApuracao
					
					ZZN->ZZN_CONTRA	:=ZZ7->ZZ7_CODIGO
					ZZN->ZZN_VERSAO	:=ZZ7->ZZ7_VERSAO
					ZZN->ZZN_CODVER	:=ZZ8->ZZ8_TIPO
					ZZN->ZZN_DESVER	:=ZZ8->ZZ8_DESCTI
					ZZN->ZZN_PERCEN	:=ZZ8->ZZ8_PERCEN
					ZZN->ZZN_TPFAT 	:=ZZ8->ZZ8_TPFAT
					ZZN->ZZN_PERIOD :=ZZ8->ZZ8_PERIOD
					ZZN->ZZN_DTINIC	:=aDatas[1]
					ZZN->ZZN_DTFIM 	:=aDatas[2]
					ZZN->ZZN_VLRBRU	:=nZZNBruto
					ZZN->ZZN_VLRLIQ	:=nZZNLiquido
					ZZN->ZZN_VLRVER	:=nZZNVLRVER
					ZZN->ZZN_CLIENT :=cCLiNF
					ZZN->ZZN_LOJA  	:=cLojaNF
					
					
					
					ZZN->(MsUnLock())
					
					nZZNBruto:=0
					nZZNLiquido:=0
					nZZNVLRVER:=0
				EndIf
				
				If lGravouItem
					
					cItem:=Soma1(cItem)
					SA1->(DbSetOrder(1))
					SA1->(DbSeek(xFilial("SA1")+cCLiNF+cLojaNF  ))
					
					ZZM->(RecLock("ZZM",.T.))
					ZZM->ZZM_FILIAL	:=xFilial("ZZM")
					ZZM->ZZM_CODIGO	:=cCodApuracao
					ZZM->ZZM_ITEM	:=cItem
					ZZM->ZZM_CONTRA	:=ZZ7->ZZ7_CODIGO
					ZZM->ZZM_VERSAO	:=ZZ7->ZZ7_VERSAO
					ZZM->ZZM_DESC	:=ZZ7->ZZ7_DESC
					ZZM->ZZM_GRPCLI	:=SA1->A1_GRPVEN
					ZZM->ZZM_DESGRU	:=Posicione("ACY",1,xFilial("ACY")+SA1->A1_GRPVEN,"ACY_DESCRI")
					ZZM->ZZM_CLIENT	:=SA1->A1_COD
					ZZM->ZZM_LOJA  	:=SA1->A1_LOJA
					ZZM->ZZM_DESCLI	:=SA1->A1_NOME
					ZZM->ZZM_MESPGT	:=cMes
					ZZM->ZZM_TIPO	:=IIf(lProvisorio,"P","E" )
					
					ZZM->ZZM_VLRBRU	:=nZZMBruto
					ZZM->ZZM_VLRLIQ	:=nZZMLiquido
					ZZM->ZZM_VLRVER	:=nZZMVLRVER
					ZZM->ZZM_DTAPUR	:=dDataPgto
					ZZM->ZZM_DTHORA	:=Time()
					ZZM->ZZM_USUAPU	:=cUserName
					ZZM->ZZM_TPVERB :=ZZ7->ZZ7_TPVERB
					
					If lPedidoVenda
						ZZM->ZZM_PEDIDO=ZZ7->ZZ7_PEDIDO
					Else
						ZZM->ZZM_META:=ZZ7->ZZ7_VLRMET
					EndIf
					
					ZZM->(MsUnLock())
					ConfirmSX8()
				Else
					RollBackSX8()
				EndIf
			Enddo
			
			
			(cAliasVerba)->(DbSkip())
		EndDo
	EndDo
	
	
	End Transaction
	
EndDo 
If lCalculado
	MsgInfo("Apuração "+cMes+" finalizada com sucesso.")
Else
	Help(" ",1,"EICSEMREG")
EndIf	

If Select(cAliasVerba)>0
	(cAliasVerba)->(DbCloseArea())
EndIf
	                    
If Select(cAliasNotas)>0
	(cAliasNotas)->(DbCloseArea())
EndIf


RestArea(aAreaZZM)
RestArea(aAreaAtu)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR710  ºAutor  ³Microsiga           º Data ³  11/26/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R710Verba(cAlias,dDtPgto)
Local cQuery 		:= ""
Local nCountReg	:=0
Local lPedidoVenda:=(mv_par01==2)
Local cTipo:=IIf((MV_PAR08==1),"P","E" )
Default dDtPgto	:=dDataPgto

cQuery:=" Select ZZ7.R_E_C_N_O_ RecZZ7,ZZ8.R_E_C_N_O_ RecZZ8,ZZ8_CODIGO,ZZ8_VERSAO,ZZ8_PERIOD "
cQuery+=" From "+RetSqlName("ZZ7")+" ZZ7,"+RetSqlName("ZZ8")+" ZZ8"+ CRLF
cQuery+=" Where ZZ7.ZZ7_FILIAL = '"+xFilial("ZZ7")+"'"+ CRLF
cQuery+=" And ZZ7.ZZ7_FLAG='2'"+CRLF	
cQuery+=" And ZZ7.ZZ7_STATUS='3'"+CRLF


If lPedidoVenda
	cQuery+=" And ZZ7.ZZ7_TPVERB='2'"+CRLF     
	cQuery+=" And Not Exists ( SELECT 1 From "+RetSqlName("ZZM") +" ZZM Where ZZM.ZZM_FILIAL='"+xFilial("ZZM")+"' And ZZM.ZZM_PEDIDO=ZZ7.ZZ7_PEDIDO AND ZZM_TIPO='"+cTipo+"' AND ZZM.D_E_L_E_T_=' ')"	+CRLF
Else
	cQuery+=" And ZZ7.ZZ7_TPVERB='1'"+CRLF			
	cQuery+=" And '"+Dtos(dDtPgto)+"' Between ZZ7.ZZ7_DTVINI And ZZ7.ZZ7_DTVFIM"+ CRLF
EndIf	

If !Empty(MV_PAR06) .or. !Empty(MV_PAR07)
	cQuery+= "  And ZZ7.ZZ7_GRPCLI BETWEEN '"	+MV_PAR06+"' AND '"+MV_PAR07+"'"	+ CRLF
Else
	cQuery+= " And ZZ7.ZZ7_CLIENT BETWEEN '"	+MV_PAR02+"' AND '"+MV_PAR04+"'"+ CRLF
	cQuery+= " And ZZ7.ZZ7_LOJA BETWEEN '"	    +MV_PAR03+"' AND '"+MV_PAR05+"'"+ CRLF
EndIf
cQuery+=" And ZZ7.ZZ7_DTALTE=' ' "+CRLF
cQuery+=" And ZZ7.D_E_L_E_T_= ' '"+ CRLF

cQuery+=" And ZZ8.ZZ8_FILIAL = '"+xFilial("ZZ8")+"'"+ CRLF
cQuery+=" And ZZ8.ZZ8_CODIGO=ZZ7.ZZ7_CODIGO"+ CRLF
cQuery+=" And ZZ8.ZZ8_VERSAO=ZZ7.ZZ7_VERSAO"+ CRLF

If lPedidoVenda
	cQuery+=" And ZZ8.ZZ8_REPASS ='2'"+ CRLF  //Pedido Venda
Else
	cQuery+=" And ZZ8.ZZ8_REPASS ='1'"+ CRLF  //Repasse Financeiro
	cQuery+=" And ZZ8.ZZ8_MES"+StrZero(Month(dDtPgto),2)+"='X'"+ CRLF
EndIf
cQuery+=" And ZZ8.D_E_L_E_T_= ' '"+ CRLF

cQuery+=" Order By ZZ8.ZZ8_CODIGO,ZZ8.ZZ8_VERSAO,ZZ8.ZZ8_PERIOD"

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
±±ºPrograma  ³NCGPR710  ºAutor  ³Microsiga           º Data ³  11/26/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R710QryNotas(cAlias,aDatas,cPeriodo,cClasse,cExcecao,lProvisorio,nMeta,cPedido)
Local cQry 		:= ""
Local cQryInter:= ""
Local nCountReg:=0
Local lPedidoVenda:=(mv_par01==2)

If !lPedidoVenda .And. !PR710Meta(aDatas,cPeriodo,cClasse,cExcecao,lProvisorio,nMeta)
	Return .F.
EndIf


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
	If !lPedidoVenda
		cQuery+=" 	AND SF2.F2_EMISSAO BETWEEN '"+DtoS(aDatas[1])+"' AND '"+DtoS(aDatas[2])+"'"	+CRLF
	EndIf	
Else
	cQuery+=" AND EXISTS(	SELECT "													+CRLF
	cQuery+=" 	Z1_DOC"												+CRLF
	cQuery+=" 	FROM "+RetSqlName("SZ1")+ " SZ1 "						+CRLF
	cQuery+=" 	WHERE SZ1.Z1_FILIAL = SF2.F2_FILIAL"					+CRLF
	cQuery+=" 	AND SZ1.Z1_DOC = SF2.F2_DOC "							+CRLF
	cQuery+=" 	AND SZ1.Z1_SERIE = SF2.F2_SERIE "						+CRLF
	cQuery+=" 	AND SZ1.Z1_CLIENTE = SF2.F2_CLIENTE"					+CRLF
	cQuery+=" 	AND SZ1.Z1_LOJA = SF2.F2_LOJA"							+CRLF
	If !lPedidoVenda
		cQuery+=" 	AND SZ1.Z1_DTENTRE BETWEEN '"+DtoS(aDatas[1])+"' AND '"+DtoS(aDatas[2])+"'"	+CRLF
	EndIf	
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

If lPedidoVenda
	cQuery+=" AND SD2.D2_PEDIDO='"+cPedido+"'"+CRLF	
EndIf

cQuery+=" AND EXISTS ( SELECT 1 FROM "+RetSqlName("SF4") +" SF4 WHERE SF4.F4_FILIAL='"+xFilial("SF4")+"' AND SF4.F4_DUPLIC='S' AND SF4.F4_CODIGO=SD2.D2_TES AND SF4.D_E_L_E_T_=' ')"	+CRLF

cQuery+=" Order By F2_CLIENTE,F2_LOJA "

If Select(cAlias)>0
	(cAlias)->(DbCloseArea())
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias, .F., .F.)

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR710  ºAutor  ³Microsiga           º Data ³  11/26/13   º±±
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
"Empty(MV_PAR06).and.Empty(MV_PAR07) .or. VAZIO()",;// 11-Expressão de Validação da Variável (60)
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
"mv_ch4",;							  			// 05-Nome da Variável (6)
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
"mv_ch5",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_COD")[1],;							// 07-Tamanho da Variável (2)
TamSx3("A1_COD")[2],;							// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"Empty(MV_PAR06).and.Empty(MV_PAR07) .or. VAZIO()",;			// 11-Expressão de Validação da Variável (60)
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
"mv_ch6",;							  			// 05-Nome da Variável (6)
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
"Empty(MV_PAR02).and.Empty(MV_PAR04) .or. VAZIO()",;			// 11-Expressão de Validação da Variável (60)
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
"mv_ch8",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_GRPVEN")[1],;						// 07-Tamanho da Variável (2)
TamSx3("A1_GRPVEN")[2],;						// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"Empty(MV_PAR02).and.Empty(MV_PAR04) .or. VAZIO()",;			// 11-Expressão de Validação da Variável (60)
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

RestArea( alAreaAtu )

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR710  ºAutor  ³Microsiga           º Data ³  11/26/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R710Periodo(dData,cPeriodo)
Local aDatas
Local dtFinal:=FirstDay(Date())-1
Local nContar:=0

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
±±ºPrograma  ³NCGPR710  ºAutor  ³Microsiga           º Data ³  11/26/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR710Devol(nVlrBrut,nVlrLiq,lGravar)
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
		ZZO->(RecLock("ZZO",.T.))
		ZZO->ZZO_CODIGO	:=cCodApuracao
		ZZO->ZZO_TPNOTA	:="D"		
		ZZO->ZZO_CONTRA	:=ZZ7->ZZ7_CODIGO
		ZZO->ZZO_CONTRA	:=ZZ7->ZZ7_CODIGO
		ZZO->ZZO_VERSAO	:=ZZ7->ZZ7_VERSAO
		ZZO->ZZO_CODVPC	:=ZZ8->ZZ8_TIPO
		ZZO->ZZO_DESVPC	:=ZZ8->ZZ8_DESCTI
		ZZO->ZZO_PERCEN	:=ZZ8->ZZ8_PERCEN
		ZZO->ZZO_TPFAT 	:=ZZ8->ZZ8_TPFAT
		ZZO->ZZO_PERIOD :=ZZ8->ZZ8_PERIOD
		ZZO->ZZO_PRODUT	:=SD1->D1_COD
		ZZO->ZZO_ITEMNF	:=SD1->D1_ITEMORI
		ZZO->ZZO_NOTA	:=SD1->D1_NFORI
		ZZO->ZZO_SERIE	:=SD1->D1_SERIORI
		ZZO->ZZO_EMISSA	:=SD1->D1_DTDIGIT
		ZZO->ZZO_CLIENT :=SD1->D1_FORNECE
		ZZO->ZZO_LOJA  	:=SD1->D1_LOJA
		ZZO->ZZO_TOTAL	:=SD1->D1_TOTAL*-1
		ZZO->ZZO_VALIPI	:=SD1->D1_VALIPI*-1
		ZZO->ZZO_VALICM	:=SD1->D1_VALICM*-1
		ZZO->ZZO_ICMSRE	:=SD1->D1_ICMSRET*-1
		ZZO->ZZO_VALIM5	:=SD1->D1_VALIMP5*-1
		ZZO->ZZO_VALIM6	:=SD1->D1_VALIMP6*-1
		ZZO->ZZO_SEGURO	:=SD1->D1_SEGURO*-1
		ZZO->ZZO_VALFRE	:=SD1->D1_VALFRE*-1
		ZZO->ZZO_DESPES	:=SD1->D1_DESPESA*-1
		ZZO->ZZO_QUANT 	:=SD1->D1_QUANT*-1
		ZZO->(MsUnLock())
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
±±ºPrograma  ³NCGPR710  ºAutor  ³Microsiga           º Data ³  11/28/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R710Manut(cAlias,nReg,nOpc,cOpcao)
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
Local lGravar:=.F.

Local cSeekKey	:=xFilial("ZZM")+ZZM->(ZZM_CODIGO+ZZM_CLIENT+ZZM_LOJA)
Local bSeekWhile := {|| ZZM_FILIAL+ZZM_CODIGO+ZZM_CLIENT+ZZM_LOJA}
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

RegToMemory("ZZM",nOpc==3)

//FillGetDados ( < nOpc>, < cAlias>, [ nOrder], [ cSeekKey], [ bSeekWhile], [ uSeekFor], [ aNoFields], [ aYesFields], [ lOnlyYes], [ cQuery], [ bMontCols], [ lEmpty], [ aHeaderAux], [ aColsAux], [ bAfterCols], [ bBeforeCols], [ bAfterHeader], [ cAliasQry], [ bCriaVar], [ lUserFields], [ aYesUsado] ) --> lRet

//VPC
bSeekWhile := {|| ZZN_FILIAL+ZZN_CODIGO+ZZN_CLIENT+ZZN_LOJA}
ZZN->(FillGetDados ( nOpc, "ZZN",1, cSeekKey, bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, /*{}*/, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadVPC, aColsVPC, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., /*{}*/ ))

// Item NF X VPC
bSeekWhile := {|| ZZO_FILIAL+ZZO_CODIGO+ZZO_CLIENT+ZZO_LOJA}
ZZO->(FillGetDados ( nOpc, "ZZO",1, cSeekKey, bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, /*{}*/, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadItem, aColsItem, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., /*{}*/ ))


aSizeAut	:= MsAdvSize(,.F.,400)
AAdd( aObjects, { 0,   100, .T., .F. } )
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


oEnchoice:=MsMGet():New( "ZZM", nReg, nOpc, , , , aCpoCab, {aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]},, 1, , ,"AllwaysTrue()", oDlg, .F. , .T. , .F. , , .T. , .F. )

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
	ZZM->(RecLock("ZZM",.F.))
	ZZM->ZZM_VLRCLI:=M->ZZM_VLRCLI
	ZZM->(MsUnLock())
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR710  ºAutor  ³Microsiga           º Data ³  01/10/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R710Legenda()
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
±±ºPrograma  ³NCGPR710  ºAutor  ³Microsiga           º Data ³  01/10/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R710Encerra()

If ZZM->ZZM_TIPO=="P"
	Aviso(ProcName()+"-"+StrZero(ProcLine(),5),"Apuração Provisoria não pode ser encerrada.",{"Ok"},3)
	Return
EndIf

If Empty(ZZM->ZZM_DTFECH)
	If Aviso(ProcName()+"-"+StrZero(ProcLine(),5),"Confirma o encerramento da Apuração: "+ZZM->ZZM_CODIGO+" - "+ ZZM->ZZM_MESPGT +" ?"+CRLF+"Após o fechamento, a mesma não poderá mais ser reprocessada.",{"Sim","Não"},3) == 1
		ZZM->(RecLock("ZZM"))
		ZZM->ZZM_DTFECH:=MsDate()
		ZZM->ZZM_ENHORA:=Time()
		ZZM->ZZM_ENCUSU	:=cUserName
		ZZM->(MsUnLock())
	EndIf
Else
	Aviso(ProcName()+"-"+StrZero(ProcLine(),5),"Essa apuração já foi encerrada.",{"Ok"},3)
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR710  ºAutor  ³Microsiga           º Data ³  01/10/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R710GeraNCC()

Processa( {|| PR710GrvSE1() }  )


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR710  ºAutor  ³Microsiga           º Data ³  01/10/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR710GrvSE1()
Local cNatRec	:=U_MyNewSX6("NCG_PR7101", "259","C","Natureza da Verba Extra","Natureza da Verba Extra","Natureza da Verba Extra",.F. )
Local cPrefixo	:=U_MyNewSX6("NCG_PR7102", "VE" ,"C","Prefixo Verba Extra","Prefixo Verba Extra","Prefixo Verba Extra",.F. )
Local cTipoTit	:=U_MyNewSX6("NCG_PR7103", "NCC","C","Tipo Verba Extra","Tipo Verba Extra","Tipo Verba Extra",.F. )

If !Empty(ZZM->ZZM_TITULO)
	Aviso(ProcName()+"-"+StrZero(ProcLine(),5),"Verba Extra já gerada para esta apuração .",{"Ok"},3)
	Return
EndIf

If Empty(ZZM->ZZM_DTFECH)
	Aviso(ProcName()+"-"+StrZero(ProcLine(),5),"Apuração não encerrada.",{"Ok"},3)
	Return
EndIf                    


IncProc("Gerando NCC Apuração"+ZZM->ZZM_CODIGO+" Mês pagamento "+ZZM->ZZM_MESPGT+"-Contrato:"+ZZM->(ZZM_CONTRA+"/"+ZZM->ZZM_VERSAO))
aAuxTit	:= {}
aAdd( aAuxTit,{ "E1_FILIAL"		,xFilial("SE1")									,Nil } )
aAdd( aAuxTit,{ "E1_PREFIXO"	,cPrefixo										,Nil } )
aAdd( aAuxTit,{ "E1_NUM"		,PadR( ZZM->ZZM_CODIGO, TAMSX3( "E1_NUM" )[1] ),Nil } )
aAdd( aAuxTit,{ "E1_PARCELA"	,PadR( ZZM->ZZM_ITEM ,	TAMSX3( "E1_PARCELA" )[1] )		,Nil } )
aAdd( aAuxTit,{ "E1_TIPO"		,cTipoTit										,Nil } )
aAdd( aAuxTit,{ "E1_NATUREZ"	,cNatRec										,Nil } )
aAdd( aAuxTit,{ "E1_CLIENTE",	ZZM->ZZM_CLIENT									,Nil } )
aAdd( aAuxTit,{ "E1_LOJA",		ZZM->ZZM_LOJA									,Nil } )
aAdd( aAuxTit,{ "E1_NOMCLI",	ZZM->ZZM_DESCLI									,Nil } )
aAdd( aAuxTit,{ "E1_EMISSAO",	dDataBase										,Nil } )
aAdd( aAuxTit,{ "E1_VENCTO",	dDataBase  										,Nil } )
aAdd( aAuxTit,{ "E1_VENCREA",	DataValida( dDataBase + 7 )						,Nil } )
aAdd( aAuxTit,{ "E1_VALOR",		ZZM->ZZM_VLRVER									,Nil } )
aAdd( aAuxTit,{ "E1_EMIS1",		dDataBase										,Nil } )
aAdd( aAuxTit,{ "E1_HIST",	"Contrato:"+ZZM->(ZZM_CONTRA+"/"+ZZM->ZZM_VERSAO) ,Nil } )
aAdd( aAuxTit,{ "E1_SALDO",		ZZM->ZZM_VLRVER	,										Nil } )
aAdd( aAuxTit,{ "E1_VENCORI",	dDataBase,										Nil } )
aAdd( aAuxTit,{ "E1_MOEDA",		1,												Nil } )
aAdd( aAuxTit,{ "E1_VLCRUZ",	ZZM->ZZM_VLRVER,										Nil } )
aAdd( aAuxTit,{ "E1_STATUS",	"A",											Nil } )
aAdd( aAuxTit,{ "E1_ORIGEM",	"NCGPR710",										Nil } )
aAdd( aAuxTit,{ "E1_FLUXO",		"S",											Nil } )
aAdd( aAuxTit,{ "E1_TIPODES",	"1",											Nil } )
aAdd( aAuxTit,{ "E1_MULTNAT",	"2",											Nil } )
aAdd( aAuxTit,{ "E1_YAPURAC",	ZZM->ZZM_CODIGO,											Nil } )

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
	ZZM->(RecLock("ZZM"))
	ZZM->ZZM_TITULO:=SE1->E1_NUM
	ZZM->ZZM_PREFIX:=SE1->E1_PREFIXO
	ZZM->(MsUnLock())
	MsgInfo("NCC gerada com sucesso.")
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR710  ºAutor  ³Microsiga           º Data ³  01/10/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR710Meta(aDatas,cPeriodo,cClasse,cExcecao,lProvisorio,nMeta)
Local aAreaAtu	:=GetArea()
Local cAliasQry:=GetNextAlias()
Local cQuery


cQuery:=" Select Sum(Bruto) Bruto,Sum(Liquido)  Liquido "+CRLF
cQuery+=" From ("+CRLF
cQuery+=" SELECT "+CRLF
cQuery+=" SUM ( D2_TOTAL +  D2_ICMSRET +  D2_VALIPI +   D2_DESPESA +  D2_SEGURO +  D2_VALFRE ) BRUTO, "+CRLF
cQuery+=" SUM ( D2_TOTAL +  D2_ICMSRET +  D2_VALIPI +    D2_DESPESA +  D2_SEGURO +  D2_VALFRE  )  -  SUM( D2_VALICM+ D2_VALIMP6+ D2_VALIMP5+ D2_VALIPI+ D2_ICMSRET+ D2_DESPESA+ D2_SEGURO+ D2_VALFRE) AS LIQUIDO "
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
cQuery+=" AND EXISTS ( SELECT 1 FROM "+RetSqlName("SF4") +" SF4 WHERE SF4.F4_FILIAL='"+xFilial("SF4")+"' AND SF4.F4_DUPLIC='S' AND SF4.F4_CODIGO=SD2.D2_TES AND SF4.D_E_L_E_T_=' ') "	+CRLF

cQuery+=" Union All "+CRLF

cQuery+=" Select  "+CRLF
cQuery+=" Sum((D1_TOTAL +  D1_VALIPI +  D1_ICMSRET +  D1_DESPESA +  D1_SEGURO +  D1_VALFRE ) -  D1_VALDESC )*-1 As Bruto ,"+CRLF
cQuery+=" Sum((D1_TOTAL +  D1_VALIPI +  D1_ICMSRET +  D1_DESPESA +  D1_SEGURO +  D1_VALFRE  -  D1_VALDESC) - ( D1_VALICM+ D1_VALIMP6+ D1_VALIMP5+ D1_VALIPI+ D1_ICMSRET+  D1_DESPESA +  D1_SEGURO +  D1_VALFRE)) *-1 As Liquido"+CRLF
cQuery+=" FROM "+RetSqlName("SF1")+" SF1,"+RetSqlName("SD1")+" SD1,"+RetSqlName("SF2")+" SF2, "+RetSqlName("SD2")+" SD2 "
cQuery+=" WHERE SD1.D1_FILIAL = '"+xFilial("SD1")+"'"+CRLF
cQuery+=" AND SD1.D1_DOC = SF1.F1_DOC"+CRLF
cQuery+=" AND SD1.D1_SERIE  = SF1.F1_SERIE"+CRLF
cQuery+=" AND SD1.D1_FORNECE= SF1.F1_FORNECE"+CRLF
cQuery+=" AND SD1.D1_LOJA   = SF1.F1_LOJA"+CRLF
cQuery+=" AND SD1.D_E_L_E_T_= ' '"+CRLF
cQuery+=" AND SD1.D1_NFORI = SF2.F2_DOC"+CRLF
cQuery+=" AND SD1.D1_SERIORI= SF2.F2_SERIE"+CRLF
cQuery+=" AND SD1.D1_LOJA   = SF2.F2_LOJA"+CRLF
cQuery+=" And  SD1.D1_COD= SD2.D2_COD"+CRLF
cQuery+=" And  SD1.D1_ITEMORI= SD2.D2_ITEM"+CRLF
cQuery+=" AND SF2.F2_CLIENTE= SD1.D1_FORNECE"+CRLF
cQuery+=" AND SF2.F2_FILIAL= '"+xFilial("SF2")+"'"+CRLF
cQuery+=" AND SF2.D_E_L_E_T_  = ' '"+CRLF
cQuery+=" AND SF1.F1_FILIAL= '"+xFilial("SF1")+"'"+CRLF
cQuery+=" AND SF1.D_E_L_E_T_  = ' '"+CRLF
cQuery+=" 	AND SF1.F1_DTDIGIT BETWEEN '"+DtoS(aDatas[1])+"' AND '"+DtoS(aDatas[2])+"'"	+CRLF
cQuery+=" AND EXISTS ( SELECT 1 FROM "+RetSqlName("SF4") +" SF4 WHERE SF4.F4_FILIAL='"+xFilial("SF4")+"' AND SF4.F4_DUPLIC='S' AND SF4.F4_CODIGO=SD1.D1_TES AND SF4.D_E_L_E_T_=' ') "	+CRLF

If !Empty(cExcecao)
	cQuery+=" AND SD2.D2_COD NOT IN "+FormatIn(cExcecao,";")+CRLF
EndIf

If !Empty(cClasse)
	cQuery+=" AND SD2.D2_COD=SB1.B1_COD"+CRLF
	cQuery+=" AND SB1.B1_FILIAL='"+xFilial("SB1")+"'"+CRLF
	cQuery+=" AND SB1.B1_YCLASSE IN "+FormatIn(cClasse,";")+CRLF
	cQuery+=" AND SB1.D_E_L_E_T_    = ' ' "+CRLF
EndIf           

cQuery+=")Notas"

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry, .F., .F.)

lRetorno:=(nMeta>(cAliasQry)->Bruto)

(cAliasQry)->(DbCloseArea())
RestArea(aAreaAtu)
Return lRetorno
