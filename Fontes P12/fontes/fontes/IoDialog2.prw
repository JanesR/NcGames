#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

User Function  BrwCred()

Local oDialog2,oSayCOD,CommandOK
oDialog2 := MSDIALOG():Create()
oDialog2:cName := "oDialog2"
oDialog2:cCaption := "Visualizar Informações do Cliente"
oDialog2:nLeft := 0
oDialog2:nTop := 0
oDialog2:nWidth := 500
oDialog2:nHeight := 300
oDialog2:lShowHint := .F.
oDialog2:lCentered := .F.

oSayCOD := TSAY():Create(oDialog2)
oSayCOD:cName := "oSayCOD"
oSayCOD:cCaption := "Código do Cliente: " + U_VCodeACr()  + chr(10) + "Loja: " +  U_VLOJAACr()  ; 
					+ chr(13) + chr(10) + " ";
					+ chr(13) + chr(10) + "Nome Cliente: " + U_VNomeACr()  ;
					+ chr(13) + chr(10) + "Nome Fantasia: " + U_VNFanACr();
					+ chr(13) + chr(10) + " ";     
					+ chr(13) + chr(10) + "Informações de Contato"  ;
					+ chr(13) + chr(10) + "DDI: " + U_VDDIACr() + chr(10) +  "DDD: " + U_VDDDACr() + chr(10) + "Tel: " + U_VTELACr(); 
					+ chr(13) + chr(10) +  "Contato: " + U_VCONTACr() + chr(10) +  "E-Mail: " + U_VEMAILACr();
					+ chr(13) + chr(10) +  "" ;
					+ chr(13) + chr(10) +  "Cond Pagamento: " + U_VCdPGACr()  + "  Desc: " + POSICIONE("SE4",1,xFilial("SE4") + U_VCdPGACr(),"E4_DESCRI")
				    

oSayCOD:nLeft := 17
oSayCOD:nTop := 14
oSayCOD:nWidth := 600
oSayCOD:nHeight := 600
oSayCOD:lShowHint := .F.
oSayCOD:lReadOnly := .F.
oSayCOD:Align := 0
oSayCOD:lVisibleControl := .T.
oSayCOD:lWordWrap := .F.
oSayCOD:lTransparent := .F.



CommandOK := SBUTTON():Create(oDialog2)
CommandOK:cName := "CommandOK"
CommandOK:cCaption := "OK"
CommandOK:nLeft := 647
CommandOK:nTop := 337
CommandOK:nWidth := 52
CommandOK:nHeight := 23
CommandOK:lShowHint := .F.
CommandOK:lReadOnly := .F.
CommandOK:Align := 0
CommandOK:lVisibleControl := .T.
CommandOK:nType := 1
CommandOK:bLClicked := {|| Close(oDialog2) }

oDialog2:Activate()

Return    
  




         
User Function VCodeACr()
Local Retorno
    dbSelectArea("SA1")
	dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA
    
    	RECLOCK("SA1",.F.)  
 
		   Retorno := SA1->A1_COD 
	   		
		MSUNLOCK() 
Return Retorno
                   


User Function VLOJAACr()
Local Retorno
    dbSelectArea("SA1")
	dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA
    
    	RECLOCK("SA1",.F.)  
 
		   Retorno := SA1->A1_LOJA 
	   		
		MSUNLOCK() 
Return Retorno

User Function VNomeACr()
Local Retorno
    dbSelectArea("SA1")
	dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA
    
    	RECLOCK("SA1",.F.)  
 
		   Retorno := SA1->A1_NOME 
	   		
		MSUNLOCK() 
Return Retorno

User Function VNFanACr()
Local Retorno
    dbSelectArea("SA1")
	dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA
    
    	RECLOCK("SA1",.F.)  
 
		   Retorno := SA1->A1_NREDUZ 
	   		
		MSUNLOCK() 
Return Retorno

User Function VDDIACr()
Local Retorno
    dbSelectArea("SA1")
	dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA
    
    	RECLOCK("SA1",.F.)  
 
		   Retorno := SA1->A1_DDI
	   		
		MSUNLOCK() 
Return Retorno  


User Function VDDDACr()
Local Retorno
    dbSelectArea("SA1")
	dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA
    
    	RECLOCK("SA1",.F.)  
 
		   Retorno := SA1->A1_DDD
	   		
		MSUNLOCK() 
Return Retorno  


User Function VTELACr()
Local Retorno
    dbSelectArea("SA1")
	dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA
    
    	RECLOCK("SA1",.F.)  
 
		   Retorno := SA1->A1_TEL
	   		
		MSUNLOCK() 
Return Retorno        


User Function VEMAILACr()
Local Retorno
    dbSelectArea("SA1")
	dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA
    
    	RECLOCK("SA1",.F.)  
 
		   Retorno := SA1->A1_EMAIL
	   		
		MSUNLOCK() 
Return Retorno 


User Function VCONTACr()
Local Retorno
    dbSelectArea("SA1")
	dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA
    
    	RECLOCK("SA1",.F.)  
 
		   Retorno := SA1->A1_CONTATO
	   		
		MSUNLOCK() 
Return Retorno 



User Function VCdPGACr()
Local Retorno
    dbSelectArea("SA1")
	dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA
    
    	RECLOCK("SA1",.F.)  
 
		   Retorno := SA1->A1_COND
	   		
		MSUNLOCK() 
Return Retorno 











