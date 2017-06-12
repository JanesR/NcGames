#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNFinr01   บ Autor ณ Reinaldo Caldas    บ Data ณ  26/07/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Emissao de duplicatas                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function Nfinr01

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         	:= "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         	:= "de acordo com os parametros informados pelo usuario."
Local cDesc3         	:= "Emissao de duplicatas NC Games"
Local cPict          	:= ""
Local titulo       		:= "Emissao de duplicatas NC Games"
Local nLin         		:= 7
Local cPerg        		:= "FINR01"
Local Cabec1       		:= "Este programa ira emitir duplicatas conforme"
Local Cabec2       		:= "os parametros selecionados"
Local imprime      		:= .T.
Local aOrd 				:= {}
Private lEnd         	:= .F.
Private lAbortPrint  	:= .F.
Private CbTxt       	:= ""
Private limite     		:= 80
Private tamanho    		:= "P"
Private nomeprog   		:= "NFinr01"
Private nTipo      		:= 18
Private aReturn    		:= { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey   		:= 0
Private cbtxt      		:= Space(10)
Private cbcont     		:= 00
Private CONTFL     		:= 01
Private m_pag      		:= 01
Private wnrel      		:= "NFinr01"

IF MSGYESNO("Imprime por Bordero?")
	U_Nfinr01A()
    Return
End If
                                     
/*
+------------------------------------------------------+
|	PERGUNTAS 	FINR01                                 |
|	MV_PAR1 ->  DA DUPLICATA ?                         |
|	MV_PAR2 ->  ATษ DUPLICATA ?                        |
|	MV_PAR3 ->  PREFIXO ?                              |
|	MV_PAR4 ->  TIPO DE VALOR ?                        |
|	MV_PAR5 ->  PARCELA                                |
|	MV_PAR6 ->	TIPO								   |
+------------------------------------------------------+
*/

Pergunte(cPerg,.T.)               // Pergunta no SX1

Private cString := "SE1"

dbSelectArea("SE1")
dbSetOrder(1)


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  26/07/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local cNum
Local cParcela := "1"
Local cPrefixo
Local cSerie
Local cCliente
Local cLoja
Local nValDupli
Local nValParc
Local cVenc
Local cEmiss
Local nTot		:= 0

_lAB:=.F.

IF MV_PAR06 == "DP " .AND. ALLTRIM(MV_PAR05) == ""
	dbSelectArea(cString)
	dbSetOrder(1)
	dbSeek(xFilial()+mv_par03+mv_par01+cParcela+MV_PAR06)                                                 
ELSEIF MV_PAR06 == "DP " .AND. MV_PAR05 >= "1"
	dbSelectArea("SE1")
	dbSetOrder(1)
	SE1->(dbSeek(xFilial("SE1")+mv_par03+mv_par01+MV_PAR05+MV_PAR06))
ELSE
	dbSelectArea(cString)
	dbSetOrder(1)
	dbSeek(xFilial()+mv_par03+mv_par01+MV_PAR05+MV_PAR06)
ENDIF

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())

cNum	 	:= SE1->E1_NUM
cParcela	:= MV_PAR05
cPrefixo	:= SE1->E1_PREFIXO 
cCliente	:= SE1->E1_CLIENTE
cLoja		:= SE1->E1_LOJA
nValDupli	:= SE1->E1_VALOR
nValParc	:= SE1->E1_SALDO
cVenc		:= SE1->E1_VENCTO
cEmiss		:= SE1->E1_EMISSAO
cSerie		:= IF(EMPTY(SE1->E1_SERIE),SE1->E1_PREFIXO,SE1->E1_SERIE) 

