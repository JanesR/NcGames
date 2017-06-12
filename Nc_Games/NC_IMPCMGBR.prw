#INCLUDE "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCRCMGBR	บAutor  ณMicrosiga		 	 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de processamento do itens do arquivo	              บฑฑ
ฑฑบ          ณ											                  บฑฑ
ฑฑฬอออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCRCMGBR(aEmp)

Local aArea 	:= GetArea()          
Local aParams   := {} 
Local cTimeIni	:= ""
Local cTimeFim	:= ""
                            
Default aEmp := {"01","03"}

	
If Aviso("Aten็ใo", "*Antes de executar esta rotina ้ recomendแvel executar o recalculo do custo m้dio (Rotina Padrใo). Deseja continuar ?",;
	{"Sim","Nใo"},2) == 1
	
	//Pergunta para processamento somente de produto de/ate
	If PergCMGBR(@aParams)
		
		//Chama a rotina para efetuar o recalculo do custo BR
		Processa({|lEnd|  RecCMGBR(aParams[1], aParams[2]) }, 'Recalculo CMG...')
	EndIf
EndIf

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCJOBCMG	บAutor  ณMicrosiga		 	 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณJob de recalculo do CMG BR e PP				              บฑฑ
ฑฑบ          ณ											                  บฑฑ
ฑฑฬอออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCJOBCMG(aEmp)

Default aEmp := {"01","03"}

RpcClearEnv()
RPCSetType(3)
RpcSetEnv(aEmp[1],aEmp[2])

//Chama a rotina para efetuar o recalculo do custo BR
RecCMGBR("", "ZZZZZZZZZZZZZZZ")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCRCMGBR	บAutor  ณMicrosiga		 	 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de processamento do itens do arquivo	              บฑฑ
ฑฑบ          ณ											                  บฑฑ
ฑฑฬอออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RecCMGBR(cProdDe, cProdAte)

Local aArea 	:= GetArea()         
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()  
Local dDtIni	:= CTOD('01/08/2013')//GetMV('MV_ULMES')+1
Local dDtFim	:= MsDate()
Local nCnt		:= 0   

Default cProdDe 	:= ""
Default cProdAte    := ""  
                            
	
cQuery	:= " SELECT B1_COD, B1_XDESC FROM "+RetSqlName("SB1")+" SB1 "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SB5")+" SB5 "+CRLF
cQuery	+= " ON SB5.B5_FILIAL = '"+xFilial("SB5")+"' "+CRLF
cQuery	+= " AND SB5.B5_COD = SB1.B1_COD "+CRLF
cQuery	+= " AND SB5.B5_YSOFTW != '1' "+CRLF
cQuery	+= " AND SB5.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " WHERE SB1.B1_FILIAL = '"+xFilial("SB1")+"'  "+CRLF
cQuery	+= " AND SB1.B1_COD BETWEEN '"+cProdDe+"' AND '"+cProdAte+"' "+CRLF
cQuery	+= " AND SB1.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )

ProcRegua( nCnt )

While (cArqTmp)->(!Eof())
	
	IncProc("Produto: " + (cArqTmp)->B1_COD )    
	//Calcula CMG BR
	RunCMGBR( dDtIni, dDtFim, (cArqTmp)->B1_COD)  

	//Calcula CMG PP
	RecCMGPP((cArqTmp)->B1_COD, (cArqTmp)->B1_COD)
	(cArqTmp)->(DbSkip())
EndDo
	
