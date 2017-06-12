#INCLUDE "PROTHEUS.CH"



/*/
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    矴P410CRP � Autor 矱LTON SANTANA		    � Data � 11/10/11 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Ponto de entrada utilizado no final do CNAB  			  潮�
北�			 � 												  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
User Function GP410CRP()

Local aArea 	:= GetArea()
Local lBcoCiti  := GetCtParam("NC_CNBCITI",;
									".T.",;
									"L",;
									"Verifica se esta ativo o CNAB do banco CITI",;
									"Verifica se esta ativo o CNAB do banco CITI",;
									"Verifica se esta ativo o CNAB do banco CITI",;
									.F. )

//Verifica se esta ativo o CNAB do banco CITI
If lBcoCiti
	//Verifica se o arquivo existe
	If File(mv_par22)
		ProcessaArq(mv_par22)
	Else
		Aviso("ERRO", "Erro ao tentar ler arquivo no diret髍io: "+mv_par22,{"Ok"},2 )
	EndIf
	
EndIf

RestArea(aArea)
Return


/*/
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砅rocessaArq� Autor 矱LTON SANTANA		    � Data � 11/10/11 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Exclui a primeira linha do arquivo			  			  潮�
北�			 � 												  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
Static Function ProcessaArq(cNomeArq)

Local aArea 	:= GetArea()
Local nCont		:= 1
Local cLinha	:= ""
Local aArquivo	:= {}

Default cNomeArq := ""                            

FT_FUse(cNomeArq)
FT_FGoTop()
ProcRegua(FT_FLastRec())
FT_FGoTop()

While !FT_FEof() 
	IncProc("Efetuando a leitura do arquivo...")
    
    //Pula a primeira linha do arquivo (Cabe鏰lho)
    If nCont == 1
    	nCont++
    	FT_FSkip()
       loop
    EndIf
    
    //Inicia as variaveis com vazio
	cLinha 	:= ""
	
	cLinha  := FT_FReadLn() //Le alinha    
	
	//Adiciona a linha ao arquivo
	aAdd(aArquivo,cLinha ) 
	
	FT_FSkip()
EndDo 

FT_FUse()//Fecha o arquivo

If Len(aArquivo) > 0
    
	//Preenche os dados que faltam no arquivo
	GetAtuArq(@aArquivo)

	//Grava o arquivo novo
	GrvArqAtu(cNomeArq, aArquivo)
EndIf

RestArea(aArea)
Return 


