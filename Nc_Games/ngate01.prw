#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO2     º Autor ³ AP6 IDE            º Data ³  13/09/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function NGATE01()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_aArea	:= GetArea()

// Posiciona no indice que ira utilizar
dbSelectArea('SBS')	
dbSetOrder(1)

	_cFabr	:= ''
	_cFabric:= ''
	_cPlat	:= ''
	_cNome	:= ''
	_cCor	:= ''
	_cEmb	:= ''
	_cQtd	:= ''
	

	// Tratamento de descricoes para jogos
	If Subs(SB1->B1_COD,1,2) == '01'
		_cBase	:= '01'+Space(12)
		
		dbSelectArea('SBS')	
		// Posiciona no fabricante
		If dbSeek(xFilial('SBS')+_cBase+'05'+Space(08)+SUBS(SB1->B1_COD,3,2), .f.)
			_cFabr	:= AllTrim(SBS->BS_DESCPRD)
			_cFabric:= AllTrim(SBS->BS_DESCR)
		EndIf
		
		// Posiciona na plataforma
		If dbSeek(xFilial('SBS')+_cBase+'01'+Space(08)+SUBS(SB1->B1_COD,5,2), .f.)
			_cPlat	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		// Posiciona no nome
		If dbSeek(xFilial('SBS')+_cBase+'02'+Space(08)+SUBS(SB1->B1_COD,7,5), .f.)
			_cNome	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		_cRet	:= _cNome+' '+_cPlat+' '+_cFabr
		
	//ElseIf Subs(SB1->B1_COD,1,2) == '02'
	ElseIf Subs(B1_COD,1,2) == '02'
		_cBase	:= '02'+Space(12)
		
		dbSelectArea('SBS')	
		// Posiciona no fabricante
		If dbSeek(xFilial('SBS')+_cBase+'03'+Space(08)+SUBS(SB1->B1_COD,3,2), .f.)
			_cFabr	:= AllTrim(SBS->BS_DESCPRD)
			_cFabric:= AllTrim(SBS->BS_DESCR)
		EndIf
		
		// Posiciona na plataforma
		If dbSeek(xFilial('SBS')+_cBase+'02'+Space(08)+SUBS(SB1->B1_COD,5,2), .f.)
			_cPlat	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		// Posiciona no nome
		If dbSeek(xFilial('SBS')+_cBase+'01'+Space(08)+SUBS(SB1->B1_COD,7,5), .f.)
			_cNome	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		// Posiciona na cor
		If dbSeek(xFilial('SBS')+_cBase+'04'+Space(08)+SUBS(SB1->B1_COD,12,2), .f.)
			_cCor	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		_cRet	:= _cNome+' '+_cCor+' '+_cPlat+' '+_cFabr
		
	ElseIf Subs(SB1->B1_COD,1,2) == '03'
		_cBase	:= '03'+Space(12)
		
		dbSelectArea('SBS')	
		// Posiciona no fabricante
		If dbSeek(xFilial('SBS')+_cBase+'03'+Space(08)+SUBS(SB1->B1_COD,3,2), .f.)
			_cFabr	:= AllTrim(SBS->BS_DESCPRD)
			_cFabric:= AllTrim(SBS->BS_DESCR)
		EndIf
		
		// Posiciona na plataforma
		If dbSeek(xFilial('SBS')+_cBase+'02'+Space(08)+SUBS(SB1->B1_COD,5,2), .f.)
			_cPlat	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		// Posiciona no nome
		If dbSeek(xFilial('SBS')+_cBase+'01'+Space(08)+SUBS(SB1->B1_COD,7,5), .f.)
			_cNome	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		// Posiciona na cor
		If dbSeek(xFilial('SBS')+_cBase+'04'+Space(08)+SUBS(SB1->B1_COD,12,2), .f.)
			_cCor	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		_cRet	:= _cNome+' '+_cCor+' '+_cFabr
		
	ElseIf Subs(SB1->B1_COD,1,2) == '04'
		_cBase	:= '04'+Space(12)
		
		dbSelectArea('SBS')	
		// Posiciona no fabricante
		If dbSeek(xFilial('SBS')+_cBase+'04'+Space(08)+SUBS(SB1->B1_COD,3,2), .f.)
			_cFabr	:= AllTrim(SBS->BS_DESCPRD)
			_cFabric:= AllTrim(SBS->BS_DESCR)
		EndIf
		
		// Posiciona na plataforma
		If dbSeek(xFilial('SBS')+_cBase+'01'+Space(08)+SUBS(SB1->B1_COD,5,2), .f.)
			_cPlat	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		// Posiciona no nome
		If dbSeek(xFilial('SBS')+_cBase+'02'+Space(08)+SUBS(SB1->B1_COD,7,5), .f.)
			_cNome	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		// Posiciona na cor
		If dbSeek(xFilial('SBS')+_cBase+'03'+Space(08)+SUBS(SB1->B1_COD,12,2), .f.)
			_cCor	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		_cRet	:= _cNome+' '+_cCor+' '+_cFabr

	ElseIf Subs(SB1->B1_COD,1,2) == '05'
		_cBase	:= '05'+Space(12)
		
		dbSelectArea('SBS')	
		// Posiciona no fabricante
		If dbSeek(xFilial('SBS')+_cBase+'01'+Space(08)+SUBS(SB1->B1_COD,3,2), .f.)
			_cFabr	:= AllTrim(SBS->BS_DESCPRD)
			_cFabric:= AllTrim(SBS->BS_DESCR)
		EndIf
		
		// Posiciona na plataforma
		If dbSeek(xFilial('SBS')+_cBase+'02'+Space(08)+SUBS(SB1->B1_COD,5,2), .f.)
			_cPlat	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		// Posiciona no nome
		If dbSeek(xFilial('SBS')+_cBase+'03'+Space(08)+SUBS(SB1->B1_COD,7,5), .f.)
			_cNome	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		// Posiciona na Embalagem
		If dbSeek(xFilial('SBS')+_cBase+'04'+Space(08)+SUBS(SB1->B1_COD,12,1), .f.)
			_cEmb	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		// Posiciona na quantidade
		If dbSeek(xFilial('SBS')+_cBase+'05'+Space(08)+SUBS(SB1->B1_COD,13,1), .f.)
			_cQtd	:= AllTrim(SBS->BS_DESCPRD)
		EndIf
		
		_cRet	:= _cPlat+' '+_cNome+' '+_cEmb+' '+_cQtd		//+' '+_cFabr
   
	EndIf

RestArea(_aArea)
Return(_cRet)
