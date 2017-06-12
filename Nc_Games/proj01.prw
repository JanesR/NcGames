//1=Agendar;2=Cancelar;3=Indicacao Devolver;4=Devolver;5=DevolverFomulCli;6=Substituir;7=Logistica Entregar;8=Compensar
// LIBERAR PARA UDUSARIOS
//VALIDAR MODIFICACOES


#include "rwmake.ch"
#include "ap5mail.ch"
#INCLUDE "COLORS.CH"
#include "TOPCONN.ch"


#INCLUDE "PROTHEUS.CH"
#INCLUDE "FIVEWIN.CH"
#INCLUDE "FONT.CH"
//#include "rwmake.ch"


User Function PROJ01()
Local aCores  := {{" (DDATABASE - E1_EMISSAO) >= 8 .AND. !U_CLIAGE2() ",'DISABLE' 	},;
{ " (DDATABASE - E1_EMISSAO) <= 2 .AND. !U_CLIAGE2() " , 'ENABLE' 		},;
{ " (DDATABASE - E1_EMISSAO) >=3 .AND. (DDATABASE - E1_EMISSAO) <= 7  .AND. !U_CLIAGE2() " , 'BR_AMARELO' 		} , ;
{ " U_CLIAGE2()  " , 'BR_AZUL' 		}  }


Private cArqInd 	:= CriaTrab(,.F.)		//Nome do arq. temporario
Private cCadastro := "Entrega Pendentes"
Private aRotina   := {}

Aadd(aRotina,{"Pesquisar" 		,"AxPesqui"     	,0,1 })
Aadd(aRotina,{"Visualizar"  	,"axvisual"     	,0,2 })
Aadd(aRotina,{"Manutenção"  	,"u_ALTSZ3FX" 	,0,3 })
Aadd(aRotina,{"Pend.Logistica"  	,"u_log001" 	,0,3 })
Aadd(aRotina,{"So Agendamento"  	,"u_fil001" 	,0,3 })
Aadd(aRotina,{"Todos"  	,"u_fil002" 	,0,3 })
//Aadd(aRotina,{"Exporta Excel"  		,"u_LeZ04" 		,0,11 })
Aadd(aRotina,{"Legenda"  		,"U_CTLegenda" 		,0,11 })


aCC := {}

//Aadd(aCC,{"Status WF","E1_STAT"})
Aadd(aCC,{"Cliente","E1_CLIENTE"})
Aadd(aCC,{"Lj","E1_LOJA"})
Aadd(aCC,{"Nome Cliente","E1_NOMCLI"})
Aadd(aCC,{"Ser","E1_PREFIXO"})
Aadd(aCC,{"Numero","E1_NUM"})
//Aadd(aCC,{"Parc","E1_PARCELA"})
Aadd(aCC,{"Emissao","E1_EMISSAO"})
//Aadd(aCC,{"Vencimento","E1_VENCTO"})
Aadd(aCC,{"Vlr Total NF","E1_TOTNF"})
//Aadd(aCC,{"Venc.Real","E1_VENCREA"})
//Aadd(aCC,{"Valor","E1_VALOR"})
//Aadd(aCC,{"Saldo","E1_SALDO"})
//Aadd(aCC,{"Atraso","E1_ISS"})  // CRIAR CAMPO VIRTUAL
Aadd(aCC,{"Dt.Etiq.","E1_DTETQ"})
Aadd(aCC,{"Dt.Saida","E1_DTSAI"})
Aadd(aCC,{"Dt.Agend","E1_DATAAG"})
Aadd(aCC,{"Hora.Ag.","E1_HORAAG"})
//Aadd(aCC,{"WorkFlow","E1_WF"})
Aadd(aCC,{"Historico Geral","E1_HISTWF"})
Aadd(aCC,{"Historico Financeiro","E1_HIST"})
Aadd(aCC,{"Portador","E1_PORTADO"})