(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPergCMGBR	บAutor  ณMicrosiga		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Perguntas a serem utilizadas no filtro 				      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergCMGBR(aParams)

Local aParamBox := {}
Local lRet      := .T.

AADD(aParamBox,{1,"Produto de:"					,Space(TAMSX3("B1_COD")[1])		,"@!"	,"","SB1","",70,.F.})
AADD(aParamBox,{1,"Produto at้:"					,Space(TAMSX3("B1_COD")[1])		,"@!"	,"","SB1","",70,.F.})

lRet := ParamBox(aParamBox, "Parโmetros", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .t., .t.)

Return lRet           

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณTabTempBR	บAutor  ณMicrosiga		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTabela temporaria para calculo do CMG BR 				      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function TabTempBR()

Local aArea := GetArea()
Local aCmp	:= {}
Local cArq	:= ""

aAdd (aCmp, {"YYY_FILIAL"	,"C", 002,	0})
aAdd (aCmp, {"YYY_COD"		,"C", 015,	0})
aAdd (aCmp, {"YYY_LOCAL"	,"C", 002,	0})
aAdd (aCmp, {"YYY_QUANT"	,"N", 014,	2})
aAdd (aCmp, {"YYY_YCMGBR"	,"N", 015,	4})
aAdd (aCmp, {"YYY_YTCMG"	,"N", 015,	2})

cArq	:=	CriaTrab (aCmp)
DbUseArea (.T., __LocalDriver, cArq, cArqBR)
IndRegua (cArqBR, cArq, "YYY_FILIAL+YYY_COD+YYY_LOCAL")

RestArea(aArea)
Return
               

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGrvSBR	บAutor  ณMicrosiga		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava o custo medio gerencial na tabela temporaria	      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvSBR(cCod, cLocal, nQtd, nVal, lSaida) 

Local aArea 	:= GetArea()

Default cCod	:= "" 
Default cLocal	:= "" 
Default nQtd	:= 0 
Default nVal	:= 0 
Default lSaida	:= .F.

DbSelectArea(cArqBR)
DbSetOrder(1)
If (cArqBR)->(DbSeek(xFilial("SB2") + PADR(cCod, TAMSX3("B2_COD")[1]) + PADR(cLocal, TAMSX3("B2_LOCAL")[1])   ))
	
	//Verifica se a atualiza็ใo vem de um documento de saida
	If lSaida

		//Atualiza o total do CMG BR
		RecLock(cArqBR,.F.)
		(cArqBR)->YYY_QUANT -= nQtd 
		(cArqBR)->YYY_YTCMG -= nVal  
		
		If (cArqBR)->YYY_QUANT != 0
			(cArqBR)->YYY_YCMGBR := (cArqBR)->YYY_YTCMG / (cArqBR)->YYY_QUANT
		EndIf
		
		(cArqBR)->(MsUnLock())

	Else//Atualiza็ใo de entrada
		
		RecLock(cArqBR,.F.)
        
        (cArqBR)->YYY_QUANT += nQtd  
		(cArqBR)->YYY_YTCMG += nVal
		
		If (cArqBR)->YYY_QUANT != 0
			(cArqBR)->YYY_YCMGBR	:=  (cArqBR)->YYY_YTCMG  / (cArqBR)->YYY_QUANT
		EndIf
        
		(cArqBR)->(MsUnLock())
	EndIf
EndIf


RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณRunCMGBR	บAutor  ณMicrosiga		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de recalculo do custo BR						      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RunCMGBR( dDatIni, dDatFin, cCodPro)

Local aAreaAtu		:= GetArea()
Local lFCalcCmgBR	:= .F.//Fornecedor que calcula cmg br
Local lPCalcCmgBR	:= .F.//Produto que calcula cmg br
Local cQry			:= ""
Local cArqQry		:= GetNextAlias()
Local nCustAux		:= 0
Local nPercMidia	:= U_MyNewSX6(	"NC_PCMGBRM",;
								"-5.5",;
								"N",;
								"Percentual para compor o valor do CMG BR Midia",;
								"Percentual para compor o valor do CMG BR Midia",;
								"Percentual para compor o valor do CMG BR Midia",;
								.F. )  
								
Private cArqBR := GetNextAlias()								


Default dDatIni := CTOD('')
Default dDatFin := CTOD('')
Default cCodPro	:= ""                              


//Chama a rotina para criar a tabela temporaria
TabTempBR()

//Atualiza a tabela temporaria com o saldo do ultimo fechamento (SB9), anterior a data de referencia
AtuTpSB2(cCodPro, dDatIni)


cQry	:= " SELECT SD1.D1_DTDIGIT DATMOV,SD1.D1_SEQCALC SEQUEN,SD1.D1_QUANT QDEENT,0 QDESAI,SD1.D1_CUSTO CUSFIS, "+CRLF 

cQry	+= " (CASE WHEN SD1.D1_YCMGBR != 0 "+CRLF
cQry	+= " 			THEN SD1.D1_YCMGBR "+CRLF
cQry	+= " ELSE SD1.D1_CUSTO   "+CRLF
cQry	+= " END) CUSENTBR, "+CRLF
cQry	+= " 0 CUSSAIBR,'SD1' TIPO,SD1.D1_TES TIPMOV,'1' SEQPROC, SD1.D1_LOCAL ARMAZEM, SD1.R_E_C_N_O_ NC_RECNO, SF4.F4_YTIPONF TPMOVMSO, D1_YPERCBR PERCBR "+CRLF

cQry	+= " FROM " + RetSqlName( "SD1" ) + " SD1, "+RetSqlName( "SF4" ) + " SF4 "+CRLF
cQry	+= " 		WHERE SD1.D1_FILIAL = '" + xFilial( "SD1" ) + "'"+CRLF
cQry	+= " 		AND SD1.D1_COD = '" + cCodPro + "' "+CRLF
cQry	+= " 		AND SD1.D1_DTDIGIT  BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "'"
cQry	+= " 		AND SD1.D1_ORIGLAN <> 'LF' "+CRLF
cQry	+= " 		AND SD1.D_E_L_E_T_ = ' ' "+CRLF
cQry	+= " 		AND SF4.F4_FILIAL = '" + xFilial( "SF4" ) + "' "+CRLF
cQry	+= " 		AND SF4.F4_CODIGO = SD1.D1_TES "+CRLF
//cQry	+= " 		AND SF4.F4_ESTOQUE = 'S' "+CRLF
cQry	+= " 		AND SF4.D_E_L_E_T_ = ' ' "+CRLF

cQry	+= " UNION ALL "+CRLF 
cQry	+= " SELECT SD2.D2_EMISSAO DATMOV,SD2.D2_SEQCALC SEQUEN,0 QDEENT,SD2.D2_QUANT QDESAI,SD2.D2_CUSTO1 CUSFIS, 0 CUSENTBR, " +CRLF

cQry	+= " (CASE WHEN SD2.D2_YCMGBR != 0 "+CRLF
cQry	+= " 		THEN SD2.D2_YCMGBR "+CRLF
cQry	+= " 	ELSE SD2.D2_CUSTO1 "+CRLF
cQry	+= " END) CUSSAIBR, "+CRLF

cQry	+= " 'SD2' TIPO,SD2.D2_TES TIPMOV,'3' SEQPROC, SD2.D2_LOCAL ARMAZEM, SD2.R_E_C_N_O_ NC_RECNO, ' ' TPMOVMSO, 0 PERCBR "+CRLF

cQry	+= " FROM " + RetSqlName( "SD2" ) + " SD2, "+ RetSqlName( "SF4" ) + " SF4 "+CRLF
cQry	+= " 		WHERE SD2.D2_FILIAL = '" + xFilial( "SD2" ) + "' "+CRLF
cQry	+= " 		AND SD2.D2_COD = '" + cCodPro + "' "+CRLF
cQry	+= " 		AND SD2.D2_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "' "
cQry	+= " 		AND SD2.D_E_L_E_T_ = ' ' "+CRLF
cQry	+= " 		AND SF4.F4_FILIAL = '" + xFilial( "SF4" ) + "' "+CRLF
cQry	+= " 		AND SF4.F4_CODIGO = SD2.D2_TES " +CRLF
//cQry	+= " 		AND SF4.F4_ESTOQUE = 'S' " +CRLF
cQry	+= " 		AND SF4.D_E_L_E_T_ = ' ' "+CRLF

cQry	+= " UNION ALL "+CRLF
cQry	+= " SELECT SD3.D3_EMISSAO DATMOV,SD3.D3_SEQCALC SEQUEN,SD3.D3_QUANT QDEENT,0 SAIDA,SD3.D3_CUSTO1 CUSFIS, "+CRLF


cQry	+= " (CASE WHEN SD3.D3_YCMGBR != 0 "+CRLF
cQry	+= " 		THEN SD3.D3_YCMGBR "+CRLF
cQry	+= " 	ELSE SD3.D3_CUSTO1 "+CRLF
cQry	+= " END) CUSENTBR, "+CRLF

cQry	+= " 0 CUSSAIBR,'SD3E' TIPO,SD3.D3_TM TIPMOV,'2' SEQPROC, SD3.D3_LOCAL ARMAZEM, SD3.R_E_C_N_O_ NC_RECNO, ' ' TPMOVMSO, 0 PERCBR "+CRLF

cQry	+= " FROM " + RetSqlName( "SD3" ) + " SD3 "+CRLF
cQry	+= " 		WHERE SD3.D3_FILIAL = '" + xFilial( "SD3" ) + "' "+CRLF
cQry	+= " 		AND SD3.D3_COD = '" + cCodPro + "'"+CRLF
cQry	+= " 		AND SD3.D3_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "' "
cQry	+= " 		AND SD3.D3_TM <= '500' "+CRLF
If SuperGetMV('MV_D3ESTOR', .F., 'N') == 'N'
	cQry += " 		AND D3_ESTORNO <> 'S' "+CRLF
EndIf
cQry	+= " 		AND SD3.D_E_L_E_T_ = ' ' "+CRLF

cQry	+= " UNION ALL"+CRLF
cQry	+= " SELECT SD3.D3_EMISSAO DATMOV,SD3.D3_SEQCALC SEQUEN,0 QDEENT,SD3.D3_QUANT QDESAI,SD3.D3_CUSTO1 CUSFIS, 0 CUSENTBR,"+CRLF

cQry	+= " (CASE WHEN SD3.D3_YCMGBR != 0 "+CRLF
cQry	+= " 		THEN SD3.D3_YCMGBR "+CRLF
cQry	+= " 	ELSE SD3.D3_CUSTO1 "+CRLF
cQry	+= " END) CUSSAIBR, "+CRLF

cQry	+= " 'SD3S' TIPO,SD3.D3_TM TIPMOV,'4' SEQPROC, SD3.D3_LOCAL ARMAZEM, SD3.R_E_C_N_O_ NC_RECNO, ' ' TPMOVMSO, 0 PERCBR "+CRLF

cQry	+= " FROM " + RetSqlName( "SD3" ) + " SD3"+CRLF
cQry	+= " 		WHERE SD3.D3_FILIAL = '" + xFilial( "SD3" ) + "' "+CRLF
cQry	+= " 		AND SD3.D3_COD = '" + cCodPro + "' "+CRLF
cQry	+= " 		AND SD3.D3_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "'"
cQry	+= " 		AND SD3.D3_TM > '500'"+CRLF

If SuperGetMV('MV_D3ESTOR', .F., 'N') == 'N'
	cQry += " 		AND D3_ESTORNO <> 'S'"+CRLF
EndIf
cQry	+= " 		AND SD3.D_E_L_E_T_ = ' ' "+CRLF
cQry	+= " ORDER BY DATMOV, SEQUEN "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQry), cArqQry , .F., .T.)

