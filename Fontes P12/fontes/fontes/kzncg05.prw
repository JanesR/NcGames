#Include "Protheus.Ch"
#Include "TopConn.Ch"

#DEFINE X3_USADO_EMUSO "€€€€€€€€€€€€€€ "
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZNCG05	     บAutor  ณCaio Pereira    	  บData  ณ 20/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณRotina com objetivo de manipular pedidos de venda EDI           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil                                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil 															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบAlteracoesณInclusao de variaveis cTabEDI e cTabIEDI para as tabelas 		  บฑฑ
ฑฑบPor		 ณcustomizadas ZAE e ZAF. Se precisar alterar nome de tabela,     บฑฑ
ฑฑบRodrigo A.ณbasta modificar essas variaveis que automaticamente  			  บฑฑ
ฑฑบTosin	 ณsera alterado todo o fonte.									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function KZNCG05()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVariavel para identificar campo de Status do Pedido EDI - Por Rodrigo A. Tosin								 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	Local nlX			:= 1

	Local 	aCampos		:= {"A1_XALTCAB",'A1_XALTITM'}
	Local	llRet		:= .T.
	Local 	alParam		:= {"KZ_PARCMIN","MV_VLMAXPV","MV_MAXITPV"}
	Local 	clSX6Fil 	:= xFilial("SX6")
	Private aRotina 	:= {}
	Private cCadastro   := ""
	Private aCores		:= {}
	Private nOpcAux 	:= 0
	Private cTabEDI		:= "ZAE"	//Tabela do Pedido EDI
	Private cTabIEDI	:= "ZAF"	//Tabela dos Itens do Pedido EDI
    Private cZAEZAF		:= "EDIQRY"
    Private cpLine		:= ""
    Private npCont		:= 0
	Private cpCpoStat	:= ""
    Private lpNovoIte	:= .F.
    Private apExcl		:= {}
    	
	cpCpoStat			:= cTabEDI + "->" + cTabEDI + "_STATUS"
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณPesquisa tabela ZAC no cadastro de tabelas (SX2) e depois pesquisa indices (SIX).															   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	
	SX2->(dbSetOrder(1))
	If SX2->(dbSeek("ZAC"))	
	
		SIX->(dbSetOrder(1))
		If SIX->(!dbSeek("ZAC1"))
			ShowHelpDlg("ZAC", {"อndice 1 nใo encontrado na tabela ZAC."},5,{"Execute o update U_UPDNCG20."},5)
			llRet := .F.
		EndIf
	Else	
		ShowHelpDlg("ZAC", {"Tabela: ZAC Nใo encontrada no cadastro de tabelas (SX2)."},5,{"Execute o update U_UPDNCG20."},5)
		llRet := .F.
	EndIf
	If llRet		
		dbSelectArea("SX6")
			SX6->(dbSetOrder(1))
			For nlX := 1 to Len(alParam)
				SX6->(dbGoTop())
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณPesquisa parametros KZ_PARCMIN , MV_VLMAXPV , MV_MAXITPV na tabela SX6. Se nao existir, exibe mensagem ao usuario.							   ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				If SX6->(!dbSeek(clSX6Fil + alParam[nlX]))
					ShowHelpDlg(alParam[nlX], {"Parโmetro " + alParam[nlX] + " nใo existe na tabela SX6 - Parโmetros."},5,{"Execute o update U_UPDNCG11."},5)	
					llRet := .F.
					Exit
				EndIf
			Next nlX
	EndIf	
	If llRet				
		SX2->(dbSetOrder(1))
		If SX2->(dbSeek( cTabEDI ))
			SX3->(dbSetOrder(2))
			For nlX := 1 to Len(aCampos)	
				If SX3->(!dbSeek(aCampos[nlX]))
					ShowHelpDlg(cTabEDI, {"Campo: " + aCampos[nlX] + CRLF + " Nใo existe no dicionแrio de arquivos (SX3) " },5,{"Execute o update U_UPDNCG06."},5)					
					llRet	:=	.F.
					Exit
				Endif
			Next nlX
			If llRet			
				aRotina		:= MENUDEF()
				
				cCadastro	:= Alltrim(SX2->X2_NOME)
			
				Aadd( aCores , { cpCpoStat + " == '1'" , "BR_VDCLARO"	} ) //Apto a gerar pedido de vendas
				Aadd( aCores , { cpCpoStat + " == '2'" , "BR_VERDE"		} ) //Apto a gerar pedido de vendas - Advertencias		
				Aadd( aCores , { cpCpoStat + " == '3'" , "BR_AMARELO"	} ) //Aguardando Aprova็ใo
				Aadd( aCores , { cpCpoStat + " == '4'" , "BR_VERMELHO"	} ) //Com Inconsistencia
				Aadd( aCores , { cpCpoStat + " == '5' .Or. " + cpCpoStat + " == '6'" , "BR_AZUL"		} ) //Encerrado - Pedido de Venda Gerado
//				Aadd( aCores , { cpCpoStat + " == '6'" , "BR_PINK"		} ) //Encerrado - Invoice Enviado
				Aadd( aCores , { cpCpoStat + " == '7'" , "BR_PRETO"		} ) //Cancelado
				
				dbSelectArea(cTabEDI)
				dbSetOrder(1)
				MBrowse( 6, 1,22,75,cTabEDI,,,,,,aCores)
			EndIf
		Else
			ShowHelpDlg(cTabEDI, {"Tabela: " + cTabEDI + CRLF + " Nใo encontrada no cadastro de tabelas (SX2)."},5,{"Execute o update U_UPDNCG06."},5)							
		EndIf
	EndIf
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZMNPREG	     บAutor  ณCaio Pereira    	  บData  ณ 20/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que cria tela de manutencao do pedido EDI posicionado    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil                                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil 															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบAlteracoesณInclusao de variaveis para utilizacao em TcBrowse		 		  บฑฑ
ฑฑบPor		 ณ																  บฑฑ
ฑฑบRodrigo A.ณ													  			  บฑฑ
ฑฑบTosin	 ณ								 								  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KZMNPREG()
			
	Private oMsMGet		:= Nil
	 	 
	Private lRet1		:= .F.
	Private lRet2		:= .F. 
	
	Private aTela[0][0]
	Private aGets[0] 
		
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVariavel para utilizar na TcBrowse - Por Rodrigo A. Tosin													 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	 
	Private oTcBrowse	:= Nil
	Private aHeader		:= {}
	Private aArray		:= {}
	Private nLAnterior	:= 1
	Private nSeek		:= 0
	Private aTamanho	:= {}
	Private aValid		:= {}
	Private aCampos 	:= {}
	Private aProdutos 	:= {}
	Private aPictures	:= {}
	Private aTipos		:= {}
	
    Private oGetDados	:= Nil
    Private aNGDHead	:= {{"Item","Item","@!",10,0,"",X3_USADO_EMUSO,"N"},{"Coluna","Coluna","@!",10,0,"",X3_USADO_EMUSO,"N"},{"Campo","Campo","@!",30,0,"",X3_USADO_EMUSO,"C"},{"Descricao","Descricao","@!",60,0,"",X3_USADO_EMUSO,"C"}}    
    Private aNGDCols	:= {}
    Private cCliFat		:= ""
    Private cLjFat		:= ""
    Private cpItem		:= ""
    
    If nOpcAux == 2 .AND. &(cpCpoStat) $ "5|6|7"
		KZCRIAHEAD()
		
		KZQuery()
		
		KZMNTTELA()
	ElseIf !(&(cpCpoStat) $ "5|6|7")
		KZVLDMNT()
			
		KZCRIAHEAD()
			
		KZQuery()
		
		KZMNTTELA()
	Else
		ShowHelpDlg("NใoPermitido", {"Nใo ้ possivel realizar manuten็ใo em um pedido com os Status: " + CRLF + "'Encerrado - Pedido de Venda Gerado'" + CRLF + "'Encerrado - InVoice Gerada'" + CRLF + "'Cancelado'"},5,{"Selecione um pedido com status diferente de: " + CRLF + "'Encerrado - Pedido de Venda Gerado'" + CRLF + "'Encerrado - InVoice Gerada'" + CRLF + "'Cancelado' " + CRLF + " para efetuar a manuten็ใo."},5)			
	EndIf
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณMENUDEF	     บAutor  ณCaio Pereira    	  บData  ณ 20/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que cria funcionalidades da rotina de pedidos EDI        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil                                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil 															  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MENUDEF()

	Local aRetorno := {}
	
	Aadd( aRetorno , {"Pesquisar"		,	"AxPesqui"		,0,1} )
	Aadd( aRetorno , {"Visualizar"		,	"U_KZFMANUT"	,0,2} )
	Aadd( aRetorno , {"Manuten็ใo"		,	"U_KZFMANUT"	,0,4} )
	Aadd( aRetorno , {"Cancelar"		,	"U_KZNCGCAN"	,0,6} )
	Aadd( aRetorno , {"Aprovar"			,	"U_KZNCGAPR"	,0,7} )
	Aadd( aRetorno , {"Rejeitar"		,	"U_KzRjPed"		,0,6} )	
	Aadd( aRetorno , {"Gerar Pedido"	,	"U_KZNCG11"		,0,8} )
	Aadd( aRetorno , {"Relacionamento"	,	"U_KZRelacao"	,0,6} )
	Aadd( aRetorno , {"Legenda"			,	"U_KZNCGLEG"	,0,9} )


Return aRetorno

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZFMANUT	     บAutor  ณCaio Pereira    	  บData  ณ 20/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que verifica se o pedido EDI pode ser manipulado         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil                                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil 															  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function KZFMANUT(cString,nReg,nOpc)
                          
	Local cStatus 		:= &((cTabEDI)->&(cTabEDI+"_STATUS"))
	Local cComplemento 	:= ""
	
	cStatus := ALLTRIM(cStatus) 
	
	If nOpc == 3
		nOpc := 4
	EndIf
	
	If nOpc == 2
		nOpcAux := nOpc
	ElseIf nOpc == 4
		
		If cStatus $ "5|6|7"
			If cStatus == "5"
				cComplemento := "Encerrado - Pedido de Venda Gerado"
			ElseIf cStatus == "6"
				cComplemento := "Encerrado - Invoice enviada"
			ElseIf cStatus == "7"
				cComplemento := "Cancelado"
			Else
				cComplemento := "Nใo Tratado !!!"
			EndIf
			
			Aviso( "KZNCG005" , "Nใo ้ possํvel realizar a manuten็ใo pois o registro estแ com status: " + Upper(cComplemento) , {"Ok"} )
			nOpcAux := 0
		Else
			nOpcAux := nOpc
		EndIf
	EndIf
	
	If nOpcAux <> 0
		KZMNPREG()
	EndIf

Return()


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZNCGCAN	     บAutor  ณCaio Pereira    	  บData  ณ 27/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que realiza o cancelamento do pedido				      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil                                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil 															  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function KZNCGCAN()

	Local oDlg		:= Nil
	Local clCod		:= Space(2)
	Local clDesc	:= Space(40)
	Local clTitulo	:= "Cancelamento de Pedido EDI"
	Local cStatus 	:= AllTrim(ZAE->ZAE_STATUS)
	
	If cStatus $ "1|2|3|4"
		DEFINE MSDIALOG oDlg TITLE clTitulo FROM  15,6 TO 210,366 COLORS 0,16777215 PIXEL //OF oMainWnd 
		
			@ 4, 2 TO 74, 179 OF oDlg  PIXEL
 			
		 	@ 17,05 SAY     OemToAnsi("C๓digo do Motivo")  SIZE 200, 07  OF oDlg PIXEL
			@ 16,53 MSGET   clCod Picture "@!"   SIZE 35, 10 F3 'ZB'  Valid {|| KzVldCod(clCod,@clDesc) } OF oDlg PIXEL
			
			@ 34,05 SAY     OemToAnsi("Descricao")    SIZE 46, 07 OF oDlg PIXEL
			@ 33,53 MSGET   clDesc ReadOnly  Picture "@!" SIZE 110, 10 OF oDlg PIXEL 

			DEFINE SBUTTON FROM 76,124 TYPE 1 ENABLE OF oDlg ACTION {|| Iif(KzEfCanc(clCod),oDlg:End(), )}
			DEFINE SBUTTON FROM 76,152 TYPE 2 ENABLE OF oDlg ACTION {|| oDlg:End() }
		
		ACTIVATE MSDIALOG oDlg CENTERED 
	Else
		ShowHelpDlg(OEMTOANSI("Aten็ใo"), {OEMTOANSI("Nใo ้ possivel cancelar um pedido 'Encerrado' ou jแ 'Cancelado'")},5,{OEMTOANSI("Selecione um pedido com status diferente de 'Encerrado' e 'Cancelado' para efetuar a a็ใo")},5)
	EndIf	


Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณKzVldCod		 บAutor  ณAdam Diniz Lima	  บ Data ณ 17/05/12    บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de Validacao do Codigo de cancelamento e captura da 	   บฑฑ
ฑฑบDesc.     ณ descricao do mesmo direto na variavel recebida por parametro    บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ clCod 	- Codigo da Inconsistencia para validar existencia na  บฑฑ
ฑฑบ			 ณ            tabela generica Z3								   บฑฑ
ฑฑบ			 ณ clDesc 	- Variavel que recebera o conteudo da descricao do     บฑฑ
ฑฑบ			 ณ 			  do Codigo da inconsistencia selecionado			   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ llRet - Logico, informando se foi realizada a operacao ou nao   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KzVldCod(clCod,clDesc)

Local alArea := GetArea()
Local llRet := .F.

If !Empty(clCod)
	DbSelectArea("SX5")
	SX5->(DbSetOrder(1))
	If SX5->(dbSeek(xFilial("SX5")+"ZB"+avKey(clCod,"X5_CHAVE")))
		clDesc	:= SX5->X5_DESCRI
		llRet	:= .T.
	Else
		ShowHelpDlg(OEMTOANSI("Aten็ใo"), {OEMTOANSI("O C๓digo do Motivo digitado nใo existe")},5,{OEMTOANSI("Preencha um C๓digo do Motivo vแlido")},5)
	EndIf
Else
	llRet := .T.
EndIf

RestArea(alArea)

Return llRet
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKzEfCanc	     บAutor  ณAdam Diniz Lima  	  บData  ณ 27/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณ Efetiva a cancelamento do pedido EDI			    	          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณclCod - Codigo do Motivo de cancelamento do pedido EDI          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณllRet - Logico informando se realizou o processo de cancelamentoบฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function KzEfCanc(clCod)

Local llRet := .F.

If !Empty(clCod)
	If MsgNoYes("Deseja realmente Cancelar esse pedido com esse Motivo ?")
		If RecLock("ZAE",.F.)
			ZAE->ZAE_MOTIVO := clCod
			ZAE->ZAE_STATUS := "7"
			ZAE->(MsUnlock())
			llRet := .T.
		EndIf
	EndIf
Else
	ShowHelpDlg(OEMTOANSI("Aten็ใo"), {OEMTOANSI("O C๓digo do Motivo nใo deve ficar em branco")},5,{OEMTOANSI("Preencha o C๓digo do Motivo ou cancele a opera็ใo")},5)
EndIf

Return llRet
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZNCGAPR	     บAutor  ณAdam Diniz Lima  	  บData  ณ 27/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณ Abre tela para preencher justificativa de aprova็ใo	          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil                                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil 															  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function KZNCGAPR()

	Local cStatus 	:= AllTrim(ZAE->ZAE_STATUS)
	Local oDlg		:= Nil
	Local olAprv	:= Nil
	Local olRprv	:= Nil
	Local olExit	:= Nil
	Local olJust	:= Nil
	Local clJust	:= ""

	Local clTitulo	:= "Aprova็ใo de Pedido EDI"

	If cStatus != "3" 
		ShowHelpDlg(OEMTOANSI("Aten็ใo"), {OEMTOANSI("Aprova็ใo permitida apenas para os Pedidos com Status 'Aguardando Aprova็ใo'")},5,{OEMTOANSI("Selecione um pedido com status 'Aguardando Aprova็ใo'")},5)
	Else//cStatus == 3 -> Aguardando Aprovacao
		
			If Aviso("Aprova็ใo",@clJust,{"Ok","Cancelar"},3,"Justificativa para Aprova็ใo",,,.T.)==1
				KzEfAprv(clJust)
			EndIf
	EndIf
	
Return
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKzEfAprv	     บAutor  ณAdam Diniz Lima  	  บData  ณ 27/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณ Efetiva a aprovacao do pedido EDI			    	          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณclJust - Justificativa digitada pelo usuario para aprovacao     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil 															  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function KzEfAprv(clJust)
	
	Local llRet := .F.    
    
	If !Empty(clJust)
		If MsgNoYes("Deseja realmente Aprovar esse pedido com essa Justificativa ?")
			If RecLock("ZAE",.F.)
				ZAE->ZAE_STATUS	:= "1"
			    ZAE->ZAE_USRAPR	:= cUserName
			    ZAE->ZAE_DTAPRV	:= dDataBase
			    ZAE->ZAE_HRAPRV	:= Time()
			    ZAE->ZAE_JTAPRV	:= clJust
				ZAE->(MsUnLock())
				llRet := .T.
			EndIf
		EndIf
	Else
		ShowHelpDlg(OEMTOANSI("Aten็ใo"), {OEMTOANSI("A Justificativa nใo pode estar em branco")},5,{OEMTOANSI("Favor preencher uma justificativa para efetuar a aprova็ใo")},5)
	EndIf
	
Return llRet

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZNCGLEG	     บAutor  ณCaio Pereira    	  บData  ณ 20/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que cria tela informativa com as legendas disponiveis    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil                                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil 															  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function KZNCGLEG()

	Local aCores := {}

	Aadd( aCores , { "BR_VDCLARO"		, "Apto a gerar Ped. Venda"					})
	Aadd( aCores , { "BR_VERDE"			, "Apto a gerar Ped. Venda - Advert๊ncias"	})
	Aadd( aCores , { "BR_AMARELO"		, "Aguardando Aprova็ใo"					})
	Aadd( aCores , { "BR_VERMELHO"		, "Com inconsist๊ncia"						})
	Aadd( aCores , { "BR_AZUL" 			, "Encerrado - Ped. Venda Gerado"			})
