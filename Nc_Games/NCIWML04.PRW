#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

#DEFINE STS_PROCOK   	"2"
#DEFINE STS_PROCER   	"E"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//| Defines utilizados para trata a matriz de parcelas    |
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

#DEFINE __DATA		1        //Data de vencimento da parcela
#DEFINE __VALOR		2        //Valor da parcela
#DEFINE __FORMA		3        //Forma de recebimento
#DEFINE __ADMINIS	4        //Codigo ou nome da Administradora
#DEFINE __NUMCART	5        //Numero do cartao ou cheque
#DEFINE __AGENCIA	6        //Agencia do cheque
#DEFINE __CONTA		7        //Numero da conta do cheque
#DEFINE __RG		8        //RG do portador do cheque
#DEFINE __TELEFON	9        //Telefone do portador do cheque
#DEFINE __TERCEIR	10       //Indica se o cheque eh de terceiros
#DEFINE __MOEDA  	11       //Moeda da parcela
#DEFINE __PARCTEF  12       //Tipo de parcelamento quando venda TEF(Client SiTEF DLL)
#DEFINE __ACRSFIN 	13		 //Valor separado do acrescimo para cada parcela de financiamento
#DEFINE __EMITENT 	14		 //Emitente quando o cheque for de terceiros
#DEFINE __FORMAID 	15		 //ID do Cartao de Credito ou Debito
#DEFINE __NSUTEF	16		 //NSU da trasacao TEF
#DEFINE __DOCTEF   	17		 //Num. Documento TEF
#DEFINE __FORMATEF	"CC;CD" //Formas de pagamento que utilizam opera็ใo TEF para valida็ใo
#DEFINE TEF_NAO_USADO				"1"		//Nao Utiliza TEF
#DEFINE TEF_SEMCLIENT_DEDICADO  	"2"     //Utiliza TEF Dedicado Troca de Arquivos
#DEFINE TEF_COMCLIENT_DEDICADO  	"3"		//Utiliza TEF Dedicado com o Client
#DEFINE TEF_DISCADO             	"4"		//Utiliza TEF Discado
#DEFINE TEF_LOTE                	"5"		//Utiliza TEF em Lote
#DEFINE TEF_CLISITEF				"6"		//Utiliza a DLL CLISITEF
#DEFINE TEF_CENTROPAG				"7"		//Utiliza a DLL CENTRO DE PAGOS
#DEFINE CTRL Chr(10)+Chr(13)              	//Pula linha

/*
Tipos do LogManager
*/
#define LMOK 1
#define LMINFO 2
#define LMALERT 3
#define LMSTOP 4
#define LMCONFIG 5

/*
Niveis do LogManager
*/
#DEFINE LMTECH 1
#DEFINE LMPROC 2

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณEste Log e um recurso a ser habilitado pelo departamento de desenvolvimento para averigua-ณ
//ณcao de possiveis problemas de transacoes TEF.                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
#DEFINE LOG_TEF LjLogTef()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//| Defines utilizados para tratar o Array de Totais      |
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
#DEFINE __VALMERC 1
#DEFINE __DESCONT 2
#DEFINE __VALACRS 3
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//| Defines utilizados para EventViewer |
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
#DEFINE IDEVENT "050"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefines utilizados para distiguir geracao de guia de despacho ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
#DEFINE GDP_NO			"0" 	//Nao sera gerada guia de despacho.Quando a venda nใo tem item reservado com entrega do tipo 3 - Release 11.5 -  Chile - F2CHI
#DEFINE GDP_PARCIAL    	"1"		//Sera gerada guia de despacho parcial.Quando a venda possui pelo menos um item reservado com entrega do tipo 3 - Release 11.5 -  Chile - F2CHI
#DEFINE GDP_TOTAL		"2"		//Sera gerada guia de despacho total.Quando todos os itens da venda estao reservados e com entrega do tipo 3 - Release 11.5 -  Chile - F2CHI


Static cClientDir           					// Pasta de instalacao do Remote
Static lRemoteType 	:= GetRemoteType() <> -1		// Verifica a origem (Front ou Venda Assistida)
Static lArqLog				                    // Verifica se o arquivo de log ja' foi criado
Static lLogHabilitado							// Verifica se o log esta' habilitado
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVariaveis utilizada no SELF-LIQUIDATEณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Static aPremio			:= {}  				   	// Array com os premios resgatados pelo cliente
Static oIntVenda  	:= Nil                        // Responsavel por integrar venda
Static lR5			:= GetRpoRelease() >= "R5"		//Indica se o release e 11.5
Static lLogManager  := FindFunction("LoggerOut")
Static aTESVenda 	:= { "", {} }

//Vale Presente
Static cTipoPrdVP 	:= ""				//Armazena se o tipo de produto que estah sendo vendido na venda eh "Vale Presente" ("S") ou NAO ("N"). Pois "Vale Presente" nao pode ser vendido junto com outros produtos.
Static lVPNewRegra 	:= Nil				//Variavel para identificar se utiliza ou nao as novas modificacoes da implementacao de Vale Presente, para imprimir o comprovante nao fiscal na venda de vale presente

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVariaveis referente a implementacao de Cartao Presente (Gift Card).ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Static lCPAtivo		:= .F.				// Verifica a configuracao de "Cartao Presente (Gift Card)" esta ativo.
Static aProdsCP   	:= {}				// Array com a relacao de produtos considerados "Cartao Presente (Gift Card)"
Static lTrnCPEfet	:= .F.				// Indica se na venda foi efetuada alguma recarga de "Cartao Presente (Gift Card)"
Static aRegTefCP	:= {} 				// Array com as movimentacoes do TEF da recarga de "Cartao Presente (Gift Card)"
Static cTipoPrdCP 	:= ""				// Armazena se o tipo de produto que estah sendo vendido na venda eh "recarga de Cartao Presente (Gift Card)" ("S") ou NAO ("N"). Pois "recarga de Cartao Presente" nao pode ser vendido junto com outros produtos.
Static lGiftCard 	:= Nil				// Variavel para verificar se estah tudo OK para utilizar a implementacao de Cartao Presente (Gift Card)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML04  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML04JOB(aDados)

Local nQtdTent	:= 5
Local nQtdNProc	:= 0 //Quantidade deregistros nใo processados

