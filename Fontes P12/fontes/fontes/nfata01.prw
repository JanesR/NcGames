#include "rwmake.ch"

User Function Nfata01


Local aCores  :={{"Empty(Z1_STATUS)",'ENABLE' },;       // Etiqueta Emitida
      			{"(Z1_STATUS)=='A' ",'BR_AZUL' },;      // Pacote com entregador 
                {"(Z1_STATUS)=='B' ",'BR_VERMELHO'}}    // Mercadoria Entregue

PRIVATE cCadastro := OemToAnsi("Liberacao de Entrega das Faturas") 

/*PRIVATE aRotina := { { OemToAnsi("Pesquisar"),"AxPesqui"  ,0,1},; 
                { OemToAnsi("Visualizar"),"U_NFATAM1(2)",0,2},;  
          	  	{ OemToAnsi("Parametros"),"U_NFATM02Par", 0 , 3},;
                { OemToAnsi("Liberar/Baixa"),"U_NFATM02",0,4,20},;  
                { OemToAnsi("Cancela.Etiqueta"),"U_NFATM03",0,4,20},;  
                { OemToAnsi("Legenda"),"U_Legenda()" ,0,3,0} } 
                */
PRIVATE aRotina := { { OemToAnsi("Pesquisar"),"AxPesqui"  ,0,1},; 
                { OemToAnsi("Visualizar"),"U_NFATAM1(2)",0,2},;  
          	  	{ OemToAnsi("Parametros"),"U_NFATM02Par", 0 , 3},;
                { OemToAnsi("Legenda"),"U_Legenda()" ,0,3,0} } 
                
                
mBrowse(,,,,"SZ1",,,,,,aCores) //

Return

User Function NFatM02Par()
pergunte("FATM02",.T.)
Return .T.


User Function Legenda

Local cCadastro:=OemToAnsi("Liberacao de Entrega das Faturas") 
BrwLegenda(cCadastro,"Legenda",{  {"ENABLE","Etiqueta Emitida - Gerando Pacotes"},;
{"BR_VERMELHO","Mercadoria Entregue"},;
{"BR_AZUL","Entrega sendo realizada"}})  

Return(.T.)

User Function NFATAM1(_nOpc)

Local cOpcao:=_nOpc
Local cOP   :=.F.
_cOpt:=cOpcao
_cTag:=.F.


Do Case
	Case cOpcao== 3 ; nOpcE:=3 ; nOpcG:=3 //"INCLUIR"
	Case cOpcao== 4 ; nOpcE:=3 ; nOpcG:=3 //"ALTERAR"
	Case cOpcao== 2 ; nOpcE:=2 ; nOpcG:=2 //"VISUALIZAR"
EndCase
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria variaveis M->????? da Enchoice                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RegToMemory("SZ1",(cOpcao== 3)) //"INCLUIR"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria aHeader e aCols da GetDados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF cOpcao == 3

nUsado:=0
dbSelectArea("SX3")
dbSeek("SZ3")
aHeader:={}
	While !Eof().And.(x3_arquivo=="SZ3")
		
		If X3USO(x3_usado).And.cNivel>=x3_nivel
    		nUsado:=nUsado+1
    	    Aadd(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture,;
		         x3_tamanho, x3_decimal,"AllwaysTrue()",;
    		     x3_usado, x3_tipo, x3_arquivo, x3_context } )
		Endif
    	dbSkip()
	End
EndIF
	
IF cOpcao != 3

nUsado:=0
dbSelectArea("SX3")
dbSeek("SZ3")
aHeader:={}
	While !Eof().And.(x3_arquivo=="SZ3")
		
		If X3USO(x3_usado).And.cNivel>=x3_nivel
    		nUsado:=nUsado+1
    	    Aadd(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture,;
		         x3_tamanho, x3_decimal,"AllwaysTrue()",;
    		     x3_usado, x3_tipo, x3_arquivo, x3_context } )
		Endif
    	dbSkip()
	End
EndIF

 
nUsadoI:=0
dbSelectArea("SX3")
dbSeek("SZ1")
aHeaderI:={}
	While !Eof().And.(x3_arquivo=="SZ1")
	
		If X3USO(x3_usado).And.cNivel>=x3_nivel
    		nUsadoI:=nUsadoI+1
    	    Aadd(aHeaderI,{ TRIM(x3_titulo), x3_campo, x3_picture,;
		         x3_tamanho, x3_decimal,"AllwaysTrue()",;
    		     x3_usado, x3_tipo, x3_arquivo, x3_context } )
   		Endif
   	 dbSkip()
	End


If cOpcao== 3 //"INCLUIR"
	aCols:={Array(nUsadoI+1)}
	aCols[1,nUsadoI+1]:=.F.
	For _ni:=1 to nUsadoI
		aCols[1,_ni]:=CriaVar(aHeaderI[_ni,2])
	Next
Else
	aCols:={}
	dbSelectArea("SZ3")
	dbSetOrder(1)
	dbSeek(xFilial()+M->Z1_DOC)
	While !eof().and.Z3_DOC == M->Z1_DOC
		AADD(aCols,Array(nUsado+1))
		For _ni:=1 to nUsado
			aCols[Len(aCols),_ni]:=FieldGet(FieldPos(aHeader[_ni,2]))
		Next 
		aCols[Len(aCols),nUsado+1]:=.F.
		dbSkip()
	End
