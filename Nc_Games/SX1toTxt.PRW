#Define Enter chr(13)+chr(10)
#INCLUDE 'PROTHEUS.CH'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ SX1toTxt	³ Autor ³                       ³ Data ³ 29/07/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Gera um arquivo txt para o PutSx1    					  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                            
User Function x1tst()
rpcsetenv("01","03")
U_SX1toTxt("NCVTEX07")
Return	


User Function SX1toTxt(cGrupo)
Local aVetor   :={}
Local oOk      := LoadBitmap( GetResources(), "LBOK" )
Local oNo      := LoadBitmap( GetResources(), "LBNO" )
Local oLbx,oLbx1,cLista

Local cAux			:=""
Local cFile			:= "PutSx1_"
Local cPathArq		:= "SYSTEM\PUTSX1\"
Local cMsg 			:= ""
Local cOrdem_mv	:="00"
Local cOrdem_ch	:="0"
Local lCk         :=.F.
Local lOk         :=.F.
Local aHelp		 	:={}
Local cHelp 		:=""
Local cHelpPor		:=""
Local cHelpEng 	:=""
Local cHelpSpa 	:=""
Local i,x
Local bWhile		:={||.T. }
Default cGrupo		:= ""

SX1->(DbGotop())

If !Empty(cGrupo)
	cGrupo:=Padr(cGrupo,Len(SX1->X1_GRUPO))
	SX1->(DbSeek(cGrupo))
	bWhile:={|| SX1->X1_GRUPO==cGrupo }
EndIf	


Do While !SX1->(Eof()) .And. Eval(bWhile)
	cGrupo:=SX1->X1_GRUPO
	aAdd( aVetor, { .F.,SX1->X1_GRUPO,})
	Do While !SX1->(Eof()) .And. SX1->X1_GRUPO==cGrupo
		SX1->(DbSkip())
	EndDo
EndDo

DEFINE MSDIALOG oDlg TITLE 'Selecione o GRUPO do SX1.' FROM 0,0 TO 240,500 PIXEL

@ 10,10 LISTBOX oLbx VAR cLista FIELDS HEADER " ", "Pergunte" SIZE 230,095 OF oDlg PIXEL ON dblClick(SX1toTxt_CkoLbx(@aVetor,@oLbx,@lCk),oLbx:Refresh())

oLbx:SetArray( aVetor )
oLbx:bLine := {|| {Iif(aVetor[oLbx:nAt,1],oOk,oNo),aVetor[oLbx:nAt,2]}}

//@ 107 , 175 Button '&Pesquisar'	Size 036, 010 Action SX1toTxt_AchaGrp(@aVetor,@oLbx) Of oDlg Pixel
@ 107 , 215 Button '&Ok' 		Size 026, 010 Action (lCk:=.T.,oDlg:End()) Of oDlg Pixel

ACTIVATE MSDIALOG oDlg CENTER