TcSetField( cArqQry, "DATMOV", "D", 08, 00 )
TcSetField( cArqQry, "CUSFIS", "N", 18, 02 )
TcSetField( cArqQry, "QDEENT", "N", 18, 02 )
TcSetField( cArqQry, "QDESAI", "N", 18, 02 )
TcSetField( cArqQry, "CUSENTBR", "N", 18, 02 )
TcSetField( cArqQry, "CUSSAIBR", "N", 18, 02 )


(cArqQry)->(DbGoTop())

DbSelectArea("SD1")
DbSetOrder(1)

DbSelectArea("SD2")
DbSetOrder(1)

DbSelectArea("SD3")
DbSetOrder(1)

DbSelectArea("SA2")
DbSetOrder(1)

DbSelectArea("SB5")
DbSetOrder(1)

DbSelectArea("SF4")
DbSetOrder(1)             

While (cArqQry)->(!Eof())
    

	//Atualiza osdbm documentos com o valor do CMG BR atual
	If 'SD1' $ (cArqQry)->TIPO
	
		nCustAux := 0
		SD1->(DbGoTo((cArqQry)->NC_RECNO) ) 
		                                        
		//Verifica se a TES movimenta estoque
		If SF4->(DbSeek(xFilial("SF4") + SD1->D1_TES))

			//Senใo movimenta estoque, o custo serแ o mesmo que o contabil
			If Alltrim(SF4->F4_ESTOQUE) == 'N'
				RecLock("SD1",.F.)
				SD1->D1_YCMGBR := SD1->D1_CUSTO
				SD1->(MsUnLock())
				(cArqQry)->(DbSkip());loop							
			EndIf			
		Else
			RecLock("SD1",.F.)
			SD1->D1_YCMGBR := SD1->D1_CUSTO
			SD1->(MsUnLock())
			(cArqQry)->(DbSkip());loop									
		EndIf
		                               
		//Se for devolu็ใo, o custo serแ o mesmo utilizado na saํda. Se nใo existir o custo, entใo serแ considerado o custo contabil
		If Alltrim(SD1->D1_TIPO) == 'D'
			nCustAux := GetCGBRDev(SD1->D1_COD, SD1->D1_LOCAL, SD1->D1_NFORI, SD1->D1_SERIORI)
						
			If nCustAux != 0
				RecLock("SD1",.F.)
				SD1->D1_YCMGBR := nCustAux * SD1->D1_QUANT 
				SD1->(MsUnLock())
			Else
				RecLock("SD1",.F.)
				SD1->D1_YCMGBR := SD1->D1_CUSTO
				SD1->(MsUnLock())
			EndIf

			//Atualiza a tabela temporaria
			GrvSBR(SD1->D1_COD, SD1->D1_LOCAL, SD1->D1_QUANT, SD1->D1_YCMGBR, .F.)
			
		Else
			lPCalcCmgBR := .F.   
         	lFCalcCMGBR	:= .F.
			nCustAux 	:= 0
			
			//Verifica se o fornecedor calcula o CMG BR
			If SA2->(MsSeek(xFilial("SA2") + SD1->D1_FORNECE + SD1->D1_LOJA) ) 
				If Alltrim(SA2->A2_YCMGBR) == '1'  	
					lFCalcCMGBR	:= .T.				
				Else
					lFCalcCMGBR	:= .F.			
				EndIf
			Else
				lFCalcCMGBR	:= .F.			
			EndIf	

			//Verifica se o produto calcula o CMG BR			
			If SB5->(MsSeek(xFilial("SB5") + SD1->D1_COD))
				If Alltrim(SB5->B5_YCMGBR) == "1"
					lPCalcCmgBR := .T.
				Else
					lPCalcCmgBR := .F.										
				EndIf			
			Else
				lPCalcCmgBR := .F.			
			EndIf			
			                            
			//Faz a verifica็ใo, se o produto e fornecedor estใo cadastrados para calcular CMG BR.  Caso contrแrio, serแ considerado o Custo Contabil.
			If lFCalcCMGBR .And. lPCalcCmgBR
			
				If Alltrim((cArqQry)->TPMOVMSO) $ "1" //Verifica se a nota ้ de midia
	                
					nCustAux := SD1->D1_CUSTO + ( (SD1->D1_CUSTO * nPercMidia ) / 100)				
				
				ElseIf Alltrim((cArqQry)->TPMOVMSO) $ "2|5"//Verifica se a nota ้ de software|outros
					
					If (cArqQry)->PERCBR != 0 
						nCustAux := SD1->D1_CUSTO + ( (SD1->D1_CUSTO * (cArqQry)->PERCBR ) / 100)
					Else
						nCustAux := SD1->D1_CUSTO					
					EndIf
				EndIf                        
				
			Else 
				nCustAux := SD1->D1_CUSTO
			EndIf                                                
			
			
			If nCustAux != 0
				RecLock("SD1",.F.)
				SD1->D1_YCMGBR := nCustAux
				SD1->(MsUnLock())
			Else 
				If SD1->D1_YCMGBR == 0		
					RecLock("SD1",.F.)
					SD1->D1_YCMGBR := SD1->D1_CUSTO 
					SD1->(MsUnLock())
				EndIf
			EndIf
         
			//Atualiza a tabela temporaria
			GrvSBR(SD1->D1_COD, SD1->D1_LOCAL, SD1->D1_QUANT, SD1->D1_YCMGBR, .F.)		
		EndIf   
			
	ElseIf 'SD2' $ (cArqQry)->TIPO
		nCustAux := 0
		
		SD2->(DbGoTo((cArqQry)->NC_RECNO) ) 
		
		
		//Verifica se a TES movimenta estoque
		If SF4->(DbSeek(xFilial("SF4") + SD2->D2_TES))
			
			//Senใo movimenta estoque, o custo serแ o mesmo que o contabil
			If Alltrim(SF4->F4_ESTOQUE) == 'N'
				RecLock("SD2",.F.)
				SD2->D2_YCMGBR := SD2->D2_CUSTO1
				SD2->(MsUnLock())
				(cArqQry)->(DbSkip());loop							
			EndIf			
		Else
			RecLock("SD2",.F.)
			SD2->D2_YCMGBR := SD2->D2_CUSTO1
			SD2->(MsUnLock())
			(cArqQry)->(DbSkip());loop									
		EndIf
		
		
		
				
		If (cArqBR)->(DbSeek(xFilial("SB2") + PADR(SD2->D2_COD, TAMSX3("B2_COD")[1]) + PADR(SD2->D2_LOCAL, TAMSX3("B2_LOCAL")[1])   ))
			
			//Verifica se ้ devolu็ใo de terceiro. Se for, serแ considerado o custo contabil	
			If DevTerc(SD2->D2_TES)
				nCustAux := SD2->D2_CUSTO1			
			Else
				nCustAux := (SD2->D2_QUANT * (cArqBR)->YYY_YCMGBR) 
			EndIf
		Else
			nCustAux := SD2->D2_CUSTO1
		EndIf
		
		RecLock("SD2",.F.)
		SD2->D2_YCMGBR := nCustAux
		SD2->(MsUnLock())

	    //Atualiza a tabela temporaria  
	    If !(DevTerc(SD2->D2_TES))
			GrvSBR(SD2->D2_COD, SD2->D2_LOCAL, SD2->D2_QUANT, SD2->D2_YCMGBR, .T.)
		EndIf
			
	ElseIf 'SD3' $ (cArqQry)->TIPO

		nCustAux := 0
		SD3->(DbGoTo((cArqQry)->NC_RECNO) )

		//O armazem destino, deverแ receber o valor do custo do armazem origem, efetuando o calculo do CMV
		If SD3->D3_TM > '500' 
            
   			//Verifica se ้ acerto de inventario
			If Alltrim(upper(SD3->D3_DOC)) == "INVENT"

				nCustAux := 0  
	            If (cArqBR)->(DbSeek(xFilial("SB2") + PADR(SD3->D3_COD, TAMSX3("B2_COD")[1]) + PADR(SD3->D3_LOCAL, TAMSX3("B2_LOCAL")[1])   ))
					If SD3->D3_QUANT != 0
						nCustAux := (SD3->D3_QUANT * (cArqBR)->YYY_YCMGBR) 
					Else
						nCustAux := SD3->D3_CUSTO1
					EndIf
				Else
					nCustAux := SD3->D3_CUSTO1
				EndIf  

				
				If nCustAux != 0
					RecLock("SD3",.F.)
					SD3->D3_YCMGBR := nCustAux
					SD3->(MsUnLock())
				Else
					RecLock("SD3",.F.)
					SD3->D3_YCMGBR := SD3->D3_CUSTO1
					SD3->(MsUnLock())
				EndIf
						                                                  
				GrvSBR(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_QUANT, SD3->D3_YCMGBR, .T.)
			          	

			Else
	            
				//Verifica se a tranferencia foi efetua pela baixa do CQ
				nCustAux := GetSd3Sai(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_DOC, SD3->D3_IDENT, SD3->D3_NUMSEQ, SD3->D3_QUANT )
				
				If nCustAux == 0            
		  			If (cArqBR)->(DbSeek(xFilial("SB2") + PADR(SD3->D3_COD, TAMSX3("B2_COD")[1]) + PADR(SD3->D3_LOCAL, TAMSX3("B2_LOCAL")[1])   ))
						If SD3->D3_QUANT != 0
							nCustAux := (SD3->D3_QUANT * (cArqBR)->YYY_YCMGBR) 
						Else
							If !(Alltrim(SD3->D3_TM) $ "303|501")
								nCustAux := SD3->D3_YCMGBR
							Else
								nCustAux := SD3->D3_CUSTO1
							EndIf
						EndIf
					Else
						nCustAux := SD3->D3_CUSTO1
					EndIf  
				EndIf
	            
				If nCustAux != 0
					RecLock("SD3",.F.)
					SD3->D3_YCMGBR := nCustAux
					SD3->(MsUnLock())
				Else
					RecLock("SD3",.F.)
					SD3->D3_YCMGBR := SD3->D3_CUSTO1
					SD3->(MsUnLock())
				
				EndIf
						                                                  
				GrvSBR(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_QUANT, SD3->D3_YCMGBR, .T.)
			EndIf
		Else
			
			//Verifica se ้ acerto de inventario
			If Alltrim(upper(SD3->D3_DOC)) == "INVENT"

				nCustAux := 0  
	         If (cArqBR)->(DbSeek(xFilial("SB2") + PADR(SD3->D3_COD, TAMSX3("B2_COD")[1]) + PADR(SD3->D3_LOCAL, TAMSX3("B2_LOCAL")[1])   ))
					If SD3->D3_QUANT != 0
						nCustAux := (SD3->D3_QUANT * (cArqBR)->YYY_YCMGBR) 
					Else
						nCustAux := SD3->D3_CUSTO1
					EndIf
				Else
					nCustAux := SD3->D3_CUSTO1
				EndIf  

				
				If nCustAux != 0
					RecLock("SD3",.F.)
					SD3->D3_YCMGBR := nCustAux
					SD3->(MsUnLock())
				Else
					RecLock("SD3",.F.)
					SD3->D3_YCMGBR := SD3->D3_CUSTO1
					SD3->(MsUnLock())
				EndIf
						                                                  
				GrvSBR(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_QUANT, SD3->D3_YCMGBR, .F.)
			          	

			Else

				nCustAux := 0
				nCustAux := GetSd3Ent(SD3->D3_COD, SD3->D3_DOC, DTOS(SD3->D3_EMISSAO), SD3->D3_NUMSEQ, SD3->D3_IDENT)
				
				If nCustAux != 0
					RecLock("SD3",.F.)
					SD3->D3_YCMGBR := nCustAux
					SD3->(MsUnLock())
				ElseIf !(Alltrim(SD3->D3_TM) $ "303|501")
					RecLock("SD3",.F.)
					SD3->D3_YCMGBR := SD3->D3_CUSTO1
					SD3->(MsUnLock())
				EndIf
				
						                                                  
				GrvSBR(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_QUANT, SD3->D3_YCMGBR, .F.)
				
			EndIf
		EndIf
	EndIf

	(cArqQry)->(DbSkip())