//	Aadd( aCores , { "BR_PINK" 			, "Encerrado - Invoice Enviada"				})
	Aadd( aCores , { "BR_PRETO" 		, "Cancelado"								})
	
	BrwLegenda("","Legenda",aCores)

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZNCGLE2	     บAutor  ณRodrigo A. Tosin 	  บData  ณ 18/06/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que cria tela informativa com as legendas disponiveis    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil                                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil															  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function KZNCGLE2()

	Local aCores := {}

	Aadd( aCores , { "BR_VERDE"	 		, "Apto a gerar Ped. Venda"					})
	Aadd( aCores , { "BR_AMARELO"		, "Apto a gerar Ped. Venda - Advert๊ncias"	})
	Aadd( aCores , { "BR_VERMELHO"		, "Com inconsist๊ncia"						})
	
	BrwLegenda("","Legenda",aCores)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZVLDMNT	     บAutor  ณCaio Pereira    	  บData  ณ 20/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que verifica se o cliente permite alteracao no pedido EDIบฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil                                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil 															  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function KZVLDMNT()
	
	SA1->(DbSetOrder(1))
	If SA1->(DbSeek(xFilial("SA1")+ZAE->ZAE_CLIFAT+ZAE->ZAE_LJFAT))
		
		If Alltrim(SA1->A1_XALTCAB) == "2"
			lRet1:= .T.			
		EndIf
		
		If Alltrim(SA1->A1_XALTITM) == "2"
			lRet2:= .T.			
		EndIf
		
	EndIf
	
	If lRet1
		MsgInfo("O cliente "+Alltrim(SA1->A1_COD)+" - "+Alltrim(SA1->A1_LOJA)+" - "+Alltrim(SA1->A1_NREDUZ)+" nใo permite altera็ใo no cabe็alho do pedido EDI.")
	EndIf
	
	If lRet2
		MsgInfo("O cliente "+Alltrim(SA1->A1_COD)+" - "+Alltrim(SA1->A1_LOJA)+" - "+Alltrim(SA1->A1_NREDUZ)+" nใo permite altera็ใo nos itens do pedido EDI.")
	EndIf

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZCRIAHEAD	 บAutor  ณCaio Pereira    	  บData  ณ 20/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que cria cabecalho da linha dos itens (TcBrowse)         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil                                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil 															  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function KZCRIAHEAD()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณPreenche aHeader da TcBrowse e variaveis aCampos, aTamanho, aPictures e aTipos - Por Rodrigo A. Tosin		 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Local nlX := 0
	
	SX3->(DbSetOrder(1))
	SX3->(DbGoTop())
	If SX3->(DbSeek(cTabIEDI))

		AAdd(aHeader,"")
				
		AAdd(aCampos,'')
						
		AADD(aTamanho,3) 
		
		AADD(aPictures,"")				
		
		AADD(aTipos,"C")									
														
		While SX3->(!Eof()) .And. SX3->X3_ARQUIVO == cTabIEDI
			If 	Alltrim(SX3->X3_CAMPO) <> cTabIEDI + "_FILIAL" .AND.;
				Alltrim(SX3->X3_CAMPO) <> cTabIEDI + "_REVISA" .AND.;
				Alltrim(SX3->X3_CAMPO) <> cTabIEDI + "_NUMEDI" .AND.;
				Alltrim(SX3->X3_CAMPO) <> cTabIEDI + "_CLIFAT" .AND.;
				Alltrim(SX3->X3_CAMPO) <> cTabIEDI + "_LJFAT"							
				AAdd(aHeader	,AllTrim(SX3->X3_TITULO))																			
				AAdd(aCampos	,AllTrim(SX3->X3_CAMPO))
				AADD(aTamanho	,SX3->X3_TAMANHO)
				AADD(aPictures	,SX3->X3_PICTURE)
				AADD(aTipos		,SX3->X3_TIPO)
				npCont++													
			EndIf
			SX3->(dbSkip())
		EndDo
		
	EndIf
	If Empty(cpLine)
	  	cpLine := " {|| {"
	  	cpLine += "IIF(aArray[oTcBrowse:nAt][1] == '1',oVDClaro,"
	  	cpLine += "IIF(aArray[oTcBrowse:nAt][1] == '2',oVerde,"
	  	cpLine += "IIF(aArray[oTcBrowse:nAt][1] == '3',oAmarelo,"
	  	cpLine += "IIF(aArray[oTcBrowse:nAt][1] == '4',oVermelho,"
	  	cpLine += "IIF(aArray[oTcBrowse:nAt][1] == '5',oAzul,"
	  	cpLine += "IIF(aArray[oTcBrowse:nAt][1] == '6',oPink,"
	  	cpLine += "IIF(aArray[oTcBrowse:nAt][1] == '7',oPreto,)))))))"   	
		For nlX := 2 to npCont+1
			cpLine += ',aArray[oTcBrowse:nAt][' + cValToChar(nlX) + "]"				
		Next nlX
		cpLine += "}}"
		npCont	:=	0
	EndIf		 
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZQuery	     บAutor  ณRodrigo A. Tosin 	  บData  ณ 25/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que filtra os itens do pedido EDI posicionado            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil                                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil															  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KZQuery()
	Local clStatus	:= ''
	Local clQuery 	:= ""
	Local clCampoSt	:= cTabEDI + "->" + cTabEDI + "_STATUS"	
	Local nCont		:= 0
	Local nX		:= 0
	Local nPosCli	:= aScan(aHeader, ALLTRIM(cTabEDI + "_CLIFAT"))
	Local nPosLoj	:= aScan(aHeader, ALLTRIM(cTabEDI + "_LJFAT"))

	Local nPosDco	:= aScan(aCampos, cTabIEDI + "_VLRDES")	
	Local nPosICM	:= aScan(aCampos, cTabIEDI + "_PERICM")
	Local nPosVCM	:= aScan(aCampos, cTabIEDI + "_VLRICM")	
	Local nPosIPI	:= aScan(aCampos, cTabIEDI + "_PERCIP") 
	Local nPosVPI	:= aScan(aCampos, cTabIEDI + "_VLRIPI")	
	Local nPosSeq	:= aScan(aCampos, cTabIEDI + "_SEQ")			
	Local aNum 		:= {nPosDco,(nPosDco-1),nPosICM,nPosVCM,nPosIPI,nPosVPI}
				
 	clQuery := "SELECT " 																							+ CRLF 	
 	clQuery += " 	   ZAE_FILIAL,ZAE_STATUS,ZAE_NUMEDI,ZAE_CLIFAT,ZAE_LJFAT,ZAE_CGCENT,ZAE_CGCFAT" 				+ CRLF
 	clQuery += "	  ,ZAE_CGCFOR,ZAF_FILIAL,ZAF_NUMEDI,ZAF_CLIFAT,ZAF_LJFAT,ZAF_SEQ,ZAF_ITEM" 			 			+ CRLF
 	clQuery += "      ,ZAF_EAN,ZAF_PRODUT,ZAF_DESCRI,ZAF_LOCAL,ZAF_UM,ZAF_QTD,ZAF_UNID2,ZAF_QTD2"					+ CRLF
 	clQuery += "      ,ZAF_PRCUNI,ZAF_TOTAL,ZAF_DTENT,ZAF_NCM,ZAF_OPER,ZAF_TES,ZAF_CFOP" 							+ CRLF
 	clQuery += "      ,ZAF_CST,ZAF_DESC,ZAF_VLRDES,ZAF_PERCIP,ZAF_VLRIPI,ZAF_VLRDSP,ZAF_VLRSEG" 					+ CRLF
 	clQuery += "      ,ZAF_VLRFRT,ZAF_PERICM,ZAF_VLRICM,B1_FILIAL,B1_COD,B1_DESC,B1_LOCPAD"							+ CRLF
// 	clQuery += "	  ,CLIENT,LOJAENT,CLIFAT,LOJAFAT"																+ CRLF 				
// 	clQuery += "      ,A2_COD,A2_LOJA,A2_CGC"																		+ CRLF
 	clQuery += " FROM" 																					   			+ CRLF
 	clQuery += "(" 																									+ CRLF
 	clQuery += "	SELECT "	+ cTabEDI +"_FILIAL" 																+ CRLF
 	clQuery += "			," 	+ cTabEDI +"_STATUS" 																+ CRLF  	
 	clQuery += "			," 	+ cTabEDI +"_NUMEDI" 																+ CRLF
 	clQuery += "			," 	+ cTabEDI +"_CLIFAT" 																+ CRLF
 	clQuery += "			," 	+ cTabEDI +"_LJFAT" 																+ CRLF
 	clQuery += "			," 	+ cTabEDI +"_CGCENT" 																+ CRLF
 	clQuery += "			," 	+ cTabEDI +"_CGCFAT" 																+ CRLF
 	clQuery += "			," 	+ cTabEDI +"_CGCFOR" 																+ CRLF 	 
 	clQuery += "	FROM " + RetSQLName(cTabEDI)   																	+ CRLF	// ZAE
 	clQuery += "	WHERE" 																					   		+ CRLF
 	clQuery += "			" + cTabEDI +"_FILIAL = '" + xFilial(cTabEDI) + "'" 									+ CRLF
 	clQuery += "		AND " + cTabEDI +"_NUMEDI = '" + (cTabEDI)->&(cTabEDI+"_NUMEDI") + "'" 					+ CRLF
 	clQuery += "		AND D_E_L_E_T_ <> '*'" 																		+ CRLF
 	clQuery += ") " + cTabEDI																						+ CRLF
 	clQuery += "INNER JOIN" 																						+ CRLF 
 	clQuery += "(" 																					   				+ CRLF
 	clQuery += "	SELECT *" 																						+ CRLF
 	clQuery += "	FROM " + RetSQLName(cTabIEDI) 																	+ CRLF // ZAF
 	clQuery += "	WHERE" 																					   		+ CRLF 
 	clQuery += "			" + cTabIEDI +"_FILIAL = '" + xFilial(cTabIEDI) + "'"									+ CRLF
 	clQuery += "		AND D_E_L_E_T_ <> '*'" 																		+ CRLF
 	clQuery += ") " + cTabIEDI																			   			+ CRLF 
 	clQuery += "ON		" + cTabEDI + "." + cTabEDI + "_NUMEDI = " + cTabIEDI + "." + cTabIEDI + "_NUMEDI" 		+ CRLF 	
 	clQuery += "INNER JOIN" 																						+ CRLF 
 	clQuery += "(" 																					   				+ CRLF
 	clQuery += "	SELECT DISTINCT A1_COD,A1_LOJA " 																			+ CRLF
 	clQuery += "	FROM " + RetSQLName("SA1")	 																	+ CRLF // SA1
 	clQuery += "	WHERE" 																					   		+ CRLF 
 	clQuery += "			A1_FILIAL = '" + xFilial("SA1") + "'"													+ CRLF
 	clQuery += "		AND	A1_MSBLQL <> '1'"																	+ CRLF 	
 	clQuery += "		AND D_E_L_E_T_ <> '*'" 																		+ CRLF
 	clQuery += ") SA1"		 																			   			+ CRLF 
 	clQuery += "ON		" + cTabEDI + "." + cTabEDI + "_CLIFAT = SA1.A1_COD"							   			+ CRLF 
  	clQuery += "	AND " + cTabEDI + "." + cTabEDI + "_LJFAT =  SA1.A1_LOJA"										+ CRLF  	 	 
 	clQuery += "LEFT JOIN" 						 																	+ CRLF 
 	clQuery += "("																					   				+ CRLF 
 	clQuery += "	SELECT B1_FILIAL,B1_COD,B1_DESC,B1_LOCPAD"														+ CRLF// SB1
 	clQuery += "	FROM " + RetSQLName("SB1")																		+ CRLF  
 	clQuery += "	WHERE"																							+ CRLF  
 	clQuery += "			B1_FILIAL = '" + xFilial("SB1") + "'"													+ CRLF  
 	clQuery += "		AND D_E_L_E_T_ <> '*'"																		+ CRLF 
 	clQuery += ") SB1"																								+ CRLF 
 	clQuery += "ON SB1.B1_COD = " + cTabIEDI + "." + cTabIEDI + "_PRODUT"											+ CRLF  
//	clQuery += "LEFT JOIN"					   							   											+ CRLF
//	clQuery += "("					   							   													+ CRLF
//	clQuery += "	SELECT A2_COD,A2_LOJA,A2_CGC"					   												+ CRLF// SA2 
//	clQuery += "	FROM " + RetSQLName("SA2")					   													+ CRLF	
//	clQuery += "	WHERE"					   																		+ CRLF
//	clQuery += "			A2_FILIAL = '" + xFilial("SA2") + "'"					   								+ CRLF
//	clQuery += "		AND D_E_L_E_T_ <> '*'"					   							   						+ CRLF
//	clQuery += ") SA2"					   							   												+ CRLF
//	clQuery += "ON SA2.A2_CGC = " + cTabEDI + "." + cTabEDI + "_CGCFOR"
 	
	clQuery := ChangeQuery(clQuery)	
	
	If Select(cZAEZAF) > 0
		(cZAEZAF)->(dbCloseArea())
	EndIf
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), cZAEZAF ,.T.,.F.)		

	If (cZAEZAF)->(EOF())
		aAdd(aArray,Array(Len(aHeader)))
		For nX:= 3 To Len(aCampos)
			If 	   aTipos[nX] == "C" 
				aArray[Len(aArray)][nX]		 := SPACE(aTamanho[nX])	
			ElseIf aTipos[nX] == "N" 
				aArray[Len(aArray)][nX]		 := Transform(0,aPictures[nX])
			ElseIf aTipos[nX] == "D" 
				aArray[Len(aArray)][nX]		 := sToD('  /  /  ')							
			EndIf			
		Next nX			
	Else
		
		(cZAEZAF)->(DbGoTop())
		While (cZAEZAF)->(!EOF())
			aAdd(aArray,Array(Len(aHeader)))
			clStatus := &(clCampoSt)

			aArray[Len(aArray)][1] := IIf(Empty(clStatus),'4',clStatus) 

			For nX:= 3 To Len(aCampos)
				If !Empty((cZAEZAF)->&(cTabIEDI + "_SEQ"))
					aArray[Len(aArray)][nPosSeq] := (cZAEZAF)->&(cTabIEDI + "_SEQ")
				Else
					aArray[Len(aArray)][nPosSeq] := Space(TAMSX3(cTabIEDI + "_SEQ")[1])					
				EndIf					
				If 	  Alltrim(aCampos[nX]) == ALLTRIM(cTabIEDI + "_DESCRI")
					If !Empty((cZAEZAF)->B1_DESC)
						aArray[Len(aArray)][nX] := TRANSFORM((cZAEZAF)->B1_DESC,aPictures[nX])
					Else
						aArray[Len(aArray)][nX] := TRANSFORM((cZAEZAF)->&(cTabIEDI + "_DESCRI"),aPictures[nX])					
					EndIf	
				ElseIf aCampos[nX] == ALLTRIM(cTabIEDI + '_DTENT')
					aArray[Len(aArray)][nX] := stoD((cZAEZAF)->&(cTabIEDI + "_DTENT"))
				Else
			   		aArray[Len(aArray)][nX] := TRANSFORM(&(cZAEZAF + "->"+Alltrim(aCampos[nX])),aPictures[nX])
				EndIf
			Next nX

			(cZAEZAF)->(DbSkip())
		EndDo
	EndIf	
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZMNTTELA	     บAutor  ณCaio Pereira    	  บData  ณ 20/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que exibe interface de manutencao ao usuario             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil                                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil 															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบAlteracoesณInclusao de variaveis para utilizacao em TcBrowse		 		  บฑฑ
ฑฑบPor		 ณ																  บฑฑ
ฑฑบRodrigo A.ณ													  			  บฑฑ
ฑฑบTosin	 ณ								 								  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function KZMNTTELA()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณArray para informacoes de tamanho da tela, objetos e posicionamento.	- Chave: TAMANHO						 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู    	

	Local aArea			:= GetArea()
	Local aDimension	:= MsAdvSize()
	Local aObjSize		:= Array(0)
	
	Local oDlg			:= Nil
	Local oPanel1		:= Nil
	Local oPanel2		:= Nil
	Local oPanel3		:= Nil
	Local oPanel4		:= Nil
	Local oPanel5		:= Nil
	
	Local oFont1		:= TFont():New("Arial",08,10,,.T.,,,,,)
	Local oFont2		:= TFont():New("Arial",13,15,,.T.,,,,,)
	Local aButtons		:= {}

	Local cCliEnt		:= cTabEDI + "_CLIENT"
	Local cLjEnt		:= cTabEDI + "_LJENT"
	Local cTipPed		:= cTabEDI + "_TIPPED"
	Local nlX 			:= 1
		
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVariavel para utilizar na TcBrowse - Por Rodrigo A. Tosin   													 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	Local bLine			:= {||}
	Local aColSizes		:= {}
	Local cField		:= ""
	Local bChange		:= {||}
	Local bLDblClick	:= {||}
	Local bRClick		:= {||}
	
	Local oVdClaro   	:= LoadBitmap(GetResources(),'BR_VDCLARO')	
	Local oVerde   		:= LoadBitmap(GetResources(),'BR_VERDE')
	Local oVermelho		:= LoadBitmap(GetResources(),'BR_VERMELHO')
	Local oAzul   		:= LoadBitmap(GetResources(),'BR_VERDE')
	Local oCinza		:= LoadBitmap(GetResources(),'BR_VERMELHO')
	Local oPink   		:= LoadBitmap(GetResources(),'BR_PINK')
	Local oPreto		:= LoadBitmap(GetResources(),'BR_PRETO')
	Local oAmarelo		:= LoadBitmap(GetResources(),'BR_AMARELO')
    Local nlTotal		:= 0 
    Local nlTFrete		:= 0
	Local nPosFre 		:= aScan(aCampos, cTabIEDI + "_VLRFRT")
	Local nlFrete 		:= 0     
   
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณArray com campos alteraveis no cabecalho em excecao de alteracao - Por Alfredo A. Magalhaes					 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู    	

    Local alCpos		:= Separa(SuperGetMv("KZ_EXCCAB",.T.,""),";")
	Local nPosSTS  		:= aScan(aCampos, "")
	Local nPosIte		:= aScan(aCampos, cTabIEDI + "_ITEM")	
	Local nPosSeq  		:= aScan(aCampos, cTabIEDI + "_SEQ")
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณArray para informacoes de tamanho da tela, objetos e posicionamento.	- Chave: TAMANHO						 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู    	
	        
	Private aInfo 		:= Array(0)
	Private aObjects	:= Array(0)
	Private aPosObj		:= Array(0)    

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณArray com tamanho em largura e altura dos objetos.	- Chave: TAMANHO										 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู    	

	aAdd(aObjects,{000, 080, .T., .T. })	// 1 - largura em pixels
	aAdd(aObjects,{000, 000, .T., .T. })	// 2 - altura em pixels
	aAdd(aObjects,{000, 075, .T., .F. })	// 3 - se for verdadeiro, ignora a largura preenchida no parametro 1 e utiliza a largura disponivel da tela
