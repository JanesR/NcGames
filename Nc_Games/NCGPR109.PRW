#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE 'TopConn.ch'

Static nHandle
Static aPos_A01:={}
Static aPos_A02:={}
Static aPos_A13:={}
Static aPos_A16:={}
Static aPos_A08:={}


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/18/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR109JOB(aDados)
Local aTabelas	:={"SB1","SF1","SC5","SF2"}
Default aDados:={"01","06","E","T"}


RpcClearEnv()      
RpcSetType(3)
RpcSetEnv(aDados[1],aDados[2])
       

If Upper(aDados[3])=="E"	 //Enviar
	If Upper(aDados[4])=="T" 
		AEval(aTabelas, {|cTabela| U_PR109Enviar(Upper(cTabela),.T.) } )
	Else
		U_PR109Enviar(Upper(AllTrim(aDados[4])),.T.) 	
	Endif	
Else
	U_PR109Retornar()
EndIf


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  09/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGPR109()
Local aCargas		:={}
Local aExecJob		:={}
Local cPerg			:="NCGPR109"
Local cFiltro		:=""
Local aExecEnviar :={}
Local aExecReceber :={}
Local nDias
Private aRotina 	:= { }
Private cCadastro	:="Monitor - Integracao WMS Store"


CriaSX1(cPerg)
If !Pergunte(cPerg)
	Return
EndIf

If mv_par01==1 .Or. mv_par01==5
	
	AAdd(aCargas,{"Produto","U_PR109CARG('SB1')",0,3})
	AAdd(aExecEnviar,{"Enviar Produto"				,"Processa( {|| U_PR109Enviar('SB1',.F.) }) ",0,3})
	
	If !mv_par01=5
		cFiltro:="ZZW_TABELA In('SB1','SB2')"
	EndIf
EndIf

If mv_par01==2 .Or. mv_par01==5
	
	AAdd(aExecEnviar,{"Enviar Nota de Entrada"	,"Processa( {|| U_PR109Enviar('SF1',.F.)}) ",0,3})
	If !mv_par01=5
		cFiltro:="ZZW_TABELA='SF1'"
	EndIf
EndIf

If mv_par01==3 .Or. mv_par01==5
	AAdd(aExecEnviar,{"Enviar Pedido Venda"		,"Processa( {|| U_PR109Enviar('SC5',.F.)}) ",0,3})
	If !mv_par01=5
		cFiltro:="ZZW_TABELA='SC5'"
	EndIf
EndIf

If mv_par01==4 .Or. mv_par01==5
	AAdd(aExecEnviar,{"Enviar Nota de Saํda"  	,"Processa( {|| U_PR109Enviar('SF2',.F.)}) ",0,3})
	If !mv_par01=5
		cFiltro:="ZZW_TABELA='SF2'"
	EndIf
EndIf

cFiltro+=IIf(!Empty(cFiltro) .And.  mv_par02<>3 ," And ","")

If mv_par02==1
	cFiltro+=" ZZW_DATENV<>' '"
ElseIf mv_par02=2
	cFiltro+=" ZZW_DATENV=' '"
EndIf

cFiltro+=IIf(!Empty(cFiltro) .And.  mv_par03<>3 ," And ","")
If mv_par03==1
	cFiltro+=" ZZW_DATRET<>' '"
ElseIf mv_par03=2
	cFiltro+=" ZZW_DATRET=' '"
EndIf

cFiltro+=IIf(!Empty(cFiltro) .And.  mv_par04<>3 ," And ","")

If mv_par04==1
	cFiltro+=" ZZW_ERRO<>'S'"
ElseIf mv_par04=2
	cFiltro+=" ZZW_ERRO='S'"
EndIf

cFiltro+=IIf(!Empty(cFiltro) .And.  mv_par05<>3 ," And ","")

If mv_par05==1
	cFiltro+=" ZZW_ESTORN<>'S'"
ElseIf mv_par05=2
	cFiltro+=" ZZW_ESTORN='S'"
EndIf

//AAdd(aExecJob,{"Enviar"	,aExecEnviar,0,3})
//AAdd(aExecJob,{"Receber",aExecReceber,0,3})

AAdd(aExecEnviar,{"Sugestao Transportadora"  ,"Processa( {|| U_PR109Transp()}) ",0,3})
AAdd(aExecEnviar,{"Receber Arquivos"      	,"Processa( {|| U_PR109Retornar()}) ",0,3})

AAdd(aRotina,{"Pesquisar","AxPesqui"		,0,1})
AAdd(aRotina,{"Visualizar","AxVisual"		,0,2})
AAdd(aRotina,{"Estornar" ,"U_PR109Estor"	,0,5})
AAdd(aRotina,{"Jobs",aExecEnviar,0,3})


If Len(aCargas)>0
	AAdd(aRotina,{"Carga Inicial",aCargas,0,3})
EndIf
//AAdd(aRotina,{"Incluir","AxInclui",0,3})
//AAdd(aRotina,{"Alterar","AxAltera",0,4})
                                                      

If !Empty(mv_par06)
	cFiltro+=IIf(!Empty(cFiltro) ," And ","")                                                                                                         
	cFiltro+="ZZW_DATENV<>' ' And 24*( to_date('"+Dtos(MsDate())+" "+Time()+"','yyyymmdd HH24:MI:SS')-to_date(ZZW_DATENV||' '||ZZW_HORENV,'yyyymmdd HH24:MI:SS') )  >= "+AllTrim(Str(mv_par06))
EndIf	

mBrowse( 6,1,22,75,"ZZW",,,,,,,,,,,,,,cFiltro)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  09/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR109carg(cTabela)

If cTabela=="SB1" .And. MsgYesNo("Confirma carga de todo o cadastro de Produto Tipo PA?","NcGames")
	U_PR109Grv(cTabela,"*",'3')
	//StartJob ( "U_PR109Lote()",GetEnvServer(), .F. ,{.T.,cEmpAnt,cFilAnt,"SB1"  } )
	Processa( {|| U_PR109Lote( {.F.,'01','06',"SB1" } )})
	
EndIf


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  09/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR109Grv(cTabela,cChave,cOpc)
Local aDadosTab:=PR09DESTAB(cTabela)


Begin Transaction
ZZW->(RecLock("ZZW",.T.))
ZZW->ZZW_FILIAL:=xFilial("ZZW")
ZZW->ZZW_CHAVE	:=cChave
ZZW->ZZW_TABELA:=cTabela
ZZW->ZZW_DESTAB:=aDadosTab[1]
ZZW->ZZW_TIPO	:=cOpc
ZZW->ZZW_ERRO	:="N"
ZZW->(MsUnLock())
End Transaction

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  09/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR09DESTAB(cTabela)
Local aDados:={""}

If cTabela=="SB1"
	aDados:={"Produto","B1_FILIAL+B1_COD"}
ElseIf cTabela=="SF1"
	aDados:={"Nota Fiscal Entrada","F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO"}
ElseIf cTabela=="SF2"
	aDados:={"Nota Fiscal Saida","F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO"}
ElseIf cTabela=="SC5"
	aDados:={"Pedido Venda","C5_FILIAL+C5_NUM"}
ElseIf cTabela=="SB2"
	aDados:={"Estoque","B2_FILIAL+B2_COD+B2_LOCAL"}
EndIf

Return aDados


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  09/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR109Lote(aDados)
Local nHDL
Local lJob
Default aDados	:= {.F.,'01','06',"SB1" }


lJob:=aDados[1]

If !U_Semaforo(.T.,@nHDL,"PR109LOTE")
	Return()
EndIf

Conout("Iniciando Atualiza็ใo...")
If lJob
	Conout("Emrpesa e Filial")
	RpcSetType(3)
	RpcSetEnv(aDados[2],aDados[3])
EndIF

If aDados[4]=="SB1"
	U_PR109Enviar(aDados[4],lJob)
EndIf

