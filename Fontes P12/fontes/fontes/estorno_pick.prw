#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PES_VOL   ³ Autor ³ ERICH BUTTNER		    ³ Data ³24/08/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ESTORN_PICK()

LOCAL  CUAUT:= GETMV("MV_ESTPICK")
Private cPedido	 := Space(06)                 
Private cCliente := ''
Private cVendedor:= ''
Private oEdit1
Private oEdit2 
Private oEdit3
Private oEdit4
Private oEdit5
Private oEdit6
Private _oDlg				
Private VISUAL := .F.                        
Private INCLUI := .F.                        
Private ALTERA := .F.                        
Private DELETA := .F.                        


IF ALLTRIM(Upper(cUsername))$ ALLTRIM(UPPER(CUAUT))
 
	DEFINE MSDIALOG _oDlg TITLE "ESTORNO PICK LIST" FROM C(128),C(131) TO C(350),C(418) PIXEL

 		// Cria Componentes Padroes do Sistema
		@ C(006),C(030) Say "INFORME OS DADOS A SEGUIR: " Size C(110),C(008) COLOR CLR_BLUE PIXEL OF _oDlg
		@ C(023),C(005) Say "Cliente: " + cCliente Size C(161),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
		@ C(043),C(005) Say "Vendedor: " + cVendedor Size C(161),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
		@ C(063),C(005) Say "Pedido(s):"           Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
		@ C(062),C(045) MsGet oEdit1 Var cPedido   Size C(060),C(009) COLOR CLR_BLACK PIXEL OF _oDlg VALID NCPEDEST()
		@ C(078),C(015) Button "&OK"   Size C(037),C(012) PIXEL OF _oDlg action (if(NCGRV(),lRet:= .T.,lRet:= .F.))
		@ C(078),C(060) Button "&Sair" Size C(037),C(012) action _oDlg:end() Object oBtn
	ACTIVATE MSDIALOG _oDlg CENTERED 
ELSE
	MSGBOX("VOCE NÃO TEM AUTORIZAÇÃO PARA ESTORNO DE PICKING")
ENDIF
	                                                                                                            
Return(.T.)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³   C()   ³ Autores ³ Norbert/Ernani/Mansano ³ Data ³10/05/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Funcao responsavel por manter o Layout independente da       ³±±
±±³           ³ resolucao horizontal do Monitor do Usuario.                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function C(nTam)                                                         
Local nHRes	:=	oMainWnd:nClientWidth	// Resolucao horizontal do monitor     
	If nHRes == 640	// Resolucao 640x480 (soh o Ocean e o Classic aceitam 640)  
		nTam *= 0.8                                                                
	ElseIf (nHRes == 798).Or.(nHRes == 800)	// Resolucao 800x600                
		nTam *= 1                                                                  
	Else	// Resolucao 1024x768 e acima                                           
		nTam *= 1.28                                                               
	EndIf                                                                         
                                                                                
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿                                               
	//³Tratamento para tema "Flat"³                                               
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                                               
	If "MP8" $ oApp:cVersion                                                      
		If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()                      
			nTam *= 0.90                                                            
		EndIf                                                                      
	EndIf                                                                         
Return Int(nTam)                                                                

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³minhatela ³ Autor ³ Erich Buttner         ³ Data ³25/08/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function NCPEDEST()                                                                                      

Local lRet   := .F.
Local cChave := ''

DBSelectArea("SC5")
SC5->(DBSETORDER(1))

if SC5->(DBSEEK(xFilial("SC5")+cPedido))
	cChaveSA3 := SC5->C5_VEND1
	cChaveSA1 := SC5->C5_CLIENTE+SC5->C5_LOJACLI
    
     DBSelectArea("SA1")
     SA1->(DBSETORDER(1))

	if SA1->(DBSEEK(xFilial("SA1")+cChaveSA1))
	   cCliente := SA1->A1_NOME	           
	Endif      
	
	 DBSelectArea("SA3")
     SA3->(DBSETORDER(1))
	
	If SA3->(DBSEEK(XFILIAL("SA3")+cChaveSA3))
		cVendedor := SA3->A3_NOME
	EndIf
		
	lRet := .T.                  

	_oDlg:Refresh()
Else
   MsgInfo = "Pedido não Encontrado !" 
Endif


Return lRet

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³minhatela ³ Autor ³ ERICH BUTTNER		    ³ Data ³24/08/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
                                                                          
Static Function NCGRV()                   

Local lRet := .F.

If empty(cPedido)

   Msginfo("Preencha todos os dados !")
   