XFILTRO := "SE1->E1_SALDO > 0    						 "
XFILTRO += "	.AND. U_FENTR()  						 "
XFILTRO += "	.AND. SE1->E1_PARCELA $ ' /1'            "
XFILTRO += "	.AND. SE1->E1_EMISSAO > CTOD('01/01/09') "
//XFILTRO += "	.AND. U_E1NCC(SE1->E1_FILORIG+SE1->E1_NUM+SE1->E1_PREFIXO+SE1->E1_CLIENTE+SE1->E1_LOJA,GETADVFVAL('SF2','F2_VALBRUT',SE1->E1_FILORIG+SE1->E1_NUM+SE1->E1_PREFIXO,1,0)  ) == 0 						 "
XFILTRO += "	.AND. 'MATA460'$SE1->E1_ORIGEM 			 "

dbSelectArea("SE1")
IndRegua("SE1",cArqInd,IndexKey(),,XFILTRO)
nIndex := RetIndex("SE1")
#IFNDEF TOP
	dbSetIndex(cArqInd+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+12)
dbGotop()

mBrowse(6, 1, 22, 75, "SE1",aCC,,,,,aCores)

dbSelectArea("SE1")
RetIndex("SE1")
dbClearFilter()
Ferase(cArqInd+OrdBagExt())
/*DbSelectArea("SE1")
DbSetOrder(11)

SET FILTER TO &XFILTRO
DbGoTop()
mBrowse(6, 1, 22, 75, "SE1",aCC,,,,,aCores)

SET FILTER TO*/

Return(.T.)




User Function CTLegenda()

BrwLegenda(cCadastro,'Legenda',{{'DISABLE'		,'Entrega Atrasada - mais de 7 dias'		},;
{'BR_AMARELO' 		,'Entrega dentro do prazo de 7 dias'	}    ,;
{'ENABLE' 		,'Entrega dentro do prazo de 48h'	},;
{'BR_AZUL'     ,'Agendamento Exigido pelo Cliente nao informado'	}})


Return(.T.)


User Function ALTSZ3FX()
Local AAREA := GETAREA()

Private _cproc     	:= SE1->E1_WF
Private _chist     	:= SE1->E1_HISTWF
Private oTMultiget
Private XVH 		:= SE1->E1_FILORIG+SE1->E1_NUM+SE1->E1_PREFIXO
Private XDT 		:= GETADVFVAL('SF2','F2_DATAAG',XVH,1,CTOD(''))
Private _DAGE      	:= XDT
Private _HAGE     	:= GETADVFVAL('SF2','F2_HORAAG',XVH,1,CTOD(''))


ACLASSE := {}
AADD(ACLASSE,"1=Agendar")
AADD(ACLASSE,"2=Cancelar")
AADD(ACLASSE,"3=Indicacao Devolver")
AADD(ACLASSE,"4=Devolver")
AADD(ACLASSE,"5=DevolverFomulCli")
AADD(ACLASSE,"6=Substituir")
AADD(ACLASSE,"7=Logistica Entregar")
AADD(ACLASSE,"8=Compensar")


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Redefinicao do aCampos para utilisar no MarkBrow             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

@ 120,200 To 600,550 Dialog mkwdlg Title OemToAnsi("Manutenção Work-Flow")

xnf := SE1->E1_NUM + "/" + SE1->E1_PREFIXO

@ 020,010 Say OemToAnsi("Cliente") PIXEL OF mkwdlg
@ 020,070 Get SE1->E1_NOMCLI   Picture "@!"  SIZE 100,10  PIXEL OF mkwdlg when .f.

@ 040,010 Say OemToAnsi("Nota Fiscal/Serie") PIXEL OF mkwdlg
@ 040,070 Get xnf   Picture "@!"  SIZE 100,10  PIXEL OF mkwdlg when .f.
       
@ 060,010 Say OemToAnsi("Historico") PIXEL OF mkwdlg
oTMultiget := tMultiget():New( 060,070, {|u| if(Pcount() >0,_chist:= u, _chist)},mkwdlg,100,70,,.F.,,,,.T.,,,,,,, {||VldHistWf()} )

