#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZNCG19	     บAutor  ณVinicius Almeida	  บData  ณ 24/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณCopia identica das tabelas de importacao e alteracao de pedido  บฑฑ  
ฑฑบ     	 ณEDI para gravacao numa outra tabela                      	  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณnOpc 1 - Se for Importacao Pedido EDI 000001 					  บฑฑ 
ฑฑบ 		 ณnOpc 2 - Se for Importacao Alteracao Pedido EDI 000001		  บฑฑ
ฑฑบ  		 ณapCbCopy - Contem os pedidos para efetuar uma copia			  บฑฑ  
ฑฑบ  		 ณapItCopy - Recebe os itens dos pedidos para efetuar uma copia	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/ 
User Function KZNCG19(nOpc,apCbCopy,apItCopy)  

	Local nx 		:= 0
	Local clVersao	:= ""
	Local nlPos		:= 0
	
	If nOpc == 1  // Se for Importacao Pedido EDI

		If Select("ZAE") == 0
			DbSelectArea("ZAE")
		EndIf
		ZAE->(DbSetOrder(1))
		ZAE->(dbGoTop())   
		
		If Select("ZAH") == 0
			DbSelectArea("ZAH")
		EndIf
		ZAH->(DbSetOrder(2))
		ZAH->(dbGoTop())
	
		For nx := 1 To Len(apCbCopy) 		
		
			If ZAE->(DbSeek(xFilial("ZAE")+apCbCopy[nx][1]+apCbCopy[nx][2]+apCbCopy[nx][3]))  		
				
				clVersao := U_KZGerVer(ZAE->ZAE_NUMCLI,ZAE->ZAE_NUMEDI)
				AADD(apCbCopy[nx],clVersao)
				
//				If ZAH->(!DbSeek(xFilial("ZAH")+apCbCopy[nx][1]+apCbCopy[nx][2]+apCbCopy[nx][3]+apCbCopy[nx][Len(apCbCopy[nx])])) 
				
				If RecLock("ZAH",.T.)
		
					ZAH->ZAH_FILIAL	:=	ZAE->ZAE_FILIAL
					ZAH->ZAH_STATUS	:=	ZAE->ZAE_STATUS	
					ZAH->ZAH_VERSAO	:=	apCbCopy[nx][Len(apCbCopy[nx])]						 
					ZAH->ZAH_TIPPED	:=	ZAE->ZAE_TIPPED						
					ZAH->ZAH_TPNGRD	:=	ZAE->ZAE_TPNGRD
					ZAH->ZAH_NUMEDI	:=	ZAE->ZAE_NUMEDI
					ZAH->ZAH_NUMCLI	:=	ZAE->ZAE_NUMCLI
					ZAH->ZAH_CLIFAT	:=	ZAE->ZAE_CLIFAT
					ZAH->ZAH_LJFAT	:=	ZAE->ZAE_LJFAT
					ZAH->ZAH_CLIENT	:=	ZAE->ZAE_CLIENT
					ZAH->ZAH_LJENT	:=	ZAE->ZAE_LJENT
					ZAH->ZAH_TIPOCL	:=	ZAE->ZAE_TIPOCL
					ZAH->ZAH_VEND	:=	ZAE->ZAE_VEND
					ZAH->ZAH_TRANSP	:=	ZAE->ZAE_TRANSP
					ZAH->ZAH_CONDPA	:=	ZAE->ZAE_CONDPA
					ZAH->ZAH_TPFRET	:=	ZAE->ZAE_TPFRET
					ZAH->ZAH_DESCFI	:=	ZAE->ZAE_DESCFI
					ZAH->ZAH_DESC1	:=	ZAE->ZAE_DESC1
					ZAH->ZAH_DESC2	:=	ZAE->ZAE_DESC2
					ZAH->ZAH_DESC3	:=	ZAE->ZAE_DESC3
					ZAH->ZAH_DESC4	:=	ZAE->ZAE_DESC4
					ZAH->ZAH_TABPRC	:=	ZAE->ZAE_TABPRC 						
					ZAH->ZAH_TOTFRT	:=	ZAE->ZAE_TOTFRT 						
					ZAH->ZAH_DTIMP	:=	ZAE->ZAE_DTIMP
					ZAH->ZAH_DTPVCL	:=	ZAE->ZAE_DTPVCL
