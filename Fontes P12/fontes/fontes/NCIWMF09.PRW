#Include "PROTHEUS.CH "


#DEFINE EMPDEST 	 1
#DEFINE FILDEST 	 2  
#DEFINE CODFIN		 3
#DEFINE DESCFIN		 4
         

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WMF01JOB  �Autor  �Microsiga           � Data �  05/14/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WMF09JOB(aDados)
Default aDados := {"01","03"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
U_NCIWMF09()
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCIWMF09 �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Atualiza��o do tipo financeiro atraves da Schedule 		  ���
���          �												    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCIWMF09()
Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local nCnt		:= 0

cQuery	:= " SELECT DISTINCT PZP_EMPORI, PZP_FILORI, PZP_CODFIN, PZP_DESCFI FROM "+RetSqlName("PZP")
cQuery	+= " WHERE PZP_FILIAL = '"+xFilial("PZP")+"' "
cQuery	+= " AND D_E_L_E_T_ = ' ' "
cQuery	+= " ORDER BY PZP_EMPORI, PZP_FILORI, PZP_DESCFI, PZP_CODFIN "

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )

ProcRegua(nCnt)


While (cArqTmp)->(!Eof())
    
    IncProc("Atualizando Cadastro Tp.Financeiro...")
	
	//Executa a job para gravar os titulos na empresa destino
	StartJob( "U_NCGTpFin", GetEnvServer(), .T.,{	Alltrim((cArqTmp)->PZP_EMPORI),;//Empresa origem a ser gerado o titulo
													Alltrim((cArqTmp)->PZP_FILORI),;//Filial origem a ser gerado o titulo
													(cArqTmp)->PZP_CODFIN,;			//Codigo financeiro
													(cArqTmp)->PZP_DESCFI;			//Descri��o
													} )          

	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GrvTpFin �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Grava o tipo financeiro 					 		  		  ���
���          �												    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGTpFin(aDados)

Local aArea := {}
//Posiciona na empresa e filial correspondente para gera��o do titulo 
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[EMPDEST], aDados[FILDEST])

aArea := GetArea()

DbSelectArea("PZU")
DbSetOrder(1)
If !PZU->(MsSeek(xFilial("PZU")+PADR(aDados[CODFIN],TAMSX3("PZU_CODFIN")[1])  ))

	RECLOCK("PZU", .T.)
	PZU->PZU_CODFIN := aDados[CODFIN]
	PZU->PZU_DESCFI	:= aDados[DESCFIN]		
	PZU->(MsUnLock())

EndIf

RestArea(aArea)
Return
      