//	aAdd(aObjects,{000, 001, .T., .F. })	// 4 - se for verdadeiro, ignora a altura preenchida no parametro 2 e utiliza a altura disponivel da tela

	aInfo := {aDimension[1],aDimension[2],aDimension[3],aDimension[4], 3 /*distancia horizontal*/, 3 /*distancia vertical*/}
	aPosObj := MsObjSize(aInfo,aObjects)
	
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCampo de C๓digo do Cliente e Loja do Cliente.																 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู    	
        
    cCliFat				:= cTabEDI + "_CLIFAT"
    cLjFat				:= cTabEDI + "_LJFAT"

	DEFINE MSDIALOG oDlg TITLE "Pedido EDI" FROM aDimension[7],aDimension[1] to aDimension[6],aDimension[5] PIXEL OF oDlg
		
		oDlg:lMaximized := .T.
		
		RegToMemory(cTabEDI,.F.)
	
		oMsMGet:= MsMget():New(cTabEDI,0,nOpcAux,,,,,aPosObj[1],Iif(lRet1,alCpos,Nil),,,.T.,,oDlg,,.T.,,,.F.)
		
		oMsMGet:oBox:Align:= CONTROL_ALIGN_TOP
  
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณTcBrowse para mostrar status dos itens do Pedido EDI - Por Rodrigo A. Tosin									 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	   
		oTcBrowse   				:= TCBrowse():New(aPosObj[2][1],aPosObj[2][2],aPosObj[2][4],aPosObj[2][3]-aPosObj[2][1]+6,bLine,aHeader,aColSizes,oDlg,cField,,,bChange,bLDblClick,bRClick,,,,,,.F.,,.T.,,.F.,,,)
	    oTcBrowse:SetArray(aArray) 
	    oTcBrowse:AHEADERS 			:= aHeader
	    oTcBrowse:bLine 			:= &(cpLine) 
	    								    
	    oTcBrowse:bLDBlClick  		:= {|| 	IIf(nOpcAux <> 2,DuplCli(),)  		}
		oTcBrowse:lAdjustColSize 	:= .T.
		oTcBrowse:bDrawSelect	 	:= {||	IIf(nOpcAux <> 2,VDrawSelect(),)	}
 	    oTcBrowse:bSeekChange 		:= {||	IIf(nOpcAux <> 2,VSeekChange(),)	}
 	    oTcBrowse:blClicked			:= {||	IIf(nOpcAux <> 2,ValidTc(oTcBrowse:nAt),)	}
 	    
		oTcBrowse:Align	  			:= CONTROL_ALIGN_TOP

		oGetDados  						:= MsNewGetDados():New(aPosObj[3][1]-3,aPosObj[3][2]-3,aPosObj[3][3],aPosObj[3][4]+6,,"AllwaysTrue",,,{},,9999999,,,,oDlg,aNGDHead,aNGDCols)		                       
		oGetDados:oBrowse:bLDBlClick	:= {|| IIF(oGetDados:aCols[oGetDados:nAt][2] <> 0,(oTcBrowse:nColPos := oGetDados:aCols[oGetDados:nAt][2],oTcBrowse:Refresh(),oTcBrowse:SetFocus()),)}
		
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVariavel para preencher informacoes dos clientes, caso venha em branco - Por Rodrigo A. Tosin   				 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
/*
		(cZAEZAF)->(dbGoTop())
		If EMPTY(&("M->" + cCliFat)) .AND. EMPTY(&("M->" + cLjFat))
			M->&(cCliFat) := (cZAEZAF)->CliFat
			M->&(cLjFat)  := (cZAEZAF)->LojaFat
		EndIf
		If EMPTY(&("M->" + cCliEnt)) .AND. EMPTY(&("M->" + cLjEnt))
			M->&(cCliEnt) := (cZAEZAF)->CliEnt
			M->&(cLjEnt)  := (cZAEZAF)->LojaEnt
		EndIf
		(cZAEZAF)->(dbGoBottom())
*/
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณPreenchimento do campo de Desc. Mot. Cancelamento - Por Adam Diniz Lima					  				 	 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If !EMPTY(M->ZAE_MOTIVO)
			M->ZAE_DESCMO := Posicione("SX5",1,xFilial("SX5")+"ZB"+M->ZAE_MOTIVO,"X5_DESCRI")
		EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVariavel para preencher tipo de pedido, caso venha em branco - Por Rodrigo A. Tosin 			  				 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If EMPTY(&("M->" + cTipPed))
			M->&(cTipPed) := "N"
		EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVariavel para preencher Nome do cliente, caso venha em branco - Por Rodrigo A. Tosin 			  			 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู		
		If Empty(&("M->" + cTabEDI + "_NOMCLI"))
			M->&(cTabEDI + "_NOMCLI") := Posicione("SA1",1,xFilial("SA1")+(cTabEDI)->&(cTabEDI + "_CLIFAT")+(cTabEDI)->&(cTabEDI + "_LJFAT"),"A1_NREDUZ")
		End If
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVariavel para preencher Nome do Vendedor, caso venha em branco - Por Rodrigo A. Tosin 			  			 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู		
		If !Empty(&("M->" + cTabEDI + "_VEND")) .AND. Empty(&("M->" + cTabEDI + "_NOMVEN"))
			M->&(cTabEDI + "_NOMVEN") := Posicione("SA3",1,xFilial("SA3")+(cTabEDI)->&(cTabEDI + "_VEND"),"A3_NOME")
		EndIf	
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณBotoes extras da EnchoiceBar - Por Rodrigo A. Tosin 			  			 									 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		aAdd(aButtons,{"ORDEM",		{|| KZORDEM()				 		   									} 	  	,"Organizar Itens"			})		
		aAdd(aButtons,{"BSTART",	{|| U_KZNCGLE2()				 		   								} 	  	,"Legenda"					})
		aAdd(aButtons,{"PRODUTO",	{|| U_KZTotlz()					 		   								} 	  	,"Totalizador"				})
		aAdd(aButtons,{"HISTORIC",	{|| U_KZBR19(.T.,M->&(cTabEDI + "_NUMEDI"))								} 	  	,"Revis๕es"					})
		aAdd(aButtons,{"S4WB009N",	{|| U_KZRINC18(.T.)  													} 		,"Relat๓rio"				})
		aAdd(aButtons,{"NCO",		{|| Iif(nOpcAux <> 2,ExcItem()										,)	}		,"Exclui Item do Pedido EDI"})
		
		If		lRet2 .OR. nOpcAux == 2
			oGetDados:oBrowse:lReadOnly := .T.
		EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณSe opcao nao for de visualizacao, executa validacao nos itens do pedido posicionado - Por Rodrigo A. Tosin	 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู			
		If nOpcAux <> 2
			
			For nlX := 1 to Len(oTcBrowse:aArray)
				ValidTc(nlX)
			Next nlX
			oGetDados:aCols:= {{"",0,"","",.F.}}
		EndIf
		
		For nlX := 1 to Len(oTcBrowse:aArray)
			
			If 		At(".",oTcBrowse:aArray[nlX][nPosFre]) > 0 .AND. At(",",oTcBrowse:aArray[nlX][nPosFre]) > 0
				nlFrete 	:= STRTRAN(oTcBrowse:aArray[nlX][nPosFre],".","")
				nlFrete 	:= STRTRAN(nlFrete,",",".")	
			ElseIf At(",",oTcBrowse:aArray[nlX][nPosFre]) > 0
				nlFrete 	:= STRTRAN(oTcBrowse:aArray[nlX][nPosFre],",",".")
			EndIf
			nlFrete := Val(nlFrete)
							
			nlTFrete += nlFrete
			
		Next nlX
		M->&(cTabEDI + "_TOTFRT") := nlTFrete 
				
		KZORDEM()
		
	ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{|| KZORDEM(), Iif(nOpcAux==4,Iif(KZVLDOBG(),LjMsgRun("Aguarde... Atualizando banco de dados.","",{|| 		IIF(GeraPed(),oDlg:End(),.F.)			}),Nil),oDlg:End())		},{|| oDlg:End()},,@aButtons)
	RestArea(aArea)	
Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZVLDOBG	     บAutor  ณCaio Pereira    	  บData  ณ 20/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que verifica se todos os campos obrigatorios foram preen-บฑฑ
ฑฑบ          ณchidos. (somente cabecalho)                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil                                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil 															  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function KZVLDOBG()
	Local nlX   	:= 1
	Local nlY   	:= 1
	Local clObri    := "ม"	
	Local llRet		:= .T.
		
	If !Obrigatorio(aGets,aTela)
		llRet := .F.
	Else
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณVerifica se campos obrigatorios do item do pedido EDI foram preenchidos.																		   ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
  /*				
		For nlX := 1 to Len(oTcBrowse:aArray)
			If !llRet
				Exit
			EndIf
			For nlY := 3 to Len(aCampos)
				If GetSX3Cache(aCampos[nlY],"X3_OBRIGAT") == clObri
					If 		VALTYPE(oTcBrowse:aArray[nlX][nlY]) == 'C' .AND. EMPTY(oTcBrowse:aArray[nlX][nlY])
						ShowHelpDlg("Obrigat",{"Campo " + aHeader[nlY] + " ้ obrigat๓rio e nใo foi preenchido."},5,{"Preencha o campo para prosseguir com a manuten็ใo."},5)    		
						oTcBrowse:nAt := nlX						
	 					llRet := .F.
	 					Exit
					ElseIf	VALTYPE(oTcBrowse:aArray[nlX][nlY]) == 'C' .AND. ALLTRIM(oTcBrowse:aArray[nlX][nlY]) == ALLTRIM(TRANSFORM(0,aPictures[nlY]))
						ShowHelpDlg("Obrigat",{"Campo " + aHeader[nlY] + " ้ obrigat๓rio e nใo foi preenchido."},5,{"Preencha o campo para prosseguir com a manuten็ใo."},5)    		
						oTcBrowse:nAt := nlX						
	 					llRet := .F.
	 					Exit	 						 					
					ElseIf	VALTYPE(oTcBrowse:aArray[nlX][nlY]) == 'D' .AND. oTcBrowse:aArray[nlX][nlY] == cToD('  /  /  ')
						ShowHelpDlg("Obrigat",{"Campo " + aHeader[nlY] + " ้ obrigat๓rio e nใo foi preenchido."},5,{"Preencha o campo para prosseguir com a manuten็ใo."},5)    		
						oTcBrowse:nAt := nlX						
						llRet := .F. 
	 					Exit																 							
					EndIf
				EndIf
			Next nlY
		Next nlX
*/			
	EndIf	
			
Return llRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ VDrawSelect   บAutor  ณRodrigo A. Tosin	  บData  ณ 24/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para validar mudanca de linha da TcBrowse			  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil						   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/ 
Static Function VDrawSelect()
	Local nlX := 1
	Local nPosQtd	:= aScan(aCampos, cTabIEDI + "_QTD")
	Local nPosPre	:= aScan(aCampos, cTabIEDI + "_PRCUNI")
	Local nPosTot	:= aScan(aCampos, cTabIEDI + "_TOTAL")
	Local nPosDt	:= aScan(aCampos, cTabIEDI + "_DTENT")
	Local nPosVDe	:= aScan(aCampos, cTabIEDI + "_VLRDES")
	Local nPosDes	:= 0
	Local nPosPeI	:= aScan(aCampos, cTabIEDI + "_PERCIP")
	Local nPosVIP	:= aScan(aCampos, cTabIEDI + "_VLRIPI")
	Local nPosVDS	:= aScan(aCampos, cTabIEDI + "_VLRDSP")
	Local nPosVSe	:= aScan(aCampos, cTabIEDI + "_VLRSEG")
	Local nPosVFr	:= aScan(aCampos, cTabIEDI + "_VLRFRT")		
	Local nPosEDI	:= aScan(aCampos, cTabIEDI + "_NUMEDI")
	Local nPosIte	:= aScan(aCampos, cTabIEDI + "_ITEM") 
	Local nPosOpe	:= aScan(aCampos, cTabIEDI + "_OPER")
	Local nPosTES	:= aScan(aCampos, cTabIEDI + "_TES") 
	Local nPosCFO	:= aScan(aCampos, cTabIEDI + "_CFOP")
	Local nPosSeq	:= aScan(aCampos, cTabIEDI + "_SEQ")	
	Local clOper 	:= ""								
	Local clTES 	:= ""
	Local clCFOP 	:= ""		
	Local nlCont	:= 1
	Local nX		:= 1
	Local nlY		:= 0
	Local clSeq		:= "" 
		
	If nPosVDe > 0
		nPosDes := nPosVDe - 1
	EndIf
		
	If	nSeek == 2 .And. nLAnterior==oTcBrowse:nAt .And. oTcBrowse:nAt == oTcBrowse:nLen
		If KZVLDOBG()
			aAdd(oTcBrowse:aArray,Array(Len(aHeader)))
	
			(cZAEZAF)->(dbGoBottom())
					
			For nX:= 3 To Len(aCampos)
				If nX <> 5 .AND. nX <> 6 
					aArray[Len(aArray)][nX] := TRANSFORM('',aPictures[nX])				
					If 	  Alltrim(aCampos[nX]) == cTabIEDI + "_DESCRI"
						aArray[Len(aArray)][nX] := TRANSFORM('',aPictures[nX])	
						Loop
					ElseIf aCampos[nX] == ALLTRIM(cTabIEDI + '_DTENT')
						aArray[Len(aArray)][nX] := ctoD('  /  /  ')
					Else
				   		aArray[Len(aArray)][nX] := TRANSFORM(&(cZAEZAF + "->"+Alltrim(aCampos[nX])),aPictures[nX])						
					EndIf
				EndIf						
			Next nX  
			
			aArray[Len(aArray)][1] 			:= '4'
			aArray[Len(aArray)][nPosSeq] 	:= '001'
			
			clOper := POSICIONE("ZAC",1,xFilial("ZAC")+M->&(cTabEDI + "_TPNGRD"),"ZAC_OPTES")
			If Empty(clOper)
				aArray[Len(aArray)][nPosOpe] 	:= aArray[nLAnterior][nPosOpe]		
				aArray[Len(aArray)][nPosTES] 	:= aArray[nLAnterior][nPosTES]		
				aArray[Len(aArray)][nPosCFO] 	:= aArray[nLAnterior][nPosCFO]
			Else
				aArray[Len(aArray)][nPosOpe] 	:= clOper		
				aArray[Len(aArray)][nPosTES] 	:= POSICIONE("SFM",1,xFilial("SFM")+clOper,"FM_TS")		
				aArray[Len(aArray)][nPosCFO] 	:= POSICIONE("SF4",1,xFilial("SF4")+aArray[Len(aArray)][nPosTES],"F4_CF")
			EndIf	

			lpNovoIte := .T.
			SomaIte(Len(aArray))									
			oTcBrowse:GoTop()
			oTcBrowse:GoBottom()
		Else
			nSeek := 1
			nLAnterior := oTcBrowse:nAt						
		EndIf		
	ElseIf nSeek == 2 .And. nLAnterior<=oTcBrowse:nLen
		For nlX := 3 to Len(aHeader)
			If 		VALTYPE(oTcBrowse:aArray[Len(oTcBrowse:aArray)][nlX]) == 'C' .AND. EMPTY(oTcBrowse:aArray[Len(oTcBrowse:aArray)][nlX])
				nlCont++
			ElseIf	VALTYPE(oTcBrowse:aArray[Len(oTcBrowse:aArray)][nlX]) == 'C' .AND. ALLTRIM(oTcBrowse:aArray[Len(oTcBrowse:aArray)][nlX]) == ALLTRIM(TRANSFORM(0,aPictures[nlX]))
				nlCont++				
			ElseIf	VALTYPE(oTcBrowse:aArray[Len(oTcBrowse:aArray)][nlX]) == 'D' .AND. oTcBrowse:aArray[Len(oTcBrowse:aArray)][nlX] == cToD('  /  /  ')
				nlCont++															 							
			EndIf		
		Next nlX
		If nlCont == (Len(aHeader)-6)
			aSize(oTcBrowse:aArray,Len(oTcBrowse:aArray)-1)
			oTcBrowse:GoTop()
			oTcBrowse:GoBottom()
		EndIf
	ElseIf nSeek == 2 .And. nLAnterior>=oTcBrowse:nAt
		For nlX := 3 to Len(aHeader)
			If 		VALTYPE(oTcBrowse:aArray[Len(oTcBrowse:aArray)][nlX]) == 'C' .AND. EMPTY(oTcBrowse:aArray[Len(oTcBrowse:aArray)][nlX])
				nlCont++
			ElseIf	VALTYPE(oTcBrowse:aArray[Len(oTcBrowse:aArray)][nlX]) == 'C' .AND. ALLTRIM(oTcBrowse:aArray[Len(oTcBrowse:aArray)][nlX]) == ALLTRIM(TRANSFORM(0,aPictures[nlX]))
				nlCont++				
			ElseIf	VALTYPE(oTcBrowse:aArray[Len(oTcBrowse:aArray)][nlX]) == 'D' .AND. oTcBrowse:aArray[Len(oTcBrowse:aArray)][nlX] == cToD('  /  /  ')
				nlCont++															 							
			EndIf		
		Next nlX
		If nlCont == (Len(aHeader)-6)
			aSize(oTcBrowse:aArray,Len(oTcBrowse:aArray)-1)
			oTcBrowse:GoTop()
			oTcBrowse:GoBottom()
		EndIf				
	EndIf
	   
	If nSeek == 1
		nLAnterior := oTcBrowse:nAt
		nSeek := 2
	ElseIf nSeek == 2
		nSeek := 0
	EndIf
	
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ VSeekChange   บAutor  ณRodrigo A. Tosin	  บData  ณ 24/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para validar mudanca de linha da TcBrowse			  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil						   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/   
Static Function VSeekChange()

	nSeek := 1
	
	oTcBrowse:DrawSelect()
	oTcBrowse:Refresh()	
			       
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ ValidTc	     บAutor  ณRodrigo A. Tosin	  บData  ณ 24/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para validar mudanca de linha da TcBrowse			  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil						   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณllRet - Retorna .T. se validou corretamente, .F. se nao validou บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/   
Static Function ValidTc(nLiAtual)
	Local llRet		:= .T.
	Local nPos		:= 0
	Local nPosCPr	:= aScan(aCampos, cTabIEDI + "_PRODUT")
	Local nPosDes	:= aScan(aCampos, cTabIEDI + "_DESCR")	
	Local nPosEAN	:= aScan(aCampos, cTabIEDI + "_EAN")
	Local nPosQtd	:= aScan(aCampos, cTabIEDI + "_QTD")
	Local nPosPre	:= aScan(aCampos, cTabIEDI + "_PRCUNI")
	Local nPosTot	:= aScan(aCampos, cTabIEDI + "_TOTAL")
	Local nPosTES	:= aScan(aCampos, cTabIEDI + "_TES") 
	Local nPosIPI	:= aScan(aCampos, cTabIEDI + "_PERCIP") 
	Local nPosVPI	:= aScan(aCampos, cTabIEDI + "_VLRIPI")	
	Local nPosQtd2	:= aScan(aCampos, cTabIEDI + "_QTD2")
	Local nPosLPA	:= aScan(aCampos, cTabIEDI + "_LOCAL")
	Local nPosUm	:= aScan(aCampos, cTabIEDI + "_UM")	
	Local nPosDco	:= aScan(aCampos, cTabIEDI + "_VLRDES")	
	Local nPosICM	:= aScan(aCampos, cTabIEDI + "_PERICM")
	Local nPosVCM	:= aScan(aCampos, cTabIEDI + "_VLRICM")
	Local nPosFre	:= aScan(aCampos, cTabIEDI + "_VLRFRT")
	Local nPosSeg	:= aScan(aCampos, cTabIEDI + "_VLRSEG")
	Local nPosDSP	:= aScan(aCampos, cTabIEDI + "_VLRDSP")	
	Local nPosSTS	:= aScan(aCampos, "")
	Local nPosIte	:= aScan(aCampos, cTabIEDI + "_ITEM")
	Local nPosOpe	:= aScan(aCampos, cTabIEDI + "_OPER")
	Local nPosCFO	:= aScan(aCampos, cTabIEDI + "_CFOP")
		
	Local llExclui	:= .T.
	Local llInclui	:= .F.		
	Local clIncons	:= '4'
    Local clQuery 	:= ""  
    Local clTabtemp := "INCQRY"    //Tabela para verificar Inconsistencias
	Local llIncons	:= .F. 
	Local alDesc	:= {}
	Local clPreco	:= ""
	Local clQtd		:= ""
    Local clOper	:= ""
	
	Local nlQtd		:= 0
	Local nlPreco	:= 0
	Local nlTotal	:= 0
	Local nlDesc	:= 0
	Local nlFrete	:= 0
	Local nlSegur	:= 0
	Local nlDespe	:= 0 
    Local nlDescCli	:= 0
    Local nlIPI		:= 0
    Local nlValIPI	:= 0
    
	Local llApto	:= .T.

									
	nPosDco -= 1 
		   
    Default nLiAtual := oTcBrowse:nAt 
    
    cpItem := aArray[nLiAtual][nPosIte]
    
    SomaIte()
    oGetDados:aCols:= {{"",0,"","",.F.}}
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica Inconsistencia - Codigo de Produto nao cadastrado					   								 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
    If !Empty(oTcBrowse:aArray[nLiAtual][nPosCPr])
		DescErro(nPosCPr,"C๓digo Produto","C๓digo Produto nใo estแ preenchido.",llExclui)	    

		clQuery := "SELECT B1_COD,B1_DESC,B1_UM,B1_LOCPAD,B1_IPI,B1_MSBLQL,B1_ATIVO,B1_CODBAR"
		clQuery += " FROM " + RetSQLName("SB1")
		clQuery += " WHERE B1_FILIAL = '" + xFilial("SB1") + "' AND B1_COD = '" + ALLTRIM(oTcBrowse:aArray[nLiAtual][nPosCPr]) + "' AND D_E_L_E_T_ <> '*'"
        clQuery := ChangeQuery(clQuery)
        
		If Select(clTabtemp) > 0
			(clTabtemp)->(dbCloseArea())
		EndIf
		
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), clTabtemp ,.T.,.F.)
						
	    If (clTabtemp)->(!EOF())
			DescErro(nPosCPr,"Produto","C๓digo Produto nใo estแ cadastrado na tabela de Produtos.",llExclui)   

			DescErro(nPosCPr,"Produto","C๓digo do produto nใo pertence ao pedido EDI.",llExclui)
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณVerifica Inconsistencia 4 - Percentual de IPI do Produto														 ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If ALLTRIM(TRANSFORM((clTabtemp)->B1_IPI,aPictures[nPosIPI])) <> ALLTRIM(NumVirg(oTcBrowse:aArray[nLiAtual][nPosIPI],nPosIPI))
				DescErro(nPosIPI,"% IPI","Percentual de IPI estแ diferente do valor cadastrado na tabela de produtos.",llInclui)									
			Else
				DescErro(nPosIPI,"% IPI","Percentual de IPI estแ diferente do valor cadastrado na tabela de produtos.",llExclui)												  
			EndIf 

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณVerifica Inconsistencia 7 - Produto bloqueado para venda ou inativo											 ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู			

			If 	(clTabtemp)->B1_MSBLQL == "1"
				DescErro(nPosCPr,"Produto","Produto esta bloqueado para vendas.",llInclui)				
			Else
				DescErro(nPosCPr,"Produto","Produto esta bloqueado para vendas.",llExclui)				
			EndIf
			If  (clTabtemp)->B1_ATIVO == "N"
				DescErro(nPosCPr,"Produto","Produto esta inativo.",llInclui)				
			Else
				DescErro(nPosCPr,"Produto","Produto esta inativo.",llExclui)				
			EndIf
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณVerifica Inconsistencia 3 - Preco unitario da tabela de preco	   											 ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			clQuery := "SELECT DA1_PRCVEN,DA1_CODPRO" 													  		+ CRLF  
			clQuery += "FROM " + RetSQLName("DA1")														  		+ CRLF  
			clQuery += "WHERE 	DA1_FILIAL  = '" + xFilial("DA1") + "'"						 					+ CRLF
			clQuery += "	AND DA1_CODTAB 	= '" + M->&(cTabEDI + "_TABPRC") + "' "								+ CRLF 				 
			clQuery += "	AND DA1_CODPRO 	= '" + ALLTRIM(oTcBrowse:aArray[nLiAtual][nPosCPr]) + "'"			+ CRLF 
			clQuery += "	AND D_E_L_E_T_	<> '*'"
				
			clQuery := ChangeQuery(clQuery) 
			
			If Select(clTabtemp) > 0
				(clTabtemp)->(dbCloseArea())
			EndIf
			
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), clTabtemp ,.T.,.F.)
			
			If  (clTabtemp)->(EOF())
				DescErro(nPosPre,"Preco Unitario","Preco Unitario nใo estแ cadastrado na tabela de preco.",llInclui)
				DescErro(nPosPre,"Preco Unitario","Preco Unitario nใo estแ igual ao preco cadastrado na tabela de preco.",llExclui)
			Else
				If ALLTRIM(TRANSFORM((clTabtemp)->DA1_PRCVEN,aPictures[nPosPre])) <> ALLTRIM(NumVirg(oTcBrowse:aArray[nLiAtual][nPosPre],nPosPre))
					DescErro(nPosPre,"Preco Unitario","Preco Unitario nใo estแ cadastrado na tabela de preco.",llExclui)
					DescErro(nPosPre,"Preco Unitario","Preco Unitario nใo estแ igual ao preco cadastrado na tabela de preco.",llInclui)
				Else
					DescErro(nPosPre,"Preco Unitario","Preco Unitario nใo estแ igual ao preco cadastrado na tabela de preco.",llExclui)
					DescErro(nPosPre,"Preco Unitario","Preco Unitario nใo estแ cadastrado na tabela de preco.",llExclui)
				EndIf
			EndIf
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณVerifica Inconsistencia 5 - Percentual de Desconto				   											 ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If	ALLTRIM(NumVirg(oTcBrowse:aArray[nLiAtual][nPosDco],nPosDco))  <> "0,00"
				clQuery := "SELECT A1_GRPVEN,A1_TABELA,A1_DESC" 											  		+ CRLF  
				clQuery += "FROM " + RetSQLName("SA1")														  		+ CRLF  
				clQuery += "WHERE 	A1_FILIAL 	= '" + xFilial("SA1") + "'"						 					+ CRLF 
				clQuery += "	AND A1_COD 		= '" + (cTabEDI)->(&(cTabEDI + "_CLIFAT")) 	+ "'"	 			+ CRLF
				clQuery += "	AND A1_LOJA 	= '" + (cTabEDI)->(&(cTabEDI + "_LJFAT")) 		+ "'"	 			+ CRLF
				clQuery += "	AND D_E_L_E_T_	<> '*'"
				
				clQuery := ChangeQuery(clQuery) 
				
				If Select(clTabtemp) > 0
					(clTabtemp)->(dbCloseArea())
				EndIf
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), clTabtemp ,.T.,.F.)
				
				If  	(clTabtemp)->(EOF())
	//				llIncons := .T.
				Else
	                nlDescCli := (clTabtemp)->A1_DESC
					clQuery	:= "SELECT ACP_PERDES"  					  											   	+ CRLF 
	 			//,ACO_GRPVEN,ACO_CODCLI,ACO_LOJA,ACO_CONDPG,ACO_CODTAB,ACO_CODREG
	 			//,ACP_CODPRO,ACP_CODREG
					clQuery	+= "FROM"  					  											   	   				+ CRLF 	
					clQuery	+= "("  					  											   	   				+ CRLF 
					clQuery	+= "	SELECT ACO_GRPVEN,ACO_CODCLI,ACO_LOJA,ACO_CONDPG,ACO_CODTAB,ACO_CODREG"    			+ CRLF 
					clQuery	+= "	FROM " + RetSQLName("ACO") 															+ CRLF
					clQuery	+= "	WHERE	ACO_FILIAL		= '" + xFilial("ACO") + "'" 								+ CRLF
					clQuery	+= "		AND	ACO_GRPVEN 		= '" + AllTrim((clTabtemp)->A1_GRPVEN)				+ "'"	+ CRLF	 
					clQuery	+= "		OR ACO_GRPVEN  		= ''" 														+ CRLF
					clQuery	+= "		AND	ACO_CODCLI  	= '" + AllTrim((cTabEDI)->&(cTabEDI+"_CLIFAT"))	+ "'"	+ CRLF
					clQuery	+= "		AND	ACO_LOJA   		= '" + AllTrim((cTabEDI)->&(cTabEDI+"_LJFAT"))		+ "'"	+ CRLF
					clQuery	+= "		AND	ACO_CONDPG 		= '" + AllTrim((cTabEDI)->&(cTabEDI+"_CONDPAG"))	+ "'"	+ CRLF	 
					clQuery	+= "		OR ACO_CONDPG  		= ''"  														+ CRLF
					clQuery	+= "		AND	ACO_CODTAB 		= '"	+ AllTrim((clTabtemp)->A1_TABELA)			+ "'" 	+ CRLF	 
					clQuery	+= "		OR ACO_CODTAB  		= ''" 														+ CRLF
					clQuery	+= "		AND D_E_L_E_T_		<> '*'" 													+ CRLF
					clQuery	+= ") ACO" 																				 	+ CRLF
					clQuery	+= "INNER JOIN" 																			+ CRLF
					clQuery	+= "(" 																						+ CRLF
					clQuery	+= "	SELECT ACP_CODPRO,ACP_CODREG,ACP_PERDES"   											+ CRLF	
					clQuery	+= "	FROM " + RetSQLName("ACP") 															+ CRLF
					clQuery	+= "	WHERE	ACP_CODPRO 		= '" + ALLTRIM(oTcBrowse:aArray[nLiAtual][nPosCPr]) + "'"	+ CRLF
					clQuery	+= "		AND	ACP_FILIAL 		= '" + xFilial("ACP") + "'" 								+ CRLF
					clQuery	+= "   		AND	D_E_L_E_T_ 		<> '*'" 													+ CRLF
					clQuery	+= ") ACPTAB" 																				+ CRLF	
					clQuery	+= "ON 	ACPTAB.ACP_CODREG = ACO.ACO_CODREG"
			
					clQuery := ChangeQuery(clQuery) 
					
					If Select(clTabtemp) > 0
						(clTabtemp)->(dbCloseArea())
					EndIf
					
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), clTabtemp ,.T.,.F.)
					If   	(clTabtemp)->(!EOF())
						If 	ALLTRIM(TRANSFORM((clTabtemp)->ACP_PERDES,aPictures[nPosDco])) < ALLTRIM(NumVirg(oTcBrowse:aArray[nLiAtual][nPosDco],nPosDco))
							DescErro(nPosDco,"% Desconto","Percentual de desconto nใo estแ igual ao percentual cadastrado na tabela de regra de desconto."	,llInclui)
							DescErro(nPosDco,"% Desconto","Percentual de desconto nใo estแ igual ao percentual cadastrado na tabela de Clientes."			,llExclui)															
						Else	
							DescErro(nPosDco,"% Desconto","Percentual de desconto nใo estแ igual ao percentual cadastrado na tabela de regra de desconto."	,llExclui)
							DescErro(nPosDco,"% Desconto","Percentual de desconto nใo estแ igual ao percentual cadastrado na tabela de Clientes."			,llExclui)															
						EndIf
					ElseIf nlDescCli < VAL(oTcBrowse:aArray[nLiAtual][nPosDco])
						DescErro(nPosDco,"% Desconto","Percentual de desconto nใo estแ igual ao percentual cadastrado na tabela de Clientes."			,llInclui)	
						DescErro(nPosDco,"% Desconto","Percentual de desconto nใo estแ igual ao percentual cadastrado na tabela de regra de desconto."	,llExclui)
					Else
						DescErro(nPosDco,"% Desconto","Percentual de desconto nใo estแ igual ao percentual cadastrado na tabela de Clientes."			,llExclui)					
						DescErro(nPosDco,"% Desconto","Percentual de desconto nใo estแ igual ao percentual cadastrado na tabela de regra de desconto."	,llExclui)																			
					EndIf
				EndIf    
			Else
				DescErro(nPosDco,"% Desconto","Percentual de desconto nใo estแ igual ao percentual cadastrado na tabela de Clientes."			,llExclui)					
				DescErro(nPosDco,"% Desconto","Percentual de desconto nใo estแ igual ao percentual cadastrado na tabela de regra de desconto."	,llExclui)										
			EndIf									
		Else 
			DescErro(nPosCPr,"Produto"			,"C๓digo Produto nใo estแ cadastrado na tabela de Produtos."						,llInclui)
			DescErro(nPosPre,"Preco Unitario"	,"Preco Unitario nใo estแ cadastrado na tabela de preco."					  		,llExclui)
			DescErro(nPosPre,"Preco Unitario"	,"Preco Unitario nใo estแ igual ao preco cadastrado na tabela de preco."   			,llExclui)
			DescErro(nPosCPr,"Produto"			,"Produto esta inativo."															,llExclui)
			DescErro(nPosCPr,"Produto"			,"Produto esta bloqueado para vendas."										   		,llExclui)
			DescErro(nPosIPI,"% IPI"			,"Percentual de IPI estแ diferente do valor cadastrado na tabela de produtos."		,llExclui)
		   	llIncons	:= .T.
			
		EndIf
		(clTabtemp)->(dbCloseArea())	
	Else
			
		DescErro(nPosCPr,"C๓digo Produto","C๓digo Produto nใo estแ preenchido."							,llInclui)
		DescErro(nPosCPr,"C๓digo Produto","C๓digo Produto nใo estแ cadastrado na tabela de Produtos."	,llExclui)
	EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica Inconsistencia - Quantidade igual a zero				   											 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	If 	ALLTRIM(oTcBrowse:aArray[nLiAtual][nPosQtd]) == '0,00'
		DescErro(nPosQtd,"Quantidade","Quantidade igual a zero ou vazio.",llInclui)	
	Else
		DescErro(nPosQtd,"Quantidade","Quantidade igual a zero ou vazio.",llExclui)
		oTcBrowse:aArray[nLiAtual][nPosQtd]  := NumVirg(oTcBrowse:aArray[nLiAtual][nPosQtd],nPosQtd)	 
	EndIf
		oTcBrowse:aArray[nLiAtual][nPosQtd2]  := NumVirg(oTcBrowse:aArray[nLiAtual][nPosQtd2],nPosQtd2)	

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica Inconsistencia - Preco unitario igual a zero			   											 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	
	If ALLTRIM(oTcBrowse:aArray[nLiAtual][nPosPre])  == '0,00'
		DescErro(nPosPre,"Preco Unitario","Preco Unitario igual a zero ou vazio.",llInclui)		
	Else
		DescErro(nPosPre,"Preco Unitario","Preco Unitario igual a zero ou vazio.",llExclui)
		oTcBrowse:aArray[nLiAtual][nPosPre] := NumVirg(oTcBrowse:aArray[nLiAtual][nPosPre] ,nPosPre)
	   	
