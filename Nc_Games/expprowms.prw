#INCLUDE "rwmake.ch"
#include "Protheus.ch"
#include "TOPCONN.CH"
#include "TbiConn.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNOVO2     บ Autor ณ AP6 IDE            บ Data ณ  06/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Codigo gerado pelo AP6 IDE.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function EXPPROWMS()
PRIVATE CPERG := "DEPWMS"

VALIDPERG()
pergunte(cPerg,.T.)

DBSELECTAREA("SB1")
DBSETORDER(1)

WHILE SB1->(!EOF())

    If SB1->B1_TIPO <> "PA"
        SB1->(dbSkip())
        Loop
    EndIf

	cQUERY		:= " SELECT ORAINT.SEQ_INTEGRACAO.NEXTVAL SEQ FROM DUAL "   // SEQUENCIAINTEGRACAO
    
	cQuery := ChangeQuery(cQuery)

 	If Select("TRB") >0
		dbSelectArea("TRB")
		dbCloseArea()
	Endif

	TCQUERY cQuery New Alias "TRB"
	
	dbSelectArea("TRB")

	cSEQINT		:= TRB->SEQ
	//cTIPOINT	:= "       001"    // TIPOINTGRACAO
	cDEPOSIT	:= MV_PAR01        // CODIGOEMPRESA
	cCODPROD	:= SB1->B1_COD     // CODIGOPRODUTO
	cDESCPROD	:= Substr(AllTrim(SB1->B1_CODBAR)+" "+"-"+" "+AllTrim(SB1->B1_XDESC),1,50)    // ALLTRIM(STRTRAN(STRTRAN(SUBSTR(ALLTRIM(SB1->B1_XDESC),1,50),"'",""),"ด",""))  // DESCRICAOPRODUTO
	cDESCPRODD	:= Substr(AllTrim(SB1->B1_CODBAR)+" "+"-"+" "+AllTrim(SB1->B1_XDESC),1,100)   // ALLTRIM(STRTRAN(STRTRAN(SUBSTR(ALLTRIM(SB1->B1_XDESC),1,100),"'",""),"ด","")) // DESCRICAOPRODUTODET
    cTIPO		:= SUBSTR(ALLTRIM(POSICIONE("SX5",1,XFILIAL("SX5")+"02"+SB1->B1_TIPO,"X5_DESCRI")),1,40)     // TIPOPRODUTO
    cGRUPO		:= Substr(AllTrim(SB1->B1_GRPWMS),1,6)                                        // SB1->B1_GRUPO // GRUPOPRODUTO
    cDESCGRUPO	:= Substr(AllTrim(TABELA("Z3",SB1->B1_GRPWMS,.F.)),1,40)                      // SUBSTR(ALLTRIM(POSICIONE("SBM",1,XFILIAL("SBM")+SB1->B1_GRUPO,"BM_DESC")),1,40) // DESCRICAOGRUPOPRODUTO
    cCLASFIS	:= SB1->B1_CLASFIS                         // CLASSIFICACAOFISCAL
    cSITPROD	:= IIF(SB1->B1_MSBLQL == "1" , "0", "1")   // SITUACAOPRODUTO
    cCNPJEMPR	:= MV_PAR01                                // CNPJCPFEMPRESA 
    cORIGEM		:= SB1->B1_ORIGEM                          // ORIGEMPRODUTO
    cNCM		:= SB1->B1_POSIPI                          // CODIGONCM
    DTLOG		:= DDATABASE
    cTIPOUC		:= SB1->B1_UM
    cSEQTIPUC	:= 1.00
    cLARG		:= SB1->B1_LARGURA
    cALT		:= SB1->B1_ALT
    cCOMPRIM	:= SB1->B1_PROF
    cPESBRU		:= SB1->B1_PESBRU
    cPESOL		:= SB1->B1_PESO
    cCODBAR		:= SB1->B1_CODBAR
    cTIPCODBAR	:= "EAN13"
    
    cCODCATEG   := Substr(AllTrim(SB1->B1_SBCATEG),1,25)
    cDESCCATEG  := Substr(AllTrim(GETADVFVAL("SBM","BM_DESC",xFilial("SBM")+SB1->B1_SBCATEG,1,Space(30))),1,100)
    
  	IF ALLTRIM(SB1->B1_TIPO) <> "PA"
  		SB1->(DBSKIP())
  		LOOP
  	ENDIF
  	   
    _cUPD := " INSERT INTO ORAINT.INTEGRACAO  "
	_cUPD += " (SEQUENCIAINTEGRACAO,TIPOINTEGRACAO,ESTADOINTEGRACAO,DATALOG) "
	_cUPD += " VALUES (TO_NUMBER('"+STR(cSEQINT)+"'),001,1,TO_DATE('"+SUBSTR(DTOS(DTLOG),7,2)+SUBSTR(DTOS(DTLOG),5,2)+SUBSTR(DTOS(DTLOG),1,4)+"','DD/MM/YYYY')) "
    
	IF TcSQLExec(_cUPD) <> 0
		MsgStop("TCSQLError() " + TCSQLError())
    ENDIF
	
	TcSQLExec("COMMIT")

    _cUPDATE := " INSERT INTO ORAINT.PRODUTO "
	_cUPDATE += " (SEQUENCIAINTEGRACAO, TIPOINTEGRACAO,CODIGOEMPRESA,CODIGOPRODUTO, DESCRICAOPRODUTO, DESCRICAOPRODUTODET, TIPOPRODUTO,GRUPOPRODUTO, "
	_cUPDATE += " DESCRICAOGRUPOPRODUTO, CLASSIFICACAOFISCAL, SITUACAOPRODUTO, CNPJCPFEMPRESA, CODIGOCATEGORIA, DESCRICAOCATEGORIA, ORIGEMPRODUTO, CODIGONCM) "
	_cUPDATE += " values (TO_NUMBER('"+STR(cSEQINT)+"'),001,'"+ALLTRIM(cDEPOSIT)+"','"+ALLTRIM(cCODPROD)+"','"+ALLTRIM(cDESCPROD)+"','"+ALLTRIM(cDESCPRODD)+"', "
	_cUPDATE += " '"+ALLTRIM(cTIPO)+"','"+ALLTRIM(cGRUPO)+"','"+ALLTRIM(cDESCGRUPO)+"', '"+ALLTRIM(cCLASFIS)+"','"+ALLTRIM(cSITPROD)+"','"+ALLTRIM(cCNPJEMPR)+"',' "
	_cUPDATE += " "+ALLTRIM(cCODCATEG)+"','"+ALLTRIM(cDESCCATEG)+"','  "
	_cUPDATE += " "+ALLTRIM(cORIGEM)+"','"+SUBSTR(ALLTRIM(cNCM),1,4)+'.'+SUBSTR(ALLTRIM(cNCM),5,2)+'.'+SUBSTR(ALLTRIM(cNCM),7,2)+"' ) "

	IF TcSQLExec(_cUPDATE) <> 0
		MsgStop("TCSQLError() " + TCSQLError())
	ENDIF
	
	TcSQLExec("COMMIT") 

    _cUPDATE1 := " INSERT INTO ORAINT.TIPOUC "
	_cUPDATE1 += " (SEQUENCIAINTEGRACAO, TIPOINTEGRACAO,CODIGOEMPRESA,CODIGOPRODUTO, TIPOUC, SEQUENCIATIPOUC, LARGURAPRODUTO, ALTURAPRODUTO, "
	_cUPDATE1 += " COMPRIMENTOPRODUTO, PESOBRUTO, PESOLIQUIDO, CODIGOBARRA, TIPOCODIGOBARRA, FATORTIPOUC) "
	_cUPDATE1 += " values (TO_NUMBER('"+STR(cSEQINT)+"'),001,'"+ALLTRIM(cDEPOSIT)+"','"+ALLTRIM(cCODPROD)+"','"+ALLTRIM(cTIPOUC)+"',TO_NUMBER('"+STR(cSEQTIPUC)+"'), "
	_cUPDATE1 += " TO_NUMBER('"+STR(cLARG)+"'),TO_NUMBER('"+STR(cALT)+"'),TO_NUMBER('"+STR(cCOMPRIM)+"'), TO_NUMBER('"+STR(cPESBRU)+"'), "
	_cUPDATE1 += " TO_NUMBER('"+STR(cPESOL)+"'),'"+ALLTRIM(cCODBAR)+"','"+ALLTRIM(cTIPCODBAR)+"',1)"

	IF TcSQLExec(_cUPDATE1) <> 0
		MsgStop("TCSQLError() " + TCSQLError())
	ENDIF
	
	TcSQLExec("COMMIT") 
		
	SB1->(DBSKIP())

ENDDO

MSGBOX("PROCESSO FINALIZADO")

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณVALIDPERG ณ Autor ณ RAIMUNDO PEREIRA      ณ Data ณ 01/08/02 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ          ณ Verifica as perguntas incluกndo-as caso no existam        ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Especifico para Clientes Microsiga                         ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/            
Static Function ValidPerg()
_aAreaVP := GetArea()
DBSelectArea("SX1")
DBSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AADD(aRegs,{cPerg,"01","CNPJ DEPOSITANTE ?","","","mv_ch1","C", 15,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})

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