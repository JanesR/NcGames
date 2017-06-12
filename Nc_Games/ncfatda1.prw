#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCFATDA1  บ Autor ณ Rodrigo Okamoto    บ Data ณ  14/01/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ PROGRAMA PARA PROCURAR ITENS NรO CADASTRADOS NAS TABELAS   บฑฑ
ฑฑบ          ณ DE PREวOS PADRีES E RETORNAR EM PLANILHA EM EXCEL          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function NCFATDA1

	Processa({|| EXECFATDA1() },"Verificando tabelas...")

Return


//Verifica็ใo das tabelas
Static Function EXECFATDA1

aDbStru := {}

cMVTab	:= getmv("MV_NCTABPR")
aMVTab	:= StrTokArr(alltrim(cMVTab),";")

AADD(aDbStru,{"CODIGONC","C",15,0})
AADD(aDbStru,{"NCDESCRI","C",100,0})
AADD(aDbStru,{"PRECOSB1","N",14,2})
/*AADD(aDbStru,{"PRECO018","N",14,2})
AADD(aDbStru,{"PRECO012","N",14,2})
AADD(aDbStru,{"PRECO007","N",14,2})*/
cCond	:= " "
lFirst	:= .T.
For nx:=1 to len(aMVTab)
	AADD(aDbStru,{"PRECO"+ALLTRIM(aMVTab[nx]),"N",17,2})
//	cQryCpo  += " DA"+ALLTRIM(aMVTab[nx])+".DA1_PRCVEN PRECO"+ALLTRIM(aMVTab[nx])+", "
	If lFirst
		cCond 	 += "AND (SB1.B1_COD NOT IN (SELECT DA1_CODPRO FROM DA1010 DA1 WHERE DA1.D_E_L_E_T_ <> '*' AND DA1.DA1_CODTAB = '"+ALLTRIM(aMVTab[nx])+"') "
		lFirst	:= .F.
	Else 
		cCond 	 += "OR SB1.B1_COD NOT IN (SELECT DA1_CODPRO FROM DA1010 DA1 WHERE DA1.D_E_L_E_T_ <> '*' AND DA1.DA1_CODTAB = '"+ALLTRIM(aMVTab[nx])+"') "
	EndIf
//	cQryTab  += " (SELECT DA1.DA1_CODPRO, DA1.DA1_PRCVEN FROM DA1010 DA1 WHERE DA1.D_E_L_E_T_ <> '*' AND DA1.DA1_FILIAL = ' ' AND DA1.DA1_CODTAB = '"+ALLTRIM(aMVTab[nx])+"') DA"+ALLTRIM(aMVTab[nx])+", "
//	cQryJoin += " AND DA"+ALLTRIM(aMVTab[nx])+".DA1_CODPRO  = B1.B1_COD  "
Next nx
cCond	+= ")"

//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
CNOMEDBF := "DIFTABELANC"

DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"XLS",.T.,.F.)

cQuery 	 := "SELECT B1_COD CODIGONC,B1_XDESC NCDESCRI,  B1_PRV1 PRECOSB1, B1_TIPO TIPO, B1_MSBLQL BLOQ, B1_BLQVEND BLOQVEND"
cQuery 	 += "FROM SB1010 SB1 "
cQuery 	 += "WHERE SB1.D_E_L_E_T_ <> '*' "
cQuery 	 += "AND SB1.B1_TIPO = 'PA' "
cQuery 	 += "AND SB1.B1_BLQVEND <> '1' "
/*cQuery 	 += "AND (SB1.B1_COD NOT IN (SELECT DA1_CODPRO FROM DA1010 DA1 WHERE DA1.D_E_L_E_T_ <> '*' AND DA1.DA1_CODTAB = '018') "
cQuery 	 += "OR SB1.B1_COD NOT IN (SELECT DA1_CODPRO FROM DA1010 DA1 WHERE DA1.D_E_L_E_T_ <> '*' AND DA1.DA1_CODTAB = '012') "
cQuery 	 += "OR SB1.B1_COD NOT IN (SELECT DA1_CODPRO FROM DA1010 DA1 WHERE DA1.D_E_L_E_T_ <> '*' AND DA1.DA1_CODTAB = '007')) "*/
cQuery 	 += cCond
cQuery 	 := ChangeQuery(cQuery)

MemoWrit("DIFTABELANC",cQuery)

MsAguarde({|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)},"Aguarde...") //"Selecionando Registros..."
dbSelectArea("TRB")
dbGoTop()

aProd 	:= {}
While !TRB->(EOF())
	XLS->(RECLOCK("XLS",.T.))
		XLS->CODIGONC	:= TRB->CODIGONC
		XLS->NCDESCRI	:= TRB->NCDESCRI
		XLS->PRECOSB1	:= TRB->PRECOSB1
		For nx:=1 to len(aMVTab)
			cNomCpo	:= "PRECO"+ALLTRIM(aMVTab[nx])
			XLS->&cNomCpo	:= getadvfval("DA1","DA1_PRCVEN",XFILIAL("DA1")+ALLTRIM(aMVTab[nx])+PADR(TRB->CODIGONC,15),1,0)
		Next nx
	msunlock()
	TRB->(DBSKIP())
EndDo

FOR I:=1 TO LEN(aProd)
NEXT


XLS->(DBGOTOP())
CpyS2T( "\SYSTEM\" + CNOMEDBF +".DBF" , "C:\RELATORIOS\" , .F. )
Alert("Arquivo salvo em C:\Relatorios\" + CNOMEDBF + ".DBF" )

If ! ApOleClient( 'MsExcel' )
	MsgStop( 'MsExcel nao instalado' )
	Return
EndIf

DbSelectArea("TRB")
DbCloseArea()

oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( "C:\RELATORIOS\" + CNOMEDBF +".DBF" ) // Abre uma planilha
oExcelApp:SetVisible(.T.)
XLS->(DBCLOSEAREA())


Return
