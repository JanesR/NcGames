#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.ch"
#INCLUDE "protheus.ch"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGRVITC  �Autor  �Microsiga           � Data �  05/14/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGRVITC()

Local aArea := GetArea()

Processa( {|| GRVITC() },"", "Sincroniza��o de dados" )

RestArea(aArea)
Return                


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GRVITC 	�Autor  �Microsiga           � Data �  05/14/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Realiza a grava��o do item contabil                        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
	If Aviso("Erro","Alguns registros n�o foram importados. Deseja visualizar o log de erro ?",{"Sim","N�o"},2) == 1
    	CtRConOut(aMsgErro)
	EndIf
Else
	Aviso("Exito", "Processamento realizado com sucesso.",{"Ok"},2) 
EndIf


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return

                      

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RunGrvItC �Autor  �Microsiga           � Data �  07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Executa automatica para gravar o item contabil		      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RunGrvItC(aDados, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aDados := {} 
Default nOpc	:= 3//Inclus�o

//Inicio da transa��o
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
		
		//Rollback da transa��o
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Dados n�o informados"
EndIf

//Finalisa a transa��o
End Transaction

RestArea(aArea)
Return cRet