@ 140,010 Say OemToAnsi("Data Agendamento") PIXEL OF mkwdlg
@ 140,070 Get _DAGE   Picture "@!"  SIZE 50,10  PIXEL OF mkwdlg //valid fvaldt()

@ 160,010 Say OemToAnsi("Hora Agendamento") PIXEL OF mkwdlg
@ 160,070 Get _HAGE   Picture "@!"  SIZE 50,10  PICTURE "99:99" PIXEL OF mkwdlg



@ 180,110 BmpButton Type 1 Action GravaAlt()
@ 180,140 BmpButton Type 2 Action Close(mkwdlg)

Activate Dialog mkwdlg CENTERED
                                                                              
RESTAREA(AAREA)
Return


Static Function VldHistWf()

Local lRet		:= .T.
Local cHistAux	:= ""               


If Len(Alltrim(_chist)) > TAMSX3("E1_HISTWF")[1]
	Aviso("Atenção","Limite máximo de caracteres permitido: "+Alltrim( Str(TAMSX3("E1_HISTWF")[1]) ) ,{"Ok"},2)
	
	cHistAux := SubStr(Alltrim(_chist),1,TAMSX3("E1_HISTWF")[1]) 
	
	_chist 	 := cHistAux
	oTMultiget := tMultiget():New( 060,070, {|u| if(Pcount() >0,_chist:= u, _chist)},mkwdlg,100,070,,.F.,,,,.T.,,,,,,, {||VldHistWf()} )
	oTMultiget:Refresh()
	mkwdlg:Refresh()
	lRet	:= .F.
EndIf

Return lRet



Static Function fvaldt()

lret := .t.

IF _DAGE < DDATABASE
	lret := .F.
ENDIF

Return lret




Static Function GravaAlt()
XSE1 := GETAREA()
XCHAVE := SE1->E1_FILIAL + SE1->E1_PREFIXO + SE1->E1_NUM
DBSELECTAREA("SE1")
SET FILTER TO
DBSETORDER(1)
DBSEEK(XCHAVE,.T.)
DO WHILE !EOF() .AND. SE1->E1_FILIAL + SE1->E1_PREFIXO + SE1->E1_NUM == XCHAVE
	RecLock("SE1",.F.)
	SE1->E1_WF := _cproc
	SE1->E1_HISTWF := _chist
	MsUnlock()
	DBSELECTAREA("SE1")
	DBSKIP()
ENDDO
SET FILTER TO &XFILTRO

DBSELECTAREA("SF2")
DBSETORDER(1)
IF DBSEEK(XVH,.T.)
	RecLock("SF2",.F.)
	SF2->F2_DATAAG := _DAGE
	SF2->F2_HORAAG := _HAGE
	MsUnlock()
ENDIF

RESTAREA(XSE1)
Close(mkwdlg)

Return


Function U_FENTR()

LRET := .T.

IF EMPTY(GETADVFVAL("SZ1","Z1_DTENTRE",SE1->E1_FILORIG+SE1->E1_NUM+SE1->E1_PREFIXO,1,CTOD("")))
	LRET := .T.
ELSE
	LRET := .F.
ENDIF

Return lRet




Function u_LeZ04()

lrel := MSGYESNO("Gera Analitico (SIM) ou Sintetico (NAO) ?")


aDbStru := {}
// Estrutura do Arquivo que irá para o Excel

//	TcSetField (cAliasSI,"DEBITO","N",aTam[1],aTam[2])
TCSETFIELD ("SE1", "EMISSAO", "D")
TCSETFIELD ("SE1", "VENCTO" , "D")
TCSETFIELD ("SE1", "VENCREA", "D")