/*	   	clPreco := NumVirg(oTcBrowse:aArray[nLiAtual][nPosPre] ,nPosPre)
	   	clPreco := STRTRAN(clPreco,".","")		   	
	   	clPreco := STRTRAN(clPreco,",",".")	   	
	   	clQtd   := NumVirg(oTcBrowse:aArray[nLiAtual][nPosQtd] ,nPosQtd)
		clQtd   := STRTRAN(clQtd,".","")		   	
	   	clQtd 	:= STRTRAN(clQtd,",",".")	
	   	
		oTcBrowse:aArray[nLiAtual][nPosTot] := NumVirg(cValToChar(val(clPreco) * Val(clQtd)),nPosTot)
*/	EndIf	
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica Inconsistencia - Valor total do item - Inconsistencia 06   											 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	
	   	clPreco := NumVirg(oTcBrowse:aArray[nLiAtual][nPosPre] ,nPosPre)
	   	clPreco := STRTRAN(clPreco,".","")		   	
	   	clPreco := STRTRAN(clPreco,",",".")	   	
	   	clQtd   := NumVirg(oTcBrowse:aArray[nLiAtual][nPosQtd] ,nPosQtd)
		clQtd   := STRTRAN(clQtd,".","")		   	
	   	clQtd 	:= STRTRAN(clQtd,",",".")	
	   	
		If NumVirg(oTcBrowse:aArray[nLiAtual][nPosTot],nPosTot) <> NumVirg(cValToChar(val(clPreco) * Val(clQtd)),nPosTot)
			DescErro(nPosTot,"Valor Total","Valor Total diferente do Preco Unitario vezes Quantidade.",llInclui)		
   		Else
			DescErro(nPosTot,"Valor Total","Valor Total diferente do Preco Unitario vezes Quantidade.",llExclui)		
		EndIf
		oTcBrowse:aArray[nLiAtual][nPosTot] := NumVirg(oTcBrowse:aArray[nLiAtual][nPosTot],nPosTot)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica Inconsistencia - Valor total igual a zero				   											 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	
	If ALLTRIM(oTcBrowse:aArray[nLiAtual][nPosTot]) == '0,00'
		oTcBrowse:aArray[nLiAtual][1] := clIncons
		DescErro(nPosTot,"Valor Total","Valor Total igual a zero ou vazio.",llInclui)	
	Else
		DescErro(nPosTot,"Valor Total","Valor Total igual a zero ou vazio.",llExclui)
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณInicializa a funcao fiscal                   ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		MaFisSave()
		MaFisEnd()  
		
	   	MaFisIni(M->&(cCliFat),M->&(cLjFat),"C","N",POSICIONE("SA1",1,xFilial("SA1")+M->&(cCliFat)+M->&(cLjFat),"A1_TIPO"),,,.F.,)   	  
		
		If 		At(".",oTcBrowse:aArray[nLiAtual][nPosQtd]) > 0 .AND. At(",",oTcBrowse:aArray[nLiAtual][nPosQtd]) > 0 
			nlQtd 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosQtd],".","")
			nlQtd 	:= STRTRAN(nlQtd,",",".")
		ElseIf At(",",oTcBrowse:aArray[nLiAtual][nPosQtd]) > 0
			nlQtd 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosQtd],",",".")
		EndIf
		nlQtd 	:= Val(nlQtd)
		
		If 		At(".",oTcBrowse:aArray[nLiAtual][nPosPre]) > 0 .AND. At(",",oTcBrowse:aArray[nLiAtual][nPosPre]) > 0
			nlPreco 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosPre],".","")
			nlPreco 	:= STRTRAN(nlPreco,",",".")	
		ElseIf At(",",oTcBrowse:aArray[nLiAtual][nPosPre]) > 0
			nlPreco 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosPre],",",".")
		EndIf 		
		nlPreco := Val(nlPreco)

		If 		At(".",oTcBrowse:aArray[nLiAtual][nPosTot]) > 0 .AND. At(",",oTcBrowse:aArray[nLiAtual][nPosTot]) > 0
			nlTotal 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosTot],".","")
			nlTotal 	:= STRTRAN(nlTotal,",",".")	
		ElseIf At(",",oTcBrowse:aArray[nLiAtual][nPosTot]) > 0
			nlTotal 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosTot],",",".")
		EndIf
		nlTotal := Val(nlTotal) 
 
		If 		At(".",oTcBrowse:aArray[nLiAtual][nPosDco]) > 0 .AND. At(",",oTcBrowse:aArray[nLiAtual][nPosDco]) > 0
			nlDesc 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosDco],".","")
			nlDesc 	:= STRTRAN(nlDesc,",",".")	
		ElseIf At(",",oTcBrowse:aArray[nLiAtual][nPosDco]) > 0
			nlDesc 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosDco],",",".")						
		EndIf		
		nlDesc := Val(nlDesc)
		
		If 		At(".",oTcBrowse:aArray[nLiAtual][nPosFre]) > 0 .AND. At(",",oTcBrowse:aArray[nLiAtual][nPosFre]) > 0
			nlFrete 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosFre],".","")
			nlFrete 	:= STRTRAN(nlFrete,",",".")	
		ElseIf At(",",oTcBrowse:aArray[nLiAtual][nPosFre]) > 0
			nlFrete 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosFre],",",".")						
		EndIf
		nlFrete := Val(nlFrete)	
		
		If 		At(".",oTcBrowse:aArray[nLiAtual][nPosSeg]) > 0 .AND. At(",",oTcBrowse:aArray[nLiAtual][nPosSeg]) > 0
			nlSegur 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosSeg],".","")
			nlSegur 	:= STRTRAN(nlSegur,",",".")	
		ElseIf At(",",oTcBrowse:aArray[nLiAtual][nPosSeg]) > 0
			nlSegur 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosSeg],",",".")						
		EndIf
		nlSegur := Val(nlSegur)					

		If 		At(".",oTcBrowse:aArray[nLiAtual][nPosDSP]) > 0 .AND. At(",",oTcBrowse:aArray[nLiAtual][nPosDSP]) > 0
			nlDespe 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosDSP],".","")
			nlDespe 	:= STRTRAN(nlDespe,",",".")	
		ElseIf At(",",oTcBrowse:aArray[nLiAtual][nPosDSP]) > 0
			nlDespe 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosDSP],",",".")						
		EndIf
		nlDespe := Val(nlDespe)

		If !Empty(oTcBrowse:aArray[nLiAtual][nPosCPr]) .And. Empty(oTcBrowse:aArray[nLiAtual][nPosTES])
			clOper := POSICIONE("ZAC",1,xFilial("ZAC")+M->&(cTabEDI + "_TPNGRD"),"ZAC_OPTES")

			aArray[nLiAtual][nPosOpe] 	:= clOper
			
			// 24/10/2012	Veronica de Almeida
			// alteracao para buscar TES inletigente 		
			// aArray[nLiAtual][nPosTES] 	:=MaTesInt(2,clOper,M->&(cCliFat),M->&(cLjFat),"C",cCodPro,NIL)
			aArray[nLiAtual][nPosTES] 	:=MaTesInt(2,clOper,M->&(cCliFat),M->&(cLjFat),"C",oTcBrowse:aArray[nLiAtual][nPosCPr],NIL)   
			// final das alteracoes
			
			aArray[nLiAtual][nPosCFO] 	:= POSICIONE("SF4",1,xFilial("SF4")+aArray[nLiAtual][nPosTES],"F4_CF")
		EndIf			
        
		If !Empty(oTcBrowse:aArray[nLiAtual][nPosCPr]) .And. !Empty(oTcBrowse:aArray[nLiAtual][nPosTES])
			MaFisAdd(oTcBrowse:aArray[nLiAtual][nPosCPr],;		   	// 1-Codigo do Produto ( Obrigatorio )
			   		 oTcBrowse:aArray[nLiAtual][nPosTES],;	   		// 2-Codigo do TES ( Opcional )
			   	     nlQtd,;		   								// 3-Quantidade ( Obrigatorio )
			   		 nlPreco,;		  							    // 4-Preco Unitario ( Obrigatorio )
					 nlDesc,; 		   								// 5-Valor do Desconto ( Opcional )
					 "",;	   			   							// 6-Numero da NF Original ( Devolucao/Benef )
					 "",;				   							// 7-Serie da NF Original ( Devolucao/Benef )
					 Nil,;			   			   					// 8-RecNo da NF Original no arq SD1/SD2
					 nlTotal*nlFrete,;					   			// 9-Valor do Frete do Item ( Opcional )
					 nlTotal*nlSegur,;					  			// 10-Valor do Seguro do item ( Opcional )
			   	 	 nlTotal*nlDespe,;					 			// 11-Valor da Despesa do item ( Opcional )
					 0,;				   							// 12-Valor do Frete Autonomo ( Opcional )
					 nlTotal,;			   							// 13-Valor da Mercadoria ( Obrigatorio )
			   	 	 0,;				   			   				// 14-Valor da Embalagem ( Opcional )
					 ,;				   								//
					 ,;				   								//
					 '')
		EndIf		 
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Calcula os valores do IPI                   ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If 		At(".",oTcBrowse:aArray[nLiAtual][nPosIPI]) > 0 .AND. At(",",oTcBrowse:aArray[nLiAtual][nPosIPI]) > 0
			nlIPI 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosIPI],".","")
			nlIPI 	:= STRTRAN(nlIPI,",",".")	
		ElseIf At(",",oTcBrowse:aArray[nLiAtual][nPosIPI]) > 0
			nlIPI 	:= STRTRAN(oTcBrowse:aArray[nLiAtual][nPosIPI],",",".")
		EndIf
		nlIPI 		:= Val(nlIPI)
		nlValIPI	:= nlTotal * (nlIPI/100)
		
		oTcBrowse:aArray[nLiAtual][nPosVPI]	   	:= NumVirg(cValToChar(nlValIPI)		,nPosVPI)
             

		// Verifica se realizou o MaFisAdd
		If !Empty(oTcBrowse:aArray[nLiAtual][nPosCPr]) .And. !Empty(oTcBrowse:aArray[nLiAtual][nPosTES])			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Calcula os valores do ICMS                  ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	  
			oTcBrowse:aArray[nLiAtual][nPosICM]		:= NumVirg(cValToChar(MaFisRet(1,'IT_ALIQSOL' ))	,nPosICM)
	//  	oTcBrowse:aArray[nLiAtual][nPosVCM]		:= NumVirg(cValToChar(MaFisRet(1,'IT_ALIQSOL') * MaFisRet(1,'IT_BASEICM'))	,nPosVCM)	
  			oTcBrowse:aArray[nLiAtual][nPosVCM]		:= NumVirg(cValToChar(MaFisRet(1,'IT_VALSOL'))		,nPosVCM)
		EndIf
		// Encerra a funcao fiscal
		MaFisEnd()
		MaFisRestore()
		
		oTcBrowse:aArray[nLiAtual][nPosDco] 		:= TRANSFORM(nlDesc					,aPictures[nPosDco]		)		  
		oTcBrowse:aArray[nLiAtual][(nPosDco+1)] 	:= TRANSFORM(nlTotal * (nlDesc/100),aPictures[(nPosDco+1)])
				
	  	llIncons	:= .F.
	EndIf	
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica Inconsistencia 2 - Codigo de EAN (Codigo de Barras) nao cadastrado									 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

    If !Empty(oTcBrowse:aArray[nLiAtual][nPosEAN])
		DescErro(nPosEAN,"C๓digo EAN","C๓digo EAN nใo estแ preenchido.",llExclui)	    
		
		clQuery := "SELECT B1_CODBAR FROM " + RetSQLName("SB1") + " WHERE B1_FILIAL = '" + xFilial("SB1") + "' AND B1_CODBAR = '" + ALLTRIM(oTcBrowse:aArray[nLiAtual][nPosEAN]) + "' AND D_E_L_E_T_ <> '*'"
		clQuery := ChangeQuery(clQuery)
		        
		If Select(clTabtemp) > 0
			(clTabtemp)->(dbCloseArea())
		EndIf
		
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), clTabtemp ,.T.,.F.) 
		
		If (clTabtemp)->(EOF())	
			DescErro(nPosEAN,"C๓digo EAN","C๓digo EAN nใo estแ cadastrado na tabela de Produtos.",llInclui)		
		Else
			DescErro(nPosEAN,"C๓digo EAN","C๓digo EAN nใo estแ cadastrado na tabela de Produtos.",llExclui)			
		EndIf
		(clTabtemp)->(dbCloseArea())
	Else
		DescErro(nPosEAN,"C๓digo EAN","C๓digo EAN nใo estแ preenchido.",llInclui)	
		DescErro(nPosEAN,"C๓digo EAN","C๓digo EAN nใo estแ cadastrado na tabela de Produtos.",llExclui)				
	EndIf