//					ZAH->ZAH_DTPV	:=	ZAE->ZAE_DTPV
//					ZAH->ZAH_DTINV	:=	ZAE->ZAE_DTINV  						
					ZAH->ZAH_DTIENT	:=	ZAE->ZAE_DTIENT 						
					ZAH->ZAH_DTENTR	:=	ZAE->ZAE_DTENTR
//					ZAH->ZAH_NUMPV	:=	ZAE->ZAE_NUMPV
//					ZAH->ZAH_NUMINV	:=	ZAE->ZAE_NUMNF
//					ZAH->ZAH_NFSERI	:=	ZAE->ZAE_NFSERI 						
					ZAH->ZAH_OBSNF	:=	ZAE->ZAE_OBSNF
					ZAH->ZAH_MOTIVO	:=	ZAE->ZAE_MOTIVO						
					ZAH->ZAH_TOTAL	:=	ZAE->ZAE_TOTAL
					ZAH->ZAH_USRALT	:=	ZAE->ZAE_USRALT
					ZAH->ZAH_DTAALT	:=	ZAE->ZAE_DTAALT
					ZAH->ZAH_CGCENT	:=	ZAE->ZAE_CGCENT
					ZAH->ZAH_CGCFAT	:=	ZAE->ZAE_CGCFAT
					ZAH->ZAH_CGCCOB	:=	ZAE->ZAE_CGCCOB
					ZAH->ZAH_CGCFOR	:=	ZAE->ZAE_CGCFOR  
					   
				EndIf
		   		ZAH->(MsUnlock())				

			EndIf
		Next nx			
	
		If Select("ZAF") == 0
			DbSelectArea("ZAF")
		EndIf
		ZAF->(DbSetOrder(1))
		ZAF->(dbGoTop())   
		
		If Select("ZAI") == 0
			DbSelectArea("ZAI")
		EndIf
		ZAI->(DbSetOrder(2))
		ZAI->(dbGoTop())
			
		For nx := 1 To Len(apItCopy)	
			
			If ZAF->(DbSeek(xFilial("ZAF")+apItCopy[nx][1]+PadR(" ",TamSx3("ZAF_REVISA")[1])+apItCopy[nx][2]+apItCopy[nx][3]+apItCopy[nx][4])) 	     
			
				//If ZAI->(!DbSeek(xFilial("ZAI")+apItCopy[nx][1]+PadR(" ",TamSx3("ZAI_REVISA")[1])+apItCopy[nx][2]+apItCopy[nx][3]+apItCopy[nx][4]+clVersao))
				nlPos := aScan(apCbCopy,{|x|  AllTrim(x[1]) == AllTrim(apItCopy[nx][1]) .And. AllTrim(x[2]) == AllTrim(apItCopy[nx][2]) .And. AllTrim(x[3]) == AllTrim(apItCopy[nx][3]) })
				If RecLock("ZAI",.T.)  
				
					ZAI->ZAI_FILIAL	:=	ZAF->ZAF_FILIAL 
					ZAI->ZAI_NUMEDI	:=	ZAF->ZAF_NUMEDI					
					ZAI->ZAI_REVISA	:=	"01" 
					ZAI->ZAI_VERSAO	:=	apCbCopy[nlPos][Len(apCbCopy[nlPos])]
					ZAI->ZAI_CLIFAT	:=	ZAF->ZAF_CLIFAT
					ZAI->ZAI_LJFAT	:=	ZAF->ZAF_LJFAT
					ZAI->ZAI_ITEM	:=	ZAF->ZAF_ITEM
					ZAI->ZAI_EAN	:=	ZAF->ZAF_EAN
					ZAI->ZAI_PRODUT	:=	ZAF->ZAF_PRODUT						
					ZAI->ZAI_LOCAL	:=	ZAF->ZAF_LOCAL
					ZAI->ZAI_UM		:=	ZAF->ZAF_UM
					ZAI->ZAI_QTD	:=	ZAF->ZAF_QTD 						
					ZAI->ZAI_UNID2	:=	ZAF->ZAF_UNID2
					ZAI->ZAI_QTD2	:=  ZAF->ZAF_QTD2 						
					ZAI->ZAI_PRCUNI	:=	ZAF->ZAF_PRCUNI
					ZAI->ZAI_TOTAL	:=	ZAF->ZAF_TOTAL
					ZAI->ZAI_DTENT	:=	ZAF->ZAF_DTENT  						
					ZAI->ZAI_NCM	:=	ZAF->ZAF_NCM 						
					ZAI->ZAI_OPER	:=	ZAF->ZAF_OPER
					ZAI->ZAI_TES	:=	ZAF->ZAF_TES
					ZAI->ZAI_CFOP	:=	ZAF->ZAF_CFOP
					ZAI->ZAI_CST	:=	ZAF->ZAF_CST
					ZAI->ZAI_DESC	:=	ZAF->ZAF_DESC
					ZAI->ZAI_VLRDES	:=	ZAF->ZAF_VLRDES
					ZAI->ZAI_PERCIP	:=	ZAF->ZAF_PERCIP
					ZAI->ZAI_VLRIPI	:=	ZAF->ZAF_VLRIPI
					ZAI->ZAI_VLRDSP	:=	ZAF->ZAF_VLRDSP
					ZAI->ZAI_VLRSEG	:=	ZAF->ZAF_VLRSEG
					ZAI->ZAI_VLRFRT	:=	ZAF->ZAF_VLRFRT 						
					ZAI->ZAI_PERICM	:=	ZAF->ZAF_PERICM
					ZAI->ZAI_VLRICM	:=	ZAF->ZAF_VLRICM 
					ZAI->ZAI_DESCRI	:=	ZAF->ZAF_DESCRI
				EndIf
				ZAI->(MsUnlock())				
				//EndIf
			EndIf
		Next nx
	
	ElseIf nOpc == 2 // Se for Importacao Alteracao Pedido EDI     
	
   		If Select("ZAJ") == 0
			DbSelectArea("ZAJ")
		EndIf
		ZAJ->(DbSetOrder(1))
		ZAJ->(dbGoTop())   
		
		If Select("ZAH") == 0
			DbSelectArea("ZAH")
		EndIf
		ZAH->(DbSetOrder(2))
		ZAH->(dbGoTop())
	
		For nx := 1 To Len(apCbCopy) 		
		
			If ZAJ->(DbSeek(xFilial("ZAJ")+apCbCopy[nx][1]+apCbCopy[nx][2]+apCbCopy[nx][3]))  		
			
				clVersao := U_KZGerVer(ZAJ->ZAJ_NUMCLI,ZAJ->ZAJ_NUMEDI)
				AADD(apCbCopy[nx],clVersao)
				//If ZAH->(!DbSeek(xFilial("ZAH")+apCbCopy[nx][1]+apCbCopy[nx][2]+apCbCopy[nx][3]+clVersao)) 
				
					If RecLock("ZAH",.T.)
			
						ZAH->ZAH_FILIAL	:=	ZAJ->ZAJ_FILIAL
						ZAH->ZAH_STATUS	:=	ZAJ->ZAJ_STATUS  
						ZAH->ZAH_VERSAO	:=	apCbCopy[nx][Len(apCbCopy[nx])]						
						ZAH->ZAH_TIPPED	:=	ZAJ->ZAJ_TIPPED						
						ZAH->ZAH_TPNGRD	:=	ZAJ->ZAJ_TPNGRD
						ZAH->ZAH_NUMEDI	:=	ZAJ->ZAJ_NUMEDI 						
						ZAH->ZAH_NUMALT	:=	ZAJ->ZAJ_NUMALT						
						ZAH->ZAH_NUMCLI	:=	ZAJ->ZAJ_NUMCLI
						ZAH->ZAH_CLIFAT	:=	ZAJ->ZAJ_CLIFAT
						ZAH->ZAH_LJFAT	:=	ZAJ->ZAJ_LJFAT
						ZAH->ZAH_CLIENT	:=	ZAJ->ZAJ_CLIENT
						ZAH->ZAH_LJENT	:=	ZAJ->ZAJ_LJENT
						ZAH->ZAH_TIPOCL	:=	ZAJ->ZAJ_TIPOCL
						ZAH->ZAH_VEND	:=	ZAJ->ZAJ_VEND
						ZAH->ZAH_TRANSP	:=	ZAJ->ZAJ_TRANSP
						ZAH->ZAH_CONDPA	:=	ZAJ->ZAJ_CONDPA
						ZAH->ZAH_TPFRET	:=	ZAJ->ZAJ_TPFRET
						ZAH->ZAH_DESCFI	:=	ZAJ->ZAJ_DESCFI
						ZAH->ZAH_DESC1	:=	ZAJ->ZAJ_DESC1
						ZAH->ZAH_DESC2	:=	ZAJ->ZAJ_DESC2
						ZAH->ZAH_DESC3	:=	ZAJ->ZAJ_DESC3
						ZAH->ZAH_DESC4	:=	ZAJ->ZAJ_DESC4 						 