EndDo                                                                                                                       


DbSelectArea("SB2")
DbSetOrder(1)
(cArqBR)->(DbGoTop())
While (cArqBR)->(!Eof())
	
	//Grava o custo BR na tabela SB2	
	If SB2->( DbSeek(xFilial("SB2") + Padr((cArqBR)->YYY_COD, TAMSX3("B2_COD")[1] ) + PADR( (cArqBR)->YYY_LOCAL , TAMSX3("B2_LOCAL")[1])  )  )
		Reclock("SB2",.F.)

		SB2->B2_YCMGBR := (cArqBR)->YYY_YCMGBR 
		SB2->B2_YTCMGBR := (cArqBR)->YYY_YTCMG		
		SB2->(MsUnLock())			
	EndIf

	(cArqBR)->(DbSkip())
EndDo

(cArqBR)->(DbCloseArea())
(cArqQry)->(DbCloseArea())

RestArea( aAreaAtu )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGetSd3Ent	บAutor  ณMicrosiga		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o custo de transferencia na entrada			      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetSd3Ent(cCodProd, cDoc, cEmissao, cNumSeq, cIdent)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmpSd3	:= GetNextAlias()
Local nRet			:= 0

Default cCodProd	:= "" 
Default cDoc		:= "" 
Default cEmissao	:= ""                  
Default cIdent		:= ""
Default cNumSeq		:= ""