If Found()
	
	While !Eof().and. E1_NUM >= mv_par01 .and. E1_NUM <= mv_par02 .And. E1_PREFIXO == mv_par03

		IF E1_TIPO != MV_PAR06//"NF"
			Dbskip()
			Loop
		EndIF
		
		// CNUM	:=	MV_PAR01
		// CSERIE	:=	MV_PAR03
		
		
		dbSelectArea("SF2")
		If Select("SQL2") > 0
			dbSelectArea("SQL2")
			dbCloseArea()
		Endif
		
		_cQry:="SELECT SF2.F2_DOC DOC, SF2.F2_SERIE SERIE, SF2.F2_CLIENTE CLIENTE, SF2.F2_LOJA LOJA,"
		_cQry+=" SF2.F2_VALMERC MERC, SF2.F2_VALBRUT BRUTO, SF2.F2_VALICM ICM, SF2.F2_VALIPI IPI"
		_cQry+=" FROM  "+RetSQLName("SF2")+" SF2"
		_cQry+=" WHERE SF2.F2_DOC= '"+CNUM+"' AND SF2.F2_SERIE='"+CSERIE+"' "
		_cQry+=" AND SF2.F2_CLIENTE= '"+cCliente+"' AND SF2.F2_LOJA='"+cLoja+"' "
		memowrit("TESTE.sql2",_cQry)
		_cQry := ChangeQuery(_cQry)
		
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,_cQry),"SQL2", .F., .T.)
		
		dbGoTop()
		SetRegua(RecCount())
		_cCliente 	:=	SQL2->CLIENTE
		_nValBrut 	:=	SQL2->BRUTO
		_NumDoc 	:=	SQL2->DOC
		dbSelectArea(cString)
		dbSetOrder(1)
		                      