AADD(aDbStru,{"CLIENTE","C",6,0})
AADD(aDbStru,{"LOJA","C",2,0})
AADD(aDbStru,{"NOMECLI","C",20,0})
AADD(aDbStru,{"RAZAO","C",40,0})
AADD(aDbStru,{"PREFIXO","C",3,0})
AADD(aDbStru,{"NUMERO","C",6,0})
AADD(aDbStru,{"PARCELA","C",3,0})
AADD(aDbStru,{"EMISSAO","D",8,0})
AADD(aDbStru,{"VENCTO","D",8,0})
AADD(aDbStru,{"VENCREA","D",8,0})
AADD(aDbStru,{"VALOR","N",17,2})
AADD(aDbStru,{"SALDO","N",17,2})
AADD(aDbStru,{"ATRASO","N",17,2})
AADD(aDbStru,{"WORKFLOW","C",1,0})
AADD(aDbStru,{"HISTORICO","C",60,0})
AADD(aDbStru,{"PORTADOR","C",3,0})
AADD(aDbStru,{"TIPO","C",3,0})

//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
CNOMEDBF := "CTR-"+ALLTRIM(STR(YEAR(DDATABASE)))+ALLTRIM(STRZERO(MONTH(DDATABASE),2))
DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"XLS",.T.,.F.)

//EMPTY(GETADVFVAL("SZ1","Z1_DTENTRE",XFILIAL("SZ1")+SE1->E1_NUM,1,CTOD("")))

cQuery:="  SELECT "
cQuery+="    E1_CLIENTE CLIENTE, "
cQuery+="    E1_LOJA LOJA, "
cQuery+="    E1_NOMCLI NOMECLI, "
cQuery+="    A1_NOME RAZAO, "
cQuery+="    E1_TIPO TIPO, "
cQuery+="    E1_PREFIXO PREFIXO, "
cQuery+="    E1_NUM NUMERO, "
cQuery+="    E1_PARCELA PARCELA, "
cQuery+="    E1_EMISSAO EMISSAO, "
cQuery+="    E1_VENCTO  VENCTO,"
cQuery+="    E1_VENCREA  VENCREA, "
cQuery+="    E1_VALOR VALOR, "
cQuery+="    E1_SALDO SALDO,  "
cQuery+="    E1_WF WORKFLOW, "
cQuery+="    E1_HISTWF HISTORICO, "
cQuery+="    E1_PORTADO PORTADOR , "
cQuery+="    E1_ISS ATRASO, "
cQuery+="    Z1_DTENTRE "
cQuery+="  FROM "
cQuery+="    SE1010 A, "
cQuery+="    SZ1010 B, "
cQuery+="    SA1010 C  "
//	cQuery+="    SD2010 D "
cQuery+="  WHERE "
cQuery+="    A.D_E_L_E_T_ <> '*'  "
cQuery+="    AND B.D_E_L_E_T_ <> '*' "
cQuery+="    AND C.D_E_L_E_T_ <> '*' "
//	cQuery+="    AND D.D_E_L_E_T_ <> '*' "
cQuery+="    AND E1_EMISSAO > '20090101' "
cQuery+="    AND E1_SALDO > 0 "
cQuery+="    AND E1_FILORIG = Z1_FILIAL "
cQuery+="    AND E1_NUM = Z1_DOC "
cQuery+="    AND E1_PREFIXO = Z1_SERIE "
cQuery+="    AND E1_CLIENTE = A1_COD "
cQuery+="    AND E1_LOJA = A1_LOJA "
//	cQuery+="    AND E1_FILORIG = D2_FILIAL "
//	cQuery+="    AND E1_NUM = D2_DOC "
//	cQuery+="    AND E1_PREFIXO = D2_SERIE "
//	cQuery+="    AND D2_VALDEV = 0 "
cQuery+="    AND Z1_DTENTRE = '          ' "
if !lrel
	cQuery+= "	AND E1_PARCELA IN (' ','1')  "
endif
//	cQuery+="ORDER BY E1_CLIENTE, E1_LOJA, E1_NOMCLI "
//	cQuery+="GROUP BY E1_CLIENTE, E1_LOJA, E1_NOMCLI "

MemoWrit("CTRXLS.SQL",cQuery)

TCQUERY cQuery NEW ALIAS "TRB"
TCSetField("TRB","EMISSAO","D")
TCSetField("TRB","VENCTO","D")
TCSetField("TRB","VENCREA","D")