cQuery := " SELECT D3_YCMGBR, D3_CUSTO1, D3_TM FROM "+RetSqlName("SD3")+CRLF
cQuery += " WHERE D3_FILIAL = '"+xFilial("SD3")+"' "+CRLF
cQuery += "  AND D3_COD = '"+cCodProd+"' "+CRLF
cQuery += "  AND D3_DOC = '"+cDoc+"' "+CRLF
cQuery += "  AND D3_NUMSEQ = '"+cNumSeq+"' "+CRLF
cQuery += "  AND D3_IDENT = '"+cIdent+"' "+CRLF
cQuery += "  AND D3_EMISSAO = '"+cEmissao+"' "+CRLF
cQuery += "  AND SUBSTR(D3_CF,1,2) = 'RE' "+CRLF
cQuery += "  AND D_E_L_E_T_ = ' ' "      +CRLF
 
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmpSd3 , .F., .T.)

(cArqTmpSd3)->(DbGoTop())
If (cArqTmpSd3)->(!Eof())
	If (cArqTmpSd3)->D3_YCMGBR == 0
		
		If (cArqTmpSd3)->D3_TM != '303'
			nRet := (cArqTmpSd3)->D3_CUSTO1
		EndIf

	Else 
		nRet := (cArqTmpSd3)->D3_YCMGBR		
	EndIf              