/*
	nPos := aScan(oGetDados:aCols,{|x| x[1] == nLiAtual}) 
	If nPos > 0
		While oGetDados:aCols[nPos][1] == nLiAtual
		    If 		ALLTRIM(	NoAcento(	UPPER(oGetDados:aCols[nPos][2])	)	) == ALLTRIM(	NoAcento(UPPER("C๓digo Produto")) 	) 		.OR.;
		    		ALLTRIM(	NoAcento(	UPPER(oGetDados:aCols[nPos][2])	)	) == ALLTRIM(	NoAcento(UPPER("C๓digo EAN"))  		) 		.OR.;
		    		ALLTRIM(	NoAcento(	UPPER(oGetDados:aCols[nPos][2])	)	) == ALLTRIM(	NoAcento(UPPER("Preco Unitario")) 	)     	.OR.;
		    		ALLTRIM(	NoAcento(	UPPER(oGetDados:aCols[nPos][2])	)	) == ALLTRIM(	NoAcento(UPPER("% IPI"))   			)      	.OR.;
		    		ALLTRIM(	NoAcento(	UPPER(oGetDados:aCols[nPos][2])	)	) == ALLTRIM(	NoAcento(UPPER("Valor Total"))		)          	//.OR.
 				llApto	 := .F.
            	llIncons := .T.
			EndIf
			nPos++
			If nPos > Len(oGetDados:aCols)
				Exit
			EndIf
		EndDo
	Else
		llApto	 := .T.	
		llIncons := .F.	
	EndIf
*/
	For nPos := 1 to Len(oGetDados:aCols)
	    If 		ALLTRIM(	NoAcento(	UPPER(oGetDados:aCols[nPos][3])	)	) == ALLTRIM(	NoAcento(UPPER("C๓digo Produto")) 	) 		.OR.;
	    		ALLTRIM(	NoAcento(	UPPER(oGetDados:aCols[nPos][3])	)	) == ALLTRIM(	NoAcento(UPPER("C๓digo EAN"))  		) 		.OR.;
	    		ALLTRIM(	NoAcento(	UPPER(oGetDados:aCols[nPos][3])	)	) == ALLTRIM(	NoAcento(UPPER("Preco Unitario")) 	)     	.OR.;
	    		ALLTRIM(	NoAcento(	UPPER(oGetDados:aCols[nPos][3])	)	) == ALLTRIM(	NoAcento(UPPER("% IPI"))   			)      	.OR.;
	    		ALLTRIM(	NoAcento(	UPPER(oGetDados:aCols[nPos][3])	)	) == ALLTRIM(	NoAcento(UPPER("Valor Total"))		)	//	.OR.;

 				llApto	 := .F.
            	llIncons := .T.
        ElseIf  ALLTRIM(	NoAcento(	UPPER(oGetDados:aCols[nPos][3])	)	) == ALLTRIM(	NoAcento(UPPER("% Desconto")) 	)
 				llApto	 := .F.
            	llIncons := .F.           	
		EndIf	
	Next nPos
		
	If 		llIncons
   		oTcBrowse:aArray[nLiAtual][1] 	:= clIncons
   	ElseIf 	llApto
   		oTcBrowse:aArray[nLiAtual][1] 	:= '2'
		DescErro(nPosCPr ,"C๓digo Produto"	,"C๓digo Produto nใo estแ preenchido."																,llExclui)
		DescErro(nPosCPr ,"Produto"			,"C๓digo Produto nใo estแ cadastrado na tabela de Produtos."										,llExclui)
		DescErro(nPosIPI ,"% IPI"			,"Percentual de IPI estแ diferente do valor cadastrado na tabela de produtos."			 			,llExclui)
		DescErro(nPosCPr ,"Produto"			,"Produto esta bloqueado para vendas."																,llExclui)
		DescErro(nPosCPr ,"Produto"			,"Produto esta inativo."																			,llExclui)
		DescErro(nPosPre ,"Preco Unitario"	,"Preco Unitario nใo estแ igual ao preco cadastrado na tabela de preco."							,llExclui)
		DescErro(nPosPre ,"Preco Unitario"	,"Preco Unitario nใo estแ cadastrado na tabela de preco."											,llExclui)
		DescErro(nPosDco ,"% Desconto"		,"Percentual de desconto nใo estแ igual ao percentual cadastrado na tabela de regra de desconto."	,llExclui)
		DescErro(nPosDco ,"% Desconto"		,"Percentual de desconto nใo estแ igual ao percentual cadastrado na tabela de Clientes."  			,llExclui)			
		DescErro(nPosQtd ,"Quantidade"		,"Quantidade igual a zero ou vazio."																,llExclui)
		DescErro(nPosPre ,"Preco Unitario"	,"Preco Unitario igual a zero ou vazio."															,llExclui)
		DescErro(nPosTot ,"Valor Total"		,"Valor Total igual a zero ou vazio."																,llExclui)
		DescErro(nPosTot ,"Valor Total"		,"Valor Total diferente do preco unitario vezes Quantidade."										,llExclui)
		DescErro(nPosEAN ,"C๓digo EAN"		,"C๓digo EAN nใo estแ cadastrado na tabela de Produtos."											,llExclui)
   	Else
   		oTcBrowse:aArray[nLiAtual][1] 	:= '3'   		
   	EndIf
   	  	
   	oTcBrowse:Refresh()
	oGetDados:aCols := aSort(oGetDados:aCols,,,{|x,y| x[2] <= y[2] }) 
	oGetDados:Refresh()	
 	
/*	INC     DESCRICAO                                              AP  IM 
	01    	Cliente de entrega/Cobran็a                            	2	1			// Com Inconsistencia
	02    	Codigo EAN                                             	2	1			// Com Inconsistencia
	03    	Valor unitแrio                                         	2	1			// Com Inconsistencia
	04    	Percentual de IPI                                      	2	1			// Com Inconsistencia
	05    	Percentual de Desconto                                 	1	2			// Aguardando Aprovacao
	06    	Valor Total Item                                       	2	1 			// Com Inconsistencia
	07    	Produto Bloqueado/Inativo                              	2	2			// Apto a gerar pedido de venda - advertencia
	08    	Produto Alternativo                                    	2	2			// Apto a gerar pedido de venda - advertencia
	09    	Valor mํnimo da parcela de R$ 500,00                   	2	2			// Apto a gerar pedido de venda - advertencia
	10    	Quantidade mแxima de 40 itens por pedido               	2	2			// Apto a gerar pedido de venda - advertencia
	11    	Valor mแximo de R$ 80.000,00 por pedido                	2	2 			// Apto a gerar pedido de venda - advertencia  	
 */
		 
Return llRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ DuplCli	     บAutor  ณRodrigo A. Tosin	  บData  ณ 24/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para validar duplo clique de campo da TcBrowse		  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil						   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil														   	  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/ 
Static Function DuplCli()
	Local nPosDes	:= aScan(aCampos, cTabIEDI + "_DESCR")	
	Local nPosEAN	:= aScan(aCampos, cTabIEDI + "_EAN")
	Local nPosTot	:= aScan(aCampos, cTabIEDI + "_TOTAL")	
	Local nPosCli	:= aScan(aCampos, cTabIEDI + "_CLIFAT")
	Local nPosLoj	:= aScan(aCampos, cTabIEDI + "_LJFAT")
	Local nPosQt	:= aScan(aCampos, cTabIEDI + "_QTD")
	Local nPosQt2	:= aScan(aCampos, cTabIEDI + "_QTD2")	
	Local nPosPro	:= aScan(aCampos, cTabIEDI + "_PRODUT")
	Local nPosLPA	:= aScan(aCampos, cTabIEDI + "_LOCAL")
	Local nPosUM	:= aScan(aCampos, cTabIEDI + "_UM")
	Local nPosPre	:= aScan(aCampos, cTabIEDI + "_PRCUNI")		
	Local nPosUM2	:= aScan(aCampos, cTabIEDI + "_UNID2")
	Local nPosOpe	:= aScan(aCampos, cTabIEDI + "_OPER")
	Local nPosTES	:= aScan(aCampos, cTabIEDI + "_TES") 
	Local nPosCFO	:= aScan(aCampos, cTabIEDI + "_CFOP")
	Local nPosDEn	:= aScan(aCampos, cTabIEDI + "_DTENT")
	Local nPosIPI	:= aScan(aCampos, cTabIEDI + "_PERCIP")
	Local nPosVIP	:= aScan(aCampos, cTabIEDI + "_VLRIPI")	
	Local nPosDco	:= aScan(aCampos, cTabIEDI + "_VLRDES")
	Local nPosICM	:= aScan(aCampos, cTabIEDI + "_PERICM")
	Local nPosVIC	:= aScan(aCampos, cTabIEDI + "_VLRICM")
	Local nPosVDS	:= aScan(aCampos, cTabIEDI + "_VLRDSP")
	Local nPosVSe	:= aScan(aCampos, cTabIEDI + "_VLRSEG")
	Local nPosVFr	:= aScan(aCampos, cTabIEDI + "_VLRFRT")
	Local nPosIte	:= aScan(aCampos, cTabIEDI + "_ITEM")
	Local nPosNCM	:= aScan(aCampos, cTabIEDI + "_NCM")
	Local nPosCST	:= aScan(aCampos, cTabIEDI + "_CST")	
	Local nPosDSP	:= aScan(aCampos, cTabIEDI + "_VLRDSP")	
	Local nPosSeq	:= aScan(aCampos, cTabIEDI + "_SEQ")	
	Local alPos		:= {}
    Local nlX 		:= 1
    Local nlTotal	:= 0
    Local nlValTot	:= 0 
    Local nlValDes	:= 0        
	Local alExc		:= Separa(SuperGetMv("KZ_EXCALT",.T.,""),";")
	Local clAux		:= ""
	Local llPerm	:= .T.
	Local nlFrete	:= 0
	Local nlTotFre  := 0
	Local nlPreco   := 0
    Local clSeq		:= ""
	Local clPreco	:= ""
	Local clQtd		:= ""
	Local clBkpPre	:= ""
	Local clBkpQtd	:= ""
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณDiminui uma unidade do campo valor de desconto	   										ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู		
	nPosDco 		-= 1
	
	alPos			:= {nPosQt,nPosQt2,nPosDco,(nPosDco+1),nPosICM,nPosVIC,nPosIPI,nPosVIP,nPosVDS,nPosVSe,nPosVFr}
			 					
	If oTcBrowse:ColPos() > 1 
		// 24/10/2012	Veronica de Almeida
		// Alteracao para campo Tipo de Operacao ser editavel
		/*
		If			oTcBrowse:ColPos() <> nPosDes;
			.AND.	oTcBrowse:ColPos() <> nPosCli;
			.AND. 	oTcBrowse:ColPos() <> nPosLoj;
			.AND.   oTcBrowse:ColPos() <> nPosIte;
			.AND.   oTcBrowse:ColPos() <> nPosNCM;
			.AND.   oTcBrowse:ColPos() <> nPosOpe;
			.AND.   oTcBrowse:ColPos() <> nPosTES;
			.AND.   oTcBrowse:ColPos() <> nPosCFO;
			.AND.   oTcBrowse:ColPos() <> nPosIPI;
			.AND.   oTcBrowse:ColPos() <> nPosVIP;
			.AND.   oTcBrowse:ColPos() <> nPosICM;
			.AND.   oTcBrowse:ColPos() <> nPosVIC;
			.AND.   oTcBrowse:ColPos() <> nPosDSP;
			.AND.   oTcBrowse:ColPos() <> (nPosDco + 1);
			.AND.   oTcBrowse:ColPos() <> nPosVFr;
			.AND.   oTcBrowse:ColPos() <> nPosCST;			
			.AND.   oTcBrowse:ColPos() <> nPosDSP;
			.AND. 	oTcBrowse:ColPos() <> nPosTot
			*/
		If			oTcBrowse:ColPos() <> nPosDes;
			.AND.	oTcBrowse:ColPos() <> nPosCli;
			.AND. 	oTcBrowse:ColPos() <> nPosLoj;
			.AND.   oTcBrowse:ColPos() <> nPosIte;
			.AND.   oTcBrowse:ColPos() <> nPosNCM;
			.AND.   oTcBrowse:ColPos() <> nPosTES;
			.AND.   oTcBrowse:ColPos() <> nPosCFO;
			.AND.   oTcBrowse:ColPos() <> nPosIPI;
			.AND.   oTcBrowse:ColPos() <> nPosVIP;
			.AND.   oTcBrowse:ColPos() <> nPosICM;
			.AND.   oTcBrowse:ColPos() <> nPosVIC;
			.AND.   oTcBrowse:ColPos() <> nPosDSP;
			.AND.   oTcBrowse:ColPos() <> (nPosDco + 1);
			.AND.   oTcBrowse:ColPos() <> nPosVFr;
			.AND.   oTcBrowse:ColPos() <> nPosCST;			
			.AND.   oTcBrowse:ColPos() <> nPosDSP;
			.AND. 	oTcBrowse:ColPos() <> nPosTot	  
		// final das alteracoes
			
					
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAltera็ใo devido a terefa de controle de exce็ใo de altera็ใoณ
			//ณdos itens do pedido EDI                                      ณ
			//ณ                                                             ณ
			//ณAlfredo A. Magalhใes                                         ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			
			If lRet2
				If Len(alExc) > 0
					clAux := aCampos[oTcBrowse:ColPos()]
					If aScan(alExc,clAux) == 0
						llPerm := .F.
					EndIf
				Else
					llPerm := .F.
				EndIf
			EndIf
			
			If llPerm
				If 		oTcBrowse:ColPos() == nPosPro .OR. oTcBrowse:ColPos() == nPosEAN
					If 	ConPad1(,,,"SB1",,,.F.)
						oTcBrowse:aArray[oTcBrowse:nAt][nPosPro] := SB1->B1_COD
						oTcBrowse:aArray[oTcBrowse:nAt][nPosDes] := SB1->B1_DESC
						oTcBrowse:aArray[oTcBrowse:nAt][nPosLPA] := SB1->B1_LOCPAD
						oTcBrowse:aArray[oTcBrowse:nAt][nPosEAN] := SB1->B1_CODBAR
						oTcBrowse:aArray[oTcBrowse:nAt][nPosUM]  := SB1->B1_UM
						oTcBrowse:aArray[oTcBrowse:nAt][nPosNCM] := SB1->B1_POSIPI
						oTcBrowse:aArray[oTcBrowse:nAt][nPosUM2] := SB1->B1_SEGUM
						If ALLTRIM(oTcBrowse:aArray[oTcBrowse:nAt][nPosPre]) == ALLTRIM("0,00")
							nlPreco := POSICIONE("DA1",2,xFilial("DA1")+avKey(SB1->B1_COD,"DA1_CODPRO")+avKey(ZAE->ZAE_TABPRC,"DA1_CODTAB"),'DA1_PRCVEN')
							oTcBrowse:aArray[oTcBrowse:nAt][nPosPre] := IIf(nlPreco <> 0,TRANSFORM(nlPreco,aPictures[nPosPre]),TRANSFORM(0,aPictures[nPosPre]))							
						EndIf
						oTcBrowse:aArray[oTcBrowse:nAt][nPosIPI] := TRANSFORM(SB1->B1_IPI,aPictures[nPosIPI])
						
						// 24/10/2012	Veronica de Almeida
						// alteracao para carregar TES inteligente
						cTes := MaTesInt(2,	oTcBrowse:aArray[oTcBrowse:nAt][nPosOpe],M->&(cCliFat),M->&(cLjFat),"C",oTcBrowse:aArray[oTcBrowse:nAt][nPosPro],NIL)
						oTcBrowse:aArray[oTcBrowse:nAt][nPosTES] := cTes
						oTcBrowse:aArray[oTcBrowse:nAt][nPosCFO] := Posicione("SF4",1,xFilial("SF4")+ cTes,"F4_CF")
						// final das alteracoes
						
					EndIf
				ElseIf	oTcBrowse:ColPos() == nPosUM
					If 	ConPad1(,,,"SAH",,,.F.)
						oTcBrowse:aArray[oTcBrowse:nAt][nPosUM] := SAH->AH_UNIMED
					EndIf
				ElseIf	oTcBrowse:ColPos() == nPosUM2
					If 	ConPad1(,,,"SAH",,,.F.)
						oTcBrowse:aArray[oTcBrowse:nAt][nPosUM2] := SAH->AH_UNIMED
					EndIf
				ElseIf	oTcBrowse:ColPos() == nPosSeq
					clSeq := IIF(!Empty(oTcBrowse:aArray[oTcBrowse:nAt][nPosSeq]),SPACE(TAMSX3(cTabIEDI + "_SEQ")[1]),oTcBrowse:aArray[oTcBrowse:nAt][nPosSeq])
					lEditCell(@oTcBrowse:aArray,oTcBrowse,'@!',oTcBrowse:ColPos())
					If clSeq <> oTcBrowse:aArray[oTcBrowse:nAt][nPosSeq]
						lpNovoIte := .T.