//						ZAH->ZAH_PERACE	:=	ZAJ->ZAJ_PERACE
//						ZAH->ZAH_PERPRO	:=	ZAJ->ZAJ_PERPRO						
						ZAH->ZAH_TABPRC	:=	ZAJ->ZAJ_TABPRC						
						ZAH->ZAH_TOTFRT	:=	ZAJ->ZAJ_TOTFRT						
						ZAH->ZAH_DTIMP	:=	ZAJ->ZAJ_DTIMP
						ZAH->ZAH_DTPVCL	:=	ZAJ->ZAJ_DTPVCL
//						ZAH->ZAH_DTPV	:=	ZAJ->ZAJ_DTPV
//						ZAH->ZAH_DTINV	:=	ZAJ->ZAJ_DTINV //	LINHAS COMENTADAS POR SOLICITACAO DE REMOCAO DO CAMPO DE NF DA ZAJ									
						ZAH->ZAH_DTIENT	:=	ZAJ->ZAJ_DTIENT					
						ZAH->ZAH_DTENTR	:=	ZAJ->ZAJ_DTENTR
//						ZAH->ZAH_NUMPV	:=	ZAJ->ZAJ_NUMPV
//						ZAH->ZAH_NUMINV	:=	ZAJ->ZAJ_NUMNF	//	LINHAS COMENTADAS POR SOLICITACAO DE REMOCAO DO CAMPO DE NF DA ZAJ			
//						ZAH->ZAH_NFSERI	:=	ZAJ->ZAJ_NFSERI	//	LINHAS COMENTADAS POR SOLICITACAO DE REMOCAO DO CAMPO DE NF DA ZAJ					
						ZAH->ZAH_OBSNF	:=	ZAJ->ZAJ_OBSNF
						ZAH->ZAH_MOTIVO	:=	ZAJ->ZAJ_MOTIVO						
						ZAH->ZAH_TOTAL	:=	ZAJ->ZAJ_TOTAL
						ZAH->ZAH_USRALT	:=	ZAJ->ZAJ_USRALT
						ZAH->ZAH_DTAALT	:=	ZAJ->ZAJ_DTAALT
						ZAH->ZAH_CGCENT	:=	ZAJ->ZAJ_CGCENT
						ZAH->ZAH_CGCFAT	:=	ZAJ->ZAJ_CGCFAT
						ZAH->ZAH_CGCCOB	:=	ZAJ->ZAJ_CGCCOB
						ZAH->ZAH_CGCFOR	:=	ZAJ->ZAJ_CGCFOR  
						   
					EndIf
			   		ZAH->(MsUnlock())				
				//EndIf
			EndIf
		Next nx			
	
		If Select("ZAK") == 0
			DbSelectArea("ZAK")
		EndIf
		ZAK->(DbSetOrder(1))
		ZAK->(dbGoTop())   
		
		If Select("ZAI") == 0
			DbSelectArea("ZAI")
		EndIf
		ZAI->(DbSetOrder(2))
		ZAI->(dbGoTop())
			
		For nx := 1 To Len(apItCopy)	
			
			If ZAK->(DbSeek(xFilial("ZAK")+avKey(apItCopy[nx][1],"ZAK_NUMEDI")+avKey(apItCopy[nx][2],"ZAK_CLIFAT")+avKey(apItCopy[nx][3],"ZAK_LJFAT")+avKey(apItCopy[nx][4],"ZAK_ITEM")))
			
				nlPos := aScan(apCbCopy,{|x|  AllTrim(x[1]) == AllTrim(apItCopy[nx][1]) .And. AllTrim(x[2]) == AllTrim(apItCopy[nx][2]) .And. AllTrim(x[3]) == AllTrim(apItCopy[nx][3]) })
				//If ZAI->(!DbSeek(xFilial("ZAI")+apItCopy[nx][1]+PadR(" ",TamSx3("ZAI_REVISA")[1])+apItCopy[nx][2]+apItCopy[nx][3]+apItCopy[nx][4]+clVersao))
				
					If RecLock("ZAI",.T.)
					
						ZAI->ZAI_FILIAL	:=	ZAK->ZAK_FILIAL
						ZAI->ZAI_NUMEDI	:=	ZAK->ZAK_NUMEDI
						ZAI->ZAI_REVISA	:=	"02"
						ZAI->ZAI_VERSAO	:=	apCbCopy[nlPos][Len(apCbCopy[nlPos])]
						ZAI->ZAI_CLIFAT	:=	ZAK->ZAK_CLIFAT
						ZAI->ZAI_LJFAT	:=	ZAK->ZAK_LJFAT
						ZAI->ZAI_ITEM	:=	ZAK->ZAK_ITEM
						ZAI->ZAI_EAN	:=	ZAK->ZAK_EAN
						ZAI->ZAI_PRODUT	:=	ZAK->ZAK_PRODUT
						ZAI->ZAI_LOCAL	:=	ZAK->ZAK_LOCAL
						ZAI->ZAI_UM		:=	ZAK->ZAK_UM
						ZAI->ZAI_QTD	:=	ZAK->ZAK_QTD
						ZAI->ZAI_UNID2	:=	ZAK->ZAK_UNID2
						ZAI->ZAI_QTD2	:=	ZAK->ZAK_QTD2						
						ZAI->ZAI_PRCUNI	:=	ZAK->ZAK_PRCUNI
						ZAI->ZAI_TOTAL	:=	ZAK->ZAK_TOTAL
						ZAI->ZAI_DTENT	:=	ZAK->ZAK_DTENT						
						ZAI->ZAI_NCM	:=	ZAK->ZAK_NCM					
						ZAI->ZAI_OPER	:=	ZAK->ZAK_OPER
						ZAI->ZAI_TES	:=	ZAK->ZAK_TES
						ZAI->ZAI_CFOP	:=	ZAK->ZAK_CFOP
						ZAI->ZAI_CST	:=	ZAK->ZAK_CST
						ZAI->ZAI_DESC	:=	ZAK->ZAK_DESC
						ZAI->ZAI_VLRDES	:=	ZAK->ZAK_VLRDES
						ZAI->ZAI_PERCIP	:=	ZAK->ZAK_PERCIP
						ZAI->ZAI_VLRIPI	:=	ZAK->ZAK_VLRIPI
						ZAI->ZAI_VLRDSP	:=	ZAK->ZAK_VLRDSP
						ZAI->ZAI_VLRSEG	:=	ZAK->ZAK_VLRSEG
						ZAI->ZAI_VLRFRT	:=	ZAK->ZAK_VLRFRT						
						ZAI->ZAI_PERICM	:=	ZAK->ZAK_PERICM
						ZAI->ZAI_VLRICM	:=	ZAK->ZAK_VLRICM 
						ZAI->ZAI_DESCRI	:=	ZAK->ZAK_DESCRI 						
					EndIf
					ZAI->(MsUnlock())				
				//EndIf
			EndIf
		Next nx
	
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
ฑฑบFuncao    ณKZGerVer	     บAutor  ณAlfredo A. MagalhaesบData  ณ 14/06/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณGera numero sequencial da tabela de revisใo.				  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณcNumCli - Numero do pedido do Cliente							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณcNumCli - Numero do pedido do cliente							  บฑฑ
ฑฑบ			 ณclNumEdi- Numero do pedido EDI								  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/ 
User Function KZGerVer(cNumCli, clNumEdi)

	Local clCod		:= ""
	Local clQuery	:= ""

	clQuery	+= " SELECT	MAX(ZAH_VERSAO) AS VERSAO " + CRLF
	clQuery	+= " FROM " + RETSQLNAME("ZAH") + CRLF
	clQuery	+= " WHERE	D_E_L_E_T_ <> '*' " + CRLF
	clQuery	+= " 		AND ZAH_FILIAL = '" + xFilial("ZAH") + "' " + CRLF
	clQuery	+= " 		AND ZAH_NUMCLI = '" + cNumCli + "' " + CRLF
	clQuery	+= " 		AND ZAH_NUMEDI = '" + clNumEdi + "' " + CRLF
	clQuery := ChangeQuery(clQuery)
	
	If Select("QRYV") > 0
		QRYV->(dbCloseArea())
	EndIf
	dbUseArea( .T., "TopConn", TCGenQry(,,clQuery), "QRYV", .F., .F. )	
	If QRYV->(!EOF())
		clCod := Soma1(QRYV->VERSAO)
	EndIf
	QRYV->(dbCloseArea())
Return clCod