/*/
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    矴rvArqAtu		 � Autor 矱LTON SANTANA	    � Data � 11/10/11 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Exclui e gera o novo arquivo texto						  潮�
北�			 � 												  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
Static Function GrvArqAtu(cArqDes, aDadosArq)

Local aArea 	:= GetArea()
Local nX		:= 0
Local cNewArq   := ""

Default cArqDes		:= "" 
Default aDadosArq	:= {}

//Exclui o arquivo anterior
ExclArq(cArqDes)

//Atualiza o novo nome doarquivo
cNewArq :=  SubStr(Alltrim(cArqDes),1,Len(Alltrim(cArqDes)) - GetCrExt(Alltrim(cArqDes)))+"_citi.txt"

//Exclui o novo arquivo se o mesmo existir
ExclArq(cNewArq)
                           
For nX := 1 To Len(aDadosArq)

	//Grava os dados no novo arquivo	
	GravaTxt(cNewArq, aDadosArq[nX])
Next

RestArea(aArea)
Return

/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北赏屯屯屯屯脱屯屯屯屯屯送屯屯屯淹屯屯屯屯屯屯屯屯屯退屯屯屯淹屯屯屯屯屯屯槐�
北篜rograma  矴etCrExt  篈utor  矼icrosiga           � Data �  02/13/12   罕�
北掏屯屯屯屯拓屯屯屯屯屯释屯屯屯贤屯屯屯屯屯屯屯屯屯褪屯屯屯贤屯屯屯屯屯屯贡�
北篋esc.     � Retorna a quantidade de caracter da exten玢o do arquivo    罕�
北�          �                                                            罕�
北掏屯屯屯屯拓屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯贡�
北篣so       � AP                                                        罕�
北韧屯屯屯屯拖屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯急�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function GetCrExt(cNomeArq)

Local nCont := 0 
Local nX	:= 0
Local nRet	:= 0

Default cNomeArq := ""        

nCont := Len(Alltrim(cNomeArq))
For nX := nCont to 1 Step -1
	If SubStr(Alltrim(cNomeArq),nX,1) == "."
		nRet := nCont - (nX-1)
	EndIf
Next

Return nRet


/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北赏屯屯屯屯脱屯屯屯屯屯送屯屯屯淹屯屯屯屯屯屯屯屯屯退屯屯屯淹屯屯屯屯屯屯槐�
北篜rograma  矴ravaTxt  篈utor  矼icrosiga           � Data �  02/13/12   罕�
北掏屯屯屯屯拓屯屯屯屯屯释屯屯屯贤屯屯屯屯屯屯屯屯屯褪屯屯屯贤屯屯屯屯屯屯贡�
北篋esc.     � Escreve dados no arquivo TXT                               罕�
北�          �                                                            罕�
北掏屯屯屯屯拓屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯贡�
北篣so       � AP                                                        罕�
北韧屯屯屯屯拖屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯急�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function GravaTxt( cArq, cTexto )

Local nHandle := 0

Default cArq	:= "" 
Default cTexto	:= ""

If !File( cArq )
	nHandle := FCreate( cArq )
	FClose( nHandle )
Endif

If File( cArq )
	nHandle := FOpen( cArq, 2 )
	FSeek( nHandle, 0, 2 )	// Posiciona no final do arquivo
	FWrite( nHandle, cTexto + Chr(13) + Chr(10), Len(cTexto)+2 )
	FClose( nHandle)
Endif

Return   

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北赏屯屯屯屯脱屯屯屯屯屯送屯屯屯淹屯屯屯屯屯屯屯屯屯退屯屯屯淹屯屯屯屯屯屯槐�
北篎uncao    矱xclArq	� Autor � Elton C.		     � Data �  27/11/12   罕�
北掏屯屯屯屯拓屯屯屯屯屯释屯屯屯贤屯屯屯屯屯屯屯屯屯褪屯屯屯贤屯屯屯屯屯屯贡�
北篋escricao � Exclui arquivos 											  罕�
北�          �                      									  罕�
北掏屯屯屯屯拓屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯贡�
北篣so       � 			                                                  罕�
北韧屯屯屯屯拖屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯急�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
Static Function ExclArq(cNomeArq)

Local aArea		:= GetArea()
Local nRetExc   := 0
Local lRet		:= .T.
Local nHandle	:= 0

Default cNomeArq	:= ""

If File(cNomeArq)
	nHandle := FOpen( cNomeArq, 2 )//Abre o Arquivo
	If !FCLOSE (nHandle) //Fecha o arquivo
		Aviso("ERRO1", "Erro ao tentar atualizar o arquivo: "+cNomeArq,{"Ok"},2 )
		lRet := .F.
	Else
		nRetExc := FERASE(cNomeArq)
		If nRetExc !=  0
			Aviso("ERRO2", "Erro ao tentar atualizar o arquivo: "+cNomeArq,{"Ok"},2 )
			lRet := .F.
		EndIf
	EndIf
EndIf


RestArea(aArea)
Return lRet



/*/
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    矴etAtuArq		 � Autor 矱LTON SANTANA	    � Data � 11/10/11 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Preenche os dados que faltam no arquivo(Trailler e espa鏾s)潮�
北�			 � 												  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
Static Function GetAtuArq(aArq)

Local aArea 	:= GetArea()
Local nX		:= 0
Local nPay		:= 0 
Local nLinReg	:= 0
Local nSValPag  := 0

Default aArq := {}

//Contagem dos registro que iniciam com PAY
For nX := 1 To Len(aArq)
	
	
	
	If UPPER(SubStr(aArq[nX],1,3)) == "PAY"
		aArq[nX] := aArq[nX]+Space(1024-Len(aArq[nX]))//Inclui a quantidade de caracter que faltam no arquivo
		nSValPag += Val(SubStr(aArq[nX],92,15)) //Soma o valor de pagamento  
	   
		++nPay
	EndIf
	
	If UPPER(SubStr(aArq[nX],1,3)) != "TRL"
		++nLinReg                               
	EndIf
		                             
	If UPPER(SubStr(aArq[nX],1,3)) == "TRL"
		
		aArq[nX] := STUFF(aArq[nX], 4,Len(Alltrim(StrZero(nPay,15))),StrZero(nPay,15) )//Contador das linha de pagamento do tipo PAY		
		aArq[nX] := STUFF(aArq[nX], 19,Len(Alltrim(StrZero(nSValPag,15))),StrZero(nSValPag,15) )//Soma do valor de pagamento do registro PAY		
		aArq[nX] := STUFF(aArq[nX], 49,Len(Alltrim(StrZero(nLinReg,15))),StrZero(nLinReg,15) )//Contador das linha do arquivo exceto a linha PAY
		//aArq[nX] := STUFF(aArq[nX], 64,37,Space(37) )//Espa鏾s em branco no final do arquivo, Registro Trailer    
							
	EndIf				