Endif
If Len(aCols)>0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa a Modelo 3                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	cTitulo:="Controle de Despacho e Etiquetagem"
	cAliasEnchoice:="SZ1"
	cAliasGetD:="SZ3"
	cLinOk:="AllwaysTrue()"
	cTudOk:="U_ValidOK(_cOpt,_cTag)" //"AllwaysTrue()"
	cFieldOk:="AllwaysTrue()"
	aCpoEnchoice:={"Z1_DOC","Z1_SERIE","Z1_CLIENTE","Z1_LOJA"}
	
	IF cOpcao == 4 .and. Empty(M->Z1_STATUS)
		IF Msgbox("Operacao de Confirmacao de Entrega de Mercadoria(Baixa) ?", 'Liberacao ou Baixa', 'YESNO')
        	cOP :=.T.
        EndIF
    ElseIF SZ1->Z1_STATUS == "A"
		cOP :=.T.        
	EndIf

	_lRet:=Modelo3(cTitulo,cAliasEnchoice,cAliasGetD,aCpoEnchoice,cLinOk,cTudOk,nOpcE,nOpcG,cFieldOk)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executar processamento                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	_nPosItem := aScan(aHeader,{|x| Upper(alltrim(x[2])) == "Z3_ITEM"})
	_nPosDoc  := aScan(aHeader,{|x| Upper(alltrim(x[2])) == "Z3_DOC"})
	_nPosSerie:= aScan(aHeader,{|x| Upper(alltrim(x[2])) == "Z3_SERIE"})
	_nPosPack := aScan(aHeader,{|x| Upper(alltrim(x[2])) == "Z3_CODPACK"})
	_nPosResp := aScan(aHeader,{|x| Upper(alltrim(x[2])) == "Z3_EMISSOR"})
	_nPosCodM := aScan(aHeader,{|x| Upper(alltrim(x[2])) == "Z3_CODMOTO"})
	_nPosMotor:= aScan(aHeader,{|x| Upper(alltrim(x[2])) == "Z3_MOTORIS"})
	
	If _lRet .and. cOpcao== 3

		dbSelectArea("SZ1")
		Reclock("SZ1",.T.)
			SZ1->Z1_DOC    :=M->Z1_DOC
			SZ1->Z1_SERIE  :=M->Z1_SERIE		
			SZ1->Z1_CLIENTE:=M->Z1_CLIENTE
			SZ1->Z1_LOJA   :=M->Z1_SERIE
			SZ1->Z1_DTEMISS:=DDATABASE
			SZ1->Z1_HORAET :=TIME()
		MsUnlock()
		
		
		dbSelectArea("SZ3")
		For _i:=1 To Len(aCols)		
			Reclock("SZ3",.T.)
  				SZ3->Z3_ITEM   := Strzero(aCols[_i,_nPosItem],2)
				SZ3->Z3_DOC    := aCols[_i,_nPosDoc]
				SZ3->Z3_SERIE  := aCols[_i,_nPosSerie]
				SZ3->Z3_CODPACK:= aCols[_i,_nPosPack]
				SZ3->Z3_EMISSOR:= aCols[_i,_nPosResp]
			MsUnlock()
		Next	
	ElseIF _lRet .and. cOpcao== 4 		
		IF !cOP  //Liberacao para entrega
			dbSelectArea("SZ1")	
			Reclock("SZ1",.F.)
				SZ1->Z1_DTSAIDA:=DDATABASE
				SZ1->Z1_HORALB :=TIME()
				SZ1->Z1_STATUS :="A"
			MsUnlock()
			dbSelectArea("SZ3")	
			dbSetOrder(1)
			dbSeek(xFilial()+M->Z1_DOC)
			While !Eof() .and. M->Z1_DOC+M->Z1_SERIE == SZ3->Z3_DOC+SZ3->Z3_SERIE
				Reclock("SZ3",.F.)
					SZ3->Z3_EMISSOR:= Upper(Substr(cUsuario,7,15))
					SZ3->Z3_CODMOTO:= aCols[Val(SZ3->Z3_ITEM),_nPosCodM]
					SZ3->Z3_MOTORIS:= aCols[Val(SZ3->Z3_ITEM),_nPosMotor]
				MsUnlock()
				dbSkip()
			EndDo

		Else // Realizacao de Entrega
			dbSelectArea("SZ1")
			RecLock("SZ1",.F.)
				SZ1->Z1_DTENTRE:=M->Z1_DTENTRE
				SZ1->Z1_BAIXAPO:=Upper(Substr(cUsuario,7,15))
				SZ1->Z1_HORAEN :=TIME()				
				SZ1->Z1_STATUS :="B"
				SZ1->Z1_DTBAIXA:=DDATABASE
			MsUnlock()	
		EndIF		
	Endif
Endif


Return


User Function ValidOK(_cOpt,_cTag)

Local _aArea    := GetArea()
Local _lRet     :=.T.
Local _lnOk     :=.T.
Local _nPosCodM := aScan(aHeader,{|x| Upper(alltrim(x[2])) == "Z3_CODMOTO"})
Local _nPosMotor:= aScan(aHeader,{|x| Upper(alltrim(x[2])) == "Z3_MOTORIS"})


IF _cOpt == 4
	IF Empty(SZ1->Z1_STATUS)
		IF  !_cTag
			For _k:=1 To Len(aCols)
				IF Empty(aCols[_k,_nPosCodM])
					_lnOk:=.F.
				EndIF	
			Next
			IF !_lnOk
				MsgAlert("O Entregador deve ser preenchido!!!!","Campo sem preenchimento")
				_lRet:=.F.
			EndIF
		EndIF
	Else
		IF Empty(SZ1->Z1_DTENTRE)
			MsgAlert("A Data da entrega deve ser preenchida!!!!","Campo sem preenchimento")
				_lRet:=.F.			
		EndIF
	EndIF	
EndIF

RestArea(_aArea)                       
Return(_lRet)