Else            
	nRet := 0
EndIf

(cArqTmpSd3)->(DbCloseArea())

RestArea(aArea)
Return nRet
                         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGetSd3Sai	บAutor  ณMicrosiga		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o custo de transferencia na saida				      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetSd3Sai(cCodProd, cLocal, cDoc, cIdent, cNumSeq, nQuant)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmpSd3	:= GetNextAlias()
Local nRet			:= 0
Local nPercMidia	:= U_MyNewSX6(	"NC_PCMGBRM",;
								"-5.5",;
								"N",;
								"Percentual para compor o valor do CMG BR Midia",;
								"Percentual para compor o valor do CMG BR Midia",;
								"Percentual para compor o valor do CMG BR Midia",;
								.F. )

Default cCodProd	:= "" 
Default cLocal		:= "" 
Default cDoc		:= "" 
Default cIdent		:= ""                         
Default cNumSeq		:= ""
Default nQuant		:= 0                 


cQuery := " SELECT D7_PRODUTO, D7_NUMSEQ, D7_NUMERO, D7_TIPO, D7_QTDE, D7_SALDO, D7_SEQ, "+CRLF
cQuery += " D1_TIPO, D1_DOC, D1_SERIE, D1_COD, D1_FORNECE, D1_LOJA, D1_CUSTO, D1_YCMGBR, D1_YCUSGER, D1_YPERCBR, D1_TES, "+CRLF
cQuery += " D3_EMISSAO, D3_DOC, D3_LOCAL, D3_TM, D3_CF, D3_SEQCALC, D3_IDENT, "+CRLF
cQuery += " D3_NUMSEQ, D3_QUANT, D3_CUSTO1, D3_YCUSGER, D3_YCMGBR, F4_YTIPONF  FROM "+RetSqlName("SD7")+" SD7 "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SD1")+" SD1 "+CRLF
cQuery += " ON SD1.D1_FILIAL = SD7.D7_FILIAL "+CRLF
cQuery += " AND SD1.D1_COD = SD7.D7_PRODUTO "+CRLF
cQuery += " AND SD1.D1_DOC = SD7.D7_DOC "+CRLF
cQuery += " AND SD1.D1_LOCAL = SD7.D7_LOCAL "+CRLF
cQuery += " AND SD1.D1_SERIE = SD7.D7_SERIE "+CRLF
cQuery += " AND SD1.D1_FORNECE = SD7.D7_FORNECE "+CRLF
cQuery += " AND SD1.D1_LOJA = SD7.D7_LOJA "+CRLF 
cQuery += " AND SD1.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("SF4")+" SF4 "+CRLF
cQuery    += " ON SF4.F4_FILIAL = '"+xFilial("SF4")+"' "+CRLF
cQuery    += " AND SF4.F4_CODIGO = SD1.D1_TES "+CRLF
cQuery    += " AND SF4.D_E_L_E_T_ = ' ' "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SD3")+" SD3 "+CRLF
cQuery += " ON SD3.D3_DOC = SD7.D7_NUMERO "+CRLF
cQuery += " AND SD3.D3_LOCAL = SD7.D7_LOCAL "+CRLF
cQuery += " AND SD3.D3_COD = SD7.D7_PRODUTO "+CRLF
cQuery += " AND SD3.D3_IDENT = '"+cIdent+"' "+CRLF
cQuery += " AND SD3.D3_NUMSEQ = '"+cNumSeq+"' "+CRLF
cQuery += " AND SD3.D_E_L_E_T_ = ' ' "+CRLF