Else
	DBSelectArea("SC5")
	SC5->(DBSETORDER(1))
	
	if SC5->(DBSEEK(xFilial("SC5")+cPedido))
		IF !EMPTY(SC5->C5_NOTA).OR.ALLTRIM(SC5->C5_STAPICK) == '3'
			MSGBOX ("Pedido "+cPedido+" Já Faturdo Total ou Parcial")
		ELSE
			dbSelectArea("SC9")
			dbSetOrder(1)
			MsSeek(xFilial("SC9")+cPedido)
			While ( !Eof() .And.C9_FILIAL == xFilial("SC9") .And.;
				C9_PEDIDO == cPedido)
					SC9->(A460Estorna())
				dbSelectArea("SC9")
				dbSkip()
			EndDo
 			
 			Reclock("SC5",.f.)
 			SC5->C5_REPICK:= ""
 			SC5->C5_STAPICK:= ""
		  	SC5->C5_CODBL := ""
			SC5->C5_DTLIB	:= CTOD("  /  /  ")
			SC5->(MSUNLOCK())
			
			DBSelectArea("SC6")
			SC6->(DBSETORDER(1))
			SC6->(MsSeek(xFilial("SC6")+cPedido))
			WHILE (!Eof() .And.SC6->C6_FILIAL == xFilial("SC6") .And.;
				SC6->C6_NUM == cPedido)
			    Reclock("SC6",.f.)
			    SC6->C6_SEQCAR:= 0
			    SC6->(MSUNLOCK()) 
			    //dbSelectArea("SC6")
			    SC6->(dbSkip())
			ENDDO
			
			lRet := .T.
       		MSGBOX ("Pedido "+cPedido+" Estornado ")
			U_Z7Status(xFilial("SC6"),SC5->C5_NUM,"000014","ESTORNO DE PICKLIST",SC5->C5_CLIENTE, SC5->C5_LOJACLI)
	    ENDIF
	    DBSELECTAREA("SZ7")
	    SZ7->(DBSETORDER(1))
	    IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000010"))
	    	WHILE SZ7->Z7_STAT == "000010"
	        	RECLOCK("SZ7")
	    		DBDELETE()
	    		SZ7->(MSUNLOCK())
	    		SZ7->(DBSKIP())
	    	ENDDO	
	    ENDIF
	    SZ7->(DBGOTOP())	    
	    IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000013"))
	    	RECLOCK("SZ7")
	    	DBDELETE()
	    	SZ7->(MSUNLOCK())
	    ENDIF
	    SZ7->(DBGOTOP())	    
	    IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000014"))
	    	RECLOCK("SZ7")
	    	DBDELETE()
	    	SZ7->(MSUNLOCK())
	    ENDIF
	    SZ7->(DBGOTOP())	    
	    IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000015"))
	    	RECLOCK("SZ7")
	    	DBDELETE()
	    	SZ7->(MSUNLOCK())
	    ENDIF
	    SZ7->(DBGOTOP())	    
	    IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000002"))
	    	RECLOCK("SZ7")
	    	DBDELETE()
	    	SZ7->(MSUNLOCK())
	    ENDIF
	    SZ7->(DBGOTOP())	    
	    IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000003"))
	    	RECLOCK("SZ7")
	    	DBDELETE()
	    	SZ7->(MSUNLOCK())
	    ENDIF
	    SZ7->(DBGOTOP())	    
	    IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000004"))
	    	RECLOCK("SZ7")
	    	DBDELETE()
	    	SZ7->(MSUNLOCK())
	    ENDIF
	    SZ7->(DBGOTOP())	    
	    IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000006"))
	    	RECLOCK("SZ7")
	    	DBDELETE()
	    	SZ7->(MSUNLOCK())
	    ENDIF
	    SZ7->(DBGOTOP())	    
	    IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000008"))
	    	RECLOCK("SZ7")
	    	DBDELETE()
	    	SZ7->(MSUNLOCK())
	    ENDIF
	    SZ7->(DBGOTOP())	    
	    IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000012"))
	    	WHILE SZ7->Z7_STAT == "000012"
	        	RECLOCK("SZ7")
	    		DBDELETE()
	    		SZ7->(MSUNLOCK())
	    		SZ7->(DBSKIP())
	    	ENDDO
	    ENDIF	    	    	    	    	    
	    SZ7->(DBGOTOP())	    
	    IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000011"))
			WHILE SZ7->Z7_STAT == "000011"
	        	RECLOCK("SZ7")
	    		DBDELETE()
	    		SZ7->(MSUNLOCK())
	    		SZ7->(DBSKIP())
	    	ENDDO
	    ENDIF
	Else
	   MsgInfo = "Pedido não Encontrado !" 
	Endif
	
	if lRet
		cPedido	 := Space(06)                 
		_oDlg:Refresh()
  	Endif
	
Endif 

Return lRet