If lCk 
	lCk:=.F.
	For i:=1 to Len(aVetor)
		If aVetor[i,1]
			cGrupo=aVetor[i,2]
			Exit
		End If
		LOOP
	Next i
	
	aVetor:={}
	
	SX1->(DbSeek(cGrupo))
	
	Do While !SX1->(Eof()).And. SX1->X1_GRUPO == cGrupo
		aAdd( aVetor, { .T.,SX1->X1_PERGUNT,SX1->X1_GRUPO,SX1->X1_ORDEM,})
		SX1->(DbSkip())
	EndDo
	
	lOk:= .F.
	
	DEFINE MSDIALOG oDlg TITLE 'Selecione as perguntas.' FROM 0,0 TO 240,500 PIXEL
	
	@ 10,10 LISTBOX oLbx1 VAR cLista FIELDS HEADER 	" ", "Tipo" 	SIZE 230,095 OF oDlg PIXEL ON dblClick(aVetor[oLbx1:nAt,1] := !aVetor[oLbx1:nAt,1],oLbx1:Refresh())
	
	oLbx1:SetArray( aVetor )
	oLbx1:bLine := {|| {Iif(aVetor[oLbx1:nAt,1],oOk,oNo),aVetor[oLbx1:nAt,2]}}
	
	@ 107 , 215 Button '&Ok' Size 026, 010 Action (lOk:=.T.,oDlg:End()) Of oDlg Pixel
	//DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
	ACTIVATE MSDIALOG oDlg CENTER
	
	If lOk
		If !lIsDir(cPathArq)
			MakeDir(cPathArq)
		EndIf
		
		nHdl := FCreate(cPathArq+cFile+AllTrim(cGrupo)+".txt")
		
		If nHdl==-1
			MsgStop("Nao foi possivel criar o arquivo.")
			Return ""
		EndIf
		
		For i:=1 to Len(aVetor)
			If !aVetor[i,1]
				LOOP
			End If
			
			SX1->(DbSeek(aVetor[i,3]+aVetor[i,4]))
			
			cOrdem_mv = AllTrim(Soma1(cOrdem_mv,2))
			cOrdem_ch = AllTrim(Soma1(cOrdem_ch,1))
		 	
			aHelp:= Strtokarr(Ap5GetHelp(SX1->X1_HELP) ,CHR(13)+CHR(10))
			
			If (Len(aHelp)>0)
				cHelp:='{'
				For x:=1 to Len(aHelp)
					cHelp+=aHelp[x]
					If !(x>=Len(aHelp))
						cHelp+=	','
					EndIf
				Next
				cHelp+='}'
			End If
			
			If Len(cHelp)>0
				Do Case
					Case __Language == "PORTUGUESE"
						cHelpPor:= cHelp
					Case __Language == "English"
						cHelpEng:= cHelp
					Case __Language == "Spanish"
						cHelpSpa:= cHelp
					Otherwise
						// Otherwise é opcional.
						MsgAlert("“Nenhuma opção selecionada”")
				EndCase
			End If
			      
			cHelpName:='.'+AllTrim(cGrupo)+cOrdem_mv+'.'
			
			cMsg:=	'PutSx1('
			cMsg+=	'cPerg'	+','
			cMsg+=	'"'+cOrdem_mv+'",'
			cMsg+=	'"'+SX1->X1_PERGUNT	+'",'
			cMsg+=	'"'+SX1->X1_PERSPA	+'",'
			cMsg+=	'"'+SX1->X1_PERENG	+'",'
			cMsg+=	'"'+'MV_CH'+cOrdem_ch +'",'
			cMsg+=	'"'+SX1->X1_TIPO	+'",'
			cMsg+=	AllTrim(Str(SX1->X1_TAMANHO))+','
			cMsg+=	AllTrim(Str(SX1->X1_DECIMAL))+','
			cMsg+=	AllTrim(Str(SX1->X1_PRESEL)) +','
			cMsg+=	'"'+SX1->X1_GSC    	+'",'
			cMsg+=	'"'+SX1->X1_VALID  	+'",'
			cMsg+=	'"'+SX1->X1_F3		+'",'
			cMsg+=	'"'+SX1->X1_GRPSXG	+'",'
			cMsg+=	'"'+SX1->X1_PYME	+'",'
			cMsg+=	'"'+'MV_PAR'+cOrdem_mv+'",'
			cMsg+=	'"'+SX1->X1_DEF01	+'",'
			cMsg+=	'"'+SX1->X1_DEFSPA1	+'",'
			cMsg+=	'"'+SX1->X1_DEFENG1	+'",'
			cMsg+=	'"'+SX1->X1_CNT01	+'",'
			cMsg+=	'"'+SX1->X1_DEF02	+'",'
			cMsg+=	'"'+SX1->X1_DEFSPA2	+'",'
			cMsg+=	'"'+SX1->X1_DEFENG2	+'",'
			cMsg+=	'"'+SX1->X1_DEF03 	+'",'
			cMsg+=	'"'+SX1->X1_DEFSPA3	+'",'
			cMsg+=	'"'+SX1->X1_DEFENG3	+'",'
			cMsg+=	'"'+SX1->X1_DEF04	+'",'
			cMsg+=	'"'+SX1->X1_DEFSPA4	+'",'
			cMsg+=	'"'+SX1->X1_DEFENG4	+'",'
			cMsg+=	'"'+SX1->X1_DEF05  	+'",'
			cMsg+=	'"'+SX1->X1_DEFSPA5	+'",'
			cMsg+=	'"'+SX1->X1_DEFENG5	+'",'
			Iif(cHelpPor=="",cMsg+='"",',cMsg+=	cHelpPor		+',')
			Iif(cHelpEng=="",cMsg+='"",',cMsg+=	cHelpEng 		+',')
			Iif(cHelpSpa=="",cMsg+='"",',cMsg+=	+cHelpSpa 		+',')
			Iif(Len(cHelp)>0,cMsg+=	'"'+cHelpName+'"',cMsg+='""')
			cMsg+=')' 
			cMsg+= Enter
			
			FWrite(nHdl,cMsg,Len(cMsg))
			SX1->(DbSkip())
			
		Next
		FClose(nHdl)
	End If
End If
Return

Static Function SX1toTxt_CkoLbx(aVetor,oLbx,lCk)
Local i

If !aVetor[oLbx:nAt,1]
	For i:=1 to Len(aVetor)
		aVetor[i,1]=.F.
	Next
	lCk:= .T.
Else
	lCk:= .F.
End If

aVetor[oLbx:nAt,1] := !aVetor[oLbx:nAt,1]

Return


Static Function SX1toTxt_AchaGrp(aVetor,oLbx)
Local i
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // Digite o Grupo?                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1(cPerg)

Pergunte(cPerg,.T.)

For i:=1 to Len(aVetor)
	If alltrim(aVetor[i,2])== alltrim(mv_par01)
		oLbx:Nat:=i
	End If
Next

Return