//						SomaIte()
					Else
						lpNovoIte := .F.						
					EndIf					
				ElseIf oTcBrowse:ColPos() == nPosQt .Or. oTcBrowse:ColPos() == nPosPre 
					clBkpQtd := NumVirg(oTcBrowse:aArray[oTcBrowse:nAt][nPosQt],nPosQt)
					clBkpPre := NumVirg(oTcBrowse:aArray[oTcBrowse:nAt][nPosPre],nPosPre)
					lEditCell(@oTcBrowse:aArray,oTcBrowse,'@!',oTcBrowse:ColPos())
				   	clPreco := NumVirg(oTcBrowse:aArray[oTcBrowse:nAt][nPosPre] ,nPosPre)
				   	clPreco := STRTRAN(clPreco,".","")		   	
				   	clPreco := STRTRAN(clPreco,",",".")	   	
				   	clQtd   := NumVirg(oTcBrowse:aArray[oTcBrowse:nAt][nPosQt] ,nPosQt)
					clQtd   := STRTRAN(clQtd,".","")		   	
				   	clQtd 	:= STRTRAN(clQtd,",",".")	
				   	If AllTrim(clBkpQtd) <> AllTrim(NumVirg(clQtd,nPosQt)) .Or. AllTrim(clBkpPre) <> Alltrim(NumVirg(clPreco,nPosPre))
						oTcBrowse:aArray[oTcBrowse:nAt][nPosTot] := NumVirg(cValToChar(val(clPreco) * Val(clQtd)),nPosTot)
					EndIf
				// 24/10/2012	Veronica de Almeida
				// Alteracao para preenchimento dos campos TES e CFOP de acordo com o tipo de operacao informado
				ElseIf oTcBrowse:ColPos() == nPosOpe 
					If 	ConPad1(,,,"DJ",,,.F.)
						oTcBrowse:aArray[oTcBrowse:nAt][nPosOpe] := SX5->X5_CHAVE
						
						clOper 	:= oTcBrowse:aArray[oTcBrowse:nAt][nPosOpe]
						cCodPro := Posicione("SB1",5,xFilial("SB1")+oTcBrowse:aArray[oTcBrowse:nAt][nPosEAN],"B1_COD")
						//Retorna a Tes Inteligente a ser utilizada na geracao do pre-pedido 
						oTcBrowse:aArray[oTcBrowse:nAt][nPosTES] := MaTesInt(2,Alltrim(clOper),M->&(cCliFat),M->&(cLjFat),"C",cCodPro,NIL)
						oTcBrowse:aArray[oTcBrowse:nAt][nPosCFO] := Posicione("SF4",1,xFilial("SF4")+ oTcBrowse:aArray[oTcBrowse:nAt][nPosTES],"F4_CF")
						oTcBrowse:Refresh()
					EndIf	
				// final das alteracoes 
				
				Else
					lEditCell(@oTcBrowse:aArray,oTcBrowse,'@!',oTcBrowse:ColPos())
					If 		oTcBrowse:ColPos() == nPosDEn
						If Valtype(oTcBrowse:aArray[oTcBrowse:nAt][nPosDEn]) == 'C'
					   		oTcBrowse:aArray[oTcBrowse:nAt][nPosDEn] := cToD(oTcBrowse:aArray[oTcBrowse:nAt][nPosDEn])
					   	EndIf
					ElseIf  aScan(alPos,oTcBrowse:ColPos()) > 0
						oTcBrowse:aArray[oTcBrowse:nAt][oTcBrowse:ColPos()]  := NumVirg(oTcBrowse:aArray[oTcBrowse:nAt][oTcBrowse:ColPos()],oTcBrowse:ColPos())	
					ElseIf  oTcBrowse:ColPos() == nPosSeq
						If 	oTcBrowse:aArray[oTcBrowse:nAt][nPosSeq] <> "001"
							oTcBrowse:aArray[oTcBrowse:nAt][nPosIte] := "0001"
						Else
							If oTcBrowse:nAt > 1
								If 		oTcBrowse:aArray[(oTcBrowse:nAt-1)][nPosSeq] == oTcBrowse:aArray[oTcBrowse:nAt][nPosSeq]
									oTcBrowse:aArray[oTcBrowse:nAt][nPosIte] := Soma1(oTcBrowse:aArray[(oTcBrowse:nAt-1)][nPosIte])
								Else
									oTcBrowse:aArray[oTcBrowse:nAt][nPosIte] := Soma1(oTcBrowse:aArray[(oTcBrowse:nAt-1)][nPosIte])
								EndIf	
							EndIf
						EndIf
					EndIf
				EndIf 
			EndIf	 
		EndIf	 
		ValidTc()
		For nlX := 1 to Len(oTcBrowse:aArray)
//			If oTcBrowse:aArray[nlX][nPosSeq] == '001'
				If 		AT(".",oTcBrowse:aArray[nlX][nPosTot]) > 0 .AND. AT(",",oTcBrowse:aArray[nlX][nPosTot]) > 0
					nlValTot := STRTRAN(oTcBrowse:aArray[nlX][nPosTot],".","")
					nlValTot := STRTRAN(nlValTot,",",".")
				ElseIf	AT(",",oTcBrowse:aArray[nlX][nPosTot]) > 0
					nlValTot := STRTRAN(oTcBrowse:aArray[nlX][nPosTot],",",".")
				EndIf
				If 		AT(".",oTcBrowse:aArray[nlX][nPosDco+1]) > 0 .AND. AT(",",oTcBrowse:aArray[nlX][nPosDco+1]) > 0
					nlValDes := STRTRAN(oTcBrowse:aArray[nlX][nPosDco+1],".","")
					nlValDes := STRTRAN(nlValDes,",",".")
				ElseIf	AT(",",oTcBrowse:aArray[nlX][nPosDco+1]) > 0
					nlValDes := STRTRAN(oTcBrowse:aArray[nlX][nPosDco+1],",",".")
				EndIf				
				nlValDes := VAL(nlValDes)				
				nlValTot := VAL(nlValTot)
				nlTotal  += (nlValTot-nlValDes)
//			EndIf
			
			
			If 		AT(".",oTcBrowse:aArray[nlX][nPosVFr]) > 0 .AND. AT(",",oTcBrowse:aArray[nlX][nPosVFr]) > 0
				nlFrete := STRTRAN(oTcBrowse:aArray[nlX][nPosVFr],".","")
				nlFrete := STRTRAN(nlFrete,",",".")
			ElseIf	AT(",",oTcBrowse:aArray[nlX][nPosVFr]) > 0
				nlFrete := STRTRAN(oTcBrowse:aArray[nlX][nPosVFr],",",".")
			EndIf 			    
 			nlTotFre += Val(nlFrete)		
				
		Next nlX
		M->&(cTabEDI + "_TOTAL")  := nlTotal
		M->&(cTabEDI + "_TOTFRT") := nlTotFre			
		oMsMGet:Refresh()		
	EndIf	
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ DescErro	     บAutor  ณRodrigo A. Tosin	  บData  ณ 24/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para descrever o erro no pedido de venda EDI		  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณclCampo,clErro			   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil														   	  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/ 
Static Function DescErro(nlLinha,clCampo,clErro,llDel)
	Local nPos	:= 0
		  
	If !llDel 
		nPos  := aScan(oGetDados:aCols, {|x| x[1] == cpItem .AND. x[2] == nlLinha .AND. NoAcento(ALLTRIM(UPPER(x[3]))) == NoAcento(ALLTRIM(UPPER(clCampo))) .AND. NoAcento(ALLTRIM(UPPER(x[4]))) == NoAcento(ALLTRIM(UPPER(clErro))) })						   		  
   		If nPos == 0	
			If 	   		!Empty(oGetDados:aCols[Len(oGetDados:aCols)][1]); 
		   		.AND. 	!Empty(oGetDados:aCols[Len(oGetDados:aCols)][2]);
		   		.AND. 	!Empty(oGetDados:aCols[Len(oGetDados:aCols)][3]); 
		   		.AND. 	!Empty(oGetDados:aCols[Len(oGetDados:aCols)][4])
		   		 		   		
				AADD(oGetDados:aCols,Array(Len(aNGDHead)+1)) 
				
			EndIf
			oGetDados:aCols[Len(oGetDados:aCols)][1]					:= cpItem
			oGetDados:aCols[Len(oGetDados:aCols)][2]					:= nlLinha
			oGetDados:aCols[Len(oGetDados:aCols)][3]					:= UPPER(clCampo)
			oGetDados:aCols[Len(oGetDados:aCols)][4]					:= UPPER(clErro) 
			oGetDados:aCols[Len(oGetDados:aCols)][Len(aNGDHead)+1]		:= llDel
		EndIf
	Else
		nPos  := aScan(oGetDados:aCols, {|x|  x[1] == cpItem .AND. x[2] == nlLinha .AND. NoAcento(ALLTRIM(UPPER(x[3]))) == NoAcento(ALLTRIM(UPPER(clCampo))) .AND. NoAcento(ALLTRIM(UPPER(x[4]))) == NoAcento(ALLTRIM(UPPER(clErro))) })						   		  		
   		If nPos > 0
   			aDel(oGetDados:aCols,nPos)
   			aSize(oGetDados:aCols,Len(oGetDados:aCols)-1)
   			If Len(oGetDados:aCols) == 0
				AADD(oGetDados:aCols,Array(Len(aNGDHead)+1))
	 			oGetDados:aCols[Len(oGetDados:aCols)][Len(aNGDHead)+1]		:= .F.
//	 			oGetDados:aCols[Len(oGetDados:aCols)][1] 					:= ''
	 			oGetDados:aCols[Len(oGetDados:aCols)][2] 					:= 0	 				 						
			EndIf	    			   			
   		EndIf   		
    EndIf
	oGetDados:Refresh()
	
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ ExcItem	     บAutor  ณRodrigo A. Tosin	  บData  ณ 24/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para excluir item do pedido EDI					  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil														   	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil														   	  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/
Static Function ExcItem()
	Local nX 		:= 1  
    Local nPosNGD	:= 0
// 	Local nPosEDI	:= aScan(aCampos, cTabIEDI + "_NUMEDI") 
// 	Local nPosRev	:= aScan(aCampos, cTabIEDI + "_REVISA")  	
 	Local nPosEAN	:= aScan(aCampos, cTabIEDI + "_EAN")
//	Local nPosCli	:= aScan(aCampos, cTabIEDI + "_CLIFAT")
//	Local nPosLoj	:= aScan(aCampos, cTabIEDI + "_LJFAT")		
	Local nPosIte	:= aScan(aCampos, cTabIEDI + "_ITEM")	
	Local nPosPro	:= aScan(aCampos, cTabIEDI + "_PRODUT")
    Local clQuery 	:= ""
        
    If !lRet2
		oTcBrowse:SetFocus()
		If Len(oTcBrowse:aArray) <> 0
            If Len(oTcBrowse:aArray) > 1
            
                aADD(apExcl,oTcBrowse:aArray[oTcBrowse:nAt])
                
				aDel(oTcBrowse:aArray,oTcBrowse:nAt)
				aSize(oTcBrowse:aArray,(Len(oTcBrowse:aArray)-1))
				/*					
				nPosNGD := aScan(oGetDados:aCols,{|x| x[1] == oTcBrowse:aArray[oTcBrowse:nAt][nPosIte] })	
				While nPosNGD > 0
					aDel(oGetDados:aCols,nPosNGD)
					aSize(oGetDados:aCols,(Len(oGetDados:aCols)-1))
					nPosNGD := aScan(oGetDados:aCols,{|x| x[1] == oTcBrowse:aArray[oTcBrowse:nAt][nPosIte] })	
					oGetDados:Refresh()			
					If Len(oGetDados:aCols) == 0
						AADD(oGetDados:aCols,Array(Len(aNGDHead)+1))
						oGetDados:aCols[1][1] := ''
						oGetDados:aCols[1][2] := 0
						oGetDados:aCols[1][3] := ''
						oGetDados:aCols[1][4] := ''
						oGetDados:aCols[1][5] := .F.
					EndIf
				EndDo
				*/
				oGetDados:aCols := {{"",0,"","",.F.}}
			Else
				ShowHelpDlg("ฺnico",{"Nใo ้ permitido excluir o ๚ltimo item de um pedido EDI."},5,{"Adicione outro item e exclua a linha que deseja."},5)    						
			EndIf	
			If Len(oTcBrowse:aArray) == 0
				aAdd(oTcBrowse:aArray,Array(Len(aHeader)))
				aArray[Len(aArray)][1] := '4'
				For nX:= 3 To Len(aCampos)
					aArray[Len(aArray)][2]		 := '001'
					If 	  Alltrim(aCampos[nX]) == cTabIEDI + "_DESCRI"
						aArray[Len(aArray)][nX] := TRANSFORM((cZAEZAF)->B1_DESC,aPictures[nX])	
						Loop
					ElseIf aCampos[nX] == ALLTRIM(cTabIEDI + '_DTENT')
						aArray[Len(aArray)][nX] := TRANSFORM(stoD((cZAEZAF)->&(cTabIEDI + "_DTENT")),aPictures[nX])	
					Else
				   		aArray[Len(aArray)][nX] := TRANSFORM(&(cZAEZAF + "->"+Alltrim(aCampos[nX])),aPictures[nX])						
					EndIf
				Next nX
			EndIf
            /*
	 		For nX := 1 to Len(oGetDados:aCols)	
	 			If ValType(oGetDados:aCols[nX][1]) == "N"
					If oGetDados:aCols[nX][1] > oTcBrowse:nAt
						oGetDados:aCols[nX][1] -= 1
					EndIf
				EndIf			
			Next nX
			*/		
		EndIf
	EndIf	
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ GeraPed	     บAutor  ณRodrigo A. Tosin	  บData  ณ 27/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para incluir Pedido EDI							  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil														   	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil														   	  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/
Static Function GeraPed()
	Local alArea 	:= GetArea()
	Local clNum 	:= ''
	Local alPVEstr 	:= {} 
	Local nlX 		:= 1		
	Local clSeq 	:= ""
	Local nlPosPr	:= aScan(aCampos, ALLTRIM(cTabIEDI + "_PRODUTO"))	
	Local nlPos		:= 0
	Local clItem	:= '0001'
	Local nlPosPU	:= aScan(aCampos, ALLTRIM(cTabIEDI + "_PRCUNI"))	
	Local nlPosQt	:= aScan(aCampos, ALLTRIM(cTabIEDI + "_QTD"))
	Local nlPosTo	:= aScan(aCampos, ALLTRIM(cTabIEDI + "_TOTAL"))
/*	Local nPosEDI	:= aScan(aCampos, ALLTRIM(cTabIEDI + "_NUMEDI"))
	Local nPosCli	:= aScan(aCampos, ALLTRIM(cTabIEDI + "_CLIFAT"))
	Local nPosLoj	:= aScan(aCampos, ALLTRIM(cTabIEDI + "_LJFAT"))
*/	
	Local nPosIte	:= aScan(aCampos, ALLTRIM(cTabIEDI + "_ITEM"))
	Local nPosFre	:= aScan(aCampos, ALLTRIM(cTabIEDI + "_VLRFRT"))	
	Local nPosDco	:= aScan(aCampos, cTabIEDI + "_VLRDES")				
	Local clProd	:= ""		
	Local llRet		:= .T.
	Local nPosSeq	:= aScan(aCampos, ALLTRIM(cTabIEDI + "_SEQ"))
	Local nlCont	:= 1
	Local nSomaTot	:= 0	
    Local clCliente	:= ""
    Local alParcel	:= {}
    Local nlValPar	:= 0

	Local clQuery 	:= ""
	Local nlTam		:= TAMSX3(cTabEDI + "_USRALT")[1]
	Local nlValTot	:= 0
	Local nlValDes	:= 0
	Local nlFrete	:= 0	
	Local nlTotFre	:= 0
	Local alIncons	:= {}
	Local clCli		:= M->&(cTabEDI + "_CLIFAT")
	Local clLoja	:= M->&(cTabEDI + "_LJFAT")	
//	Private cpMsg	:= "Pedido EDI: " + cpGetEDI + CRLF + "Pedidos EDI gerados: "
	 	
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณOrganiza itens do pedido de venda EDI em ordem crescente para geracao dos novos pedidos EDI													   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
	oTcBrowse:aArray	:= aSort(oTcBrowse:aArray,,,{|x,y| x[nPosSeq] <= y[nPosSeq]})	
	
	clNum := ((cTabEDI)->&(cTabEDI + "_NUMEDI"))
		
	If llRet
		BEGIN TRANSACTION
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณExclui os itens do pedido atual para efetuar as alteracoes e inclusoes corretamente.									   						   ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
            
/*
			For nlX := 1 to Len(oTcBrowse:aArray)
				ExcPeIte(oTcBrowse:aArray[nlX])
			Next nlX

			For nlX := 1 to Len(apExcl)
				ExcPeIte(apExcl[nlX])
			Next nlX
*/						
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณCodigo do Cliente + Loja do Cliente																					   						   ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	 	   	 
			clCliente := clCli + clLoja
				 	   	
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณApaga itens para nao ter problema de duplicacao de sequencia.																													   ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	       ApagaItens(clNum,clCli,clLoja)

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณGrava itens no pedido EDI.																													   ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			clSeq  := oTcBrowse:aArray[1][nPosSeq]

	 	   	For nlX := 1 to Len(oTcBrowse:aArray)
	 	   	
/*              If oTcBrowse:aArray[nlX][nPosSeq]	<> clSeq
                	clItem := '0001'
                EndIf  */
                
                clItem := oTcBrowse:aArray[nlX][nPosIte]
                
				ItemPed(clNum,clItem, oTcBrowse:aArray[nlX] )
				clSeq:= oTcBrowse:aArray[nlX][nPosSeq]
				
				If 		AT(".",oTcBrowse:aArray[nlX][nlPosTo]) > 0 .AND. AT(",",oTcBrowse:aArray[nlX][nlPosTo]) > 0
					nlValTot := STRTRAN(oTcBrowse:aArray[nlX][nlPosTo],".","")
					nlValTot := STRTRAN(nlValTot,",",".")
				ElseIf	AT(",",oTcBrowse:aArray[nlX][nlPosTo]) > 0
					nlValTot := STRTRAN(oTcBrowse:aArray[nlX][nlPosTo],",",".")
				EndIf
				If 		AT(".",oTcBrowse:aArray[nlX][nPosDco]) > 0 .AND. AT(",",oTcBrowse:aArray[nlX][nPosDco]) > 0
					nlValDes := STRTRAN(oTcBrowse:aArray[nlX][nPosDco],".","")
					nlValDes := STRTRAN(nlValDes,",",".")
				ElseIf	AT(",",oTcBrowse:aArray[nlX][nPosDco]) > 0
					nlValDes := STRTRAN(oTcBrowse:aArray[nlX][nPosDco],",",".")
				EndIf				
				nlValDes := VAL(nlValDes)				
				nlValTot := VAL(nlValTot)
				nSomaTot += (nlValTot-nlValDes)

				If 		AT(".",oTcBrowse:aArray[nlX][nPosFre]) > 0 .AND. AT(",",oTcBrowse:aArray[nlX][nPosFre]) > 0
					nlFrete := STRTRAN(oTcBrowse:aArray[nlX][nPosFre],".","")
					nlFrete := STRTRAN(nlFrete,",",".")
				ElseIf	AT(",",oTcBrowse:aArray[nlX][nPosFre]) > 0
					nlFrete := STRTRAN(oTcBrowse:aArray[nlX][nPosFre],",",".")
				EndIf 			    
 				nlTotFre += Val(nlFrete)   	
//				clItem 							:= Soma1(clItem)
				nlValTot 						:= 0
				nlValDes						:= 0				 						 	   	
	 	   	Next nlX
	 	   	
			M->&(cTabEDI + "_USRAPR") 		:= ""
			M->&(cTabEDI + "_DTAPRV") 		:= cToD("  /  /  ")
			M->&(cTabEDI + "_HRAPRV") 		:= ""
			M->&(cTabEDI + "_JTAPRV")  		:= ""
			M->&(cTabEDI + "_TOTAL")  		:= nSomaTot
	 	   	M->&(cTabEDI + "_TOTFRT") 		:= nlTotFre
	 	   	
	 	   	CabePed(clNum,clCliente)
	 	   	
			U_ExIncons(	clNum,clCli,clLoja )	 	   	
 	   		alIncons := U_KZNCG24({	{	clNum,clCli,clLoja	}	})
 	   		If Len(alIncons) > 0 
				If Reclock(cTabEDI,(cTabEDI)->(!dbSeek(xFilial(cTabEDI) + clNum + clCliente)))
			   		(cTabEDI)->&(cTabEDI + "_STATUS") := alIncons[1][4]
			   		(cTabEDI)->(MsUnlock())
				EndIf
			EndIf
  			
		END TRANSACTION
	EndIf		
	RestArea(alArea)
Return llRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ CabePed	     บAutor  ณRodrigo A. Tosin	  บData  ณ 27/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para incluir Pedido EDI							  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณclNum  	- Numero do Pedido EDI		   						  บฑฑ
ฑฑบ			 ณclCliente - Codigo + Loja do Cliente	  					   	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil														   	  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/
Static Function CabePed(clNum,clCliente) 
	Local alArea 	:= GetArea()
	Local alEstrut  := (cTabEDI)->(dbStruct())
	Local clFilial  := xFilial(cTabEDI) 
	Local nlX		:= 1    
	Local llRet		:= .T.
	Local nlTam		:= TAMSX3(cTabEDI + "_USRALT")[1]
	
	(cTabEDI)->(dbSetOrder(1))	
	(cTabEDI)->(dbGoTop())
			
	If Reclock(cTabEDI,(cTabEDI)->(!dbSeek(clFilial + clNum + clCliente)))
		For nlX := 1 to Len(alEstrut)
			(cTabEDI)->&(alEstrut[nlX][1]) := M->&(alEstrut[nlX][1])
		Next nlX
		(cTabEDI)->&(cTabEDI + "_NUMEDI")  := clNum 
		(cTabEDI)->&(cTabEDI + "_USRALT")  := SUBSTR(cUserName,1,nlTam)
		(cTabEDI)->&(cTabEDI + "_DTAALT")  := dDataBase
		(cTabEDI)->(MsUnlock())
    EndIf
	RestArea(alArea)    
