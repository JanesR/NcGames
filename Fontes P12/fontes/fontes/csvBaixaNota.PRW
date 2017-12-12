#Include 'Protheus.Ch'
#Include 'TopConn.Ch'
#Include 'TOTVS.Ch'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE "TOTVS.CH"
#include "Fileio.ch"


user function bxCanhoto()
Local aArea := GetArea()      
Local cArq	:= ""
Local cDirPadr := "C:\"
Private aNotas := {}

msgAlert("Essa rotina tem como objetivo realizar a baixa de canhotos de notas entregues.","Baixa de Entregas")

cArq := cGetFile( '*.csv|*.csv' , 'arq (csv)', 1, cDirPadr, .F., GETF_LOCALHARD + GETF_LOCALFLOPPY)

IF(!Empty(cArq))
	IF(File(cArq))
	  	MsgRun( "Lendo Arquivo","*** Efetuando leitura do arquivo ***"	,{|| procArq(cArq)})
	  	
	  	IF(Len(aNotas) > 0)
	 	 MsgRun( "Baixando notas","*** Efetuando Baixa das Notas ***"	,{|| funcBaixa()})
	 	Else       
		 	RestArea(aArea)
	 		return 
		EndIF
	Else
		msgAlert("Arq, não encontrado!","O arquivo encontrado não foi encontrado!")
 	EndIF
EndIf

RestArea(aArea)
return

Static Function procArq(cArq)
Local aArea := GetArea()
Local cBuffer := ""
Local aLinha := {}
Local aAux  

		FT_FUSE(cArq)
		FT_FGOTOP() 	
		ProcRegua(FT_FLASTREC())
		maxLinha := FT_FLASTREC()
		
		While !FT_FEOF()

			IncProc("Efetuando a leitura do arquivo.")
			

			cBuffer := FT_FREADLN() 			
			aAux := STRTOKARR(cBuffer,';')
			
			If( len(aAux) = 2 )	
				aadd(aLinha, aAux)
			Else
				alert("Uma das colunas encontra-se com campo vazio.  Favor Verificar.")
				aNotas :={}
			    Return 
			EndIF
			
			FT_FSKIP() 
		EndDo
		FT_FUSE()
		
		aNotas := aLinha
		
RestArea(aArea)
Return

Static Function funcBaixa()
Local aArea := GetArea()

DbSelectArea("SZ1")
DbSetOrder(1)

For nX := 2 to Len(aNotas)
	
	If DbSeek(xFilial("SZ1")+StrZero(val(aNotas[nX][1]),9))
		if RecLock("SZ1", .F.)
	
				SZ1->Z1_DTENTRE := CtoD(aNotas[nX][2])
				SZ1->Z1_DTBAIXA := dDatabase
				SZ1->Z1_STATUS 	:= "B"
				SZ1->(MsUnlock())
	
		EndIf 
	Endif
	
	
Next

DbCloseArea("SZ1")

msgAlert("Processo finalizado!","Notas Baixadas")	

RestArea(aArea)
Return
