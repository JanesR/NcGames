#Define Enter Chr(13)+Chr(10)

#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"



User Function NCGAtuJOB(cTabela)
Default cTabela:="SD2"

RpcSetEnv("01","03")  
u_NCGAtuSX3(cTabela)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGATUSX3 ºAutor  ³Microsiga           º Data ³  01/14/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGAtuSX3(cTabela)
Local cAliasTab
Local cAliasQry:=GetNextAlias()
Local cMensagem:=""
Local bWhile	:={|| .T. }
//LimpaBase()


ProcRegua(SX3->(RecCount()))
SX3->(DbSetOrder(1))
SX3->(DbGoTop())

If !Empty(cTabela)
	SX3->(DbSeek(cTabela))
	bWhile:={|| SX3->X3_ARQUIVO==cTabela }
EndIf	



Do While SX3->(!Eof()) .And. Eval(bWhile)
	
	cAliasTab:=SX3->X3_ARQUIVO
	
	If !SX2->(DbSeek(cAliasTab))
		SX3->(DbSkip());Loop
	EndIf
	
	cTabela:=AllTrim(SX2->X2_ARQUIVO)
	
	If !TcCanOpen(cTabela)
		SX3->(DbSkip());Loop
	EndIf
	
	FechaArea(cAliasQry)
	DbUseArea( .T. , 'TOPCONN', cTabela,cAliasQry, .T., .F. )
	
	If Select(cAliasQry)==0
		SX3->(DbSkip());Loop
	EndIf
	
	
	aStructAtu:=(cAliasQry)->(DbStruct())
	aStructNew:={}
	
	lAlterado:=.F.
	Do While SX3->(!Eof()) .And. SX3->X3_ARQUIVO==cAliasTab
		
		IncProc("Tabela:"+SX3->X3_ARQUIVO)
		PtInternal( 1, "Tabela:	"+SX3->X3_ARQUIVO )
		TcInternal( 1, "Tabela:	"+SX3->X3_ARQUIVO )
		If SX3->X3_CONTEXT=="V" .And. (cAliasQry)->(FieldPos( AllTrim(SX3->X3_CAMPO) ))>0
			SX3->(RecLock("SX3",.F.))
			SX3->X3_CONTEXT:="R"
			SX3->(MsUnLock())
		EndIf
		
		If SX3->X3_CONTEXT<>"V"
			lAlterado:=.T.
			Aadd( aStructNew,{ SX3->X3_CAMPO, SX3->X3_TIPO , SX3->X3_TAMANHO, SX3->X3_DECIMAL } )
		EndIf
		
		If (cAliasQry)->(FieldPos( AllTrim(SX3->X3_CAMPO) ))==0
			lAlterado:=.T.
		EndIf
		
		SX3->(DbSkip())
	EndDo
	FechaArea(cAliasQry)
	
	If lAlterado .Or. Len(aStructAtu)<>Len(aStructNew)
		nTopErr:=Nil
		
		If Select(cAliasTab)>0
			(cAliasTab)->(DbCloseArea())                                       
		EndIf
		
		DbSelectarea("SX3")
		If TcAlter( cTabela , aStructAtu, aStructNew, @nTopErr )
			cMensagem+="Tabela "+cTabela+" Alterada"+Enter
		Else
			cMensagem+="Erro "+AllTrim(Str(nTopErr))+" ao alterar a tabela "+cTabela+Enter
		EndIf
	EndIf
	
	FechaArea(cAliasQry)
EndDo


//AVISO(ProcName(0), cMensagem, {"Ok"}, 3)
MsgInfo("FIm")


Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGATUSX3 ºAutor  ³Microsiga           º Data ³  01/14/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function LimpaBase()
Local lTabVazio
Local cAliasQry:=GetNextAlias()
Local cTabela
Local cTabApaga:=""


SX2->(DbGoTop())
Do While SX2->(!Eof())
	
	cTabela:=AllTrim(SX2->X2_ARQUIVO)
	
	PtInternal( 1, "Tabela:	"+cTabela )
	TcInternal( 1, "Tabela:	"+cTabela )
	
	
	If !TcCanOpen(cTabela)
		SX2->(DbSkip());Loop
	EndIf
	
	FechaArea(cAliasQry)
	DbUseArea( .T. , 'TOPCONN', cTabela,cAliasQry, .T., .F. )
	lTabVazio:=.T.
	
	(cAliasQry)->(DbGoTop())
	
	Do While (cAliasQry)->(!Eof())
		lTabVazio:=.F.
		Exit
	EndDo
	
	FechaArea(cAliasQry)
	
	
	If lTabVazio .And. TCDELFile(cTabela)
		cTabApaga+="Tabela "+cTabela+" apagada"+Enter
	EndIf
	
	SX2->(DbSkip())
EndDo

AVISO(ProcName(0), cTabApaga, {"Ok"}, 3)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGATUSX3 ºAutor  ³Microsiga           º Data ³  01/14/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FechaArea(cAliasTemp)

If Select(cAliasTemp)>0
	(cAliasTemp)->(DbCloseArea())
EndIf

Return