cQuery += " WHERE SD7.D7_FILIAL = '"+xFilial("SD7")+"' "+CRLF
cQuery += " AND SD7.D7_NUMERO = '"+cDoc+"'  "+CRLF
cQuery += " AND ((SD7.D7_NUMSEQ = '"+cIdent+"') OR (SD7.D7_NUMSEQ = '"+cNumSeq+"')) "+CRLF
cQuery += " AND SD7.D7_PRODUTO = '"+cCodProd+"' "+CRLF
cQuery += " AND SD7.D7_LOCAL = '"+cLocal+"' "+CRLF
cQuery += " AND SD7.D7_QTDE = '"+Alltrim(Str(nQuant))+"' "+CRLF
cQuery += " AND  SD7.D_E_L_E_T_ = ' ' "+CRLF

cQuery += " ORDER BY D7_SEQ "+CRLF

cQuery := ChangeQuery(cQuery)
 
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmpSd3 , .F., .T.)

(cArqTmpSd3)->(DbGoTop())
If (cArqTmpSd3)->(!Eof())
	
	//Tratamento para os itens importados da planilha
	If Alltrim((cArqTmpSd3)->F4_YTIPONF) $ "1"//Verifica se a nota ้ de midia
		nRet := (cArqTmpSd3)->D3_CUSTO1 + (((cArqTmpSd3)->D3_CUSTO1 * nPercMidia) / 100 )
		
	ElseIf Alltrim((cArqTmpSd3)->F4_YTIPONF) $ "2|5"	//Verifica se a nota ้ de software
		nRet := (cArqTmpSd3)->D3_CUSTO1 + (((cArqTmpSd3)->D3_CUSTO1 * (cArqTmpSd3)->D1_YPERCBR) / 100 )
		
	Else
		If (cArqTmpSd3)->D3_YCMGBR == 0
			nRet := (cArqTmpSd3)->D3_CUSTO1

		Else
			nRet := (cArqTmpSd3)->D3_YCMGBR
		EndIf
		
	EndIf
	
Else
	nRet := 0
EndIf

(cArqTmpSd3)->(DbCloseArea())

RestArea(aArea)
Return nRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGetCGBRDev	บAutor  ณMicrosiga	     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o custo BR na devolu็ใo						      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetCGBRDev(cCodProd, cArm, cDoc, cSerie)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmpSd2	:= GetNextAlias()
Local nRet			:= 0

Default cCodProd	:= "" 
Default cArm		:= "" 
Default cDoc		:= "" 
Default cSerie		:= ""

cQuery := " SELECT D2_QUANT, D2_YCMGBR, D2_CUSTO1 FROM "+RetSqlName("SD2")+" SD2 "+CRLF
cQuery += " WHERE SD2.D2_FILIAL = '"+xFilial("SD2")+"' "	+CRLF
cQuery += " 	AND SD2.D2_COD = '"+cCodProd+"' "+CRLF
cQuery += " 	AND SD2.D2_DOC = '"+cDoc+"' "+CRLF
cQuery += " 	AND SD2.D2_SERIE = '"+cSerie+"' "+CRLF
cQuery += " 	AND SD2.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmpSd2 , .F., .T.)

(cArqTmpSd2)->(DbGoTop())
If (cArqTmpSd2)->(!Eof())
	If (cArqTmpSd2)->D2_YCMGBR == 0
		nRet := (cArqTmpSd2)->D2_CUSTO1 / (cArqTmpSd2)->D2_QUANT
	Else
		nRet := (cArqTmpSd2)->D2_YCMGBR  / (cArqTmpSd2)->D2_QUANT
	EndIf
EndIf

(cArqTmpSd2)->(DbCloseArea())

RestArea(aArea)
Return nRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณDevTerc		บAutor  ณMicrosiga	     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se ้ devolu็ใo de 3บ							      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function DevTerc(cCod)

Local aArea 	:= GetArea()
Local lRet		:= .F.
Local cQuery    := "" 
Local cArqTmp	:= GetNextAlias()

Default cCod := ""

cQuery    := " SELECT F4_PODER3 FROM "+RetSqlName("SF4")+CRLF
cQuery    += " WHERE F4_FILIAL = '"+xFilial("SF4")+"' "
cQuery    += " AND F4_CODIGO = '"+cCod+"' "
cQuery    += " AND  D_E_L_E_T_ = ' ' "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

(cArqTmp)->(DbGoTop())

If (cArqTmp)->(!Eof())
	If Alltrim((cArqTmp)->F4_PODER3) == "D"
		lRet := .T.
	EndIf
EndIf


(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณAtuTpSB2		บAutor  ณMicrosiga	     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza o saldo atual da tabela temporaria			      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtuTpSB2(cCod, dDtRef)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cAliasTmp	:= GetNextAlias()   
Local aFechAux	:= {}

Default cCod 	:= ""
Default dDtRef  := CTOD('')

cQuery    := " SELECT R_E_C_N_O_ RECNOSB2 FROM "+RetSqlName("SB2")
cQuery    += "  WHERE D_E_L_E_T_ = ' ' "
cQuery    += "  AND B2_FILIAL = '"+xFilial("SB2")+"' "
cQuery    += "  AND B2_COD = '"+cCod+"' "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasTmp , .F., .T.)

