#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.ch"
#INCLUDE "protheus.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRVITC  ºAutor  ³Microsiga           º Data ³  05/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGRVITC()

Local aArea := GetArea()

Processa( {|| GRVITC() },"", "Sincronização de dados" )

RestArea(aArea)
Return                


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GRVITC 	ºAutor  ³Microsiga           º Data ³  05/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Realiza a gravação do item contabil                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GRVITC()

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local aItContab	:= {}
Local cMsgErr	:= {}
Local aMsgErro	:= {}
Local nCnt		:= 0

cQuery    := " SELECT 'CLIENTE' TPCAD, A1_COD COD, A1_LOJA LOJA, A1_NOME NOME FROM "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery    += " WHERE SA1.A1_FILIAL = '"+xFilial("SA1")+"'  "+CRLF
cQuery    += " AND SA1.A1_MSBLQL = '2'  "+CRLF
cQuery    += " AND SA1.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += " AND NOT EXISTS ( SELECT 'X' FROM "+RetSqlName("CTD")+" CTD "+CRLF
cQuery    += "                   WHERE CTD.CTD_FILIAL = SA1.A1_FILIAL "+CRLF
cQuery    += "                   AND TRIM(CTD.CTD_ITEM) = 'C'||TRIM(SA1.A1_COD)||TRIM(SA1.A1_LOJA) "+CRLF
cQuery    += "                   AND CTD.D_E_L_E_T_ = ' ' "+CRLF 
cQuery    += "                 ) "+CRLF
cQuery    += " UNION ALL "+CRLF
cQuery    += " SELECT 'FORNECEDOR' TPCAD, A2_COD COD, A2_LOJA LOJA, A2_NOME NOME FROM "+RetSqlName("SA2")+" SA2 "+CRLF
cQuery    += " WHERE SA2.A2_FILIAL = '"+xFilial("SA2")+"'  "+CRLF
cQuery    += " AND SA2.A2_MSBLQL = '2'  "+CRLF
cQuery    += " AND SA2.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += " AND NOT EXISTS ( SELECT 'X' FROM "+RetSqlName("CTD")+" CTD "+CRLF
cQuery    += "                   WHERE CTD.CTD_FILIAL = SA2.A2_FILIAL "+CRLF
cQuery    += "                   AND TRIM(CTD.CTD_ITEM) = 'F'||TRIM(SA2.A2_COD)||TRIM(SA2.A2_LOJA) "+CRLF 
cQuery    += "                   AND CTD.D_E_L_E_T_ = ' ' "+CRLF 
cQuery    += "                 ) "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)	

(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )

ProcRegua(nCnt)

While (cArqTmp)->(!Eof())    

    IncProc("Processando...")
                  
    aItContab:={}
    
    If Alltrim((cArqTmp)->TPCAD) ==  "CLIENTE"
	    AADD(aItContab,	{"CTD_ITEM","C"+Alltrim((cArqTmp)->COD)+Alltrim((cArqTmp)->LOJA)		,Nil})
		AADD(aItContab,	{"CTD_CLASSE", "2"															,Nil})
		AADD(aItContab,	{"CTD_DESC01",Alltrim((cArqTmp)->NOME)									,Nil})
	Else
	    AADD(aItContab,	{"CTD_ITEM","F"+Alltrim((cArqTmp)->COD)+Alltrim((cArqTmp)->LOJA)		,Nil})
		AADD(aItContab,	{"CTD_CLASSE", "2"															,Nil})
		AADD(aItContab,	{"CTD_DESC01",Alltrim((cArqTmp)->NOME)									,Nil})	
	EndIf
	               
	
	cMsgErr := RunGrvItC(aItContab, 3 )
	
	If !Empty(cMsgErr)
		Aadd(aMsgErro,cMsgErr )
		Aadd(aMsgErro,"--------------------------------------------------------------------------------------------" )
		Aadd(aMsgErro,"--------------------------------------------------------------------------------------------" )
		Aadd(aMsgErro,"--------------------------------------------------------------------------------------------" )
	EndIf
	
	(cArqTmp)->(DbSkip())
EndDo

If Len(aMsgErro) > 0
	If Aviso("Erro","Alguns registros não foram importados. Deseja visualizar o log de erro ?",{"Sim","Não"},2) == 1
    	CtRConOut(aMsgErro)
	EndIf
Else
	Aviso("Exito", "Processamento realizado com sucesso.",{"Ok"},2) 
EndIf


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return

                      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RunGrvItC ºAutor  ³Microsiga           º Data ³  07/04/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Executa automatica para gravar o item contabil		      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RunGrvItC(aDados, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aDados := {} 
Default nOpc	:= 3//Inclusão

//Inicio da transação
Begin Transaction

//Verifica se os dados foram informados
If (Len(aDados) > 0)
	
	//Chama a rotina automatica para gravar os dados da nota de entrada
	MsExecAuto({|x,y| CTBA040(x,y)}, aDados, nOpc)

	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		//Captura a mensagem de erro
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		
		//Rollback da transação
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Dados não informados"
EndIf

//Finalisa a transação
End Transaction

RestArea(aArea)
Return cRet



