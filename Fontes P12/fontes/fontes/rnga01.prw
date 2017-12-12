#INCLUDE 'rwmake.ch'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RNGA01    ºAutor  ³ROGER CANGIANELI    º Data ³  04/15/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera lançamentos de itens zerados no inventario, se houver  º±±
±±º          ³registro de saldos do produto no SB2                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RNGA01()

SetPrvt('cPerg,cMsg,')

cPerg	:= 'ESTP01'
ValidPerg()

If !Pergunte(cPerg,.T.)
	Return
EndIf

If Empty(MV_PAR01) .or. Empty(MV_PAR02)
	MsgBox('Parametros invalidos. Corrija e refaça a rotina.','Atencao','Stop')
	Return
EndIf

cMsg	:= 'Este procedimento ira gerar itens zerados no estoque, de forma a '
cMsg	+= 'remover a quantidade dos produtos nao contados. '
cMsg	+= 'Rotina irreversivel, tenha extremo cuidado ao executar. '
cMsg	+= 'SERA GRAVADO O LOG DO USUARIO QUE UTILIZAR ESTA ROTINA. '
cMsg	+= 'Tem certeza que deseja continuar? '
If Msgbox(cMsg, 'CUIDADO AO EXECUTAR', 'YESNO')

	cMsg	:= 'Ao confirmar iniciara o processo, nao podera ser abortado e '
	cMsg	+= 'registrara o usuario. '
	cMsg	+= 'MUITO CUIDADO AO EXECUTAR. Deseja continuar?'
	If Msgbox(cMsg, 'OPERACAO IRREVERSIVEL', 'YESNO')
		Processa({|| _RunProc()}, 'Gerando contagem de inventario')
	EndIf

EndIf


Return



Static Function _RunProc()

dbSelectArea('SB1')
dbSetOrder(1)

dbSelectArea('SB7')
dbSetOrder(1)

dbSelectArea('SB2')
ProcRegua(RecCount())
dbSetOrder(1)
dbSeek(xFilial("SB2"))
While !Eof() .and. SB2->B2_FILIAL == xFilial("SB2")
	IncProc('Prod/Almox:'+AllTrim(SB2->B2_COD)+'/'+SB2->B2_LOCAL)
	
	
	dbSelectArea('SB1')
	If dbSeek(xFilial('SB1')+SB2->B2_COD,.F.)
		
		dbSelectArea('SB7')
		If !dbSeek(xFilial("SB7")+DTOS(MV_PAR01)+SB2->B2_COD+SB2->B2_LOCAL,.F.)
			RecLock('SB7',.T.)
			SB7->B7_FILIAL	:= XFILIAL('SB7')
			SB7->B7_COD		:= SB2->B2_COD
			SB7->B7_LOCAL	:= SB2->B2_LOCAL
			SB7->B7_TIPO	:= SB1->B1_TIPO
			SB7->B7_DOC		:= MV_PAR02
			SB7->B7_QUANT	:= 0
			SB7->B7_QTSEGUM:= 0
			SB7->B7_DATA	:= MV_PAR01
			SB7->B7_DTVALID:= MV_PAR01
			msUnlock()
		EndIf
		
	Else
		dbSelectArea('SB2')
		RecLock('SB2',.F.)
		dbDelete()
		msUnlock()
		
	EndIf
	
	dbSelectArea('SB2')
	dbSkip()
	
EndDo

MsgBox('Processamento Finalizado','AVISO','Alert')

Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³VALIDPERG ³ Autor ³ RAIMUNDO PEREIRA      ³ Data ³ 01/08/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³ Verifica as perguntas inclu¡ndo-as caso n„o existam        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ValidPerg()
_aAreaVP := GetArea()
DBSelectArea("SX1")
DBSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AADD(aRegs,{cPerg,"01","Data do Inventario   ?","","","mv_ch1","D", 8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Numero do Documento  ?","","","mv_ch2","C", 6,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !DBSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to Len(aRegs[i])
			FieldPut(j,aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next

RestArea(_aAreaVP)
Return