Next

RestArea(aArea)
Return           


/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北赏屯屯屯屯脱屯屯屯屯屯送屯屯屯淹屯屯屯屯屯屯屯屯屯退屯屯屯淹屯屯屯屯屯屯槐�
北篜rograma  矴etCtParam篈utor  矱lton C.		     � Data �  03/13/09   罕�
北掏屯屯屯屯拓屯屯屯屯屯释屯屯屯贤屯屯屯屯屯屯屯屯屯褪屯屯屯贤屯屯屯屯屯屯贡�
北篋esc.     砇etorna o conteudo do parametro e ou cria o parametro       罕�
北�          砪aso n鉶 exista                                             罕�
北掏屯屯屯屯拓屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯贡�
北篣so       � AP                                              	          罕�
北韧屯屯屯屯拖屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯急�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function GetCtParam( cMvPar, xValor, cTipo, cDescP, cDescS, cDescE, lAlter )

Local aAreaAtu	:= GetArea()
Local lRecLock	:= .F.
Local xlReturn

Default lAlter := .F.

If ( ValType( xValor ) == "D" )
	If " $ xValor
		xValor := Dtoc( xValor, "ddmmyy" )
	Else
		xValor	:= Dtos( xValor )
	Endif
ElseIf ( ValType( xValor ) == "N" )
	xValor	:= AllTrim( Str( xValor ) )
ElseIf ( ValType( xValor ) == "L" )
	xValor	:= If ( xValor , ".T.", ".F." )
EndIf

DbSelectArea('SX6')
DbSetOrder(1)
lRecLock := !MsSeek( Space( Len( X6_FIL ) ) + Padr( cMvPar, Len( X6_VAR ) ) )
RecLock( "SX6", lRecLock )
FieldPut( FieldPos( "X6_VAR" ), cMvPar )
FieldPut( FieldPos( "X6_TIPO" ), cTipo )
FieldPut( FieldPos( "X6_PROPRI" ), "U" )
If !Empty( cDescP )
	FieldPut( FieldPos( "X6_DESCRIC" ), SubStr( cDescP, 1, Len( X6_DESCRIC ) ) )
	FieldPut( FieldPos( "X6_DESC1" ), SubStr( cDescP, Len( X6_DESC1 ) + 1, Len( X6_DESC1 ) ) )
	FieldPut( FieldPos( "X6_DESC2" ), SubStr( cDescP, ( Len( X6_DESC2 ) * 2 ) + 1, Len( X6_DESC2 ) ) )
EndIf
If !Empty( cDescS )
	FieldPut( FieldPos( "X6_DSCSPA" ), cDescS )
	FieldPut( FieldPos( "X6_DSCSPA1" ), SubStr( cDescS, Len( X6_DSCSPA1 ) + 1, Len( X6_DSCSPA1 ) ) )
	FieldPut( FieldPos( "X6_DSCSPA2" ), SubStr( cDescS, ( Len( X6_DSCSPA2 ) * 2 ) + 1, Len( X6_DSCSPA2 ) ) )
EndIf
If !Empty( cDescE )
	FieldPut( FieldPos( "X6_DSCENG" ), cDescE )
	FieldPut( FieldPos( "X6_DSCENG1" ), SubStr( cDescE, Len( X6_DSCENG1 ) + 1, Len( X6_DSCENG1 ) ) )
	FieldPut( FieldPos( "X6_DSCENG2" ), SubStr( cDescE, ( Len( X6_DSCENG2 ) * 2 ) + 1, Len( X6_DSCENG2 ) ) )
EndIf
If lRecLock .Or. lAlter
	FieldPut( FieldPos( "X6_CONTEUD" ), xValor )
	FieldPut( FieldPos( "X6_CONTSPA" ), xValor )
	FieldPut( FieldPos( "X6_CONTENG" ), xValor )
EndIf

MsUnlock()

xlReturn := GetNewPar(cMvPar)

RestArea( aAreaAtu )

Return(xlReturn)