DbSelectArea("SB2")
DbSetOrder(1)

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())
	
	SB2->(DbGoTo((cAliasTmp)->RECNOSB2))

	aFechAux := {}
	
	//Recebe a quantidade, valor unitario e valor total do ultimo fechamento anterior a data informada
	/*
	aFechAux[1] = Quantidade do ultimo fechamento
	aFechAux[2] = Valor unitario do ultimo fechamento
	aFechAux[3] = Valor Total do Ultimo fechamento
	*/	
	//aFechAux 	:= GetUltFech(SB2->B2_COD, SB2->B2_LOCAL, dDtRef)
	aFechAux 	:= u_GetEstBR(SB2->B2_COD, SB2->B2_LOCAL, dDtRef)
	
	If Len(aFechAux) >= 2
		
		If (cArqBR)->(DbSeek(xFilial("SB2") + SB2->B2_COD + SB2->B2_LOCAL ))
		
			RecLock(cArqBR, .F.)
	
			(cArqBR)->YYY_QUANT	:= aFechAux[1]         
		
			If aFechAux[1] != 0
				(cArqBR)->YYY_YCMGBR 	:= aFechAux[2] / aFechAux[1] 
			Else             
				(cArqBR)->YYY_YCMGBR	:= 0
			EndIf
		
			(cArqBR)->YYY_YTCMG	:= aFechAux[2]

   			(cArqBR)->(MsUnLock())
   			
		Else
			
			RecLock(cArqBR, .T.)
	        
	 		(cArqBR)->YYY_FILIAL 	:= xFilial("SB2")
	 		(cArqBR)->YYY_COD		:= SB2->B2_COD
	 		(cArqBR)->YYY_LOCAL 	:= SB2->B2_LOCAL
	 		
			(cArqBR)->YYY_QUANT	:= aFechAux[1]         
		
			If aFechAux[1] != 0
				(cArqBR)->YYY_YCMGBR 	:= aFechAux[2] / aFechAux[1]  
			Else             
				(cArqBR)->YYY_YCMGBR	:= 0     
			EndIf
		
			(cArqBR)->YYY_YTCMG	:= aFechAux[2]

   			(cArqBR)->(MsUnLock())
		EndIf                                   
	EndIf
		
	(cAliasTmp)->(DbSkip())
EndDo

(cAliasTmp)->(DbCloseArea())

RestArea(aArea)
Return

/*/
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณGetUltFech  ณ Autor ณMicrosiga		   ณ Data ณ 11/10/11  ณฑฑ
ฑฑณ			 ณ 												  			  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Retorna a quantidade, valor unitario e valor total do  	  ณฑฑ
ฑฑณ			 ณ ultimo fechamento anterior a data informada	  			  ณฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function GetUltFech(cCod, cArm, dDtRef)

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cAliasTmp	:= GetNextAlias()
Local aRet		:= {}

cQuery := " SELECT * FROM "+RetSqlName("SB9")+" SB9 "+CRLF
cQuery += " WHERE SB9.B9_FILIAL = '"+xFilial("SB9")+"' "+CRLF
cQuery += " 	AND SB9.B9_COD = '"+cCod+"' "+CRLF
cQuery += " 	AND SB9.B9_LOCAL = '"+cArm+"' "+CRLF
cQuery += " 	AND SB9.B9_DATA <= '"+DTOS(dDtRef)+"' "+CRLF
cQuery += " 	AND  SB9.D_E_L_E_T_ = ' '"+CRLF
cQuery += " ORDER BY B9_DATA DESC "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasTmp , .F., .T.)

(cAliasTmp)->(DbGoTop())
If (cAliasTmp)->(!Eof())          

	If (cAliasTmp)->B9_YCMGBR != 0//Custo BR no fechamento
		aRet := {(cAliasTmp)->B9_QINI, (cAliasTmp)->B9_YCMGBR, ((cAliasTmp)->B9_YCMGBR * (cAliasTmp)->B9_QINI) }
	Else
		aRet := {(cAliasTmp)->B9_QINI, (cAliasTmp)->B9_CM1, (cAliasTmp)->B9_VINI1}	
	EndIf
Else        
	aRet := {0,0,0}
EndIf
 
(cAliasTmp)->(DbCloseArea())

RestArea(aArea)
Return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณRecCMGPP		บAutor  ณMicrosiga	     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza o saldo atual da tabela temporaria			      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RecCMGPP(cProdDe, cProdAte)

Local aArea 	:= GetArea()         
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()  
Local nCnt		:= 0 
Local aUltPP	:= {}  

Default cProdDe 	:= ""
Default cProdAte    := ""

cQuery	+= " SELECT P06_CODPRO, B1_COD, B1_DESC, B1_XDESC, P05_CODPP, P05_DTAPLI, P05_DTEFET FROM "+RetSqlName("P05")+" P05 "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("P06")+" P06 "+CRLF
cQuery	+= " ON P06.P06_FILIAL = P05.P05_FILIAL "+CRLF
cQuery	+= " AND P06.P06_CODPP = P05.P05_CODPP "+CRLF
cQuery	+= " AND P06.P06_CODPRO BETWEEN '"+cProdDe+"' AND '"+cProdAte+"' "+CRLF
cQuery	+= " AND P06.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cQuery	+= " ON SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cQuery	+= " AND SB1.B1_COD = P06.P06_CODPRO "+CRLF
cQuery	+= " AND SB1.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " WHERE P05.P05_FILIAL = '"+xFilial("P05")+"' "+CRLF
cQuery	+= " AND P05.P05_DTEFET != ' ' "+CRLF
cQuery	+= " AND P05.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " GROUP BY P06_CODPRO, B1_COD, B1_DESC, B1_XDESC, P05_CODPP, P05_DTAPLI, P05_DTEFET "
cQuery	+= " ORDER BY P05_DTAPLI, P05_CODPP, P06_CODPRO "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)


(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )

//ProcRegua( nCnt )

While (cArqTmp)->(!Eof())
	
	//IncProc("Produto: " + Alltrim((cArqTmp)->P06_CODPRO) + " - "+(cArqTmp)->B1_XDESC )
     
	u_CalCMGPP(Alltrim((cArqTmp)->P06_CODPRO), STOD((cArqTmp)->P05_DTAPLI), (cArqTmp)->P05_CODPP)

	(cArqTmp)->(DbSkip())
EndDo


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return


