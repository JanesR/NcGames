#INCLUDE 'PROTHEUS.CH'


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Rotina    �MT540GRV	�Autor  � Elton C. 	 		 � Data �  01/03/13   ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de entrada utilizado para gravar o historico das     ���
���          � exce��es fiscais                                           ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MT540GRV()

Return

static function smt540g ()

Local aArea 	:= GetArea()
Local aItStatic	:= {}      
Local nYOpc		:= 1
Local aYHeader	:= {}  
Local aYAcols	:= {}
Local aItens	:= {}
Local cGrp		:= ""

//Recebe os valores das variaveis staticas criadas no ponto de entrada MT540VLD
aItStatic := u_GetMT540() 
//{nYOpc,aYHeader, aYAcols, aRetItem, cYCodGrp}

If Len(aItStatic) >= 3

	nYOpc		:= aItStatic[1]
	aYHeader	:= aItStatic[2]  
	aYAcols		:= AClone(aItStatic[3])
	aItens		:= AClone(aItStatic[4])
	cGrp		:= aItStatic[5]

	GrvHist(cGrp,aYHeader,aItens)	
Else
	Aviso("ERR-HISTEXCEFIS","Erro ao gravar hist�rico das exce��es fiscais",{"Ok"}, 2)
	Return
EndIf

RestArea(aArea)
Return                                       


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Rotina    �VerifItAlt�Autor  � Elton C. 	 		 � Data �  01/03/13   ���
�������������������������������������������������������������������������͹��
���Descricao � Verifica os itens alterados								  ���
���          � 	                                  						  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GrvHist(cGrp,aYHeader,aItens)

Local aArea 		:= GetArea()
Local nPosGrCli		:= Ascan( aYHeader, { |x| UPPER( AllTrim( x[2] ) ) == "F7_GRPCLI" } )
Local nPosSequen	:= Ascan( aYHeader, { |x| UPPER( AllTrim( x[2] ) ) == "F7_SEQUEN" } )
Local nX			:= 0
Local nY			:= 0  


Default cGrp		:= ""
Default aYHeader	:= {}                         
Default aItens 	:= {}

DbSelectArea("PDZ")
DbSetOrder(1)
For nX := 1 To Len(aItens)
    

	//Grava��o dos valores na tabela PDZ (Historico das excecoes fiscais)
	If 	PDZ->(DbSeek(xFilial("PDZ") ;
				+PADR(cGrp,TAMSX3("DZ_GRTRIB")[1]);
				+PADR(aItens[nX][nPosGrCli],TAMSX3("DZ_GRPCLI")[1]) ;
				+PADR(aItens[nX][nPosSequen],TAMSX3("DZ_SEQUEN")[1]) + DTOS(MsDate()-1) ))

		RecLock("PDZ", .F.)
	Else
		RecLock("PDZ", .T.)	
	EndIf

    PDZ->DZ_FILIAL 	:= xFilial("PDZ")
    PDZ->DZ_GRTRIB 	:= cGrp
	PDZ->DZ_DTVALID := MsDate()-1                                                  
	
	For nY := 1 To Len(aYHeader)

		//Verifica se o campo existe no SX3
		If VldCpoDc(aYHeader[nY][2]) .And. VldCpoDc("DZ"+SubStr(aYHeader[nY][2],3, Len(aYHeader[nY][2])))
		    
                                      
            PDZ->&("DZ"+SubStr(aYHeader[nY][2],3, Len(aYHeader[nY][2]) )) := aItens[nX][nY]
                             
	
		EndIf
	Next
	
	PDZ->(MsUnLock())
Next

RestArea(aArea)
Return 
                                                
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Rotina    �VldCpoDc	�Autor  � Elton C. 	 		 � Data �  01/03/13   ���
�������������������������������������������������������������������������͹��
���Descricao � Verifica se o campo existe no dicionario SX3		          ���
���          � 					                                          ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldCpoDc(cCpo)

Local aArea 	:= GetArea()
Local lRet	    := .F.

Default cCpo := ""

DbSelectArea( "SX3" )
DbSetOrder(2)
If SX3->(DbSeek(cCpo))
	lRet := .T.
EndIf

RestArea(aArea)
Return lRet




