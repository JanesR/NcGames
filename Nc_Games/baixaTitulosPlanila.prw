#Include 'Protheus.ch'

#define PREFIXO 1
#define TITULO 2
#define PARCELA 3
#define TIPO 4
#define VALOR 5

Static aDados:={}
Static aDadosSE5:={}

user Function NcgExBaixa()
Local aArea := GetArea()
Local cArquivo := padr("",300)
Local aPergs := {}
Local aRet :={}
Local aTitulos := {}
Local aRecs := {}
Local ctime := ""
Local ctimeend :=""
Local cMensagem := ""

aAdd( aPergs ,{6,"Arquivo",cArquivo,"",,"", 90 ,.T.,"Arquivos .CSV |*.CSV","C:\",GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_NETWORKDRIVE})

IF ParamBox(aPergs, 'Baixa de Titulos por arquivo CSV', aRet)
    
    aTitulos := LerArquivo(aRet[1])
    aTitulos := BuscaRec(aTitulos)
    ProcRegua( len(aTitulos) )
    ctime := time()
    MsgRun("Processando....", "Excluindo Baixas",{|| ExcluiBX(aTitulos)})
	ctimeend := time()
	cMensagem := "Processo finalizado, tempo de excecução: "+ CRLF
	cMensagem += "[ Hora inicial ]  "+ctime    + CRLF
	cMensagem += "[ Hora Final   ]  "+ctimeend
	MsgInfo(cMensagem, "Tempo de execução")

EndIf

restArea(aArea)
Return

Static Function LerArquivo(arq)
Local aArea := GetArea()
Local cArquivo := arq
Local aTitulos := {}
Local aT1 := {}
Local cBuffer := ""

FT_FUSE(cArquivo)  //ABRIR ARQUIVO
FT_FGOTOP() //POSSICIONAR NO INICIO

While !FT_FEOF()
    cBuffer := FT_FREADLN()
    aT1 := separa(cBuffer,';')
    aadd(aTitulos,aT1)
    aT1 := {}
    FT_FSKIP()
End

restArea(aArea)
Return aTitulos


Static Function ExcluiBX(aTitulos)

Local aArea := GetArea()
Local nOpcao := 6
Local aBaixa := {}
local lFoundSE5 := .F.
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

for nx:=1 to Len(aTitulos)
    IncProc("Processando item:" + str(nx))
    aBaixa := {}

    AADD(aBaixa , {"E1_PREFIXO"	, PadR(aTitulos[nx][PREFIXO],TamSx3("E1_PREFIXO")[1])	, NIL})
    AADD(aBaixa , {"E1_NUM"		, StrZero(val(aTitulos[nx][TITULO])	,TamSx3("E1_NUM")[1] ,0)	, NIL})
    AADD(aBaixa , {"E1_PARCELA"	, PadR(aTitulos[nx][PARCELA],TamSx3("E1_PARCELA")[1])	, NIL})
    AADD(aBaixa , {"E1_TIPO"	, PadR(aTitulos[nx][TIPO],TamSx3("E1_TIPO")[1])			, NIL})
	AADD(aBaixa , {"E1_VALOR"	, PadR(aTitulos[nx][VALOR],TamSx3("E1_VALOR")[1])		, NIL})

    lFoundSE5:= M980PosSE5(PadR(aTitulos[nx][PREFIXO],TamSx3("E1_PREFIXO")[1]),;
						   StrZero(val(aTitulos[nx][TITULO]),TamSx3("E1_NUM")[1] ,0),;
						   PadR(aTitulos[nx][PARCELA],TamSx3("E1_PARCELA")[1]),;
						   PadR(aTitulos[nx][TIPO],TamSx3("E1_TIPO")[1]))

    Begin Transaction
			lMsErroAuto := .F.
			
			SetFunName("FINA070")
			Pergunte("FIN070",.F.)
			If lFoundSE5
				MSExecAuto({|x, y| Fina070(x, y)}, aBaixa, nOpcao)
                //Verifica se ocorreru algum erro no processamento
                If lMSErroAuto
                    cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
                    MemoWrite(NomeAutoLog()," ")
                    cRet := cMsgErro
                    DisarmTransaction()
                EndIf
		
			Else
				lMsErroAuto:=.T.
				cMsgErro :="SE5 não encontrado."
			EndIf
			
			If lMsErroAuto .And. lFoundSE5
				cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
				MostraErro('cPath',NomeAutoLog())//Apagar o arquivo atual
				DisarmTransaction()
			EndIf
						
			MsUnLockAll()
		End Transaction
next

restArea(aArea)
Return



Static Function M980PosSE5( Prefix,Num,Parc,Tipo )
	Local aAreaAtu:=GetArea()
	Local cAliaQry	:=GetNextAlias()
	Local lFound
	
	aDadosSE5 := {}
	BeginSql Alias cAliaQry
		Select SE5.R_E_C_N_O_ RecSE5
		From %Table:SE5% SE5
		Where SE5.E5_FILIAL=%xFilial:SE5%
		And SE5.E5_NUMERO=%Exp:Num%
		And SE5.E5_PREFIXO=%Exp:Prefix%
		And SE5.E5_PARCELA =%Exp:Parc%
		And SE5.E5_TIPO =%Exp:Tipo%
		And SE5.%notDel%
	EndSql
	
	aDadosSE5:={}
	If (lFound:=(cAliaQry)->RecSE5>0)
		SE5->(DbGoTo((cAliaQry)->RecSE5)) 
		AAdd(aDadosSE5,SE5->E5_SEQ  )
		AAdd(aDadosSE5,SE5->E5_VALOR )
	EndIf
	(cAliaQry)->(DbCloseArea())
	
	
	RestArea(aAreaAtu)
Return lFound

Static Function BuscaRec(aTitulos)
Local aArea := GetArea()
Local aRecs := {}
Local aAreaSE1 := SE1->(GetArea())
Local cChave := ""
DbSelectArea("SE1")
DbSetOrder(1)
for nx:=1 to len(aTitulos)

    cChave := xFilial("SE1") + PadR(aTitulos[nx][PREFIXO],TamSx3("E1_PREFIXO")[1]) +;
                               StrZero(val(aTitulos[nx][TITULO]) ,TamSx3("E1_NUM")[1] ,0) +;
                               PadR(aTitulos[nx][PARCELA] ,TamSx3("E1_PARCELA")[1]) +;
                               PadR(aTitulos[nx][TIPO],TamSx3("E1_TIPO")[1])

    if DbSeek(cChave)
		if ALLTRIM( DtoS(SE1->(E1_BAIXA) )) != ""
			aadd(aRecs,{PadR(aTitulos[nx][PREFIXO],TamSx3("E1_PREFIXO")[1]) ,;
								StrZero(val(aTitulos[nx][TITULO]) ,TamSx3("E1_NUM")[1] ,0) ,;
								PadR(aTitulos[nx][PARCELA] ,TamSx3("E1_PARCELA")[1]) ,;
								PadR(aTitulos[nx][TIPO],TamSx3("E1_TIPO")[1]) ,;
								PadR(aTitulos[nx][VALOR],TamSx3("E1_VALOR")[1])} )
		endIf
    EndIf
next

restArea(aArea)
Return aRecs