U_Semaforo(.F.,@nHDL,"PR109LOTE")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  09/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR109Enviar(cTabela,lJob)
Local aAreaAtu	:=GetArea()
Local cAliasQry:= GetNextAlias()
Local cAliasTab:= GetNextAlias()
Local cQuery	:=""
Local bWhile	:={}
Local nSizeFil := FWSizeFilial()
Local cChave
Local nLenChave
Local cNomeArq
Local cError	:=""
Local cTabZZW 	:=RetSqlName("ZZW")
Local cPathArq	:=Alltrim(U_MyNewSX6("ES_NCG0004","\ARQ_WMS_STORE\","C","Diretorio Arquivos WMS Store","","",.F. ))
Local cNomeArq
Local cDirTab	:=PR109GetDir(cTabela)
Local nSemaforo
Local cArqSemaforo:=ProcName(0)+cTabela
Local lEnvWMS	:=.F.
Local cArmWmas :=GETMV("MV_ARMWMAS")
Local clArmzCQ	:= SuperGetMV("MV_CQ") //
Private aNomesUsados:={}

If !ExistDir(cPathArq)
	MakeDir(cPathArq)
EndIf

cPathArq+=cDirTab

If !ExistDir(cPathArq)
	MakeDir(cPathArq)
EndIf

If !ExistDir(cPathArq+"Erro\")
	MakeDir(cPathArq+"Erro\")
EndIf

If !ExistDir(cPathArq+"Enviado\")
	MakeDir(cPathArq+"Enviado\")
EndIf

If !U_Semaforo(.T.,@nSemaforo,cArqSemaforo)
	Return
EndIf

ProcRegua(0)
cQuery:=" Select ZZW.R_E_C_N_O_ RECZZW"
cQuery+=" From "+cTabZZW+" ZZW"
cQuery+=" Where ZZW.ZZW_FILIAL='"+xFilial("ZZW")+"'"
cQuery+=" And ZZW.ZZW_TABELA='"+cTabela+"'"
cQuery+=" And ZZW.ZZW_ARQENV='  '"
cQuery+=" And ZZW.ZZW_ESTORN=' '"
cQuery+=" And ZZW.D_E_L_E_T_=' '"
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAliasQry,.F.,.T.)

If cTabela=="SB1"
	
	nLenChave:=AvSx3("B1_FILIAL",3)+AvSx3("B1_COD",3)
	SB5->(DbSetOrder(1))////B5_FILIAL+B5_COD
	
	Do While !(cAliasQry)->(Eof())
		
		cError	:=""
		cNomeArq	:=U_PR109NAME(cTabela)
		If (nHandle:= FCreate(cPathArq+cNomeArq,0))	==-1
			cError:=PR109FError( AllTrim(STR(FERROR()) )  )
		EndIf
		ZZW->(DbGoTo( (cAliasQry)->RECZZW ))
		
		If !Empty(cError)
			PR109GrvErro(cError)
			(cAliasQry)->(DbSkip())
			Loop
		EndIf
		
		If AllTrim(ZZW->ZZW_CHAVE)=="*"
			SB1->(DbSetOrder(2))//B1_FILIAL+B1_TIPO+B1_COD
			cChave:=xFilial("SB1")+"PA"
			SB1->(MsSeek(cChave))
			bWhile:={|| SB1->(B1_FILIAL+B1_TIPO)==cChave}
		Else
			SB1->(DbSetOrder(1))//B1_FILIAL+B1_COD
			cChave:=Padr(RTrim(ZZW->ZZW_CHAVE),nLenChave)
			SB1->(MsSeek(cChave))
			bWhile:={|| SB1->(B1_FILIAL+B1_COD)==cChave}
		EndIf
		
		Do While SB1->(!Eof()) .And. Eval(bWhile)
			SB5->(DbSeek(xFilial("SB5")+SB1->B1_COD))
			If SB5->B5_YSOFTW <> "1"
				If !lJob
					IncProc("Processando produto:"+SB1->B1_COD+"-"+SB1->B1_XDESC)
				EndIf
				PR109Linha(nHandle,"SB1")
			EndIf
			SB1->(DbSkip())
		EndDo
		
		Begin Transaction
		
		If FClose(nHandle)
			ZZW->(RecLock("ZZW",.F.))
			ZZW->ZZW_ARQENV	:=cNomeArq
			ZZW->ZZW_ERRO	:="N"
			ZZW->ZZW_DSERRO:=""
			ZZW->(MsUnLock())
			U_PR109Conec(cTabela)
		EndIf
		
		End Transaction
		
		(cAliasQry)->(DbSkip())
	EndDo
	
	U_PR109Conec(cTabela)
	U_Semaforo(.F.,nSemaforo,cArqSemaforo)
	
ElseIf cTabela=="SF1"
	
	nLenChave:= AvSx3("F1_FILIAL",3)+AvSx3("F1_DOC",3)+AvSx3("F1_SERIE",3)+AvSx3("F1_FORNECE",3)+AvSx3("F1_LOJA",3)+AvSx3("F1_TIPO",3)
	
	Do While !(cAliasQry)->(Eof())
		
		cError	:=""
		cNomeArq	:=U_PR109NAME(cTabela)
		If (nHandle:= FCreate(cPathArq+cNomeArq,0))	==-1
			cError:=PR109FError( AllTrim(STR(FERROR()) )  )
		EndIf
		
		If !Empty(cError)
			PR109GrvErro(cError)
			(cAliasQry)->(DbSkip())
			Loop
		EndIf
		
		ZZW->(DbGoTo( (cAliasQry)->RECZZW ))
		SF1->(DbSetOrder(1))//F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO
		cChave:=Padr(RTrim(ZZW->ZZW_CHAVE),nLenChave)
		
		If SF1->(MsSeek(cChave))
			SB1->(DbSetOrder(1))
			PR109Linha(nHandle,"SF1")
			
			cQuery:=" Select SD1.R_E_C_N_O_ RECSD1"
			cQuery+=" From "+RetSqlName("SD1")+" SD1"
			cQuery+=" Where SD1.D1_FILIAL='"+xFilial("SD1")+"'"
			cQuery+=" And SD1.D1_DOC='"+SF1->F1_DOC+"'"
			cQuery+=" And SD1.D1_SERIE='"+SF1->F1_SERIE+"'"
			cQuery+=" And SD1.D1_FORNECE='"+SF1->F1_FORNECE+"'"
			cQuery+=" And SD1.D1_LOJA='"+SF1->F1_LOJA+"'"
			cQuery+=" And SD1.D_E_L_E_T_=' '"
			cQuery+=" Order by SD1.D1_ITEM"
			DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAliasTab,.F.,.T.)
			
			Do While (cAliasTab)->(!Eof())
				
				SD1->(DbGoTo((cAliasTab)->RECSD1))
				SB1->(DbSeek(xFilial("SB1")+SD1->D1_COD))
				
				If !SB1->B1_TIPO== "PA"//SOMENTE PRODUTOS DO TIPO PA DEVEM SER EXPORTADOS PARA O WMS
					(cAliasTab)->(DbSkip());Loop
				EndIf
				
				If !Posicione("SF4",1,xFilial("SF4")+SD1->D1_TES,"F4_ESTOQUE") == "S" 		//SOMENTE ITENS QUE MOVIMENTEM ESTOQUE DEVEM SER EXPORTADORS PARA O WMS
					(cAliasTab)->(DbSkip());Loop
				EndIf
				
				If ! ( SD1->D1_LOCAL $ FORMATIN(cArmWmas,"/") .OR. SD1->D1_LOCAL $ FORMATIN(clArmzCQ,"/") )//SOMENTE ITENS COM OS ARMAZENS CONTROLADOS PELO WMS (MV_ARMWMAS)
					(cAliasTab)->(DbSkip());Loop
				EndIf
				
				If SD1->D1_QUANT==0
					(cAliasTab)->(DbSkip());Loop
				EndIf
				
				PR109Linha(nHandle,"SD1")
				(cAliasTab)->(DbSkip())
			EndDo
			(cAliasTab)->(DbCloseArea())
			DbSelectArea(cAliasQry)
			
			Begin Transaction
			
			If FClose(nHandle)
				ZZW->(RecLock("ZZW",.F.))
				ZZW->ZZW_ARQENV	:=cNomeArq
				ZZW->ZZW_ERRO	:="N"
				ZZW->ZZW_DSERRO:=""
				ZZW->(MsUnLock())
			EndIf
			
			End Transaction
			
		EndIf
		(cAliasQry)->(DbSkip())
	EndDo
	
	U_PR109Conec(cTabela)
	U_Semaforo(.F.,nSemaforo,cArqSemaforo)
	
ElseIf cTabela=="SF2"
	
	nLenChave:= AvSx3("F2_FILIAL",3)+AvSx3("F2_DOC",3)+AvSx3("F2_SERIE",3)+AvSx3("F2_CLIENTE",3)+AvSx3("F2_LOJA",3)+AvSx3("F2_FORMUL",3)+AvSx3("F2_TIPO",3)
	
	Do While !(cAliasQry)->(Eof())
		
		cError	:=""
		cNomeArq	:=U_PR109NAME(cTabela)
		If (nHandle:= FCreate(cPathArq+cNomeArq,0))	==-1
			cError:=PR109FError( AllTrim(STR(FERROR()) )  )
		EndIf
		
		If !Empty(cError)
			PR109GrvErro(cError)
			(cAliasQry)->(DbSkip())
			Loop
		EndIf
		
		ZZW->(DbGoTo( (cAliasQry)->RECZZW ))
		SF2->(DbSetOrder(1))//F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
		cChave:=AllTrim(ZZW->ZZW_CHAVE)
		
		If SF2->(MsSeek(cChave))
			PR109Linha(nHandle,"SF2")
			
			Begin Transaction
			
			If FClose(nHandle)
				ZZW->(RecLock("ZZW",.F.))
				ZZW->ZZW_ARQENV	:=cNomeArq
				ZZW->ZZW_ERRO	:="N"
				ZZW->ZZW_DSERRO:=""
				ZZW->(MsUnLock())
			EndIf
			
			End Transaction
			
		EndIf
		(cAliasQry)->(DbSkip())
	EndDo
	
	U_PR109Conec(cTabela)
	U_Semaforo(.F.,nSemaforo,cArqSemaforo)
	
ElseIf cTabela=="SC5"
	
	
	nLenChave:= AvSx3("C5_FILIAL",3)+AvSx3("C5_NUM",3)
	
	Do While !(cAliasQry)->(Eof())
		
		cError	:=""
		cNomeArq	:=U_PR109NAME(cTabela)
		If (nHandle:= FCreate(cPathArq+cNomeArq,0))	==-1
			cError:=PR109FError( AllTrim(STR(FERROR()) )  )
		EndIf
		
		If !Empty(cError)
			PR109GrvErro(cError)
			(cAliasQry)->(DbSkip())
			Loop
		EndIf
		
		
		ZZW->(DbGoTo( (cAliasQry)->RECZZW ))
		SC5->(DbSetOrder(1))//C5_FILIAL+C5_NUM
		
		cChave:=Padr(RTrim(ZZW->ZZW_CHAVE),nLenChave)
		
		
		If SC5->(MsSeek(cChave))
			
			PR109Modal()  //Verifica se cliente ้ modal proprio
			
			If !Empty(SC5->C5_YTRANSP)//Jแ foi realizada a susgestใo de frete
				
				SB1->(DbSetOrder(1))
				PR109Linha(nHandle,"SC5")
				cChave:=xFilial("SC9")+SC5->C5_NUM
				
				SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
				SC9->(MsSeek(cChave))
				lEnvWMS:=.F.
				Do While SC9->(!Eof()) .And. SC9->(C9_FILIAL+C9_PEDIDO) ==cChave
					
					If !Empty(SC9->C9_BLWMS) .And. Empty(SC9->C9_BLEST) .And. Empty(SC9->C9_BLCRED)
						SB1->(DbSeek(xFilial("SB1")+SC9->C9_PRODUTO))
						PR109Linha(nHandle,"SC9")
						lEnvWMS:=.T.
					EndIf
					SC9->(DbSkip())
				EndDo
				
				FClose(nHandle)
				
				ZZW->(DbGoTo( (cAliasQry)->RECZZW ))
				Begin Transaction
				If lEnvWMS
					ZZW->(RecLock("ZZW",.F.))
					ZZW->ZZW_ARQENV:=cNomeArq
					ZZW->ZZW_ERRO	:="N"
					ZZW->ZZW_DSERRO:=""
					ZZW->(MsUnLock())
					U_PR109Conec(cTabela,cNomeArq)
				Else
					Ferase(cNomeArq)
				EndIf
				
				End Transaction
				
				
			EndIf
		EndIf
		(cAliasQry)->(DbSkip())
	EndDo
	
	U_PR109Conec(cTabela)
	U_Semaforo(.F.,nSemaforo,cArqSemaforo)
	
	
EndIf



(cAliasQry)->(DbCloseArea())
RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/02/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR109Retornar()
Local cFilAtu		:=cFilAnt
Local aAreaAtu		:=GetArea()
Local cAliasQry	:= GetNextAlias()
Local cAliasTab	:= GetNextAlias()
Local cQuery		:=""
Local bWhile		:={}
Local nSizeFil 	:= FWSizeFilial()
Local cError		:=""
Local cTabZZW 		:=RetSqlName("ZZW")
Local cPathArq		:=Alltrim(U_MyNewSX6("ES_NCG0004","\ARQ_WMS_STORE\","C","Diretorio Arquivos WMS Store","","",.F. ))
Local cArqSemaforo:=ProcName(0)
Local cNomeArq
Local nSemaforo
Local aDados
Local aRetArq
Local cNomeArq
Local cNomeWork
Local cNomeTrb
Local aDbfStru:={}
Local nLenItem	:=AvSx3("D2_ITEM"		,3)
Local nLenPV	:=AvSx3("C5_NUM"		,3)
Local aLotePend:={}
Local aProcessado:={}
Local lFirst
Local lPedidoVenda:=.F.
Local cArqRet

If !ExistDir(cPathArq)
	MakeDir(cPathArq)
EndIf

If !ExistDir(cPathArq+"Erro\")
	MakeDir(cPathArq+"Erro\")
EndIf

If !ExistDir(cPathArq+"Retornado\")
	MakeDir(cPathArq+"Retornado\")
EndIf

If !ExistDir(cPathArq+"Retornado\Processado")
	MakeDir(cPathArq+"Retornado\Processado")
EndIf

If !ExistDir(cPathArq+"Retornado\Erro")
	MakeDir(cPathArq+"Retornado\Erro")
EndIf


If !U_Semaforo(.T.,@nSemaforo,cArqSemaforo)
	Return
EndIf

If !ConectFTP("C")
	Return .F.
EndIf

If !FtpDirChange( "/Ncgames/Retorno/")
	PR109EnvMail("Nใo foi possํvel acessar o diretorio /Ncgames/Retorno/.")
EndIf

If Select("Work")>0
	Work->(DbCloseArea())
EndIf


AADD(aDbfStru,{"TIPOREG"	,"C",2,0})
AADD(aDbfStru,{"FILIAL"		,"C",nSizeFil,0})
AADD(aDbfStru,{"TABELA"		,"C",6		,0})
AADD(aDbfStru,{"ARQUIVO"	,"C",50		,0})
AADD(aDbfStru,{"DATAEST"	,"D",08		,0})
AADD(aDbfStru,{"ARMAZEM"	,"C",02		,0})
AADD(aDbfStru,{"UM"			,"C",AvSx3("B1_UM"		,3)		,0})
AADD(aDbfStru,{"DOCUMENTO"	,"C",AvSx3("F2_DOC"		,3),0})
AADD(aDbfStru,{"SERIE"		,"C",AvSx3("F2_SERIE"	,3),0})
AADD(aDbfStru,{"CLIFOR"		,"C",AvSx3("F2_CLIENTE"	,3),0})
AADD(aDbfStru,{"LOJA"		,"C",AvSx3("F2_LOJA"		,3),0})
AADD(aDbfStru,{"PRODUTO"	,"C",AvSx3("B1_COD"		,3),0})
AADD(aDbfStru,{"ITEM"		,"C",AvSx3("D2_ITEM"		,3),0})
AADD(aDbfStru,{"QUANTIDADE","N",AvSx3("D2_QUANT"	,3),AvSx3("D2_QUANT"	,4)})
AADD(aDbfStru,{"VOLUME"		,"N",AvSx3("C5_VOLUME1"	,3),AvSx3("C5_VOLUME1"	,4)})
AADD(aDbfStru,{"STATUSOPER","C",AvSx3("ZZW_STATUS"	,3),AvSx3("ZZW_STATUS"	,4)})
AADD(aDbfStru,{"TIPODOC"	,"C",5,0})

cNomeWork:=E_CriaTrab(,aDbfStru,"Work")
IndRegua("Work",cNomeWork+OrdBagExt()    ,"FILIAL+TIPOREG+DOCUMENTO+ITEM+PRODUTO", , , ,.F. )



AADD(aDbfStru,{"NUMEROSERI"	,"C",AvSx3("ZZC_IMEI_1"		,3),0})
cNomeTrb:=E_CriaTrab(,aDbfStru,"Trb")
IndRegua("Trb",cNomeTrb+OrdBagExt()    ,"FILIAL+DOCUMENTO", , , ,.F. )


aRetArq := FTPDIRECTORY( "*.txt", )
For nInd:=1 To Len(aRetArq)
	If File(cPathArq+"Retornado\" + aRetArq[nInd][1])
		FTPERASE( aRetArq[nInd][1] )
	ElseIf !FtpDownload( cPathArq+"Retornado\" + aRetArq[nInd][1], aRetArq[nInd][1])
		PR109EnvMail("Nใo foi baixar o arquivo "+aRetArq[nInd][1])
	Else
		FTPErase( aRetArq[nInd][1] )
	EndIf
Next
aRetArq := Directory( cPathArq+"Retornado\*.txt", )


For nInd:=1 To Len(aRetArq)
	
	If !RetProcessado(AllTrim(aRetArq[nInd,1]),cPathArq+"Retornado\","")
		Loop
	Endif
	
	cArquivo	:= cPathArq+"Retornado\"+aRetArq[nInd,1]
	
	FT_FUSE(cArquivo)  //ABRIR
	FT_FGOTOP() //PONTO NO TOPO
	Work->(__DbZap());Trb->(__DbZap())
	aLotePend:={}
	
	Do While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
		cBuffer := FT_FREADLN() //LENDO LINHA
		aDados:={}
		SeparaDados(aDados,cBuffer,aRetArq[nInd,1])
		
		If Empty(aDados)
			FT_FSKIP();Loop
		EndIf
		
		cTipoReg:=aDados[01]
		
		If cTipoReg$"08"
			Trb->(DbAppend())
		Else
			Work->(DbAppend())
		EndIf
		
		If cTipoReg$"01*03*53"
			Work->FILIAL		:=cFilAnt
			WORK->TABELA		:=IIf(aDados[1]=="01","NOTA","PEDIDO")
			Work->DOCUMENTO	:=SubStr(aDados[14],3)
			Work->SERIE 		:=aDados[13]
			Work->TIPOREG 		:=cTipoReg
			Work->ARQUIVO 		:=aRetArq[nInd,1]
			Work->STATUSOPER  :=aDados[59]
			Work->TIPODOC 		:=aDados[12]
			Work->VOLUME		:=Val(aDados[49])/10000
		ElseIf cTipoReg$"04"//Item
			Work->FILIAL		:=cFilAnt
			Work->TABELA		:=IIf(aDados[1]=="02","NOTA","PEDIDO")
			Work->DOCUMENTO	:=SubStr(aDados[05],3)
			Work->SERIE 		:=aDados[04]
			Work->PRODUTO 		:=aDados[07]
			Work->ITEM	 		:=StrZero( Val(aDados[18]),nLenItem)
			Work->QUANTIDADE  :=Val(aDados[08])/10000
			Work->TIPOREG 	:=cTipoReg
			Work->ARQUIVO 	:=aRetArq[nInd,1]
		ElseIf cTipoReg$"08"//Numero de Serie
			Trb->FILIAL		:=cFilAnt
			Trb->DOCUMENTO	:=SubStr(aDados[05],3)
			Trb->SERIE 		:=aDados[04]
			Trb->PRODUTO 		:=aDados[07]
			Trb->TIPOREG 		:=cTipoReg
			Trb->NUMEROSERI	:=aDados[08]
			Trb->ARQUIVO 		:=aRetArq[nInd,1]
		ElseIf cTipoReg$"16"
			AADD(aLotePend,{cFilAnt,SubStr( aDados[05],nSizeFil+1)})
		ElseIf cTipoReg=="55"
			Work->FILIAL		:=cFilAnt
			Work->TIPOREG 		:=cTipoReg
			Work->PRODUTO 		:=aDados[07]
			Work->DATAEST 		:=CTOD( Left( aDados[06],2)+"/"+SubStr( aDados[06],3,2  )+"/"+SubStr( aDados[06],5,4)   )
			Work->QUANTIDADE  :=Val(aDados[15])/10000
			Work->ARQUIVO 		:=aRetArq[nInd,1]
			Work->DOCUMENTO	:="ESTOQUE"
			Work->ARMAZEM		:=aDados[14]
			Work->UM				:=aDados[08]
		EndIf
		FT_FSKIP()   //pr๓ximo registro no arquivo txt
	EndDo
	
	FT_FUSE() //fecha o arquivo txt
	Work->(DbGoTop())
	SC5->(DbSetOrder(1))//C5_FILIAL+C5_NUM
	SC9->(DBOrderNickName("PEDPRODWMS"))//C9_FILIAL+C9_PEDIDO+C9_PRODUTO
	ZZW->(DbSetOrder(2))//ZZW_ARQRET  ***** SEEK SEM FILIAL
	
	Do While Work->(!Eof())
		
		cFilWork	:=Work->FILIAL
		cFilAnt	:=cFilWork
		
		Do While Work->(!Eof()) .And. Work->FILIAL==cFilWork
			
			cArqRet	 :=Work->ARQUIVO
			cDocumento:=Work->DOCUMENTO
			lPendencia:= ( Ascan(aLotePend,{|a| a[1]==cFilWork .And. a[2]==cDocumento }  ) >0)
			lFirst:=.T.
			cMensagem:=""
			lPedidoVenda:=.F.
			
			Begin Transaction
			
			Do While Work->(!Eof()) .And. Work->FILIAL==cFilWork	.And.	Work->DOCUMENTO==cDocumento
				
				If lPendencia
					Work->(DbSkip());Loop
				EndIf
				
				If Work->TIPOREG=="01"
					Work->( GravaZZWRet(DOCUMENTO,SERIE,AllTrim(ARQUIVO),"","SF1"))
					AADD(aProcessado,Work->ARQUIVO)
				ElseIf Work->TIPOREG=="53"
					Work->( GrvStatusZZW(DOCUMENTO,SERIE,BuscaTab(AllTrim(Work->TIPODOC) ),Work->STATUSOPER ))
					AADD(aProcessado,Work->ARQUIVO)
				ElseIf Work->TIPOREG=="03"//Liberar para Faturamento
					If SC5->(MsSeek(xFilial("SC5")+Padr( AllTrim(Work->DOCUMENTO),nLenPV)))
						SC5->(RecLock("SC5",.F.))					
						SC5->C5_VOLUME1:=Work->VOLUME
						SC5->(MsUnLock())
					EndIf
				ElseIf Work->TIPOREG=="04"//Liberar para Faturamento
					lPedidoVenda:=.T.
					cChave:=xFilial("SC9")+Padr( AllTrim(Work->DOCUMENTO),nLenPV)+Work->PRODUTO
					If !SC9->(MsSeek(cChave))
						cMensagem+="Produto/Item "+Work->(PRODUTO+"/"+ITEM)+" nใo encontrado no Pedido "+Padr( AllTrim(Work->DOCUMENTO),nLenPV)+CRLF
					ElseIf SC9->C9_QTDLIB<>Work->QUANTIDADE
						cMensagem+="Produto/Item "+SC9->(C9_PRODUTO+"/"+C9_ITEM)+" com divergencia : "+CRLF+;
						"Liberado no Sistema   "+TransForm(SC9->C9_QTDLIB,"@E 999999.99")+CRLF+;
						"Retorno do WMAS Store "+TransForm(Work->QUANTIDADE,"@E 999999.99")+CRLF
					Else
						SC9->(RecLock("SC9",.F.))
						SC9->C9_BLWMS:="03"  //Flag para libera็ใo do Pedido para Faturamento ==
						SC9->(MsUnLock())
					EndIf
					
				ElseIf Work->TIPOREG=="55"//Batimento Estoque
					
					lJaExiste:=ZZX->(MsSeek(xFilial("ZZX")+Work->PRODUTO+Work->ARMAZEM+Dtos(Work->DATAEST) )  )
					ZZX->(RecLock("ZZX",!lJaExiste))
					ZZX->ZZX_FILIAL:=xFilial("ZZX")
					ZZX->ZZX_PRODUT	:=Work->PRODUTO
					ZZX->ZZX_QUANT		:=Work->QUANTIDADE
					ZZX->ZZX_DATA	   :=Work->DATAEST
					ZZX->ZZX_LOCAL	   :=Work->ARMAZEM
					ZZX->ZZX_UM		   :=Work->UM
					If SB2->(MsSeek(xFilial("ZZX")+ZZX->(ZZX_PRODUT+ZZX_LOCAL) ))
						ZZX->ZZX_SLDSB2:=CalcEst( ZZX->ZZX_PRODUT,ZZX->ZZX_LOCAL,ZZX->ZZX_DATA+1,xfilial("SB2"))
					EndIf	
					ZZX->(MsUnLock())
					
					If !ZZW->(DbSeek(Work->ARQUIVO))
						U_PR109Grv("SB2",xFilial("SB2")+Work->ARQUIVO,"3")
						Work->( GravaZZWRet(Work->ARQUIVO,"",AllTrim(ARQUIVO),"SB2"))
						lFirst:=.F.
						AADD(aProcessado,Work->ARQUIVO)
					EndIf
					
				EndIf
				Work->(DbSkip())
			EndDo
			
			
			If lPedidoVenda
				cMensagem:=""
				RetProcessado(cArqRet,cPathArq+"Retornado\" ,Iif(U_PR109ValPV(cDocumento,@cMensagem,cArqRet,.T.,.T.),"Processado\","Erro\"))
			EndIf
			
			
			
			End Transaction
			
			
			
			
		EndDo
		
	EndDo
	
	ZZW->(DbSetOrder(2))//ZZW_ARQRET  ***** SEEK SEM FILIAL
	For nYnd:=1 To Len(aProcessado)
		RetProcessado(aProcessado[nYnd],cPathArq+"Retornado\","\Processado\")
	Next
	
Next
cFilAnt:=cFilAtu

Work->(E_EraseArq(cNomeWork))
Trb->(E_EraseArq(cNomeTrb))


RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  09/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณA nomenclatura dos arquivos EDI deve ter a seguinte sintaxe:บฑฑ
ฑฑบ          ณprefixo_aaaammddhhmiss_cccc.txt, onde o “prefixo_” defini   บฑฑ
ฑฑบ          ณcada procedimento de integra็ใo,                            บฑฑ
ฑฑบ          ณaaaammddhhmiss_ define o ano, m๊s, dia, hora, minuto e		  บฑฑ
ฑฑบ          ณsegundo de cria็ใo do arquivo										  บฑฑ
ฑฑบ          ณe cccc_ ้ um c๓digo de controle do remetente.					  บฑฑ
ฑฑบ          ณQuando nใo for possํvel distinguir os procedimentos de      บฑฑ
ฑฑบ          ณintegra็๕es, a nomenclatura do arquivo EDI deve ser         บฑฑ
ฑฑบ          ณ“ediStore_aaaammddhhmiss_cccc.txt”.                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR109Name(cTabela)
Local aAreaAtu:=GetArea()
Local aAreaZZW:=ZZW->(GetArea())
Local cNomeArq

ZZW->(DbSetOrder(2))//ZZW_ARQRET  ***** SEEK SEM FILIAL
Do While .T.
	
	cNomeArq:="ediStore_"+Dtos(MsDate())+StrTran(Time(),":","")+".txt"
	
	Do Case

		Case cTabela=="SB1"
			cNomeArq:="ediPrd_"+Dtos(MsDate())+StrTran(Time(),":","")+"tSB1.txt"
		Case cTabela=="SF1"
			cNomeArq:="ediDe_"+Dtos(MsDate())+StrTran(Time(),":","")+"tSF1.txt"
		Case cTabela=="SC5"
			cNomeArq:="ediPs_"+Dtos(MsDate())+StrTran(Time(),":","")+"tSC5.txt"
		Case cTabela=="SF2"
			cNomeArq:="ediNfs_"+Dtos(MsDate())+StrTran(Time(),":","")+"tSF2.txt"			
	EndCase
	
	If ( Ascan(aNomesUsados,cNomeArq ) ) ==0
		AADD(aNomesUsados,cNomeArq )
	Else
		Loop
	EndIf
	
	
	If ZZW->(DbSeek(cNomeArq) )
		Loop
	Endif
	
	Exit
	
EndDo




RestArea(aAreaZZW)
RestArea(aAreaAtu)
Return cNomeArq
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  09/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR109Linha(nHandle,cTabela)
Local cLinha

If cTabela=="SB1"
	cLinha:=U_PR111EnvLayout("A05")//Produto
	PR109Write(@cLinha,nHandle)
	cLinha:=U_PR111EnvLayout("A06")//Tipo Unidade Condicionamento ( Tipo UC)
	PR109Write(@cLinha,nHandle)
	cLinha:=U_PR111EnvLayout("A07")//Produto Relacionado
	PR109Write(@cLinha,nHandle)
ElseIf cTabela=="SF1"
	cLinha:=U_PR111EnvLayout("NFE_A01")//Cabe็alho da Nota de Entrada
	PR109Write(@cLinha,nHandle)
ElseIf cTabela=="SF2"
	cLinha:=U_PR111EnvLayout("NFS")//Cabe็alho da Nota de Saida
	PR109Write(@cLinha,nHandle)
ElseIf cTabela=="SD1"
	cLinha:=U_PR111EnvLayout("NFE_A02")//Itens da Nota de Entrada
	PR109Write(@cLinha,nHandle)
ElseIf cTabela=="SC5"
	cLinha:=U_PR111EnvLayout("PV_A01")//Cabecalho Pedido Venda
	PR109Write(@cLinha,nHandle)
ElseIf cTabela=="SC9"
	cLinha:=U_PR111EnvLayout("PV_A02")//Itens do Pedido Venda
	PR109Write(@cLinha,nHandle)
EndIf


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  09/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR109FError(cErro)
Local aErros:={}
Local nAscan
Local cDescricao:=cErro

AADD(aErros,{"2","Arquivo nใo encontrado."})
AADD(aErros,{"3","Diret๓rio nใo encontrado."})
AADD(aErros,{"4","Muitos arquivos foram abertos. Verifique o   parโmetro FILES."})
AADD(aErros,{"5","Impossํvel acessar o arquivo."})
AADD(aErros,{"6","N๚mero de manipula็ใo de arquivo invแlido."})
AADD(aErros,{"8","Mem๓ria insuficiente."})
AADD(aErros,{"15","Acionador (Drive) de discos invแlido."})
AADD(aErros,{"19","Tentativa de gravar sobre um disco   protegido contra escrita."})
AADD(aErros,{"21","Acionador (Drive) de discos inoperante."})
AADD(aErros,{"23","Erro de dados no disco."})
AADD(aErros,{"29","Erro de grava็ใo no disco."})
AADD(aErros,{"30","Erro de leitura no disco."})
AADD(aErros,{"32","Viola็ใo de compartilhamento."})
AADD(aErros,{"33","Viola็ใo de bloqueio."})

If (nAscan:=Ascan(aErros,{|a|a[1]==cErro}))>0
	cDescricao+="-"+aErros[nAscan,2]
EndIf

Return cDescricao


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  09/28/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR109Conec(cTabela,cNomeArq)
Local aAreaAtu	:=GetArea()
Local cAliasQry:= GetNextAlias()
Local cQuery	:=""
Local cTabZZW 	:=RetSqlName("ZZW")
Local nSemaforo
Local cArqSemaforo:=ProcName(0)+cTabela
Local nSemaforo

Default cTabela:=""
Default cNomeArq:=""

If !U_Semaforo(.T.,@nSemaforo,cArqSemaforo)
	Return
EndIf

ProcRegua(0)
cQuery:=" Select ZZW.R_E_C_N_O_ RECZZW"
cQuery+=" From "+cTabZZW+" ZZW"
cQuery+=" Where ZZW.ZZW_FILIAL='"+xFilial("ZZW")+"'"
If !Empty(cTabela)
	cQuery+=" And ZZW.ZZW_TABELA='"+cTabela+"'"
EndIf

If !Empty(cNomeArq)
	cQuery+=" And ZZW.ZZW_ARQENV='"+cNomeArq+"'"
Else
	cQuery+=" And ZZW.ZZW_ARQENV<>'  '"
Endif

cQuery+=" And ZZW.ZZW_ESTORN=' '"
cQuery+=" And ZZW.ZZW_DATENV =' '
cQuery+=" And ZZW.D_E_L_E_T_=' '"
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAliasQry,.F.,.T.)


Do While !(cAliasQry)->(Eof())
	ZZW->(DbGoTo( (cAliasQry)->RECZZW ))
	
	Begin Transaction
	If PR109Ftp(ZZW->ZZW_ARQENV,ZZW->ZZW_TABELA)
		ZZW->(RecLock("ZZW",.F.))
		ZZW->ZZW_ERRO	:="N"
		ZZW->ZZW_DSERRO:=""
		ZZW->ZZW_DATENV :=MsDate()
		ZZW->ZZW_HORENV :=Time()
		If ZZW->ZZW_TABELA=="SB1"
			ZZW->ZZW_DATRET :=MsDate()
			ZZW->ZZW_HORRET :=Time()
		EndIf
		ZZW->(MsUnLock())
	EndIf
	End Transaction
	(cAliasQry)->(DbSkip())
EndDo
(cAliasQry)->(DbCloseArea())

U_Semaforo(.F.,nSemaforo,cArqSemaforo)






RestArea(aAreaAtu)
Return






/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  09/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR109Ftp(cNomeArq,cTabela)
Local lRetorno		:=.T.
Local aAreaAtu		:=GetArea()
Local aAreaZZW		:=ZZW->(GetArea())
Local cPathArq		:=Alltrim(U_MyNewSX6("ES_NCG0004","\ARQ_WMS_STORE\","C","Diretorio Arquivos WMS Store","","",.F. ))
Local cChaveZZW	:=xFilial("ZZW")+Padr(AllTrim(cNomeArq),Avsx3("ZZW_ARQENV",3) )
Local cDirTab		:=PR109GetDir(cTabela)
Default cNomeArq	:=""

cPathArq+=cDirTab
If !File(cPathArq+cNomeArq)
	PR109GrvErro("Arquivo "+cNomeArq+" nใo encontrado.")
Else
	If ConectFTP("C")
		If FtpDirChange( "/Ncgames/Envio/")
			If FtpUpLoad( cPathArq+cNomeArq, cNomeArq )
				_CopyFile( cPathArq+cNomeArq, cPathArq+"\Enviado\"+cNomeArq)
				Ferase(cPathArq+cNomeArq)
			Else
				PR109GrvErro("Erro ao executar o upload do arquivo.")
				lRetorno		:=.F.
			EndIf
		Else
			PR109EnvMail("Nใo foi possํvel acessar o diretorio /Ncgames/Envio/.")
		EndIf
		
	EndIf
	ConectFTP("D")
EndIf

RestArea(aAreaZZW)
RestArea(aAreaAtu)


Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  09/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR109Write(cLinha,nHandle)
FWrite(nHandle,cLinha,Len(cLinha))
cLinha:=""
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  09/23/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR109GetDir(cTabela)
Local cRetorno:=""
If cTabela=="SB1"
	cRetorno:="Produto\"
EndIf

Return cRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  09/23/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR109GrvErro(cMensErro)

ZZW->(RecLock("ZZW",.F.))
ZZW->ZZW_ERRO	:="S"
ZZW->ZZW_DSERRO:=cMensErro
ZZW->(MsUnLock())


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  10/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR109WMAS(cTabela)

If cTabela=='SF1'
	If MsgYesNo("Deseja enviar nota "+SF1->(F1_DOC+"/"+F1_SERIE)+" para WMAS?")
		SF1->( U_PR109Grv("SF1",F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO,"3"))
		MsgInfo("Enviado com sucesso.")
	EndIf
ElseIf cTabela=='SC5'
	If MsgYesNo("Deseja enviar pedido "+SC5->C5_NUM+" para WMAS?")
		SC5->( U_PR109Grv("SC5",C5_FILIAL+C5_NUM,"3"))
		MsgInfo("Enviado com sucesso.")
	EndIf
ElseIf cTabela=='SF2'
	If MsgYesNo("Deseja enviar nota "+SF2->(F2_DOC+"/"+F2_SERIE)+" para WMAS?")
		SF2->( U_PR109Grv("SF2",F2_FILIAL+F2_DOC+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO,"3"))
		MsgInfo("Enviado com sucesso.")
	EndIf
EndIf
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  10/21/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaSX1(cPerg)
PutSx1(cPerg,"01","Da Tabela            ?","Tabela            ","Tabela  "								,"MV_CH1","N",1,0,0,"C","                                                            ","      ","   "," ","MV_PAR01","Produto        ","Produto        ","Produto        ","                                                            ","N.F. Entrada   ","N.F. Entrada   ","N.F. Entrada   ","Pedido Venda   ","Pedido Venda   ","Pedido Venda   ","N.F. de Saida  ","N.F. de Saida  ","N.F. de Saida  ","Todos          ","Todos          ","Todos     ","","","","")

PutSx1(cPerg,"02","Status  Envio        ?","Status Envio      ","Status  Envio                  ","MV_CH2","N",1,0,0,"C","                                                            ","      ","   "," ","MV_PAR02","Enviado       ","Enviado       ","Enviado       ","                                                            ","Nใo Enviado   ","Nใo Enviado   ","Nใo Enviado   ","Ambos          ","Ambos          ","Ambos          ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"03","Status  Retorno      ?","Status Retorno    ","Status  Retorno                ","MV_CH3","N",1,0,0,"C","                                                            ","      ","   "," ","MV_PAR03","Recebido      ","Recebido      ","Recebido       ","                                                            ","Nใo Recebido   ","Nใo Recebido   ","Nใo Recebido   ","Ambos          ","Ambos          ","Ambos          ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"04","Status  Erro         ?","Status Erro    "   ,"Status  Erro                   ","MV_CH4","N",1,0,0,"C","                                                            ","      ","   "," ","MV_PAR04","Sem Erro      ","Sem Erro      ","Sem Erro       ","                                                            ","Sim","Sim  ","Sim  ","Ambos          ","Ambos          ","Ambos          ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"05","Visualizar Estorno   ?","Visualizar Estorno    ","Visualizar Estorno         ","MV_CH5","N",1,0,0,"C","                                                            ","      ","   "," ","MV_PAR05","Nใo","Nใo","Nใo ","                                                            ","Sim   ","Sim  ","Sim  ","Ambos          ","Ambos          ","Ambos          ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"06","Enviado a mais de (horas)?           ","Enviado a mais de ?           ","Enviado a mais de ?           ","MV_CH6","N",2,0,0,"G","Positivo()                                                  ","      ","   "," ","MV_PAR06","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")



Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/02/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ConectFTP(cParam)
Local lRetorno
Local cUrlFPT		:=Alltrim(U_MyNewSX6("ES_NCG0001","189.3.124.212","C","Url FPT","","",.F. ))
Local cLoginFPT	:=Alltrim(U_MyNewSX6("ES_NCG0002","ftpci10","C","Usuario FTP ","","",.F. ))
Local cSenhaFPT	:=Alltrim(U_MyNewSX6("ES_NCG0003","Ncg2015","C","Senha FTP","","",.F. ))


If cParam=="C"       //Conectar
	If !(lRetorno:=FtpConnect( cUrlFPT , 21 ,cLoginFPT, cSenhaFPT ))
		PR109EnvMail("Nใo foi possํvel conectar ao FTP.")
	EndIf
Else
	FTPDisconnect()
EndIf

Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/02/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function PR109EnvMail(cMensagem)

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/02/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SeparaDados(aDados,cBuffer,cArquivo)
Local aPosAux:={}
Local nInd


If Upper(Left(cArquivo,5))$"EDIDE*EDIDS" .Or. (Upper(Left(cArquivo,9))=="EDISITDOC")
	If Empty(aPos_A01)
		aPos_A01:=aClone( U_PR111RetLayout("A01") )//Documento
	EndIf
	If Empty(aPos_A02)
		aPos_A02:=aClone( U_PR111RetLayout("A02") )//Item Documento
	EndIf
EndIf

If Upper(Left(cArquivo,9))="EDIPOSEST" .And. Empty(aPos_A16)
	aPos_A16:=aClone( U_PR111RetLayout("A16") )//Posi็ใo Estoque
EndIf

If Empty(aPos_A13)
	aPos_A13:=aClone( U_PR111RetLayout("A13") )//Lote Sequ๊ncia (Rela็ใo de Lotes Dependentes)
EndIf

If Empty(aPos_A08)
	aPos_A08:=aClone( U_PR111RetLayout("A08") )//Numero de Serie
EndIf


aDados:={}
If !Empty(cBuffer)
	If Left(cBuffer,2)$"01*03*23*33*35*53"
		aPosAux:=aPos_A01
	ElseIf Left(cBuffer,2)$"02*04"
		aPosAux:=aPos_A02
	ElseIf Left(cBuffer,2)$"08"
		aPosAux:=aPos_A08
	ElseIf Left(cBuffer,2)$"15*16"
		aPosAux:=aPos_A13
	ElseIf Left(cBuffer,2)$"55"
		aPosAux:=aPos_A16
	EndIf
	
EndIf

For nInd:=1 To Len(aPosAux)
	AADD(aDados,SubStr(cBuffer,aPosAux[nInd,3],aPosAux[nInd,4]))
Next


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/02/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GravaZZWRet(cDocumento,cSerie,cArquivo,cTabela,cError)
Local aAreaAtu	:=GetArea()
Local cAliasQry:= GetNextAlias()
Local cQuery
Local cTabZZW 	:=RetSqlName("ZZW")
Default cError:=""

cQuery:=" Select ZZW.R_E_C_N_O_ RECZZW"
cQuery+=" From "+cTabZZW+" ZZW"
cQuery+=" Where ZZW.ZZW_FILIAL='"+xFilial("ZZW")+"'"
cQuery+=" And ZZW.ZZW_TABELA='"+cTabela+"'"
cQuery+=" And ZZW.ZZW_ARQRET='  '"
cQuery+=" And ZZW.ZZW_ESTORN=' '"
cQuery+=" And ZZW.D_E_L_E_T_=' '"
cQuery+=" And ZZW_CHAVE LIKE '"+cFilAnt+cDocumento+cSerie+"%'"
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAliasQry,.F.,.T.)

If !(cAliasQry)->( Eof() .And. Bof() )
	Begin Transaction
	ZZW->(DbGoTo((cAliasQry)->RECZZW))
	ZZW->(RecLock("ZZW",.F.))
	ZZW->ZZW_ARQRET:=cArquivo
	ZZW->ZZW_DATRET :=MsDate()
	ZZW->ZZW_HORRET :=Time()
	ZZW->ZZW_ERRO	 :="N"
	ZZW->ZZW_DSERRO :=""
	ZZW->(MsUnLock())
	
	If !Empty(cError)
		PR109GrvErro(cError)
	EndIf
	End Transaction
EndIf

(cAliasQry)->(DbCloseArea())
RestArea(aAreaAtu)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/02/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RetProcessado(cArquivo,cPathRaiz,cPathDest)
Local lRetorno	:=.T.


ZZW->(DbSetOrder(2))


If ZZW->(MsSeek(cArquivo )  )
	If Empty(cPathDest)
		cPathDest:=IIf( ZZW->ZZW_ERRO=="S","\Erro\","\Processado\")
	EndIf
	
	If __CopyFile(cPathRaiz+cArquivo,cPathRaiz+cPathDest+cArquivo)
		FErase(cPathRaiz+"\"+cArquivo)
	EndIf
	lRetorno	:=.F.
EndIf

Return lRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/02/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR109Transp()
Local cQuery
Local cQryAlias		:= GetNextAlias()
Local clUsrBD		:= ""
Local clQuery		:= ""
Local alCabec		:= {}
Local llAtuStatus	:= .F.
Local  cStatus:='FR'
Local nSizeFil := FWSizeFilial()

clUsrBD	:= SuperGetMV("NCG_000019")

cQuery := " SELECT A.TRS_COD_DEPOSITANTE,A.TRS_NUM_DOCUMENTO,B.DPCS_COD_CHAVE "+CRLF
cQuery += " FROM "+clUsrBD+".TB_FRTINTERF_DOC_SAIDA_TRANSP A , "+clUsrBD+".TB_WMSINTERF_DOC_SAIDA B "+CRLF
cQuery += " WHERE B.DPCS_COD_CHAVE  Like '"+cFilAnt+"%'"+CRLF
cQuery += " AND DPCS_NUM_DOCUMENTO = TRS_NUM_DOCUMENTO"+CRLF
cQuery += " AND A.STATUS = 'FR'"+CRLF

DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cQryAlias  ,.F.,.T.)
Do While (cQryAlias)->(!EOF())
	(cQryAlias)->( U_FTRSSC5(TRS_COD_DEPOSITANTE,AllTrim(TRS_NUM_DOCUMENTO),"",0,'PR',Left(DPCS_COD_CHAVE,nSizeFil) ) )
	(cQryAlias)->(DbSkip())
EndDo


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR109Modal()
Local aAreaAtu:=GetArea()

If Posicione("SA1",1,xFilial("SA1")+SC5->(C5_CLIENT+C5_LOJAENT), "A1_TEMODAL" ) == '1' .And. Empty(SC5->C5_YTRANSP)
	SC5->(RecLock("SC5",.F.))
	SC5->C5_YTRANSP:=SC5->C5_TRANSP
	SC5->(MsUnLock())
EndIf

RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR109LibSC9(cPedido)
Local aAreaAtu:=GetArea()
Local aAreaSC9:=SC9->(GetArrea())
Local cChaveSC9:=xFilial("SC9")+cPedido

SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
SC9->(MsSeek(cChaveSC9))

Do While SC9->( !Eof() ) .And. SC9->(C9_FILIAL+C9_PEDIDO)==cChaveSC9
	If !Empty(SC9->C9_BLWMS) .And. Empty(SC9->C9_BLEST) .And. Empty(SC9->C9_BLCRED)
		SC9->(RecLock("SC9",.F.))
		SC9->C9_BLWMS:=""
		SC9->(MsUnLock())
	EndIf
	SC9->(DbSkip())
EndDo


RestArea(aAreaSC9)
RestArea(aAreaAtu)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR109ValPV(cPedido,cMensagem,cArqRet,lGravaZZW,lGravaZZC)
Local lReturn:=.T.
Local aAreaAtu	:=GetArea()
Local aAreaSC9	:=SC9->(GetArea())
Local cFilSC9	:=xFilial("SC9")


Default cMensagem	:=""
Default cArqRet	:=""
Default lGravaZZW:=.F.
Default lGravaZZC:=.F.

cPedido:=AllTrim(cPedido)
SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO


If !SC9->(MsSeek(cFilSC9+cPedido))
	cMensagem+="Pedido de Venda "+cPedido+" Filial "+cFilSC9+" nใo encontrado"+CRLF
	lReturn:=.F.
EndIf

Do While SC9->( !Eof() ) .And. SC9->(C9_FILIAL+C9_PEDIDO)==cFilSC9+cPedido
	
	If SC9->C9_BLWMS=="02" .And. Empty(SC9->C9_BLEST) .And. Empty(SC9->C9_BLCRED)
		cMensagem+="Produto/Item "+SC9->(C9_PRODUTO+"/"+C9_ITEM)+" com divergencia."+CRLF
		//"Liberado no Sistema   "+TransForm(SC9->C9_QTDLIB,"@E 999999.99")+CRLF+;
		//"Retorno do WMAS Store "+TransForm(0,"@E 999999.99")+CRLF
		lReturn:=.F.
	EndIf
	SC9->(DbSkip())
EndDo

If lGravaZZW
	
	GravaZZWRet(cPedido,"",cArqRet,"SC5",cMensagem)
	
	If !Empty(cMensagem)
		PR109Send(cMensagem,cPedido,cFilSC9)
	EndIf
	
EndIf

If lReturn .And. lGravaZZC
	PR109ZZC(cPedido)//Grava IMEI
EndIf


RestArea(aAreaSC9)
RestArea(aAreaAtu)

Return lReturn


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/12/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR109Send(cMensagem,cPedido,cFilPV)
Local lRetorno 		:= .T.
Local cServer   	:= GetNewPar("MV_RELSERV","")
Local cAccount		:= GetNewPar("MV_RELACNT","")
Local cPassword	:= GetNewPar("MV_RELAPSW","")
Local lMailAuth 	:= GetNewPar("MV_RELAUTH",.F.)
Local cEmailTo	 	:=U_MyNewSX6(	"NCG_000109", "cleverson.silva@acpd.com.br","C", "Usuแrios responsaveis Integra็ใo Store","","",.F. )

Local cEmailCc 	:= ""
Local aAnexos		:= {}
Local cAssunto	:= "Problemas no retorno separa็ใo Pedido Venda "+cPedido+" Filial "+cFilPV
Local cErro		:= ""

If !Empty(cEmailTo) .And. !Empty(cAssunto) .And. !Empty(cMensagem)
	
	If MailSmtpOn( cServer, cAccount, cPassword )
		If lMailAuth
			If ! ( lRetorno := MailAuth(cAccount,cPassword) )
				lRetorno := MailAuth(SubStr(cAccount,1,At("@",cAccount)-1),cPassword)
			EndIf
		Endif
		If lRetorno
			If !MailSend(cAccount,{cEmailTo},{cEmailCc},{},cAssunto,cMensagem,aAnexos,.F.)
				cErro := "Erro na tentativa de e-mail para " + cEmailTo + ". " + Mailgeterr()
				lRetorno := .F.
			EndIf
		Else
			cErro := "Erro na tentativa de autentica็ใo da conta " + cAccount + ". "
			lRetorno := .F.
		EndIf
		MailSmtpOff()
	Else
		cErro := "Erro na tentativa de conexใo com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
		lRetorno := .F.
	EndIf
Else
	
	If Empty(cEmailTo)
		cErro := "ษ neessแrio fornecer o destinแtario para o e-mail. "
		lRetorno := .F.
		
	EndIf
	
	If Empty(cAssunto)
		
		cErro := "ษ neessแrio fornecer o assunto para o e-mail. "
		lRetorno := .F.
		
	EndIf
	
	If Empty(cMensagem)
		
		cErro := "ษ neessแrio fornecer o corpo do e-mail. "
		lRetorno := .F.
		
	EndIf
	
Endif

Return(lRetorno)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/13/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR109ZZC(cPedido)
Local aAreaAtu:=GetArea()
Local aAreaZZC:=ZZC->(GetArea())
Local aAreaSC5:=SC5->(GetArea())
Local aAreaSB1:=SB1->(GetArea())
Local cNumeroSerie
Local cItem:=StrZero(0,Len(ZZC->ZZC_ITEM))
Local nTotal:=0
Local nInd
Local nYnd

Local aProdutos:={}
Local aImeis:={}

//B1_YSERIE == 1=Nao Necessario#2=Numero de Serie#3=IMEI1#4=IMEI1 e IMEI2

ZZC->(DbSetOrder(1))
ZZC->(MsSeek(xFilial("ZZC")+cPedido ) )
Do While ZZC->(!Eof() ) .And. ZZC->(ZZC_FILIAL+ZZC_PEDIDO)==xFilial("ZZC")+cPedido
	ZZC->(RecLock("ZZC",.F.))
	ZZC->(DbDelete())
	ZZC->(MsUnLock())
	ZZC->(DbSkip())
EndDo

SC5->(DbSetOrder(1))
SC5->(MsSeek(xFilial("SC5")+cPedido ) )


Trb->(DbSeek(xFilial("SC5")+cPedido))


Do While Trb->(!Eof()) .And. Trb->(FILIAL+AllTrim(DOCUMENTO))==xFilial("SC5")+cPedido
	
	If !SB1->(MsSeek(xFilial("SB1")+AllTrim(Trb->PRODUTO))) .Or. SB1->B1_YSERIE=="1"//1=Nao Necessario
		Trb->(DbSkip());Loop
	EndIf
	
	cNumeroSerie:=AllTrim(Trb->NUMEROSERI)
	
	If (nAscan:=Ascan(aProdutos,{ |a| a[1]==SB1->B1_CODBAR}))==0
		AADD(aProdutos,{SB1->B1_CODBAR,{} })
	Else
		aImeis:=aProdutos[nAscan,2]
		nTotal:=Iif(SB1->B1_YSERIE$"2*3",1,2)//2=Numero de Serie#3=IMEI1#4=IMEI1 e IMEI2
		If Len(aImeis)=nTotal
			AADD(aProdutos,{SB1->B1_CODBAR,{} })
			aImeis:=aProdutos[Len(aProdutos),2]
		EndIf
		AADD(aImeis,cNumeroSerie)
	EndIf
	
	Trb->(DbSkip())
	
	
EndDo


For nInd:=1 To Len(aProdutos)
	ZZC->(RecLock("ZZC",.T.))
	ZZC->ZZC_FILIAL	:= xFilial("ZZC")
	ZZC->ZZC_CODBAR	:=aProdutos[nInd,1]
	ZZC->ZZC_PEDIDO	:= SC5->C5_NUM
	ZZC->ZZC_CLIENT	:= SC5->C5_CLIENTE
	ZZC->ZZC_LOJA	   := SC5->C5_LOJACLI
	ZZC->ZZC_NOMCLI	:= SC5->C5_NOMCLI
	ZZC->ZZC_ITEM  	:=Soma1(cItem)
	aImeis:=aProdutos[nInd,2]
	For nYnd:=1 To Len(aImeis)
		If nYnd==1
			ZZC->ZZC_IMEI_1	:=aImeis[nYnd]
		Else
			ZZC->ZZC_IMEI_2	:=aImeis[nYnd]
		EndIf
	Next
	ZZC->(MsUnLock())
Next

RestArea(aAreaZZC)
RestArea(aAreaSC5)
RestArea(aAreaSB1)
RestArea(aAreaAtu)


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/25/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function BuscaTab(cTipoDoc)
Local cTabela:="XXXX"


If cTipoDoc=="NFE"
	cTabela:="SF1"
ElseIf cTipoDoc=="PV" .Or. cTipoDoc=="PED"
	cTabela:="SC5"
EndIf
Return cTabela



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  11/25/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvStatusZZW(cDocumento,cSerie,cTabela,cStatus)
Local aAreaAtu	:=GetArea()
Local cAliasQry:= GetNextAlias()
Local cQuery
Local cTabZZW 	:=RetSqlName("ZZW")

cQuery:=" Select ZZW.R_E_C_N_O_ RECZZW"
cQuery+=" From "+cTabZZW+" ZZW"
cQuery+=" Where ZZW.ZZW_FILIAL='"+xFilial("ZZW")+"'"
cQuery+=" And ZZW.ZZW_TABELA='"+cTabela+"'"
cQuery+=" And ZZW.ZZW_ARQRET='  '"
cQuery+=" And ZZW.ZZW_ESTORN=' '"
cQuery+=" And ZZW.D_E_L_E_T_=' '"
cQuery+=" And ZZW_CHAVE LIKE '"+cFilAnt+cDocumento+cSerie+"%'"
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAliasQry,.F.,.T.)

If !(cAliasQry)->( Eof() .And. Bof() )
	Begin Transaction
	ZZW->(DbGoTo((cAliasQry)->RECZZW))
	ZZW->ZZW_STATUS :=cStatus
	ZZW->(MsUnLock())
	End Transaction
EndIf

(cAliasQry)->(DbCloseArea())
RestArea(aAreaAtu)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  12/02/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/            
User Function PR109Estor(cAlias,nReg,nOpc)
Local oObjBrow := GetObjBrow() //Obt้m o ultimo Objeto Browse

If (AxAltera(cAlias,nReg,nOpc,/*aAcho*/,/*aCpos*/,/*nColMens*/,/*cMensagem*/,/*"U_PR109VALID()"*/,/*cTransact*/,/*cFunc*/,/*aButtons*/,/*aParam*/,/*aAuto*/,/*lVirtual*/,/*lMaximized*/,/*cTela*/,/*lPanelFin*/,/*oFather*/,/*aDim*/,/*uArea*/,/*lFlat*/))==1

	If MsgNoYes("Confirma estorno "+PR09DESTAB(ZZW->ZZW_TABELA)[1]+Space(1)+AllTrim(ZZW->ZZW_CHAVE)+"?" ) 	
		ZZW->(RecLock("ZZW",.F.))
		ZZW->ZZW_ESTORN:="S"
		ZZW->ZZW_ERRO:=AllTrim(ZZW->ZZW_ERRO)+CRLF+"Estornado por:"+AllTrim(cUserName)+" เs "+Time()+" em "+DTOC(MsDate())
		ZZW->(MsUnLock())
		oObjBrow:ResetLen()		
		oObjBrow:Refresh()		
	EndIf	
EndIf	


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR109  บAutor  ณMicrosiga           บ Data ณ  12/02/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR109Canc(cTabela,cChave)
Local aAreaAtu	:=GetArea()
Local cAliasQry:= GetNextAlias()
Local lPodeCanc
Local cQuery

cQuery:=" Select Count(1) Contar"
cQuery+=" From "+RetSqlName("ZZW")+" ZZW"
cQuery+=" Where ZZW.ZZW_FILIAL='"+xFilial("ZZW")+"'"
cQuery+=" And ZZW.ZZW_TABELA='"+cTabela+"'"
cQuery+=" And ZZW.ZZW_ESTORN=' '"
cQuery+=" And ZZW.D_E_L_E_T_=' '"
cQuery+=" And ZZW_CHAVE LIKE '"+cChave+"%'"
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAliasQry,.F.,.T.)

lPodeCanc:=((cAliasQry)->Contar==0)

(cAliasQry)->(DbCloseArea())
RestArea(aAreaAtu)

Return lPodeCanc