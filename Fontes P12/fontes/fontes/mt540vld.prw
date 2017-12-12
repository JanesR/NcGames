#INCLUDE 'PROTHEUS.CH'

//Variaveis staticas que ser�o utilizadas no ponto de entrada MT540GRV para grava��o do historico
Static aYHeader := {}
Static aYAcols	:= {}
Static nYOpc	:= 1
Static aRetItem	:= {}
Static cYCodGrp	:= ""

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Rotina    �MT540VLD	�Autor  � Elton C. 	 		 � Data �  01/03/13   ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de entrada utilizado na valida��o do cadastro das    ���
���          � exce��es fiscais                                           ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MT540VLD()
 
Return .T.


Static Function SMt540V()
Local aArea 	:= GetArea()
Local nOpc		:= Paramixb[1]


aYHeader := {}
aYAcols	:= {}
nYOpc	:= 1
aRetItem	:= {}
cYCodGrp	:= ""

aYHeader 	:= aHeader
aYAcols     := Paramixb[2]
nYOpc		:= nOpc
cYCodGrp 	:= cGrupo1
   

//Verifica os itens inclusos/alterados no cadastro de exce��es fiscais para ser utilizado no 
//ponto de entrada MT540GRV
VerifItAlt(cYCodGrp,aYHeader,aYAcols)


RestArea(aArea)
Return .T.


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
Static Function VerifItAlt(cGrp,aYHeader,aYAcols)

Local aArea 		:= GetArea()
Local nPosGrCli		:= Ascan( aYHeader, { |x| UPPER( AllTrim( x[2] ) ) == "F7_GRPCLI" } )
Local nPosSequen	:= Ascan( aYHeader, { |x| UPPER( AllTrim( x[2] ) ) == "F7_SEQUEN" } )
Local nX			:= 0
Local nY			:= 0
Local i				:= 0
Local aColsAux		:= {}
Local nCols			:= 0
Local lIncAcols		:= .F.
Local nQtdCpo		:= Len(aYHeader)

Default cGrp		:= ""
Default aYHeader	:= {}                         
Default aYAcols 	:= {}

DbSelectArea("SF7")
DbSetOrder(1)
For nX := 1 To Len(aYAcols)
	
	lIncAcols := .F.
	
	//Verifica se o cadastro ja existe na base de dados e se o mesmo foi alterado
	If 	SF7->(DbSeek(xFilial("SF7") ;
		+PADR(cGrp,TAMSX3("F7_GRTRIB")[1]);
		+PADR(aYAcols[nX][nPosGrCli],TAMSX3("F7_GRPCLI")[1]) ;
		+PADR(aYAcols[nX][nPosSequen],TAMSX3("F7_SEQUEN")[1])  ))
		
		//Verifica se algum campo foi alterado
		For nY := 1 To Len(aYHeader)
			
			If VldCpoDc(aYHeader[nY][2])
				If SF7->&(aYHeader[nY][2]) != aYAcols[nX][nY]
					lIncAcols := .T.
				EndIf
			EndIf
		Next
        
		//Grava os dados anteriores a altera��o
        If lIncAcols
			
			AAdd(aColsAux, Array(nQtdCpo+1))
			nCols++
			
			For i := 1 To nQtdCpo
				If VldCpoDc(aYHeader[i][2])
					If aYHeader[i][10] <> "V"
						aColsAux[nCols][i] := FieldGet(FieldPos(aYHeader[i][2]))
					Else
						aColsAux[nCols][i] := CriaVar(aYHeader[i][2], .T.)
					EndIf
				
				
					aColsAux[nCols][i]:= SF7->&(aYHeader[i][2])
				EndIf
			Next
			
			aColsAux[nCols][nQtdCpo+1] := .F.
		    
			aadd(aRetItem,AClone(aColsAux[nCols]))
		EndIf
	EndIf
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
                         

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Rotina    �GetMT540	�Autor  � Elton C. 	 		 � Data �  01/03/13   ���
�������������������������������������������������������������������������͹��
���Descricao � Retorna os dados dos itens alterados antes da grava��o	  ���
���          �                                            				  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GetMT540()

Local aRet := {nYOpc,aYHeader, aYAcols, aRetItem, cYCodGrp}

Return aRet