//		IF MV_PAR06 == "DP " .AND. MV_PAR05 != "1" 
//			IF !EMPTY(E1_PARCELA) .AND. E1_PARCELA != "1"
//				Dbskip()
//				Loop
//			ENDIF
//		ELSEIF !EMPTY(E1_PARCELA) .AND. E1_PARCELA != MV_PAR05
//			Dbskip()
//			Loop
//		EndIF
		
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
						
		IF E1_TIPO == "AB-"
		
			_nValor:=SE1->E1_VALOR
			_lAB:=.T.                       
			Dbskip()
			Loop
		Else
			IF !_lAB
				_nValor:=0	
			EndIF
		Endif
		
		
		@ nLin,062 PSAY cEmiss // SE1->E1_EMISSAO
		nLin:= nLin + 5
		                                               
		
		 // -----------------------------
         // IMPRIME VALOR DA FATURA
         // -----------------------------
	  	IF MV_PAR06 == "NF "
	    	@ nLin,009 PSAY Alltrim(transform(_nValBrut,"999,999.99"))
   	  	ELSEIF MV_PAR06 == "DP "
   	  	
	         	WHILE !EOF() .AND. MV_PAR01 == cNum .AND. MV_PAR03 == cPrefixo .AND. cCliente == E1_CLIENTE .AND. cLoja == E1_LOJA 
	               		IF E1_TIPO == "DP "
							nTot := nTot + 1   
						ENDIF
					dbSelectArea(cString)
					DbSkip()
				EndDO
	    	@ nLin,009 PSAY Alltrim(transform(nValDupli * nTot,"999,999.99"))
	    ENDIF	
	    	
		
		// RETIRADO POR ROGERIO - SUPERTECH PARA IMPRIMIR O VALOR TOTAL DA NOTA
		/*
		Do Case
		Case mv_par04=3
		@ nLin,009 PSAY Alltrim(transform(e1_valor,"999,999.99"))
		Case e1_saldo==e1_valor  .or. mv_par04=2
		@ nLin,009 PSAY Alltrim(transform(e1_valor,"999,999.99"))
		OtherWise
		@ nLin,009 PSAY Alltrim(transform(e1_saldo,"999,999.99"))
		EndCase
		*/
		
			@ nLin,020 Psay cPrefixo // E1_PREFIXO //criado pelo Rafael 03.12.09
			@ nLin,022 PSAY cNum // E1_NUM
		
 		// @ nLin,032 PSAY IIF(SE1->E1_SALDO == SE1->E1_VALOR .OR. MV_PAR04 = 2,SE1->E1_VALOR-_nValor,SE1->E1_SALDO) Picture"@E@Z 999,999.99"
		
    	 // -----------------------------
         // IMPRIME VALOR DA DUPLICATA   
         // -----------------------------
			Do Case
			    Case mv_par04=3   							
					   IF MV_PAR06 == "DP " .AND. nValParc == 0
		               @ nLin,032 PSAY Alltrim(transform(nValDupli,"999,999.99")) //E1_VALOR
						ELSE                                                                                   
		               @ nLin,032 PSAY Alltrim(transform(nValParc,"999,999.99")) //E1_SALDO
		    			ENDIF
			    Case nValParc == nValDupli .or. mv_par04=2	
   		     		   @ nLin,032 PSAY Alltrim(transform(nValDupli,"999,999.99")) //E1_VALOR
      			OtherWise                   
		            IF MV_PAR06 == "DP " .AND. nValParc == 0
		               @ nLin,032 PSAY Alltrim(transform(nValDupli,"999,999.99")) //E1_VALOR
		           	ELSE
		               @ nLin,032 PSAY Alltrim(transform(nValParc,"999,999.99")) //E1_SALDO
		            ENDIF
	      EndCase
		
			@ nLin,047 Psay cPrefixo 					// criado pelo Rafael 03.12.2009 // E1_PREFIXO
            IF LEN(ALLTRIM(CNUM))== 9
				@ nLin,049 PSAY SUBSTR(RTRIM(cNum),4,6)+" "+cParcela 	// E1_NUM + E1_PARCELA
			ELSE
				@ nLin,049 PSAY RTRIM(cNum)+" "+cParcela
			ENDIF
			@ nLin,060 PSAY cVenc 						// E1_VENCTO
		nLin:= nLin + 3
			if nValDupli != nValParc .and. mv_par04=3
			// @ nLin,26 PSAY "APLICADO DESCONTO NA DUPLICATA DE R$ "+Alltrim(transform(e1_valor-e1_saldo,"999,999.99"))+"****"
			@ nLin,26 PSAY "APLICADO DESCONTO NA DUPLICATA DE R$ "+Alltrim(transform(nValDupli-nValParc,"999,999.99"))+"****"
		Endif
		nLin++
		DbSelectArea("SA1")
		DbSetOrder(1)
			DbSeek(xFilial()+cCliente+cLoja)
		@ nLin,038 PSAY A1_COD
		@ nLin,055 PSAY A1_VEND
		@ nLin,072 PSAY A1_BCO1
		nLin:= nLin + 2
		If found()
			@ nLin,000 PSAY CHR(15)
			@ nLin,045 PSAY A1_NOME
			nLin:= nLin + 1
			@ nLin,045 PSAY A1_ENDCOB
			nLin:= nLin +1
			@ nLin,045 PSAY A1_MUNC
			@ nLin,117 PSAY A1_ESTC
			@ nLin,127 PSAY A1_CEPC
			@ nLin,000 PSAY CHR(15)
			nLin := nLin + 1
			@ nLin,045 PSAY ALLTRIM(A1_MUNC)+" "+ALLTRIM(A1_ESTC)
			nLin := nLin + 1
			@ nLin,045 PSAY A1_CGC
			@ nLin,100 PSAY A1_INSCR
			@ nLin,000 PSAY CHR(18)
			nLin := nLin +2
		Endif
		
			DbSelectArea("SE1")
			dbSetOrder(1)
			@ nLin,000 PSAY CHR(15)
			IF nValParc == nValDupli .OR. MV_PAR04 = 2
				@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(nValDupli-_nValor),1,55)) + REPLICATE("*",69),1,69) //E1_VALOR - _nValor
						nLin:= nLin + 1
	   		   	@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(nValDupli-_nValor),56,55)) + REPLICATE("*",69),1,69) //E1_VALOR - _nValor
		   				nLin:= nLin + 1
   	   			@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(nValDupli-_nValor),112,55)) + REPLICATE("*",69),1,69) //E1_VALOR - _nValor
   	   	ElseIf MV_PAR06 == "DP " .AND. nValParc == 0
   	   			nValParc := nValDupli
   	   			@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(nValParc),1,55)) + REPLICATE("*",69),1,69) //E1_SALDO
						nLin:= nLin + 1
	   		   	@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(nValParc),56,55)) + REPLICATE("*",69),1,69) //E1_SALDO
	   					nLin:= nLin + 1
   	   			@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(nValParc),112,55)) + REPLICATE("*",69),1,69) //E1_SALDO
  	   		Else
   	   			@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(nValParc),1,55)) + REPLICATE("*",69),1,69) //E1_SALDO
						nLin:= nLin + 1
	   		   	@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(nValParc),56,55)) + REPLICATE("*",69),1,69) //E1_SALDO
	   					nLin:= nLin + 1
   	   			@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(nValParc),112,55)) + REPLICATE("*",69),1,69) //E1_SALDO
   	   EndIF	
		
		
		@ nLin,000 PSAY CHR(18)
		DbSkip()
		_lAB:=.F.
		IF nLin > 80
			SetPrc(0,0) // (Zera o Formulario)
			nLin:=17
		Else
			nLin := nLin+17
		EndIF
	EndDO
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return