Return llRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ ItemPed	     บAutor  ณRodrigo A. Tosin	  บData  ณ 27/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para incluir Pedido EDI							  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณclNum  - Numero do Pedido EDI		   							  บฑฑ
ฑฑบ			 ณclItem - Numero do Item do Pedido EDI	  					   	  บฑฑ
ฑฑบ			 ณaItem	 - Array com informacoes do item do pedido EDI		   	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil														   	  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/
Static Function ItemPed(clNum,clItem,aItem)
	Local alArea	:= GetArea()
	Local clFilial  := xFilial(cTabIEDI) 
//	Local nPosRev	:= aScan(aCampos, ALLTRIM(cTabIEDI + "_REVISA"))
	Local nlX		:= 1
	Local nlPosPU	:= aScan(aCampos, cTabIEDI + "_PRCUNI")	
	Local nlPosQt	:= aScan(aCampos, cTabIEDI + "_QTD")
	Local nlPosTo	:= aScan(aCampos, cTabIEDI + "_TOTAL")
	Local nPosIPI	:= aScan(aCampos, cTabIEDI + "_PERCIP")
	Local nPosQtd2	:= aScan(aCampos, cTabIEDI + "_QTD2")
	Local nPosVDe	:= aScan(aCampos, cTabIEDI + "_VLRDES")
	Local nPosDes	:= 0
	Local nPosPeI	:= aScan(aCampos, cTabIEDI + "_PERCIP")
	Local nPosVIP	:= aScan(aCampos, cTabIEDI + "_VLRIPI")
	Local nPosVDS	:= aScan(aCampos, cTabIEDI + "_VLRDSP")
	Local nPosVSe	:= aScan(aCampos, cTabIEDI + "_VLRSEG")
	Local nPosVFr	:= aScan(aCampos, cTabIEDI + "_VLRFRT")	
	Local nPosPIC	:= aScan(aCampos, cTabIEDI + "_PERIC")		
	Local nPosVIC	:= aScan(aCampos, cTabIEDI + "_VLRICM")	
	Local alPosN	:= {}                     
	Local nPosDEn	:= aScan(aCampos, cTabIEDI + "_DTENT")
//	Local nPosCli	:= aScan(aCampos, cTabIEDI + "_CLIFAT")
//	Local nPosLj	:= aScan(aCampos, cTabIEDI + "_LJFAT")
	Local nPosCpr	:= aScan(aCampos, cTabIEDI + "_PRODUT")
	Local nPosIte	:= aScan(aCampos, cTabIEDI + "_ITEM")
	Local nlPosSeq	:= aScan(aCampos, cTabIEDI + "_SEQ") 
	Local clSeq		:= ""			
	Local clRev		:= ""
	Local clCli		:= ""
	Local clLoja	:= ""
	Local clProdut	:= ""	
	Local clQuery	:= ""
	Local llRec		:= .F.
	Local clValor   := ""
	Local nlValor   := 0
		
	nPosDes 		:= nPosVDe - 1
	alPosN	   		:= {nlPosPU,nlPosQt,nlPosTo,nPosIPI,nPosQtd2,nPosVDe,nPosDes,nPosPeI,nPosVIP,nPosVDS,nPosVSe,nPosVFr,nPosPIC,nPosVIC}   
	
	clNum			:= M->&(cTabEDI + "_NUMEDI") 
	clCli 			:= M->&(cTabEDI + "_CLIFAT")
	clLoja 			:= M->&(cTabEDI + "_LJFAT")
	clProdut        := PADR(aItem[nPosCpr]	,TAMSX3(cTabIEDI + "_PRODUT"	)[1])
	clSeq           := PADR(aItem[nlPosSeq]	,TAMSX3(cTabIEDI + "_SEQ"		)[1]) 
	
	clQuery := "SELECT R_E_C_N_O_ as ZAFRECNO FROM " + RetSQLName(cTabIEDI) 					+ CRLF
	clQuery += " WHERE 	" + cTabIEDI + "_FILIAL 	= '" + clFilial	+ "'"			+ CRLF
	clQuery += " 	AND " + cTabIEDI + "_NUMEDI 	= '" + clNum	+ "'"			+ CRLF
	clQuery += " 	AND " + cTabIEDI + "_CLIFAT		= '" + clCli 	+ "'"			+ CRLF
	clQuery += " 	AND " + cTabIEDI + "_LJFAT 		= '" + clLoja 	+ "'"			+ CRLF
	clQuery += " 	AND " + cTabIEDI + "_SEQ 		= '" + clSeq 	+ "'"			+ CRLF	
	clQuery += " 	AND " + cTabIEDI + "_ITEM 		= '" + clItem 	+ "'"			+ CRLF
	clQuery += " 	AND " + cTabIEDI + "_PRODUT 	= '" + clProdut	+ "'"			+ CRLF	
	clQuery += " 	AND D_E_L_E_T_ 					<> '*'"

	clQuery := ChangeQuery(clQuery)	
	
	If Select("ZAFQRY") > 0
		ZAFQRY->(dbCloseArea())
	EndIf
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), "ZAFQRY",.T.,.F.)		
	
	dbSelectArea(cTabIEDI)   
	
    If ZAFQRY->(EOF())
    	llRec := .T.
    Else
    	llRec := .F.
    	
		(cTabIEDI)->(dbSetOrder(1))
		(cTabIEDI)->(dbGoTop())
		(cTabIEDI)->(dbGoTo(ZAFQRY->ZAFRECNO))		    	
    EndIf
			
	If RecLock(cTabIEDI, llRec)
		(cTabIEDI)->&(cTabIEDI + "_FILIAL") := clFilial
		(cTabIEDI)->&(cTabIEDI + "_NUMEDI") := clNum
		(cTabIEDI)->&(cTabIEDI + "_CLIFAT") := clCli
		(cTabIEDI)->&(cTabIEDI + "_LJFAT")  := clLoja
		(cTabIEDI)->&(cTabIEDI + "_SEQ")    := clSeq						
		For nlX := 4 to Len(aHeader)
			If 		aScan(alPosN,nlX) > 0 

				If 		AT(".",aItem[nlX]) > 0 .AND. AT(",",aItem[nlX]) > 0
					clValor := STRTRAN(aItem[nlX],".","")
					clValor := STRTRAN(clValor,",",".")
				ElseIf	AT(",",aItem[nlX]) > 0
					clValor := STRTRAN(aItem[nlX],",",".")
				EndIf 			    
 				nlValor := Val(clValor)
 				
 				(cTabIEDI)->&(aCampos[nlX]) := nlValor									
			ElseIf 	nlX == nPosDEn
				If ValType(aItem[nlX]) == 'C'
					(cTabIEDI)->&(aCampos[nlX]) := cToD(aItem[nlX])
				Else
					(cTabIEDI)->&(aCampos[nlX]) := aItem[nlX]				
				EndIf	
			Else
				(cTabIEDI)->&(aCampos[nlX]) := aItem[nlX]
			EndIf
		Next nlX
		(cTabIEDI)->&(cTabIEDI + "_ITEM") := clItem		
	EndIf
	(cTabIEDI)->(MsUnlock())
	
    RestArea(alArea)
Return 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ ExcPeIte	     บAutor  ณRodrigo A. Tosin	  บData  ณ 01/06/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para excluir item do Pedido EDI					  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณaItem	 - Array com informacoes do item do pedido EDI		   	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil														   	  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/
Static Function ExcPeIte(aArray)
	Local clQuery 	:= ""
	Local nlPosPr 	:= aScan(aCampos,cTabIEDI + "_PRODUT")
	Local nlPosIt 	:= aScan(aCampos,cTabIEDI + "_ITEM")
	
	If aArray[nlPosPr] 	== Nil
		aArray[nlPosPr] := ''
	EndIf
		
	clQuery := "SELECT R_E_C_N_O_ FROM " + RetSQLName(cTabIEDI) 							   				+ CRLF
	clQuery += " WHERE 	" + cTabIEDI + "_FILIAL 	= '" + xFilial(cTabIEDI)	+ "'"		   	  	 		+ CRLF
	clQuery += " 	AND " + cTabIEDI + "_NUMEDI 	= '" + M->&(cTabEDI + "_NUMEDI") 		+ "'"			+ CRLF
	clQuery += " 	AND " + cTabIEDI + "_CLIFAT		= '" + M->&(cTabEDI + "_CLIFAT")  		+ "'"			+ CRLF
	clQuery += " 	AND " + cTabIEDI + "_LJFAT 		= '" + M->&(cTabEDI + "_LJFAT") 		+ "'"			+ CRLF
	clQuery += " 	AND " + cTabIEDI + "_ITEM		= '" + aArray[nlPosIt]  	   			+ "'"			+ CRLF	
	clQuery += " 	AND " + cTabIEDI + "_PRODUT		= '" + aArray[nlPosPr] 	  				+ "'"			+ CRLF	
	clQuery += " 	AND D_E_L_E_T_ 					<> '*'"

	clQuery := ChangeQuery(clQuery)	
	
	If Select("ZAFQRY") > 0
		ZAFQRY->(dbCloseArea())
	EndIf
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), "ZAFQRY",.T.,.F.)		
	
	dbSelectArea(cTabIEDI)   
	
    While ZAFQRY->(!EOF())
		(cTabIEDI)->(dbSetOrder(1))
		(cTabIEDI)->(dbGoTop())
		(cTabIEDI)->(dbGoTo(ZAFQRY->R_E_C_N_O_))
		If RecLock(cTabIEDI,.F.)
			(cTabIEDI)->(dbDelete())
		EndIf
		(cTabIEDI)->(MsUnlock())
		ZAFQRY->(dbSkip()) 
    EndDo
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณNoAcento		 บAutor  ณRodrigo A. Tosin	  บ Data ณ 28/05/2012  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que troca as letras sem acento por letras normais 		   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณArg1 - Palavra que contem acento								   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณclString						                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NoAcento(Arg1)
	
	Local nConta 	:= 0
	Local cLetra 	:= ""
	Local cRet 		:= ""
	
	Arg1 := Upper(Arg1)
	For nConta:= 1 To Len(Arg1)
		cLetra := SubStr(Arg1, nConta, 1)
		Do Case
			Case (Asc(cLetra) > 191 .and. Asc(cLetra) < 198) .Or.(Asc(cLetra) > 223 .and. Asc(cLetra) < 230)
				cLetra := "A"
			Case (Asc(cLetra) > 199 .and. Asc(cLetra) < 204) .Or.(Asc(cLetra) > 231 .and. Asc(cLetra) < 236)
				cLetra := "E"  
			Case (Asc(cLetra) > 204 .and. Asc(cLetra) < 207) .Or.(Asc(cLetra) > 235 .and. Asc(cLetra) < 240)
				cLetra := "I"
			Case (Asc(cLetra) > 209 .and. Asc(cLetra) < 215) .Or.(Asc(cLetra) == 240) .or. (Asc(cLetra) > 241 .and. Asc(cLetra) < 247)
				cLetra := "O"
			Case (Asc(cLetra) > 216 .and. Asc(cLetra) < 221) .Or.(Asc(cLetra) > 248 .and. Asc(cLetra) < 253)
				cLetra := "U"
			Case Asc(cLetra) == 199 .or. Asc(cLetra) == 231
				cLetra := "C"
		EndCase
		cRet += cLetra
	Next
Return UPPER(cRet) 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณNumVirg		 บAutor  ณRodrigo A. Tosin	  บ Data ณ 06/06/2012  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que valida string de numero							   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณulNum - Variavel que contem string de numero					   บฑฑ
ฑฑบ			 ณnPos  - Posicao da coluna da TcBrowse			   				   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณclNum - Variavel que contem o numero com picture                 บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NumVirg(ulNum,nPos)
	Local clNum 	:= 0
	Local clSubs	:= ""
	Local nPosQt	:= aScan(aCampos, cTabIEDI + "_QTD")
	Local nPosQt2	:= aScan(aCampos, cTabIEDI + "_QTD2")
	
	clSubs 	:= STRTRAN(ulNum,"-","") 
			
	If nPos == nPosQt .OR. nPos == nPosQt2
		If 		At(",",ulNum) > 0 .AND. At(".",ulNum) > 0
			clSubs 	:= STRTRAN(ulNum,".","")
			clSubs 	:= STRTRAN(clSubs,",",".")
		ElseIf 	At(",",ulNum) > 0
			clSubs := STRTRAN(ulNum,",",".")
		Else
			clSubs := TRANSFORM(Val(clSubs)	,aPictures[nPos])
			clSubs 	:= STRTRAN(clSubs,".","")
			clSubs 	:= STRTRAN(clSubs,",",".")
		EndIf		
		clSubs := SUBSTR(clSubs,1,(AT(".",clSubs)-1))
		clSubs := Val(clSubs)			
		clNum  := TRANSFORM(clSubs,aPictures[nPos])
	Else
		If At(",",ulNum) > 0 .AND. At(".",ulNum) > 0
			clSubs 	:= STRTRAN(ulNum,".","")
			clSubs 	:= STRTRAN(clSubs,",",".")
			clNum	:=	TRANSFORM(VAL(clSubs),aPictures[nPos])	
		ElseIf At(".",ulNum) > 0
		 	clNum	:=	TRANSFORM(VAL(clSubs),aPictures[nPos])	
		ElseIf At(",",ulNum) > 0
			clSubs := STRTRAN(ulNum,",",".")	
			clNum	:=	TRANSFORM(VAL(clSubs),aPictures[nPos])
		Else
			clNum	:= 	TRANSFORM(VAL(clSubs),aPictures[nPos])
		EndIf
	 
	EndIf

Return clNum
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณExIncons		 บAutor  ณRodrigo A. Tosin	  บ Data ณ 06/06/2012  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que valida string de numero							   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณclPedido 	- Numero do pedido EDI 								   บฑฑ
ฑฑบ			 ณclCliente - Codigo do Cliente de FAturamento 					   บฑฑ
ฑฑบ			 ณclLoja	- Loja do Cliente de FAturamento					   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil												               บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ExIncons(clPedido,clCliente,clLoja)
	Local clQuery := ""

	clQuery := "SELECT R_E_C_N_O_ FROM " + RetSQLName("ZAG")
	clQuery += " WHERE 	ZAG_FILIAL = '" + xFilial("ZAG") 	+ "'" 	+ CRLF
	clQuery += " 	AND ZAG_NUMEDI = '" + clPedido 			+ "'" 	+ CRLF
	clQuery += " 	AND ZAG_CLIFAT = '" + clCliente 		+ "'" 	+ CRLF
	clQuery += " 	AND ZAG_LJFAT  = '" + clLoja 			+ "'" 	+ CRLF
	clQuery += " 	AND D_E_L_E_T_  <> '*'" 						+ CRLF
	clQuery := ChangeQuery(clQuery)	
	
	If Select("ZAGQRY") > 0
		ZAGQRY->(dbCloseArea())
	EndIf
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), "ZAGQRY",.T.,.F.)
	
	dbSelectArea("ZAG")   
	
    While ZAGQRY->(!EOF())
		ZAG->(dbSetOrder(1))
		ZAG->(dbGoTop())
		ZAG->(dbGoTo(ZAGQRY->R_E_C_N_O_))
		If RecLock('ZAG',.F.)
			ZAG->(dbDelete())
		EndIf
		ZAG->(MsUnlock())
		ZAGQRY->(dbSkip()) 
    EndDo
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณSomaIte		 บAutor  ณRodrigo A. Tosin	  บ Data ณ 19/06/2012  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que inclui valida codigo do item do pedido EDI			   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณnlLiAtual - Linha da TcBrowse onde esta posicionado			   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil											                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SomaIte(nlLiAtual)
/*	Local clSeq 	:= ""
	Local nPosSeq	:= aScan(aCampos, cTabIEDI + "_SEQ")
	Local nlX 		:= 1
	Local nlCont	:= 0
	Local nlUltimo	:= 0
*/	
	Local nPosIte	:= aScan(aCampos, cTabIEDI + "_ITEM") 
	Local alArray	:= {}
	Local clItem 	:= ""
	Local clItTab	:= ""
	Local clVlMxIt	:= ""
	Local clQuery 	:= ""
		
	Default nlLiAtual := oTcBrowse:nAt
	
	If lpNovoIte
		// Se for um item ja existente de importa็ใo mantem o valor atual da coluna item
		If Empty(oTcBrowse:aArray[nlLiAtual][nPosIte])
			// Relaliza copia do array da TC Browse para um array local para manipula็ใo 
			alArray := aClone(oTcBrowse:aArray)
			// Ordena de forma Decrescente pela coluna de ITEM
			aSort(alArray,,,{|x,y| x[nPosIte] > y[nPosIte]})
			// Caputura o numero maior de itens e soma1 para o item novo 
			clItem := Soma1(alArray[1][nPosIte])	      
			
			// Realizar Busca para Saber o prox sequencial disponivel pelos arquivos importados.ด
			clQuery :=	" Select MAX(ZAK_ITEM) as ITMAX														" +CRLF
			clQuery +=	"				From " + RetSqlName("ZAJ") + " ZAJ "								  +CRLF
			clQuery +=	"					Inner join " + RetSqlName("ZAK") + " ZAK "						  +CRLF
			clQuery +=	"					ON ZAK_NUMALT = ZAJ_NUMALT										" +CRLF
			clQuery +=	"					Where 				  											" +CRLF
			
			clQuery +=	"					ZAJ.D_E_L_E_T_ <> '*'											" +CRLF
			clQuery +=	"					AND ZAJ_FILIAL = '"+xFilial("ZAJ")+"'							" +CRLF
			clQuery +=	"					AND ZAK.D_E_L_E_T_ <> '*'										" +CRLF
			clQuery +=	"					AND ZAK_FILIAL = '"+xFilial("ZAK")+"'							" +CRLF
			
			clQuery +=	"					AND ZAJ_NUMCLI = '"+ZAE->ZAE_NUMCLI+"'							" +CRLF
			clQuery +=	"					AND ZAJ_NUMEDI = '"+ZAE->ZAE_NUMEDI+"'							" +CRLF			
			clQuery +=	"					AND ZAJ_CLIFAT = '"+ZAE->ZAE_CLIFAT+"'							" +CRLF
			clQuery +=	"					AND ZAJ_LJFAT = '"+ZAE->ZAE_LJFAT+"'							" +CRLF
			clQuery +=	"					AND ZAJ_STATUS = '2'											" +CRLF
			clQuery +=	"					AND ZAJ_DTAALT = (												" +CRLF
			clQuery +=	"										Select MAX(ZAJ_DTAALT) From " + RetSqlName("ZAJ")		  +CRLF
			clQuery +=	"										Where 													" +CRLF
			clQuery +=	"											ZAJ.D_E_L_E_T_ <> '*'								" +CRLF
			clQuery +=	"											AND ZAJ_FILIAL = '"+xFilial("ZAJ")+"'				" +CRLF
			clQuery +=	"											AND ZAJ_NUMCLI = '"+ZAE->ZAE_NUMCLI+"'				" +CRLF
			clQuery +=	"											AND ZAJ_CLIFAT = '"+ZAE->ZAE_CLIFAT+"'				" +CRLF
			clQuery +=	"											AND ZAJ_LJFAT = '"+ZAE->ZAE_LJFAT+"'				" +CRLF
			clQuery +=	"											AND ZAJ_NUMEDI = '"+ZAE->ZAE_NUMEDI+"'				" +CRLF				
			clQuery +=	"											AND ZAJ_STATUS = '2'								" +CRLF
			clQuery +=	"									 )					   										" +CRLF
			clQuery +=	"					AND ZAJ_HORALT = (															" +CRLF
			clQuery +=	"										Select MAX(ZAJ_HORALT) From " + RetSqlName("ZAJ")		  +CRLF
			clQuery +=	"										Where 					  								" +CRLF
			clQuery +=	"											ZAJ.D_E_L_E_T_ <> '*'								" +CRLF
			clQuery +=	"											AND ZAJ_FILIAL = '"+xFilial("ZAJ")+"'				" +CRLF
			clQuery +=	"											AND ZAJ_NUMCLI = '"+ZAE->ZAE_NUMCLI+"'				" +CRLF
			clQuery +=	"											AND ZAJ_CLIFAT = '"+ZAE->ZAE_CLIFAT+"'				" +CRLF
			clQuery +=	"											AND ZAJ_LJFAT = '"+ZAE->ZAE_LJFAT+"'				" +CRLF
			clQuery +=	"											AND ZAJ_NUMEDI = '"+ZAE->ZAE_NUMEDI+"'				" +CRLF				
			clQuery +=	"											AND ZAJ_STATUS = '2'								" +CRLF
			clQuery +=	"									 )								   							" +CRLF

			clQuery := ChangeQuery(clQuery)	
			
			If Select("ITALT") > 0
				ITALT->(dbCloseArea())
			EndIf
			
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), "ITALT",.T.,.F.)
			 
			clItTab := IIF(!EMPTY(ITALT->ITMAX), Soma1(ITALT->ITMAX), "01")
			ITALT->(dbCloseArea())
			          
			
			If clItTab == "01" // Ou seja nใo houve alteracoes aprovadas ou nao existem alteracoes
				// Realizar Busca na tabela de revisoes buscando o MAX do item do pedido importado
				clQuery :=	" Select MAX(ZAI_ITEM) as ITMAX														" +CRLF
				clQuery +=	"				From " + RetSqlName("ZAH") + " ZAH "								  +CRLF
				clQuery +=	"					Inner join " + RetSqlName("ZAI") + " ZAI "						  +CRLF
				clQuery +=	"					ON ZAH_VERSAO = ZAI_VERSAO										" +CRLF
				clQuery +=	"					AND ZAH_NUMEDI  = ZAI_NUMEDI							  		" +CRLF
				clQuery +=	"					AND ZAH_CLIFAT = ZAI_CLIFAT							  	  		" +CRLF
				clQuery +=	"					AND ZAH_LJFAT  = ZAI_LJFAT							   	  		" +CRLF
				clQuery +=	"					Where 				  											" +CRLF
				
				clQuery +=	"					ZAH.D_E_L_E_T_ <> '*'											" +CRLF
				clQuery +=	"					AND ZAH_FILIAL = '"+xFilial("ZAH")+"'							" +CRLF
				clQuery +=	"					AND ZAI.D_E_L_E_T_ <> '*'										" +CRLF
				clQuery +=	"					AND ZAI_FILIAL = '"+xFilial("ZAI")+"'							" +CRLF
				
				clQuery +=	"					AND ZAH_NUMCLI = '"+ZAE->ZAE_NUMCLI+"'							" +CRLF
				clQuery +=	"					AND ZAH_CLIFAT = '"+ZAE->ZAE_CLIFAT+"'							" +CRLF
				clQuery +=	"					AND ZAH_LJFAT = '"+ZAE->ZAE_LJFAT+"'							" +CRLF
				clQuery +=	"					AND ZAH_NUMEDI = '"+ZAE->ZAE_NUMEDI+"'							" +CRLF
				
				clQuery +=	"					AND ZAH_VERSAO = '001'											" +CRLF
 
				clQuery := ChangeQuery(clQuery)	
				
				If Select("ITVER001") > 0
					ITVER001->(dbCloseArea())
				EndIf
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), "ITVER001",.T.,.F.)
				 
				clItTab := IIF(!EMPTY(ITVER001->ITMAX), Soma1(ITVER001->ITMAX), "01")
				ITVER001->(dbCloseArea())

			EndIf
			
			If clItTab > clItem
				clVlMxIt := clItTab
			Else
				clVlMxIt := clItem				
			EndIf
			
			// Preenche o novo valor na Tela
   			oTcBrowse:aArray[nlLiAtual][nPosIte] := clVlMxIt
   		EndIf
				
 /*		clSeq := oTcBrowse:aArray[nlLiAtual][nPosSeq]
		For nlX := 1 to Len(oTcBrowse:aArray)
			If clSeq == oTcBrowse:aArray[nlX][nPosSeq]
                If oTcBrowse:aArray[nlX][nPosIte] == Nil
                	Exit
                EndIf 
				If Val(oTcBrowse:aArray[nlX][nPosIte]) > Val(clItem) .AND. nlX <> nlLiAtual
					clItem := oTcBrowse:aArray[nlX][nPosIte] 
					nlUltimo := nlX
					nlCont++
				EndIf
			EndIf
		Next nlX
		
		If nlCont > 1 .OR. IIF(nlUltimo > 0,(clSeq == oTcBrowse:aArray[nlUltimo][nPosSeq] .AND. nlCont == 1),.T.)
			oTcBrowse:aArray[nlLiAtual][nPosIte] 	:= Soma1(clItem)
		Else
			oTcBrowse:aArray[nlLiAtual][nPosIte] 	:= '0001'
		EndIf  */
		lpNovoIte := .F.
		oTcBrowse:Refresh()
	EndIf
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณKZORDEM		 บAutor  ณRodrigo A. Tosin	  บ Data ณ 21/06/2012  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que organiza itens do pedido EDI atual					   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil											                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil											                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KZORDEM()
	Local nPosSTS  		:= aScan(aCampos, "")
	Local nPosIte		:= aScan(aCampos, cTabIEDI + "_ITEM")
	Local nPosSeq		:= aScan(aCampos, cTabIEDI + "_SEQ")
	Local nlX 			:= 1
	
 	oTcBrowse:aArray	:= aSort(oTcBrowse:aArray,,,{|x,y| IIF(x[nPosSTS]==y[nPosSTS],  x[nPosSeq]+x[nPosIte] <= y[nPosSeq]+y[nPosIte],x[nPosSTS] >= y[nPosSTS])	}) 	

    oGetDados:aCols:= {{0,"","",.F.}}
       
	For nlX := 1 to Len(oTcBrowse:aArray)
		ValidTc(nlX)
	Next nlX
	
	oGetDados:aCols := aSort(oGetDados:aCols,,,{|x,y| x[2] <= y[2] }) 
	oGetDados:Refresh()	
	oTcBrowse:Refresh()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณKzRjPed		 บAutor  ณAdam Diniz Lima	  บ Data ณ22/06/2012   บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que realiza a REJEICAO do pedido com motivo fixo '04'	   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil											                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil											                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