While !TRB->(EOF())
	
	XLS->(RECLOCK("XLS",.T.))
	FOR I:=1 TO TRB->(FCOUNT())
		IF (nPos:=XLS->(FIELDPOS(TRB->(FIELDNAME(I))))) # 0
			XLS->(FIELDPUT(nPos,TRB->(FIELDGET(I))))
		ENDIF
	NEXT
	TRB->(DBSKIP())
	//Close(TRB)
EndDo
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


User Function e1ncc(xchv,nvltot)
NRet := 0

ASD2 := GETAREA()
_NTT := 0
_NQTD := 0
XVH := XCHV //SE1->E1_FILORIG+SE1->E1_NUM+SE1->E1_PREFIXO

cQry:="SELECT SUM(D2_QTDEDEV) NVALDEV , SUM(D2_QUANT) NQTD "
cQry+="FROM "+RetSqlName("SD2")+" WHERE D_E_L_E_T_=' ' " 
cQry+="AND D2_FILIAL = '"+ SUBSTR(XVH,1,2) +"' "
cQry+="AND D2_DOC = '"+ SUBSTR(XVH,3,9) +"' "
cQry+="AND D2_SERIE = '"+ SUBSTR(XVH,12,3) +"' "
DbUseArea( .t., "TOPCONN", TcGenQry(,,cQry), "Pega" )
TcSetField( "Pega", "NVALDEV", "N", 10, 2 )
_NTT := Pega->NVALDEV
_NQTD := Pega->NQTD
Pega->(DbCloseArea())

IF _NTT > 0
	IF  _NQTD - _NTT > 0
		NRet := 1
	ELSEIF _NQTD - _NTT == 0
		NRet := 2
	ELSE
		NRet := 0
	endif
ENDIF

RESTAREA(ASD2)

Return nRet



User Function fDev()
lRet := .t.


Return lRet


User Function CLIAGE()
//.AND. EMPTY(GETADVFVAL('SF2','F2_DATAAG',SE1->E1_FILORIG+SE1->E1_NUM+SE1->E1_PREFIXO,1,CTOD(''))
lRet := .f.
                       
_NTT := 0

/*
IF GETADVFVAL("SA1","A1_TEMAGE",XFILIAL("SA1")+SE1->E1_CLIENTE,1,"") == "1"
	lRet := .T.
ENDIF
*/


// PROCURA SE ALGUM CLIENTE (CODIGO RAIZ) EXIGE AGENDAMENTO
cQry:="SELECT COUNT(*) NTEMAGE "
cQry+="FROM "+RetSqlName("SA1")+" WHERE D_E_L_E_T_=' ' AND A1_COD='"+SE1->E1_CLIENTE+"'  "
DbUseArea( .t., "TOPCONN", TcGenQry(,,cQry), "Pega" )
TcSetField( "Pega", "NTEMAGE", "N", 10, 2 )
_NTT := Pega->NTEMAGE
Pega->(DbCloseArea())

IF _NTT > 0
	lRet := .T.
ENDIF

Return lRet

User Function CLIAGE2()
ASE1 := GETAREA()
lRet := .f.
_NTT := 0
XVH := SE1->E1_FILORIG+SE1->E1_NUM+SE1->E1_PREFIXO
XDT := GETADVFVAL('SF2','F2_DATAAG',XVH,1,CTOD(''))

// PROCURA SE ALGUM CLIENTE (CODIGO RAIZ) EXIGE AGENDAMENTO
cQry:="SELECT COUNT(*) NTEMAGE "
cQry+="FROM "+RetSqlName("SA1")+" WHERE D_E_L_E_T_=' ' AND A1_COD='"+SE1->E1_CLIENTE+"'  AND A1_AGEND = '1' "
DbUseArea( .t., "TOPCONN", TcGenQry(,,cQry), "Pega" )
TcSetField( "Pega", "NTEMAGE", "N", 10, 2 )
_NTT := Pega->NTEMAGE
Pega->(DbCloseArea())

IF _NTT > 0 .AND. EMPTY( XDT )
	lRet := .T.
ENDIF
RESTAREA(ASE1)
Return lRet