Default aDados := {"03","02"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
U_NCIWML04()


//Verifica se existe registros a serem processados
nQtdNProc := GetQRegNPr()
If nQtdNProc > 0
   	While nQtdTent > 0
	
		U_NCIWML04()
		
		//Verifica se existe registros a serem processados
		nQtdNProc := GetQRegNPr()
		If nQtdNProc <= 0
			Exit		
		EndIf   
		
		--nQtdTent
	EndDo
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetQRegNPr   บAutor  ณMicrosiga        บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a quantidade de registros a serem processados      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetQRegNPr()

Local aArea 	:= GetArea()
Local nQtdReg   := 0
Local cTbPZQ	:= "%PZQ010 " + "PZQ%"
Local cQryAlias	:= GetNextAlias()


BeginSQL Alias cQryAlias
	
	SELECT COUNT(*) CONTADOR
	FROM  %exp:cTbPZQ%
	WHERE PZQ_FILIAL = %xfilial:PZQ%
	AND PZQ.PZQ_DOCPRT=' '
	AND PZQ.PZQ_OPER IN ('VE','TRV')
	AND PZQ.PZQ_NUMORC <> ' '
	AND PZQ.%notDel%
	
EndSQL

If (cQryAlias)->(!Eof())
	nQtdReg := (cQryAlias)->CONTADOR
Else
	nQtdReg := 0
EndIf

(cQryAlias)->(DbCloseArea())
RestArea(aArea)
Return nQtdReg



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML04  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCIWML04()
Processa({|| ExecBlock("WML04GERAR") }, " Explode Vendas  ", "Interface de Dados")
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML04  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML04Gerar()
Local aAreaAtu		:= GetArea()
Local cQryAlias		:= GetNextAlias()
Local aDados		:= {}
Local cModo			:= ""
Local cTbPZQ		:= "%PZQ010 " + "PZQ%"
Local cEmpPZQ
Local cFilPZQ
Local nInd
Local nYnd
Local aConexoes
Local aDadosAux
Local nContar
Local lWait
BeginSQL Alias cQryAlias
	
	SELECT PZQ.R_E_C_N_O_ RecPZQ,PZQ.PZQ_EMPDES,PZQ.PZQ_FILDES,PZQ_EMISSA,PZQ_CODMOV
	FROM  %exp:cTbPZQ%
	WHERE PZQ_FILIAL = %xfilial:PZQ%
	AND PZQ.PZQ_DOCPRT=' '
	AND PZQ.PZQ_OPER IN ('VE','TRV','CA')
	AND PZQ.PZQ_NUMORC <> ' '
	AND PZQ.%notDel%
	//AND PZQ_CODMOV IN ('1381541','1357288','1357295')
	ORDER BY PZQ_EMPDES,PZQ_FILDES,PZQ_EMISSA,PZQ_CODMOV
	
EndSQL

ProcRegua(2)

Conout("")
Conout(AllTrim(GetLastQuery()[2]))
Conout("")

Do While (cQryAlias)->(!Eof())
	
	cEmpPZQ:=(cQryAlias)->PZQ_EMPDES
	cFilPZQ:=(cQryAlias)->PZQ_FILDES
	
	AADD(aDados,{ {cEmpPZQ,cFilPZQ},{} } )
	aDadosAux:=aDados[Len(aDados),2]
	
	Do While (cQryAlias)->(!Eof()) .And. (cQryAlias)->PZQ_EMPDES==cEmpPZQ .And. (cQryAlias)->PZQ_FILDES==cFilPZQ
		AADD(aDadosAux,(cQryAlias)->RecPZQ)
		(cQryAlias)->(DbSkip())
	EndDo
	
EndDo


(cQryAlias)->(DbCloseArea())

For nInd:=1 To Len(aDados)
	aDadosAux:=aDados[nInd]
	//aConexoes:=GetUserInfoArray()
	//nContar:=0
	//AEVAL( aConexoes, {|a| IIf( (a[6]==GetEnvServer() .And. AllTrim(Upper(a[5]))=="U_WML04GRAVAR" ),nContar++, )   }  )
	U_WML04Gravar(aDadosAux)
Next

AcertNF(MsDate(),MsDate())


RestArea(aAreaAtu)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML04Gravar(aDados, lMultiT )
Local aAreaAtu:=GetArea()
Local cModo
Local cAliasPZQ
Local cAliasPZR
Local cChavePZR
Local aRecnos			:=	aDados[2]
Local cChave
Local cPDV
Local cChaveDOC
Local cChaveSFT
Local aProdutos:={}
Local lMovSaida
Local aParam:={}
Local nTam     := 0
Local cProduto
Local cCliPadrao	:= Getmv("MV_CLIPAD",,"000001")
Local cLojaPadrao	:= GetMv("MV_LOJAPAD",,"01")
Local cCodVend		:= GetMv("MV_VENDPAD",,"000001")
Local cNfSerie		:= GetMv("MV_LOJANF",,"")
Local cMsgErro		:= ""
Local lGravacao		:= .F.
Local cEspec
Local cSerie
Local dDtMenor:=""
Local dDtMaior:=""
Local nYnd
Local nXnd
Local nLenD2Item
Local nLenD1Item
Local nLenB1Cod
Local cCodWMMov
Local cCodWMLoja
Local cTESVenda
Local aNfeOrig
Local lTransf
Local dDataAtu
Local cAtuModulo:=cModulo
Local nAtuModulo:=nModulo

Default lMultiT := .T.

// ----------------------------------------------
// Se for processamento em MultitThread - Prep.Env.
If lMultiT
	RpcClearEnv()
	RpcSettype(3)
	RpcSetEnv(aDados[1,1],aDados[1,2])
EndIf

//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_WML04JOB", "Grava็ใo das Notas Fiscais de saํda das Opera็๕es VE,TRV", "FISCAL", MsDate() )


dDataAtu		:=dDataBase

cAliasPZQ	:=GetNextAlias()
cAliasPZR	:=GetNextAlias()

EmpOpenFile(cAliasPZQ,"PZQ",1,.T.,"01",@cModo)
EmpOpenFile(cAliasPZR,"PZR",2,.T.,"01",@cModo)

dbSelectArea("SL1")
SL1->( DbSetOrder(1) )	// L1_FILIAL + L1_NUMORC

For nYnd:=1 To Len(aRecnos)
	
	(cAliasPZQ)->(DbGoTo(aRecnos[nYnd]))
	cChavePZR:=(cAliasPZQ)->(PZQ_FILIAL+PZQ_OPER+PZQ_CODMOV) //PZR_FILIAL+PZR_OPER+PZR_CODMOV+PZR_SEQ
	If !(cAliasPZR)->(MsSeek(cChavePZR))
		Loop
	EndIf
	cCodWMMov	:=(cAliasPZQ)->PZQ_CODMOV
	cCodWMLoja	:=(cAliasPZQ)->PZQ_CODLOJ
	
	cPDV:=(cAliasPZR)->PZR_TERMIN
	cEspCupom:=(cAliasPZR)->PZR_CUPMOD
	
	PtInternal(1,"Empresa: "+cEmpAnt+" Filial: "+cFilAnt+" - "+(cAliasPZR)->PZR_DOC+" Emissao: "+DTOC((cAliasPZQ)->PZQ_EMISSA)+" Operacao:"+(cAliasPZQ)->PZQ_OPER+" Movimento:"+(cAliasPZQ)->PZQ_CODMOV  )
	
	// -----------------------------------------------
	// Posiciona no orcamento gerado
	// -----------------------------------------------
	
	IF !SL1->( DbSeek( (cAliasPZQ)->(PZQ_FILORC + PZQ_NUMORC) ) )
		U_WML03ERRO(cAliasPZQ, "Filial Orcamento / Orcamento["+(cAliasPZQ)->(PZQ_FILORC +"/"+ PZQ_NUMORC)+ "] nao encontrado no SL1 Chave"+SL1->(INDEXKEY()),"E" )
		RecLock(cAliasPZQ,.F.)
		(cAliasPZQ)->PZQ_NUMORC :="" // REPROCESSAR
		(cAliasPZQ)->(MsUnLock())		
		Loop
	EndIf
	cModulo := "LOJ"
	nModulo	:= 12
	
	If Empty(SL1->L1_CLIENTE)
		cCliForn 	:= ""
		cLojaCliFor	:= ""
		U_WML02CliFor(@cCliForn,@cLojaCliFor,cAliasPZR,cAliasPZQ,.T.,.F.,.F. )//PZR deve estar posicionado
		RecLock("SL1",.F.)
		SL1->L1_CLIENTE:=cCliForn
		SL1->L1_LOJA	:=cLojaCliFor
		SL1->(MsUnLock())
	EndIf
	
	If !ValidaCupom(cAliasPZQ)
		Loop
	EndIf
	
	M->LQ_CLIENTE 	:= SL1->L1_CLIENTE
	M->LQ_LOJA		:= SL1->L1_LOJA
	
	// Transforma o orcamento em cupom fiscal
	RecLock("SL1",.F.)
	SL1->L1_SITUA	:= "RX"
	SL1->L1_SERIE 	:= cNfSerie
	SL1->L1_DOC		:= (cAliasPZQ)->PZQ_DOC
	SL1->(MsUnLock())
	
	// ------------------------------------------------------------------
	// Grava Batch - Copia da funcao padrao por nao existir execauto
	dDataBase:=(cAliasPZQ)->PZQ_EMISSA
	SetFunName("LOJA701")
	lGravacao:=.F.
	U_NCGrvBatch( cEmpAnt , cFilAnt , /*cIntervalo*/ , /*cMinReproc*/ , SL1->L1_NUM , @lGravacao )
	
	If !lGravacao
		U_WML03ERRO(cAliasPZQ, ("Erro no Grava Batch. Verifique o console log ref. ao or็amento: " + AllTrim(SL1->L1_NUMORC)) ,"E" )
	Else
		Begin Transaction
		RecLock(cAliasPZQ,.F.)
		(cAliasPZQ)->PZQ_STATUS := STS_PROCOK
		(cAliasPZQ)->PZQ_DOCPRT:=SF2->F2_DOC
		(cAliasPZQ)->PZQ_SERPRT:=SF2->F2_SERIE
		(cAliasPZQ)->(MsUnLock())
		End Transaction
		
		U_WML03ERRO(cAliasPZQ, "" ,"2" )
		// -----------------------------------------------
		// Funcao para reprocessamento do Cupom Fiscal
		FReprocCF(cAliasPZR,cAliasPZQ, cChavePZR, SF2->F2_FILIAL, SF2->F2_DOC, SF2->F2_SERIE , SF2->F2_CLIENTE , SF2->F2_LOJA,cEspCupom )
	EndIf
	
Next nYnd

dDataBase:=dDataAtu
cModulo	:=cAtuModulo
nModulo	:=nAtuModulo

(cAliasPZQ)->(dbCloseArea())
(cAliasPZR)->(dbCloseArea())


//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_WML04JOB", "Grava็ใo das Notas Fiscais de saํda das Opera็๕es VE,TRV", "FISCAL", MsDate(), "F" )


RestArea(aAreaAtu)
MsUnLockAll()

Return

/*/{Protheus.doc} FReprocCF
(long_description)
@author jeferson.acpd
@since 07/06/2015
@version 1.0
@return ${return}, ${return_description}
@example
(examples)
@see (links_or_references)
/*/
Static Function FReprocCF(cAliasPZR,cAliasPZQ, cChavePZR, cF2Filial ,cNFiscalF2, cSerie, cCodCli, cLojaCli,cEspCupom )
Local aAreaAtu			:=GetArea()
Local aParam			:={}
Local aSF2Area			:= SF2->(GetArea())
Local aSD2Area			:= SD2->(GetArea())
Local cChave			:= ""
Local aMap				:= {}
Local nCont 			:= 0
Local nInfo 			:= 0

Default cAliasPZR 		:= ""
Default cF2Filial 		:= ""
Default cNFiscalF2 		:= ""
Default cSerie 			:= ""
Default cCodCli			:= ""
Default cLojaCli		:= ""
Default cChavePZR		:= ""

Begin Transaction
SF2->(RecLock("SF2",.F.))
SF2->F2_YCODMOV :=(cAliasPZQ)->PZQ_CODMOV
SF2->F2_YLOJAWM :=(cAliasPZQ)->PZQ_CODLOJ
SF2->F2_YTOPER	 :=(cAliasPZQ)->PZQ_OPER
SF2->(MsUnLock())
End Transaction

cChave := (cF2Filial+cNFiscalF2+cSerie+cCodCli+cLojaCli)

// --------------------------------------------------------
// MAPA DOS CAMPOS PZR X SD2
//  ------ ICMS
aAdd( aMap , {"D2_PICM"		,"PZR_ALICMS" } )
aAdd( aMap , {"D2_VALICM"	,"PZR_VLICMS" } )

// ------ IPI
//aAdd( aMap , {"D2_IPI"		,"PZR_" } )
//aAdd( aMap , {"D2_VALIPI"	,"PZR_" } )
// ------ PIS
aAdd( aMap , {"D2_ALQIMP6"	,"PZR_ALPIS" } )
aAdd( aMap , {"D2_VALIMP6"	,"PZR_VLPIS" } )

// ------ COFINS
aAdd( aMap , {"D2_ALQIMP5"	,"PZR_ALCOFI" } )
aAdd( aMap , {"D2_VALIMP5"	,"PZR_VLCOFI" } )

SD2->(dbSetOrder(3)) // D2_FILIAL  + D2_DOC + D2_SERIE + D2_CLIENTE + D2_LOJA + D2_COD + D2_ITEM
SD2->(MsSeek( cChave ))

Do While SD2->(!EOF()) .And. SD2->(D2_FILIAL + D2_DOC + D2_SERIE + D2_CLIENTE + D2_LOJA)==cChave
	
	RecLock( "SD2", .F. )
	SD2->D2_YCODMOV	:=(cAliasPZQ)->PZQ_CODMOV
	SD2->D2_YLOJAWM	:=(cAliasPZQ)->PZQ_CODLOJ
	SD2->D2_YTOPER		:=(cAliasPZQ)->PZQ_OPER
	
	SD2->D2_PDV    :=SL1->L1_PDV
	SD2->D2_NUMSERI:=SL1->L1_SERPDV
	SD2->D2_ESPECIE:=cEspCupom
	
	
	
	If GetPZR((cAliasPZR)->PZR_FILIAL,cAliasPZR,(cAliasPZQ)->PZQ_CODMOV,(cAliasPZQ)->PZQ_CODLOJ,SD2->D2_COD	)
		For nCont:=1 To Len(aMap)
			nInfo := (cAliasPZR)->(FieldGet( FieldPos(aMap[nCont,2]) ))
			If nInfo>=0
				SD2->( FieldPut( FieldPos(aMap[nCont,1]) , nInfo ) )
			EndIf
		Next nCont
	EndIf
	
	
	SD2->(MsUnLock())
	SD2->(DbSkip())
EndDo

ML04ACERT(cNFiscalF2,cSerie,cCodCli,cLojaCli)

/*AADD(aParam,DTOC(dDataBase))	//Data Inicial ?
AADD(aParam,DTOC(dDataBase))	//Data Final ?
AADD(aParam,2)				//Livro de ?  1=Entrada 2=Saida 3=Ambos
AADD(aParam,cNFiscalF2)		//Da Nota Fiscal ?
AADD(aParam,cNFiscalF2)		//Ate a Nota Fiscal ?
AADD(aParam,cSerie)			//Serie de ?
AADD(aParam,cSerie)			//Serie Ate ?
AADD(aParam,"      ")		//Do Cliente/Forn. ?
AADD(aParam,"ZZZZZZ")		//Ate o Cliente/Forn. ?
AADD(aParam,"  ")			//Da Loja ?
AADD(aParam,"ZZ")			//Ate a Loja ?
MATA930(.T.,aParam) 		//Reprocessamento Livros Fiscais
*/

//cChave:=xFilial("SFT")+"S"+cSerie+cNFiscalF2+cCodCli+cLojaCli
//SFT->(DbSetOrder(1)) //FT_FILIAL, FT_TIPOMOV, FT_SERIE, FT_NFISCAL, FT_CLIEFOR, FT_LOJA, FT_ITEM, FT_PRODUTO
//SFT->(MsSeek(cChave))
//Do While SFT->(!Eof())  .And. SFT->(FT_FILIAL+SFT->FT_TIPOMOV+SFT->FT_SERIE+SFT->FT_NFISCAL+SFT->FT_CLIEFOR+SFT->FT_LOJA)==cChave
//	RecLock("SFT",.F.)
//	SFT->FT_PDV :=SL1->L1_SERPDV
//	SFT->(MSUnLock())
//	SFT->(DBSkip())
//EndDo





RestArea(aSD2Area)
RestArea(aSF2Area)
RestArea(aAreaAtu)

Return NIL
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณLjGrvBatchณ Autor ณ Vendas Clientes       ณ Data ณ 22/09/00 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณGrava em processo batch o com base no SL1, SL2, SL4.        ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณFront Loja / Siga Loja                                   	  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGrvBatch( cEmp, cFilTrab , cIntervalo, cMinReproc, cNumOrc, lGravacao )

Local nHandle						   			   				// Indica se o arquivo foi criado
Local aFiles		:= {}						   				// Arquivos
Local nIntervalo 	:= 0			   			   				// Intervalo para o Loop
Local nTimes	 	:= 0			   							// Numero de loop antes de entrar no while
Local lRetValue  	:= .T.             			   				// Retorno da fun็ใo
Local aFiliais   	:= {}              			   				// Filiais
Local aBadRecno  	:= {}			   			   				// Recnos
Local cFileName		:= ""			   			   				// Nome do arquivo
Local nCount 		:= 1						   				// Contador
Local cTemp			:= ""			   			   				// Temporario
Local lTemReserva	:= .F.						   				// Verifica se existe algum item com reserva
Local lProcessou	:= .F.			   			   				// Verifica se processou as vendas na Retaguarda.
Local bOldError  								   				// Bloco de tratamento de erro
Local lLJ7051		:= FindFunction("U_LJ7051")	   				// Verifica se a funcao LJ7051 esta compilada
Local lExProc 		:= .T.			   			   				// Controla o while do Killapp
Local lMultFil 		:= .F.			   			   				// Verifica se e' passado mais de uma filial no parametro
Local lCriouAmb		:= .F.			   			   				// Verifica se o PREPARE ENVIRONMENT foi executado
Local nSleep		:= 0			   			   				// Utilizado para atribuicao na variavel nIntervalo
Local aAreaSL1		:= {}			   			   				// Guarda a Area do SL1
Local nRecSL1		:= 0			   			   				// Guarda o Recno do SL1
Local lGerInt 		:= .F.             			   				// Verifica se a integracao esta habilitada
Local aRecFail		:= {}			   			   				// Registros que nao conseguiram ser travados
Local oLJCLocker 	:= Nil
Local lLj7064       := ExistBlock("LJ7064") 	   				// Verifica se existe o ponto de entrada LJ7064
Local nOpcProc		:= 0			   			   				// Opcao de processamento
Local lLstPresAt	:= .F.              		   				// SuperGetMV("MV_LJLSPRE",.F.,.F.) .AND. IIf(FindFunction("LjUpd78Ok"),LjUpd78Ok(),.F.)	//Lista de presente ativa?
Local lMvLjGrvBt	:= .F. 						   				// Parametro que define se utilizara o indice "14" para priorizar a integracao dos orcamentos com reserva.
Local lFTVD7051	:= FindFunction("U_FTVD7051")  				// Verifica se a funcao LJ7051 esta compilada
Local lFtvdVer12	:= FindFunction("LjFTvd") .AND. LjFTVD() 	// Verifica se ้ Release 11.7 e o FunName ้ FATA701 - Compatibiliza็ใo Venda Direta x Venda Assisitida
Local cNomeProg	:= Iif(lFtvdVer12,"FATA701","LOJA701") 		// Nome da Rotina
Local lLj843GrvMv  := .F.
Local lTPLOtica 	:= .F.
Local lLj7AtuInte := .F.
Local lMvLjOffLn 	:= .F.
Local lUsaInd14 	:= .F. 										// Indica se usa o indice 14 da tabela SL1 para priorizar os orcamentos com pedido.
Local lGrvEstorn	:= .F. 										// Indica se a tabela MBZ e funcao de gravacao de estorno existem na base
Local lLOJA0051	:= .F.
Local cMvLJILJLO 	:= ""
Local cCliPad		:= ""										// Cliente Padrao
Local cLojaPad		:= ""										// Loja Padrao
Local nMinReproc	:= 0										// Utilizado para atribuicao na variavel cMinReproc
Local nMinFalha	:= 0										// Tempo da ultima falha de processamento
Local lReproc		:= .T.										// Sinaliza se deve marcar como registro ja reprocessado, somente quando utiliza cMinReproc
Local xRet140Exc	:= Nil										// Retorno da Rotina de cancelamento automatico NFC-e
Local lLj7082		:= ExistBlock("LJ7082")						// Indica se o PE LJ7082 esta compilado
Local lRetLj7082	:= .F.										// Retorno do PE LJ7082
Local aRecnoNFCe	:= {}										// vetor com R_E_C_N_O_ dos orcamentos com NFC-e que deverao ser cancelados
Local nI				:= 0

Default cIntervalo  	:= 30000								// Conteudo do terceiro parametro (Parm3 do mp8srv.ini)
Default cMinReproc		:= 1000									// Conteudo do quarto parametro, para tentar processar novamente o registro quando ocorre falha por Lock(SA1)
Default cNumOrc			:= ""

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variavel Private para que caso seja execultada a funcao      ณ
//ณ via JOB, atribua o valor padrao a nMoedaCor.				 ณ
//ณ Rotina Utilizada para o Padrao, Lista de Presentes e Localizaณ
//ณ cao Chile/Colombia.                                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Private nMoedaCor 	:= 1

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณTratamento caso o terceiro parametro seja passado ou nao.ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If ValType(cIntervalo) <> "N"
	nSleep := Val(cIntervalo)
Else
	nSleep := cIntervalo
Endif
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณTratamento caso o quarto parametro seja passado ou nao.  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If ValType(cMinReproc) <> "N"
	nMinReproc := Val(cMinReproc)
Else
	nMinReproc := cMinReproc
Endif

While nCount <= Len( cFilTrab )
	
	cTemp := ""
	While SubStr( cFilTrab, nCount, 1 ) <> "," .AND. nCount <= Len( cFilTrab )
		cTemp += SubStr( cFilTrab, nCount, 1 )
		nCount++
	End
	AADD( aFiliais, { cTemp } )
	nCount++
	
End

nCount := 1

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica o numero de filiais que esta sendo passadoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If Len(aFiliais) > 1
	lMultFil := .T.
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFaz a inicializacao de algumas variaveis para verificar qual o Release utilizado e/ou a Existencia de Functions no RPO.  ณ
//ณFaz esta inicializacao aqui para executar apenas uma vez, ao inves de executar varias vezes no Loop da SL1.              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
lLj843GrvMv := FindFunction("Lj843GrvMv")	//Verifica se a funcao existed
lLj7AtuInte := FindFunction("Lj7AtuInte")	//Verifica se a funcao existe
lGrvEstorn  := FindFunction("Lj601GrPDV") 	//Checa se a funcao de gravacao de estorno existe
lLOJA0051 	:= FindFunction("LOJA0051")		//Verifica se a funcao existe
lR5 		:= GetRpoRelease() >= "R5"
lCriouAmb 	:= .T.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFaz a inicializacao de variaveis de PARAMETROS que serao utilizadas no Loop da SL1.                        ณ
//ณFaz esta inicializacao aqui para executar apenas uma vez, ao inves de executar varias vezes no Loop da SL1.ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cCliPad		:= SuperGetMV("MV_CLIPAD")				// Cliente Padrao
cLojaPad	:= SuperGetMV("MV_LOJAPAD")				// Loja Padrao
lGerInt 	:= SuperGetMv("MV_LJGRINT",.F.,.F.) 	// Verifica se a integracao esta habilitada
lLstPresAt	:= SuperGetMV("MV_LJLSPRE",.F.,.F.) .AND. IIf(FindFunction("LjUpd78Ok"),LjUpd78Ok(),.F.)
lMvLjGrvBt 	:= SuperGetMv("MV_LJGRVBT",.F.,.F.) 	// Se o parametro for .F. nao utiliza o indice "14" da SL1
lUsaInd14 	:= lMvLjGrvBt .AND. AllTrim(SL1->(IndexKey(14))) = "L1_FILIAL+L1_SITUA+L1_STATUS" //Indica se usa o indice 14 da tabela SL1 para priorizar os orcamentos com pedido.
lTPLOtica 	:= HasTemplate("OTC") 					// Verifica se eh Template Otica
lMvLjOffLn  := SuperGetMv("MV_LJOFFLN", Nil, .F.) 	// Identifica se o ambiente esta operando em offline
lGrvEstorn  := lGrvEstorn .And. AliasInDic("MBZ") 	// Checa se a tabela MBZ e fun็ใo de gravacao de estorno existem na base
cMvLJILJLO  := SuperGetMV( "MV_LJILJLO",,"2" )    	// Se utilizarแ sistema de travas nos Jobs FRTA020, LOJA1115 e LJGrvBatch. (0=Nใo, 1=Sim)

cFileName := cEmp + aFiliais[ nCount ][1]

If (!lMultFil .AND. lCriouAmb) .OR. ( nHandle := MSFCreate("LJGR"+cFileName+".WRK") ) >= 0
	
	ConOut("LJGrvBatch: "+"Empresa:" + cEmp + " Filial:" + aFiliais[ nCount ][1])  // "Empresa:" ### " Filial:"
	ConOut("            "+"Iniciando processo de gravacao batch...")  //"Iniciando processo de gravacao batch..."
	
	If lLOJA0051 .And. cMvLJILJLO == "1"
		oLJCLocker := LJCGlobalLocker():New()
		If !oLJCLocker:GetLock( "LOJXFUNCILLock" )
			Return
		EndIf
	EndIf
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณTodos os arquivos devem ser abertos antes de entrar no Begin Transaction.    ณ
	//ณCaso exista customizacao, os arquivos devem ser abertos neste PE.            ณ
	//ณOBS: O ADSSERVER nao permite uso da ChkFile() dentro de um Begin Transaction.ณ
	//ณEm outros ambientes, este problema nao ocorre.                               ณ
	//ณRetornar um array, por exemplo {"SZ1", "SZ2"}                                ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If !lFtvdVer12
		If ExistBlock("LJGRVOPEN")
			aFiles := ExecBlock("LJGRVOPEN", .F., .F.)
			RPCOpenTables(aFiles)
		EndIf
	ElseIf lFtvdVer12
		If ExistBlock("FTVDGRVOPEN")
			aFiles := ExecBlock("FTVDGRVOPEN", .F., .F.)
			RPCOpenTables(aFiles)
		EndIf
	EndIf
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณProcessar a transferencia de caixa automatica, se necessario. ณ
	//ณEsse processamento deve chamar independente se existe SL1 paraณ
	//|explorir ou nao, no entanto foi incluido fora do Loop da SL1. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If GetNewPar("MV_LJTRANS",.F.)
		If FindFunction("LjVerTrans")
			LjVerTrans()
		EndIf
	EndIf
	
	SL1->( DbSetOrder(1) )
	IF SL1->( DbSeek( xFilial("SL1") + cNumOrc ) ) .And. SL1->L1_SITUA == "RX"
		
		Do While SL1->( L1_FILIAL+L1_NUM == xFilial("SL1")+cNumOrc )
			
			If ( nPos := Ascan( aBadRecno, SL1->( Recno() ) ) ) > 0
				Do While SL1->( L1_FILIAL+L1_NUM == xFilial("SL1")+cNumOrc )  .AND. ( Ascan( aBadRecno, SL1->( Recno() ) ) > 0 )
					SL1->( DbSkip() )
				EndDo
			EndIf
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Executa o PE, que verifica se a venda sera processada ou nao pelo LjGrvBatch.ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If lLj7082
				lRetLj7082 := ExecBlock("LJ7082",.F.,.F.)
				If !lRetLj7082
					SL1->( DbSkip() )
					Loop
				EndIf
			EndIf
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Verifica se o cliente esta alocado para outro usuario , caso esteja coloca  ณ
			//ณ esse registro na fila novamente,apos cinco tentativas grava o mesmo como ER ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			dbSelectArea("SA1")
			SA1->(DbSetOrder(1))
			
			If SA1->(MsSeek(xFilial("SA1")+SL1->L1_CLIENTE+SL1->L1_LOJA))
				
				If cCliPad+cLojaPad <> SA1->A1_COD+SA1->A1_LOJA
					
					If SA1->(Rlock())
						SA1->(MsUnlock())
					Else
						nPos := aScan( aRecFail,{|x| x[1] ==  SL1->(Recno()) })
						If nPos == 0
							aAdd(aRecFail,{ SL1->(Recno()) , 1, TIME() } )
						Else
							Conout(Chr(13) + Chr(10)+"LJGrvBatch: " + TIME() + " " + "Filial " + aFiliais[ nCount ][1] + "."+"Registro alocado,Cliente:"+; // "Filial " #"Registro alocado,Cliente:"
							SL1->L1_CLIENTE + " Loja:" + SL1->L1_LOJA ) // " Loja:"#"
							
							If aRecFail[nPos][2] > 5
								LjGravaErr()
								ConOut( Chr(13) + Chr(10)+"LJGrvBatch: " + TIME() + " " + "Filial " + aFiliais[ nCount ][1] + "."+"Registro alocado,Cliente:"+;		// "Filial " #"Registro alocado,Cliente:"
								SL1->L1_CLIENTE+ " Loja:" +SL1->L1_LOJA + " a venda sera gravada como 'ER'.") // #" Loja:"# " a venda sera gravada como 'ER'."
							Else
								//Verifica se ultima validacao eh inferior ao tempo de reprocessamento
								If nMinReproc > 0
									nMinFalha 	:= Val(SubStr( ELAPTIME( aRecFail[nPos][3], TIME() ),4,2))
									lReproc 	:= IIF(nMinFalha < nMinReproc,.F.,.T.)
								Else
									lReproc := .T.
								EndIf
								
								If lReproc
									aRecFail[nPos][2]++
									aRecFail[nPos][3] := TIME() //Atualiza Ult verificacao
									Conout(Chr(13) + Chr(10)+"LJGrvBatch: " + TIME() + "Filial " + aFiliais[ nCount ][1] + "."+"Registro alocado,Cliente:"+; // "Filial " #"Registro alocado,Cliente:"
									SL1->L1_CLIENTE + " Loja:" + SL1->L1_LOJA + " tentara depois processar novamente.") // " Loja:"#" tentara depois processar novamente."
								EndIf
							EndIf
						EndIf
						
						SL1->(DbSkip())
						
					EndIf
					
				EndIf
				
			EndIf
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Protejo situa็ใo de todos os orcamentos "RX" estarem em aBadRecno, neste    ณ
			//ณ caso nใo devo processar o proximo (que eh eof), mas sim abandonar o Loop    ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If SL1->(Eof()) .OR. SL1->L1_SITUA <> 'RX'
				Return
			EndIf
			
			nOpcProc := 0
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณTratamento de lista de presentes  ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If lLstPresAt .And. lLj843GrvMv
				nOpcProc := Lj843GrvMv(SL1->L1_NUM)
				//Caso a rotina tenha identificado que existem itens de entrega, alterar a variavel identificadora de reserva
				If nOpcProc == 1
					lTemReserva := .T.
				Endif
			Endif
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณVerifica se os itens foram gravados corretamenteณ
			//ณNใo grava como reserva, quando Template Otica   ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If nOpcProc == 0
				lTemReserva := .F.
				SL2->( DbSetOrder( 1 ) )
				If SL2->( DbSeek( xFilial( "SL2" ) + SL1->L1_NUM ) ) .AND. !lTPLOtica
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณ Verifica se existe item com Reserva na venda ณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					While SL2->L2_FILIAL + SL2->L2_NUM == xFilial( "SL2" ) + SL1->L1_NUM
						If !Empty(SL2->L2_RESERVA) .AND. SL2->L2_ENTREGA <> "2"	//RETIRA
							lTemReserva := .T.
							nOpcProc := 1	//LJ7PEDIDO
							Exit
						Endif
						SL2->(DbSkip())
					EndDo
				Endif
			Endif
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณQuando or็amento(filho) possui outro or็amento com reserva,     ณ
			//ณLimpa L1_Status para salvar como venda e nใo gerar nova reserva.ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If lTemReserva .AND. !Empty(SL1->L1_ORCRES)
				lTemReserva := .F.
				If nOpcProc == 1
					nOpcProc := 2
				Endif
				RecLock("SL1", .F.)
				REPLACE SL1->L1_STATUS WITH ""
				MsUnlock()
			EndIf
			
			cEstacao  := SL1->L1_ESTACAO
			aAreaSL1  := SL1->(GetArea())
			nRecSL1	  := SL1->(Recno())
			
			//Caso nao seja processamento de pedido (entrega) e lista de presentes do tipo credito, processar o LjGrvTudo
			If nOpcProc == 0
				nOpcProc := 2
			Endif
			ConOut("LJGrvBatch: nOpcProc = " + cValToChar(nOpcProc))
			Do Case
				//ฺฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณLJ7PEDIDO  ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤู
				Case nOpcProc == 1
					Begin Transaction
					bOldError := ErrorBlock( {|x| LjVerPedErro(x,lProcessou,aFiliais[nCount][1],nRecSL1) } ) // muda code-block de erro
					Begin Sequence
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณ Transforma o orcamento para pedido   ณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					lProcessou := LJ7Pedido(	{} , 2, NIL, .F.,;
					{} , .T. )
					
					If !lProcessou
						UserException("LJGrvBatch: "+ "Filial "+ aFiliais[nCount][1] + ". "+"Problemas na gera็ใo do Pedido" )// "Filial " ### ". " "Problemas na gera็ใo do Pedido"
					EndIf
					End Sequence
					ErrorBlock( bOldError )
					End Transaction
					
					//ฺฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณLJGRVTUDO  ณ
					//ภฤฤฤฤฤฤฤฤฤฤฤู
				Case nOpcProc == 2
					lProcessou := LjGrvTudo( /*_lScreen*/ .F.,/*lFinanceiro*/ .F.,/*nNccUsada*/,/*aNccItens*/	,;
                    /*nNccGerada*/,/*aImpCheque*/,/*nMoedaCor*/,/*aRecSE1*/,;
                    /*aVlrAcres*/,/*aSL1*/		  ,/*aSL2*/		,/*cDoc*/		,;
                    /*lVendaCup*/,/*nNumItens*/  ,/*nFrete*/		,/*nSeguro*/	,;
                    /*nDespesa*/,/*cLQFrete*/	  ,/*aAcrFin*/	,/*lPedFin */.T.	,;
                    /*cCgcCli*/,/*cNomeCli*/	  ,/*lNfManual*/	,/*lExistNF*/    ,;
                    /*cDescErro*/,/*cEspecNf*/	  ,/*cDocFo*/		,/*aBreakNota*/ ,;
                    /*aNewNCC*/,/*cTpGeraGdp*/ ,/*nOpc*/)
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณLJGRVFIN - LISTA DE PRESENTES EXCLUSIVA DE CREDITO  ณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				Case nOpcProc == 3
					//Como o SL1 esta posicionado, basta chamar a funcao de gravacao
					lProcessou := LjGrvFin(.F./*Interface*/,.T./*Gera fin.*/,/*nNccUsada*/,/*aNccItens*/,/*nNccGerada*/,/*aVendedor*/,/*aReceb*/,/*aRecSE1*/,	/*nValPIS*/,/*nValCSLL*/,/*Valor COFIN*/,/*nBaseDup*/,/*aImpCheque*/,/*nMoedaCor*/,/*lOriFun*/,.T.,Nil,/*Lista presente de credito*/)
					
					If lProcessou
						//Alterar o L1_SITUA para OK
						RecLock("SL1",.F.)
						SL1->L1_SITUA := "OK"
						SL1->(MsUnlock())
					Endif
			EndCase
			
			RestArea(aAreaSL1)
			
			// Variaval de controle do processo
			lGravacao	:= lProcessou
			
			If lProcessou
				
				If lMvLjOffLn .AND. lLj7AtuInte
					Lj7AtuInte(Nil, SL1->L1_NUM, SL1->L1_FILIAL, .T.)
				Endif
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณSe ambiente for do tipo SIGAPAF e orcamento          ณ
				//ณveio do SC5, entao atualiza campos do pedido de vendaณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				If SL2->(FieldPos("L2_PEDSC5")) > 0 .And. SL2->(FieldPos("L2_ITESC6")) > 0 .And. SL2->(FieldPos("L2_SEQUEN")) > 0
					Mt461PedUp(SL1->L1_NUM)
				Endif
				
				Lj7PesqAltMot( SL1->L1_SERIE, SL1->L1_DOC , SL1->L1_NUM ) //( cSerie , cDoc , cNumOrc ) - Pesquisa se existe algum motivo de desconto cadastrado para a venda
				
				If lGerInt .And. !lTemReserva
					LjProIntVe()
				EndIf
				FRTProcSZ()
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณPonto de entrada.ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				If lLJ7051
					bOldError := ErrorBlock( {|x| LjVerifErro(x) } ) // muda code-block de erro
					Begin Sequence
					U_LJ7051()
					Recover
					Conout("Nao conformidades na execucao do ponto de entrada LJ7051")//"Nao conformidades na execucao do ponto de entrada LJ7051"
					End Sequence
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณ Restaura rotina de erro anteriorณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					ErrorBlock( bOldError )
				Endif
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณ Inclusao de chamada - Especifico Template  ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				
				If ExistTemplate("LJ7002")
					ExecTemplate( "LJ7002", .F., .F., { 2, Nil, 2 } )
				EndIf
				
				If ExistBlock("LJ7002")
					ExecBlock( "LJ7002", .F., .F., { 2, Nil, 2 } )
				EndIf
				
				
				If File("LJGR"+cFileName+".FIM")
					
					ConOut("            "+"Solicitacao para finalizar gravacao batch atendida...") 	//"Solicitacao para finalizar gravacao batch atendida..."
					
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณSomente apaga o arquivo quando existirณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					
					FErase("LJGR"+cFileName+".FIM")
					lExProc := .F.
				EndIf
				nTimes := 0
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณSomente apaga o arquivo de orcamentos quando existirณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				LjxCDelArq( SL1->L1_NUM )
				
				nIntervalo := 0
				nTimes++
				
			Else
				
				LjGravaErr()
				ConOut("LJGrvBatch: "+ "Filial " + aFiliais[ nCount ][1] + ". "+"Ocorreu algum erro no processo de gravacao batch...") // "Filial " ### ". " "Ocorreu algum erro no processo de gravacao batch..."
				AADD(aBadRecno, SL1->(Recno()) )
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณPonto de entrada que permite verificar o erro gerado no processo de gravacao batch ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				If lLj7064
					ExecBlock("LJ7064", .F., .F., {SL1->(Recno())})
				EndIf
				
			EndIf
			
			SL1->( DbSkip() )
			
		EndDo
		
	Endif
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤaฟ
	//ณCheca se a tabela MBZ e fun็ใo de gravacao de estorno existem na base                   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤaู
	If lGrvEstorn
		Lj601GrPDV()
	EndIf
	
	// ------------------------------------------
	// NOTA FISCAL CONSUMIDOR ELETRONICA (NFC-E)
	// -----------------------------------------------------------------------------------------------------------------
	// Se houve um erro na venda (rejeicao ou TSS offline), ela esta marcada para ser cancelada (L1_SITUA = 'RY')
	// Executamos o LOJA140, para que seja feita a transmissao do cancelamento para o TSS e o cancelamento perante o ERP
	//-------------------------------------------------------------------------------------------------------------------
	aRecnoNFCe	:= {}	//zeramos o array que recebera os R_E_C_N_O_
	aAreaSL1	:= SL1->( GetArea() )
	
	SL1->( DbSetOrder(9) )	//L1_FILIAL + L1_SITUA + L1_PDV + L1_DOC
	If SL1->( DbSeek(xFilial("SL1") + "RY") )
		Do While SL1->L1_FILIAL + SL1->L1_SITUA == xFilial("SL1") + "RY"
			Aadd( aRecnoNFCe, SL1->(Recno()) )
			SL1->( DbSkip() )
		EndDo
	EndIf
	
	For nI := 1 to Len(aRecnoNFCe)
		//atraves do R_E_C_N_O_ posicionamos no orcamento a ser cancelado
		SL1->( DbGoTo(aRecnoNFCe[nI]) )
		//"LJGrvBatch: Envia cancelamento NFC-e para TSS. Filial:" ## " - Orcamento:" ## " - Doc.: " ## " - Serie:"
		Conout("LJGrvBatch: Envia cancelamento NFC-e para TSS. Filial:" +SL1->L1_FILIAL+ " - Orcamento:" + AllTrim(SL1->L1_NUM) + " - Doc.: " + SL1->L1_DOC + " - Serie:" + SL1->L1_SERIE )
		
		xRet140Exc := lj140Exc( "SL1", SL1->(Recno()), 2,Nil,.T.,SL1->L1_FILIAL,SL1->L1_NUM)
		
		If ValType(xRet140Exc) == "N" .AND. xRet140Exc == 1
			Conout("LJGrvBatch: Envia cancelamento NFC-e para TSS - Processado com sucesso.")							//
		Else
			Conout("LJGrvBatch: Envia cancelamento NFC-e para TSS - Nใo Processado!",xRet140Exc)				//"LJGrvBatch: Envia cancelamento NFC-e para TSS - Nใo Processado!"
		EndIf
	Next
	
	RestArea(aAreaSL1)
	
	nIntervalo := 0
	nTimes++
	aBadRecno  := {}
	
	Iif( lLOJA0051 .And. cMvLJILJLO == "1", oLJCLocker:ReleaseLock( "LOJXFUNCILLock" ),NIL)
	
	If lMultFil
		If lCriouAmb .AND. FindFunction("LJ1415LP")
			LJ1415LP(.T.)
		EndIF
		RESET ENVIRONMENT
	Endif
	
	If lMultFil
		FClose(nHandle)
		FErase("LJGR"+cFileName+".WRK")
		
		ConOut("            "+"Empresa:" + cEmp + " Filial:" + aFiliais[ nCount ][1]+" - "+"Processo de gravacao batch finalizado...") //""Empresa:" ### " Filial: - Processo de gravacao batch finalizado..."
	Endif
	
Else
	ConOut(Repl("*",40)+Chr(10)+Chr(10))
	ConOut("LJGrvBatch: "+"Empresa:" + cEmp + " Filial:" + aFiliais[ nCount ][1])  // "Empresa:" ### " Filial:"
	ConOut("            "+"Processo de gravacao batch ja estava rodando")  //"Processo de gravacao batch ja estava rodando"
	
	lRetValue := .F.
	Return
EndIf

If nCount < LEN( aFiliais )
	nCount := nCount + 1
Else
	nCount := 1
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณExecu็ใo da rotina de limpeza para loja Off-lineณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If lCriouAmb .AND. FindFunction("LJ1415LP") .AND. !lMultFil
	LJ1415LP(.T.)
Endif

FClose(nHandle)
FErase("LJGR"+cFileName+".WRK")

Return ( lRetValue )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML04  บAutor  ณMicrosiga           บ Data ณ  06/16/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetPZR(cFilPZR,cAliasPZR,cCodMov,cCodLoja,cProduto)
Local cTbPZR		:= "%PZR010 " + "PZR%"
Local aAreaAtu		:=GetArea()
Local lFound 		:=.F.

BeginSQL Alias "GETPZR"
	SELECT PZR.R_E_C_N_O_ RecnoPZR
	FROM  %exp:cTbPZR%
	WHERE PZR_FILIAL = %Exp:cFilPZR%
	AND PZR.PZR_CODMOV=%Exp:cCodMov%
	AND PZR.PZR_CODLOJ=%Exp:cCodLoja%
	AND PZR.PZR_PRODUT=%Exp:cProduto%
	AND PZR.%notDel%
EndSQL

If GETPZR->RecnoPZR>0
	lFound:=.T.
	(cAliasPZR)->(DbGoTo(GETPZR->RecnoPZR))
EndIf

GETPZR->(DbCloseArea())
RestArea(aAreaAtu)


Return lFound


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML04  บAutor  ณMicrosiga           บ Data ณ  10/13/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ML04ACERT(cDoc,cSerie,cCliente,cLoja)
Local cQryAlias

cQryAlias:=GetNextAlias()

//Acertando o PDV

cUpdate:=" UPDATE "+RetSqlName("SD2")+" SD2 SET D2_PDV=(SELECT DISTINCT L1_PDV FROM "+RetSqlName("SL1")+" SL1 WHERE L1_FILIAL=D2_FILIAL AND L1_DOC=D2_DOC AND L1_SERIE=D2_SERIE AND L1_CLIENTE=D2_CLIENTE AND L1_EMISNF=D2_EMISSAO AND SL1.D_E_L_E_T_=' ')"
cUpdate+=" WHERE D2_FILIAL='"+xFilial("SD2")+"'"
cUpdate+=" AND D2_DOC='"+cDoc+"'"
cUpdate+=" AND D2_SERIE='"+cSerie+"'"
cUpdate+=" AND D2_CLIENTE='"+cCliente+"'"
cUpdate+=" AND D2_LOJA='"+cLoja+"'"
//cUpdate+=" AND D2_EMISSAO BETWEEN '"+Dtos(dDataIni)+"' And '"+Dtos(dDataFim)+"'"
cUpdate+=" AND SD2.D2_ESPECIE='2D'
cUpdate+=" AND D_E_L_E_T_=' '"

TcSqlExec(cUpdate)

BeginSQL Alias cQryAlias
	
	SELECT *
	From (
	SELECT SD2.R_E_C_N_O_ RECSD2,D2_DOC,D2_SERIE,SD2.D2_CF,D2_FILIAL FILIAL,(SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET+SD2.D2_SEGURO+SD2.D2_DESPESA+SD2.D2_VALFRE) Nota_Val_Cont,SD2.D2_BASEICM,
	SD2.D2_PICM,SD2.D2_VALICM,Round((SD2.D2_BASEICM*SD2.D2_PICM)/100,2) Valor
	FROM  %Table:SD2% SD2
	WHERE SD2.D2_FILIAL=%xFilial:SD2%
	And SD2.D2_DOC =%Exp:cDoc%
	And SD2.D2_SERIE =%Exp:cSerie%
	And SD2.D2_CLIENTE=%Exp:cCliente%
	And SD2.D2_LOJA=%Exp:cLoja%
	AND SD2.D2_ESPECIE='2D'
	AND SD2.D_E_L_E_T_=' '
	) Tab1
	Where Valor<>Tab1.D2_VALICM
	
EndSql

PtInternal(1,"Empresa"+cEmpAnt+" Acerta D2_VALICM")

Do While (cQryAlias)->(!Eof())
	SD2->(DbGoTo((cQryAlias)->RECSD2))
	nVlrICM:=Round((SD2->D2_BASEICM*SD2->D2_PICM)/100,2)
	If SD2->D2_VALICM<>nVlrICM
		RecLock("SD2",.F.)
		SD2->D2_VALICM=nVlrICM
		SD2->(MsUnLock())
	EndIf
	(cQryAlias)->(DbSkip())
EndDo


(cQryAlias)->(DbCloseArea())

PtInternal(1,"Empresa"+cEmpAnt+" Acerta F2_VALICM")

BeginSQL Alias cQryAlias
	
	SELECT SF2.R_E_C_N_O_ RECSF2, F2_DOC,F2_SERIE,F2_CLIENTE,F2_LOJA,F2_EMISSAO,SF2.F2_VALICM,SD2.D2_VALICM
	From %Table:SF2% SF2,
	(SELECT D2_FILIAL,D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,D2_EMISSAO,SUM(D2_VALICM) D2_VALICM
	FROM  %Table:SD2% SD2
	WHERE SD2.D2_FILIAL=%xFilial:SD2%
	And SD2.D2_DOC =%Exp:cDoc%
	And SD2.D2_SERIE =%Exp:cSerie%
	And SD2.D2_CLIENTE=%Exp:cCliente%
	And SD2.D2_LOJA=%Exp:cLoja%
	AND SD2.D2_ESPECIE='2D'
	AND SD2.D_E_L_E_T_=' '
	GROUP BY D2_FILIAL,D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,D2_EMISSAO) SD2
	
	WHERE SF2.F2_FILIAL=SD2.D2_FILIAL
	And SF2.F2_DOC=SD2.D2_DOC
	And SF2.F2_SERIE=SD2.D2_SERIE
	And SF2.F2_CLIENTE=SD2.D2_CLIENTE
	And SF2.F2_LOJA=SD2.D2_LOJA
	And SF2.F2_VALICM<>D2_VALICM
	Order By 1
EndSql

Do While (cQryAlias)->(!Eof())
	
	SF2->(DbGoTo((cQryAlias)->RECSF2))
	If SF2->F2_VALICM<>(cQryAlias)->D2_VALICM
		RecLock("SF2",.F.)
		SF2->F2_VALICM:=(cQryAlias)->D2_VALICM
		SF2->(MsUnLock())
	EndIf
	(cQryAlias)->(DbSkip())
EndDo

(cQryAlias)->(DbCloseArea())

BeginSQL Alias cQryAlias
	     
	SELECT SFT.R_E_C_N_O_ RECSFT,D2_PDV
	From %Table:SFT% SFT,%Table:SD2% SD2
	Where SD2.D2_FILIAL=%xFilial:SD2%
	And SD2.D2_DOC =%Exp:cDoc%
	And SD2.D2_SERIE =%Exp:cSerie%
	And SD2.D2_CLIENTE=%Exp:cCliente%
	And SD2.D2_LOJA=%Exp:cLoja%
	AND SD2.D2_ESPECIE='2D'
	AND SD2.D_E_L_E_T_=' '
	
	And SFT.FT_FILIAL=SD2.D2_FILIAL
	And SFT.FT_NFISCAL=SD2.D2_DOC
	And SFT.FT_SERIE=SD2.D2_SERIE
	And SFT.FT_CLIEFOR=SD2.D2_CLIENTE
	And SFT.FT_LOJA=SD2.D2_LOJA
	And SFT.FT_ITEM=SD2.D2_ITEM
	And SFT.FT_PRODUTO=SD2.D2_COD
    And SFT.FT_PDV<>SD2.D2_PDV
EndSql

Do While (cQryAlias)->(!Eof())	
	SFT->(DbGoTo((cQryAlias)->RECSFT))
	RecLock("SFT",.F.)
	SFT->FT_PDV:=(cQryAlias)->D2_PDV
	SFT->(MsUnLock())
	(cQryAlias)->(DbSkip())
EndDo

(cQryAlias)->(DbCloseArea())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML04  บAutor  ณMicrosiga           บ Data ณ  11/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ValidaCupom(cAliasPZQ)
Local aAreaAtu:=GetArea()
Local aAreaSF2:=SF2->(GetArea())
Local aAreaSF4:=SF4->(GetArea())
Local aAreaSL1:=SL1->(GetArea())
Local aAreaSL2:=SL2->(GetArea())
Local aAreaSB1:=SB1->(GetArea())
Local aAreaSA1:=SA1->(GetArea())
Local lRetorno:=.T.
Local cMensagem:=""

SF2->( DbSetOrder( 1 ) )
If SF2->( DbSeek( xFilial( "SF2" ) + SL1->L1_DOC + SL1->L1_SERIE ) )
	cMensagem+=" "+SL1->L1_DOC +"/"+ SL1->L1_SERIE+CRLF
	
	Begin Transaction	
	RecLock(cAliasPZQ,.F.)
	(cAliasPZQ)->PZQ_STATUS := STS_PROCOK
	(cAliasPZQ)->PZQ_DOCPRT:=SF2->F2_DOC
	(cAliasPZQ)->PZQ_SERPRT:=SF2->F2_SERIE
	(cAliasPZQ)->(MsUnLock())
	End Transaction
	
	
	cMensagem+="DOC e SERIE ja existente no SF2: "+CRLF
	lRetorno:=.F.
EndIf
SA1->(DbSetOrder(1))
If !SA1->( MsSeek( xFilial( "SA1" ) + SL1->L1_ClIENTE + SL1->L1_LOJA ) )
	cMensagem+="Cliente/Loja nใo encontrado: "+SL1->L1_ClIENTE +"/"+ SL1->L1_LOJA+CRLF
	lRetorno:=.F.
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica se os itens foram gravados corretamenteณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
SL2->( DbSetOrder( 1 ) )
If ! SL2->( DbSeek( xFilial( "SL2" ) + SL1->L1_NUM ) )
	cMensagem+="Itens nใo encontrados no or็amento: "+CRLF
	lRetorno:=.F.
Else
	While !SL2->( Eof() ) .AND. SL2->L2_FILIAL + SL2->L2_NUM == xFilial( "SL2" ) + SL1->L1_NUM
		
		If ! SF4->(MsSeek(xFilial("SF4") + SL2->L2_TES))
			cMensagem+="Tipo de Entrada/Saํda nใo encontrado: "+CRLF
			lRetorno:=.F.
		EndIf
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณPosiciona no B1 Correspondenteณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		If ! SB1->(MsSeek( xFilial("SB1") + SL2->L2_PRODUTO ))
			cMensagem+="C๓digo de produto "+SL2->L2_PRODUTO+" nใo encontrado: "+CRLF
			lRetorno:=.F.
		EndIf
		
		SL2->(DbSkip())
	EndDo
	
EndIf

If !lRetorno
	U_WML03ERRO(cAliasPZQ,cMensagem,"E")	
EndIf

RestArea(aAreaSF2)
RestArea(aAreaSF4)
RestArea(aAreaSL1)
RestArea(aAreaSL2)
RestArea(aAreaSB1)
RestArea(aAreaSA1)
RestArea(aAreaAtu)
Return lRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML04  บAutor  ณMicrosiga           บ Data ณ  12/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function L04GravaLF(dData,cEmpresa,cFilEmpresa)
Local cQryAlias
Local dDataIni:=FirstDay(dData)
Local dDataFim:=LastDay(dData)
Local nInd

RpcClearEnv()
RpcSetType(3)
RpcSetEnv(cEmpresa,cFilEmpresa)

PtInternal(1,"Empresa: "+cEmpAnt+" Delete "+RetSqlName("SF3"))
TcSqlExec("Delete From "+RetSqlName("SF3")+" Where D_E_L_E_T_='*'")

PtInternal(1,"Empresa: "+cEmpAnt+" Delete "+RetSqlName("SFT"))
TcSqlExec("Delete From "+RetSqlName("SFT")+" Where D_E_L_E_T_='*'")

PtInternal(1,"Empresa: "+cEmpAnt+" Delete "+RetSqlName("CD2"))
TcSqlExec("Delete From "+RetSqlName("CD2")+" Where D_E_L_E_T_='*'")

cQryAlias:=GetNextAlias()

BeginSQL Alias cQryAlias
	
	COLUMN D2_EMISSAO AS DATE
	
	SELECT DISTINCT D2_FILIAL,D2_EMISSAO
	From(
	SELECT D2_CLIENTE,D2_LOJA,D2_FILIAL,D2_EMISSAO,D2_DOC,D2_SERIE,D2_ITEM,D2_VALICM,NVL(FT_VALICM,0)FT_VALICM ,(Tab1.D2_VALICM-NVL(Tab2.FT_VALICM,0)) DIFERENCA
	From
	(SELECT *
	FROM  %Table:SD2% SD2
	WHERE SD2.D2_FILIAL BETWEEN  '  ' AND  'ZZ'
	And SD2.D2_DOC BETWEEN '      ' And 'ZZZZZZ'
	And SD2.D2_SERIE BETWEEN '  ' And 'ZZ'
	And SD2.D2_CLIENTE BETWEEN '  ' And 'ZZ'
	And SD2.D2_LOJA BETWEEN '  ' And 'ZZ'
	AND SD2.D2_EMISSAO BETWEEN  %Exp:Dtos(dDataIni)% AND  %Exp:Dtos(dDataFim)%
	AND SD2.D2_ESPECIE='2D'
	AND SD2.D_E_L_E_T_= ' ') Tab1
	LEFT OUTER JOIN
	(SELECT *
	FROM  %Table:SFT% SFT
	WHERE FT_FILIAL BETWEEN  '  ' AND  'ZZ'
	AND FT_TIPOMOV='S'
	AND FT_ENTRADA BETWEEN  %Exp:Dtos(dDataIni)% AND  %Exp:Dtos(dDataFim)%
	And FT_SERIE BETWEEN '  ' And 'ZZ'
	And FT_NFISCAL BETWEEN '      ' And 'ZZZZZZ'
	And FT_CLIEFOR BETWEEN '  ' And 'ZZ'
	And FT_LOJA BETWEEN '  ' And 'ZZ'
	And FT_ITEM BETWEEN '  ' And 'ZZ'
	And FT_PRODUTO BETWEEN '  ' And 'ZZ'
	AND FT_DTCANC=' '
	AND D_E_L_E_T_=' '
	AND FT_ESPECIE='CF' ) Tab2
	On Tab1.D2_FILIAL=Tab2.FT_FILIAL
	And Tab1.D2_EMISSAO=Tab2.FT_ENTRADA
	And Tab1.D2_PDV=Tab2.FT_PDV
	And Tab1.D2_DOC=Tab2.FT_NFISCAL
	And Tab1.D2_SERIE=FT_SERIE
	And Tab1.D2_COD=Tab2.FT_PRODUTO
	And D2_ITEM=FT_ITEM
	) TAB3
	WHERE TAB3.DIFERENCA>0
	ORDER BY 1,2
	
EndSql


Do While (cQryAlias)->(!Eof())
	
	aParam:={}
	AADD(aParam,Dtoc((cQryAlias)->D2_EMISSAO))	//Data Inicial ?
	AADD(aParam,Dtoc((cQryAlias)->D2_EMISSAO))	//Data Final ?
	AADD(aParam,2)				//Livro de ?  1=Entrada 2=Saida 3=Ambos
	AADD(aParam,"         ")		//Da Nota Fiscal ?
	AADD(aParam,"ZZZZZZZZZ")		//Ate a Nota Fiscal ?
	AADD(aParam,"   ")			//Serie de ?
	AADD(aParam,"ZZZZ")			//Serie Ate ?
	AADD(aParam,"         ")		//Do Cliente/Forn. ?
	AADD(aParam,"ZZZZZ")		//Ate o Cliente/Forn. ?
	AADD(aParam,"      ")			//Da Loja ?
	AADD(aParam,"ZZZZZ")			//Ate a Loja ?
	//AADD(aParam,(cQryAlias)->D2_FILIAL)			//Da Filial ?
	//AADD(aParam,(cQryAlias)->D2_FILIAL)			//Ate a Filial ?
	//AADD(aParam,"  ")			//Utilizar Hist. Oper. Fiscal ?
	cFilAnt:=(cQryAlias)->D2_FILIAL
	PTINTERNAL(1,"Filial:"+(cQryAlias)->D2_FILIAL+" Emissao:"+Dtoc((cQryAlias)->D2_EMISSAO)+" Empresa: "+cEmpAnt  )
	
	MATA930(.T.,aParam) 		//Reprocessamento Livros Fiscais
	(cQryAlias)->(DbSkip())
EndDo

PtInternal(1,"Empresa: "+cEmpAnt+" Delete "+RetSqlName("SF3"))
TcSqlExec("Delete From "+RetSqlName("SF3")+" Where D_E_L_E_T_='*'")

PtInternal(1,"Empresa: "+cEmpAnt+" Delete "+RetSqlName("SFT"))
TcSqlExec("Delete From "+RetSqlName("SFT")+" Where D_E_L_E_T_='*'")

PtInternal(1,"Empresa: "+cEmpAnt+" Delete "+RetSqlName("CD2"))
TcSqlExec("Delete From "+RetSqlName("CD2")+" Where D_E_L_E_T_='*'")


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML04  บAutor  ณMicrosiga           บ Data ณ  12/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AcertNF(dDataIni,dDataFim)
Local nInd:=1
Local cQryAlias
Local aEmps:={{"03","01"},{"40","01"}}
Local cFiltro:=""

default dDataIni:=ctod("01/07/2015")
default dDataFim:=LastDay(MsDate())


For nInd:=1 To Len(aEmps)
	
	RpcClearEnv()
	RpcSetType(3)
	RpcSetEnv(aEmps[nInd,1],aEmps[nInd,2],,,,,{"SF2"})
	
	
	cQryAlias:=GetNextAlias()
	
	PtInternal(1,"Empresa:"+cEmpAnt+" Delete SF3")
	TcSqlExec("Delete From "+RetSqlName("SF3")+" Where D_E_L_E_T_='*'")
	
	PtInternal(1,"Empresa:"+cEmpAnt+" Delete SFT")
	TcSqlExec("Delete From "+RetSqlName("SFT")+" Where D_E_L_E_T_='*'")
	
	/*
	cUpdate:=" UPDATE "+RetSqlName("SD2")+" SD2 SET D2_PDV=(SELECT DISTINCT L1_PDV FROM "+RetSqlName("SL1")+" SL1 WHERE L1_FILIAL=D2_FILIAL AND L1_DOC=D2_DOC AND L1_SERIE=D2_SERIE AND L1_CLIENTE=D2_CLIENTE AND L1_EMISNF=D2_EMISSAO AND D2_PDV<>L1_PDV AND SL1.D_E_L_E_T_=' ')"
	cUpdate+=" WHERE D2_FILIAL='21'"
	cUpdate+=" AND SD2.D2_ESPECIE='2D'"
	cUpdate+=" AND D_E_L_E_T_=' '"
	TcSqlExec(cUpdate)
	
	cUpdate:=" UPDATE "+RetSqlName("SFT")+" SFT SET FT_PDV=(SELECT DISTINCT L1_PDV FROM "+RetSqlName("SL1")+" SL1 WHERE L1_FILIAL=FT_FILIAL AND L1_DOC=FT_NFISCAL AND L1_SERIE=FT_SERIE AND L1_CLIENTE=FT_CLIEFOR AND L1_EMISNF=FT_ENTRADA AND FT_PDV<>L1_PDV AND SL1.D_E_L_E_T_=' ')"
	cUpdate+=" WHERE D2_FILIAL='21'"
	cUpdate+=" AND SFT.FT_TIPOMOV='S'"
	cUpdate+=" AND FT_DTCANC=' '"
	cUpdate+=" AND FT_ESPECIE='CF'"
	cUpdate+=" AND D_E_L_E_T_=' '"
	TcSqlExec(cUpdate)
	*/
	
	BeginSQL Alias cQryAlias
		
		SELECT *
		From (
		SELECT SD2.R_E_C_N_O_ RECSD2,D2_DOC,D2_SERIE,SD2.D2_CF,D2_FILIAL FILIAL,(SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET+SD2.D2_SEGURO+SD2.D2_DESPESA+SD2.D2_VALFRE) Nota_Val_Cont,SD2.D2_BASEICM,
		SD2.D2_PICM,SD2.D2_VALICM,Round((SD2.D2_BASEICM*SD2.D2_PICM)/100,2) Valor
		FROM %Table:SD2% SD2
		WHERE SD2.D2_FILIAL BETWEEN '01' And '99'
		And SD2.D2_DOC BETWEEN '      ' And 'ZZZZZZ'
		And SD2.D2_SERIE BETWEEN '  ' And 'ZZ'
		And SD2.D2_CLIENTE BETWEEN '  ' And 'ZZ'
		And SD2.D2_LOJA BETWEEN '  ' And 'ZZ'
		AND SD2.D2_ESPECIE='2D'
		AND SD2.D_E_L_E_T_=' '
		) Tab1
		Where Valor<>Tab1.D2_VALICM
	EndSql
	
	PtInternal(1,"Empresa"+cEmpAnt+" Acerta D2_VALICM")
	
	Do While (cQryAlias)->(!Eof())
		
		SD2->(DbGoTo((cQryAlias)->RECSD2))
		
		nVlrICM:=Round((SD2->D2_BASEICM*SD2->D2_PICM)/100,2)
		
		If SD2->D2_VALICM<>nVlrICM
			RecLock("SD2",.F.)
			SD2->D2_VALICM=nVlrICM
			SD2->(MsUnLock())
		EndIf
		(cQryAlias)->(DbSkip())
	EndDo
	
	
	(cQryAlias)->(DbCloseArea())
	
	PtInternal(1,"Empresa"+cEmpAnt+" Acerta F2_VALICM")
	
	BeginSQL Alias cQryAlias
		
		SELECT SF2.R_E_C_N_O_ RECSF2, F2_DOC,F2_SERIE,F2_CLIENTE,F2_LOJA,F2_EMISSAO,SF2.F2_VALICM,SD2.D2_VALICM
		
		From %Table:SF2% SF2,
		(SELECT D2_FILIAL,D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,D2_EMISSAO,SUM(D2_VALICM) D2_VALICM
		FROM %Table:SD2% SD2
		WHERE SD2.D2_FILIAL BETWEEN '01' And '99'
		And SD2.D2_DOC BETWEEN '      ' And 'ZZZZZZ'
		And SD2.D2_SERIE BETWEEN '  ' And 'ZZ'
		And SD2.D2_CLIENTE BETWEEN '  ' And 'ZZ'
		And SD2.D2_LOJA BETWEEN '  ' And 'ZZ'
		AND SD2.D2_ESPECIE='2D'
		AND SD2.D_E_L_E_T_=' '
		GROUP BY D2_FILIAL,D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,D2_EMISSAO) SD2
		
		WHERE SF2.F2_FILIAL=SD2.D2_FILIAL
		And SF2.F2_DOC=SD2.D2_DOC
		And SF2.F2_SERIE=SD2.D2_SERIE
		And SF2.F2_CLIENTE=SD2.D2_CLIENTE
		And SF2.F2_LOJA=SD2.D2_LOJA
		And SF2.F2_VALICM<>D2_VALICM
		Order By 1
		
	EndSql
	
	Do While (cQryAlias)->(!Eof())
		
		SF2->(DbGoTo((cQryAlias)->RECSF2))
		If SF2->F2_VALICM<>(cQryAlias)->D2_VALICM
			RecLock("SF2",.F.)
			SF2->F2_VALICM:=(cQryAlias)->D2_VALICM
			SF2->(MsUnLock())
		EndIf
		
		
		(cQryAlias)->(DbSkip())
	EndDo
Next

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML04  บAutor  ณMicrosiga           บ Data ณ  12/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function L04JOBLF()
Local dData:=Date()-15
Local cEmpresa
Local cFilEmpresa
Local nInd
For nInd:=2 To 1 Step -1
	If nInd==1
		cEmpresa:="03"
		cFilEmpresa:="01"
	Else
		cEmpresa:="40"
		cFilEmpresa:="01"
	EndIf
	U_L04GravaLF(dData,cEmpresa,cFilEmpresa)
	//StartJob( "U_L04GravaLF", GetEnvServer(), .F., dData,cEmpresa,cFilEmpresa )
Next
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML04  บAutor  ณMicrosiga           บ Data ณ  12/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xDelLFDupli()
Local cQryAlias:=GetNextALias()

RpcSetEnv("40","01")

BeginSQL Alias cQryAlias
	SELECT FT_FILIAL,FT_TIPOMOV,FT_SERIE,FT_NFISCAL,FT_CLIEFOR,FT_LOJA,FT_ITEM,FT_PRODUTO,COUNT(1) Contar
	FROM SFT400 SFT
	WHERE FT_FILIAL BETWEEN '  ' AND '99'
	AND SFT.D_E_L_E_T_=' '
	GROUP BY FT_FILIAL,FT_TIPOMOV,FT_SERIE,FT_NFISCAL,FT_CLIEFOR,FT_LOJA,FT_ITEM,FT_PRODUTO
	HAVING COUNT(1)>1
EndSql

ChkFile("SFT")
SFT->(DbSetOrder(1))
Do While (cQryAlias)->(!Eof())
	
	cChaveSFT:=(cQryAlias)->(FT_FILIAL+FT_TIPOMOV+FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA+FT_ITEM+FT_PRODUTO)
	
	SFT->(DbSeek(cChaveSFT))
	SFT->(DbSkip())
	Do While SFT->(!Eof()) .And. SFT->(FT_FILIAL+FT_TIPOMOV+FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA+FT_ITEM+FT_PRODUTO)==cChaveSFT
		
		SFT->(RecLock("SFT",.F.))
		SFT->(DbDelete())
		SFT->(MsUnLock())
		SFT->(DbSkip())
	EndDo
	(cQryAlias)->(DbSkip())	       
EndDo	

TcSqlExec("Delete From "+RetSqlName("SFT")+" Where D_E_L_E_T_='*'")	

Return 
	