User function KzRjPed()
    If ZAE->ZAE_STATUS = '3'
		If MsgNoYes("Deseja realmente Rejeitar esse pedido ?")
			If RecLock("ZAE",.F.)
				ZAE->ZAE_MOTIVO := "04" // "Pedido EDI nใo aprovado"  
				ZAE->ZAE_STATUS := "7"
				ZAE->(MsUnlock())
				llRet := .T.
			EndIf
		EndIf
	Else
		ShowHelpDlg("Status", {"Nใo ้ permitido rejeitar pedidos com status diferente de 'Aguardando aprova็ใo'."},5,{"Escolha um pedido que esteja com status Amarelo - 'Aguardando aprova็ใo'."},5)		
		llRet := .F.
	EndIf
Return
 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณKZTotlz		 บAutor  ณAdam Diniz Lima	  บ Data ณ27/06/2012   บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que abre tela de Totalizador por Sequencia				   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil											                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil											                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
User Function KZTotlz()

Local oDlg		:= Nil
Local olDesc	:= Nil
Local alCabec	:= {"Seq.","Qtd. Itens","Valor Seq.","Valor Parc."}
Local alArray	:= {}
Local clTitulo	:= "Totalizador por Sequencias"
Local olBrowSeq	:= Nil

alArray := KzGrdTot()

DEFINE MSDIALOG oDlg TITLE clTitulo FROM  15,6 TO 312,460 PIXEL 

//	@ 4, 2 TO 48, 179 OF oDlg  PIXEL

	olBrowSeq   				:= TCBrowse():New(14,02,100,137,,alCabec,,oDlg,,,,,,,,,,,,.F.,,.T.,,.F.,,.T.)
    olBrowSeq:SetArray(alArray) 
    olBrowSeq:bLine 			:=  {||{alArray[olBrowSeq:nAt][1],;
    									alArray[olBrowSeq:nAt][2],;
    								   	alArray[olBrowSeq:nAt][3],;
    								   	alArray[olBrowSeq:nAt][4]}}	
	olBrowSeq:lAdjustColSize 	:= .T.

	olBrowSeq:Align	  			:= CONTROL_ALIGN_TOP
	
	ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{|| oDlg:End()},{|| oDlg:End()},,)


Return 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณKzGrdTot		 บAutor  ณAdam Diniz Lima	  บ Data ณ27/06/2012   บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que abre tela de Totalizador por Sequencia				   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil											                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณalArray - array contendo os itens do grid da tela de tot.seq     บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
Static Function KzGrdTot()

	Local clQuery := ""
	Local nlParce := 0
	Local alParce := {}
	Local alArray := {}

	clQuery := " Select	ZAF_SEQ, 					   			" + CRLF
	clQuery += " 		COUNT(ZAF_SEQ) as QntSeq,	   			" + CRLF
	clQuery += " 		SUM(ZAF_TOTAL) as VlrSeq,	   			" + CRLF
	clQuery += " 		ZAE_CONDPA					   			" + CRLF
	clQuery += " From								   			" + CRLF
	clQuery += " 	"+ RetSqlName("ZAF") +" ZAF		   			" + CRLF
	clQuery += " INNER JOIN							   			" + CRLF
	clQuery += " 	"+ RetSqlName("ZAE") +" ZAE		   			" + CRLF
	clQuery += " ON ZAE_NUMEDI = ZAF_NUMEDI			   			" + CRLF
	clQuery += " Where	ZAE.D_E_L_E_T_ = ''						" + CRLF
	clQuery += " 	AND ZAE.ZAE_FILIAL = '"+xFilial("ZAE")+"'	" + CRLF
	clQuery += " 	AND ZAF.D_E_L_E_T_ = ''			   			" + CRLF
	clQuery += " 	AND ZAF.ZAF_FILIAL = '"+xFilial("ZAF")+"' 	" + CRLF
	clQuery += " 	AND ZAE.ZAE_NUMEDI = '"+M->ZAE_NUMEDI+"' 	" + CRLF
	clQuery += " Group By ZAF_SEQ, ZAE_CONDPA					" + CRLF
	clQuery += " Order By ZAF_SEQ								" + CRLF

	clQuery := ChangeQuery(clQuery)	
	
	If Select("SQTOT") > 0
		SQTOT->(dbCloseArea())
	EndIf

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), "SQTOT",.T.,.F.)

	While SQTOT->(!EOF())
 		If Empty(SQTOT->ZAE_CONDPA)
			aAdd(alArray, {SQTOT->ZAF_SEQ,SQTOT->QntSeq,Transform(SQTOT->VlrSeq,"@E 999,999,999.99"),"SEM COND.PGTO" })
 		Else                                                                
			alParce := Condicao(SQTOT->VlrSeq,SQTOT->ZAE_CONDPA,0,dDataBase,0)
			
			If Len(alParce) > 0
				nlParce := alParce[1][2]
			Else
				nlParce := 0
			EndIf

			aAdd(alArray, {SQTOT->ZAF_SEQ,SQTOT->QntSeq,Transform(SQTOT->VlrSeq,"@E 999,999,999.99"),Transform(nlParce,"@E 999,999,999.99") })		
		EndIf
	     
		SQTOT->(DbSkip())
	EndDo

	SQTOT->(dbCloseArea())

	If Len(alArray) == 0
		aAdd(alArray, {"","","",""})
	EndIf

Return alArray

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณApagaItens	 บAutor  ณThiago Moyses	  บ Data ณ27/06/2012   บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que itens antes de regravar a sequencia				   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil											                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ApagaItens(cNumPedAx,cCliAux,cLojAux)
***********************************************
Local clQuery 	:= ""
	
clQuery := "SELECT R_E_C_N_O_ FROM " + RetSQLName(cTabIEDI) 							   				+ CRLF
clQuery += " WHERE 	" + cTabIEDI + "_FILIAL 	= '" + xFilial(cTabIEDI)	+ "'"		   	  	 		+ CRLF
clQuery += " 	AND " + cTabIEDI + "_NUMEDI 	= '" + M->&(cTabEDI + "_NUMEDI") 		+ "'"			+ CRLF
clQuery += " 	AND " + cTabIEDI + "_CLIFAT		= '" + M->&(cTabEDI + "_CLIFAT")  		+ "'"			+ CRLF
clQuery += " 	AND " + cTabIEDI + "_LJFAT 		= '" + M->&(cTabEDI + "_LJFAT") 		+ "'"			+ CRLF
clQuery += " 	AND D_E_L_E_T_ 					<> '*'"

clQuery := ChangeQuery(clQuery)	

If Select("ZAFDEL") > 0
	ZAFDEL->(dbCloseArea())
EndIf

dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), "ZAFDEL",.T.,.F.)		

dbSelectArea(cTabIEDI)   

While ZAFDEL->(!EOF())
	(cTabIEDI)->(dbSetOrder(1))
	(cTabIEDI)->(dbGoTop())
	(cTabIEDI)->(dbGoTo(ZAFDEL->R_E_C_N_O_))

	If RecLock(cTabIEDI,.F.)
		(cTabIEDI)->(dbDelete())
	EndIf
	(cTabIEDI)->(MsUnlock())

	ZAFDEL->(dbSkip()) 
EndDo

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณKZRelacao		 บAutor  ณAdam Diniz Lima	  บ Data ณ27/06/2012   บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que abre tela de Relacionamentos que envolvem o ped. edi  บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil											                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil											                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
User Function KZRelacao()

Local oDlg		:= Nil
Local olDesc	:= Nil
Local alCabec	:= {"Pedido EDI","Seq.","Pedido Venda","Data Ped. Venda","Nota Fiscal","S้rie","Data Nota Fiscal","Data Invoice"}
Local alArray	:= {}
Local clTitulo	:= "Consulta de Relacionamento"
Local olBrowSeq	:= Nil

alArray := KzGrdRel()

DEFINE MSDIALOG oDlg TITLE clTitulo FROM  15,6 TO 312,790 PIXEL 

//	@ 4, 2 TO 48, 179 OF oDlg  PIXEL

	olBrowSeq   				:= TCBrowse():New(14,02,100,137,,alCabec,,oDlg,,,,,,,,,,,,.F.,,.T.,,.F.,,.T.)
    olBrowSeq:SetArray(alArray) 
    olBrowSeq:bLine 			:=  {||{alArray[olBrowSeq:nAt][1],;
    									alArray[olBrowSeq:nAt][2],;
    								   	alArray[olBrowSeq:nAt][3],;
    								   	alArray[olBrowSeq:nAt][4],;
    									alArray[olBrowSeq:nAt][5],;
    								   	alArray[olBrowSeq:nAt][6],;
    								   	alArray[olBrowSeq:nAt][7],;
    								   	alArray[olBrowSeq:nAt][8],;
    								   	}}	
	olBrowSeq:lAdjustColSize 	:= .T.

	olBrowSeq:Align	  			:= CONTROL_ALIGN_TOP
	
	ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{|| oDlg:End()},{|| oDlg:End()},,)


Return 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณKzGrdRel		 บAutor  ณAdam Diniz Lima	  บ Data ณ27/06/2012   บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que gera conteudo de relacionamento para o Ped.Edi  	   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil											                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณalArray - array contendo os itens do grid da tela de tot.seq     บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
Static Function KzGrdRel()

	Local clQuery := ""
	Local nlParce := 0
	Local alParce := {}
	Local alArray := {}
	
	clQuery := " Select 										"+CRLF
	clQuery += " ZAE_NUMEDI 									"+CRLF
	clQuery += " ,ZAF_SEQ 										"+CRLF
	clQuery += " ,C5_NUM 										"+CRLF
	clQuery += " ,C5_EMISSAO 									"+CRLF
	clQuery += " ,F2_DOC 										"+CRLF
	clQuery += " ,F2_SERIE 										"+CRLF
	clQuery += " ,F2_EMISSAO									"+CRLF
	clQuery += " ,F2_DTINV 										"+CRLF
	clQuery += "  												"+CRLF
	clQuery += " From  											"+CRLF
	clQuery += "  												"+CRLF
	clQuery += " "+RetSqlName("ZAE")+" ZAE						"+CRLF
	clQuery += "  												"+CRLF
	clQuery += " INNER JOIN  									"+CRLF
	clQuery += "  												"+CRLF
	clQuery += " "+RetSqlName("ZAF")+" ZAF						"+CRLF
	clQuery += "  												"+CRLF
	clQuery += " ON ZAE_NUMEDI = ZAF_NUMEDI 					"+CRLF
	clQuery += " AND ZAF.ZAF_FILIAL = '"+xFilial("ZAF")+"'		"+CRLF
	clQuery += " AND ZAF.D_E_L_E_T_ <> '*'						"+CRLF	
	clQuery += "  												"+CRLF
	clQuery += " LEFT JOIN  									"+CRLF
	clQuery += "  												"+CRLF
	clQuery += " "+RetSqlName("SC5")+" SC5						"+CRLF
	clQuery += "  												"+CRLF
	clQuery += " ON ZAE_NUMEDI = C5_NUMEDI  					"+CRLF
	clQuery += " AND ZAF_SEQ = C5_SEQ		  					"+CRLF
	clQuery += " AND SC5.C5_FILIAL = '"+xFilial("SC5")+"'		"+CRLF
	clQuery += " AND SC5.D_E_L_E_T_ <> '*'						"+CRLF
	clQuery += "  												"+CRLF
	clQuery += " LEFT JOIN 										"+CRLF
	clQuery += "  												"+CRLF
	clQuery += " "+RetSqlName("SF2")+" SF2						"+CRLF
	clQuery += "  												"+CRLF
	clQuery += " ON ZAE_NUMEDI = F2_NUMEDI 						"+CRLF
	clQuery += " AND ZAF_SEQ = F2_SEQ							"+CRLF
	clQuery += " AND SF2.F2_FILIAL = '"+xFilial("SF2")+"'		"+CRLF
	clQuery += " AND SF2.D_E_L_E_T_ <> '*'						"+CRLF
	clQuery += "  												"+CRLF
	clQuery += " Where ZAE.ZAE_NUMEDI = '"+ZAE->ZAE_NUMEDI+"' 	"+CRLF
	clQuery += " AND ZAE.D_E_L_E_T_ <> '*'						"+CRLF
	clQuery += " AND ZAE.ZAE_FILIAL = '"+xFilial("ZAE")+"'		"+CRLF	 
	clQuery += "  												"+CRLF
	clQuery += " GROUP BY  										"+CRLF
	clQuery += " ZAE_NUMEDI 									"+CRLF
	clQuery += " ,ZAF_SEQ 										"+CRLF
	clQuery += " ,C5_NUM 										"+CRLF
	clQuery += " ,C5_EMISSAO 									"+CRLF
	clQuery += " ,F2_DOC 										"+CRLF
	clQuery += " ,F2_SERIE 										"+CRLF
	clQuery += " ,F2_EMISSAO									"+CRLF
	clQuery += " ,F2_DTINV 										"+CRLF
	clQuery += " 		 										"+CRLF
	clQuery += " ORDER BY ZAF_SEQ								"+CRLF


	clQuery := ChangeQuery(clQuery)	
	
	If Select("QRYREL") > 0
		QRYREL->(dbCloseArea())
	EndIf

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), "QRYREL",.T.,.F.)

	While QRYREL->(!EOF())
		aAdd(alArray,{QRYREL->ZAE_NUMEDI, QRYREL->ZAF_SEQ, QRYREL->C5_NUM,StoD(QRYREL->C5_EMISSAO),QRYREL->F2_DOC,QRYREL->F2_SERIE,StoD(QRYREL->F2_EMISSAO),StoD(QRYREL->F2_DTINV)})
		QRYREL->(DbSkip())
	EndDo

	QRYREL->(dbCloseArea())

	If Len(alArray) == 0
		aAdd(alArray, {"","","","","","","",""})
	EndIf

Return alArray




/*
If 		llAprov  .And. llImped
	clStatus := "4" // Com Inconsistencia
ElseIf 	llAprov  .And. !llImped
	clStatus := "3" // Aguardando Aprovacao
ElseIf 	!llAprov .And. llImped
	clStatus := "4" // Com Inconsistencia
Else // !llAprov .And. !llImped
	clStatus := "2" // Apto a gerar pedido de venda - advertencia
EndIf
*/
/*	INC     DESCRICAO                                              AP  IM 
	01    	Cliente de entrega/Cobran็a                            	2	1			// Com Inconsistencia
	02    	Codigo EAN                                             	2	1			// Com Inconsistencia
	03    	Valor unitแrio                                         	2	1			// Com Inconsistencia
	04    	Percentual de IPI                                      	2	1			// Com Inconsistencia
	05    	Percentual de Desconto                                 	1	2			// Aguardando Aprovacao
	06    	Valor Total Item                                       	2	1 			// Com Inconsistencia
	07    	Produto Bloqueado/Inativo                              	2	2			// Apto a gerar pedido de venda - advertencia
	08    	Produto Alternativo                                    	2	2			// Apto a gerar pedido de venda - advertencia
	09    	Valor mํnimo da parcela de R$ 500,00                   	2	2			// Apto a gerar pedido de venda - advertencia
	10    	Quantidade mแxima de 40 itens por pedido               	2	2			// Apto a gerar pedido de venda - advertencia
	11    	Valor mแximo de R$ 80.000,00 por pedido                	2	2 			// Apto a gerar pedido de venda - advertencia  	
 */
 