User Function CLIAGE3()
ASE1 := GETAREA()
lRet := .f.
_NTT := 0

// PROCURA SE ALGUM CLIENTE (CODIGO RAIZ) EXIGE AGENDAMENTO
cQry:="SELECT COUNT(*) NTEMAGE "
cQry+="FROM "+RetSqlName("SA1")+" WHERE D_E_L_E_T_=' ' AND A1_COD='"+SF2->F2_CLIENTE+"'  AND A1_AGEND = '1' "
DbUseArea( .t., "TOPCONN", TcGenQry(,,cQry), "Pega" )
TcSetField( "Pega", "NTEMAGE", "N", 10, 2 )
_NTT := Pega->NTEMAGE
Pega->(DbCloseArea())

IF _NTT > 0 //.AND. EMPTY( SF2->F2_DATAAG )
	lRet := .T.
ENDIF
RESTAREA(ASE1)
Return lRet

User Function CLIAGE4()
ASE1 := GETAREA()
lRet := .f.
_NTT := 0

// PROCURA SE ALGUM CLIENTE (CODIGO RAIZ) EXIGE AGENDAMENTO
cQry:="SELECT COUNT(*) NTEMAGE "
cQry+="FROM "+RetSqlName("SA1")+" WHERE D_E_L_E_T_=' ' AND A1_COD='"+SE1->E1_CLIENTE+"'  AND A1_AGEND = '1' "
DbUseArea( .t., "TOPCONN", TcGenQry(,,cQry), "Pega" )
TcSetField( "Pega", "NTEMAGE", "N", 10, 2 )
_NTT := Pega->NTEMAGE
Pega->(DbCloseArea())

IF _NTT > 0 //.AND. EMPTY( SF2->F2_DATAAG )
	lRet := .T.
ENDIF
RESTAREA(ASE1)
Return lRet




User Function fil001()

XFILTRO := "SE1->E1_SALDO > 0    						 "
XFILTRO += "	.AND. U_FENTR()  						 "
XFILTRO += "	.AND. SE1->E1_PARCELA $ ' /1'            "
XFILTRO += "	.AND. SE1->E1_EMISSAO > CTOD('01/01/09') "
XFILTRO += "	.AND. 'MATA460'$SE1->E1_ORIGEM 			 "
XFILTRO += "	.AND. U_CLIAGE4() 	   					 "
                                       	

dbSelectArea("SE1")
IndRegua("SE1",cArqInd,IndexKey(),,XFILTRO)
nIndex := RetIndex("SE1")
#IFNDEF TOP
	dbSetIndex(cArqInd+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+12)
dbGotop()
/*DbSelectArea("SE1")
DbSetOrder(11)

SET FILTER TO &XFILTRO
DbGoTop()*/


Return

User Function fil002()

XFILTRO := "SE1->E1_SALDO > 0    						 "
XFILTRO += "	.AND. U_FENTR()  						 "
XFILTRO += "	.AND. SE1->E1_PARCELA $ ' /1'            "
XFILTRO += "	.AND. SE1->E1_EMISSAO > CTOD('01/01/09') "
//XFILTRO += "	.AND. U_E1NCC(SE1->E1_FILORIG+SE1->E1_NUM+SE1->E1_PREFIXO+SE1->E1_CLIENTE+SE1->E1_LOJA,GETADVFVAL('SF2','F2_VALBRUT',SE1->E1_FILORIG+SE1->E1_NUM+SE1->E1_PREFIXO,1,0)  ) == 0 						 "
XFILTRO += "	.AND. 'MATA460'$SE1->E1_ORIGEM 			 "
//XFILTRO += "	.AND. SE1->E1_NUM == '001822' 			 "

dbSelectArea("SE1")
IndRegua("SE1",cArqInd,IndexKey(),,XFILTRO)
nIndex := RetIndex("SE1")
#IFNDEF TOP
	dbSetIndex(cArqInd+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+12)
dbGotop()
/*DbSelectArea("SE1")
DbSetOrder(11)

SET FILTER TO &XFILTRO
DbGoTop()*/


Return
