#include "rwmake.ch"
#include "topconn.ch"
#include "protheus.ch"
#include "fileio.ch"

// #########################################################################################
// Projeto:
// Modulo :
// Fonte  : M261Imp
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor             | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 26/02/16 | Lucas Felipe      | Gerado pelo Assistente de Código
// ---------+-------------------+-----------------------------------------------------------
//------------------------------------------------------------------------------------------

User Function M261ImpEx()

Local cArq,cInd
Local aStru1 := {}

Private oLeTxt

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem da tela de processamento.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


	@ 200,  1 to 380, 380 dialog oLeTxt title "Importacao de Transferencias"
	@ 10, 10 to 80,190
	
	//Coloque um pequeno descritivo com o objetivo deste processamento
	@ 10, 18 say " Este programa ira ler o conteudo de um arquivo .CSV, "
	@ 18, 18 say " conforme leiaute abaixo: "
	@ 26, 18 say " Cod.Produto(c/0); Arm. Origem; Qnt à transf; Arm. Destino "
	@ 34, 18 say " EX.: 0101010123;01;10;51 "
	
	@ 70, 128 bmpButton type 01 action OkLeTxt()
	@ 70, 158 bmpButton type 02 action Close(oLeTxt)
	activate dialog oLeTxt centered
	
Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} OkLeTxt
Processo de exportação.

@author    Lucas Felipe
@version   1.00
@since     26/02/2016
/*/
//------------------------------------------------------------------------------------------

Static Function OkLeTxt

Private cPerg  := "M241IMPEX"

ValidPerg()

if !Pergunte(cPerg,.t.)
	Return
Endif

Private cArqTxt := mv_par01
Private nHdl    := fOpen(mv_par01,68)
Private cEOL    := "CHR(13)+CHR(10)"

If Empty(cEOL)
	cEOL := CHR(13)+CHR(10)
Else
	cEOL := Trim(cEOL)
	cEOL := &cEOL
Endif


If nHdl == -1
	
	MsgAlert("O arquivo de nome " + mv_par01 + " nao pode ser aberto!","Atencao!")
	Return
	
Endif


If Empty(mv_par01)
	
	MsgAlert("Preencha todos os parâmetros da rotina!")
	Return
	
Endif


Processa({|| doProcess() },"Processando...")

fClose(nHdl)
nDhl := nil

Return


//------------------------------------------------------------------------------------------
/*/{Protheus.doc} doProcess
Processo de exportação.

@author    TOTVS | Developer Studio - Gerado pelo Assistente de Código
@version   1.xx
@since     26/02/2016
/*/
//------------------------------------------------------------------------------------------

Static Function doProcess()

local cBuffer, nLenLidos, nTamLin, nLenLote

Local aAreaSB1 := SB1->(GetArea())
Local aAreaSB2 := SB2->(GetArea())

Local aItensAux	:= {}
Local aAreaAux	:= {}

Local dValid:=CTOD("31/12/2049")

Private lMsErroAuto := .F.

//Recomenda-se o uso de procRegua usando 100 (representando 100%)
nTamFile := fSeek(nHdl,0,2)
if nTamFile > 100
	procRegua(100)
	nTamFile := int(nTamFile * 0.05)
else
	procRegua(nTamFile)
endif
nTamFile := 0

ft_fuse(cArqTxt)

nCont := 1

SB1->(DbSetOrder(1))//B1_FILIAL+B1_COD
SB2->(DbSetOrder(1))//B2_FILIAL+B2_COD+B2_LOCAL

While  !ft_feof()
	
	cBuffer := ft_freadln()
	
	aAreaAux := {}
	//cBuffer	:= StrTran(cBuffer,'"',"")
	aAreaAux := Separa(cBuffer,";")
	
	IncProc("Lendo Referência : " + aAreaAux[1] + " Linha : " + strzero((nCont ),4))
	
	cProd 		:= AllTrim(aAreaAux[1])
	cArmOri	:= AllTrim(aAreaAux[2])
	nQuant		:= Val(aAreaAux[3])
	cArmTrans	:= AllTrim(aAreaAux[4])
	
	If SB1->(MsSeek(xFilial("SB1")+cProd))
		If SB2->(MsSeek(xFilial("SB2")+SB1->B1_COD+cArmOri))
			If SB2->(B2_QATU-B2_RESERVA) - nQuant >= 0
				If SB2->(MsSeek(xFilial("SB2")+SB1->B1_COD+cArmTrans))
					
					aTransf:=Array(2)
					aTransf[1] := {"",dDataBase}
					
					aTransf[2]:= {{"D3_COD"    	, SB1->B1_COD                ,NIL}}
					aAdd(aTransf[2],{"D3_DESCRI" , SB1->B1_DESC               ,NIL})
					aAdd(aTransf[2],{"D3_UM"     , SB1->B1_UM                 ,NIL})
					aAdd(aTransf[2],{"D3_LOCAL"  , cArmOri		                ,NIL})
					aAdd(aTransf[2],{"D3_LOCALIZ", Criavar("D3_LOCALIZ")   	  ,NIL})
					aAdd(aTransf[2],{"D3_COD"    , SB1->B1_COD             	  ,NIL})
					aAdd(aTransf[2],{"D3_DESCRI" , SB1->B1_DESC               ,NIL})
					aAdd(aTransf[2],{"D3_UM"     , SB1->B1_UM             	  ,NIL})
					aAdd(aTransf[2],{"D3_LOCAL"  , cArmTrans            		  ,NIL})
					aAdd(aTransf[2],{"D3_LOCALIZ", CriaVar("D3_LOCALIZ")   	  ,NIL})
					aAdd(aTransf[2],{"D3_NUMSERI", CriaVar("D3_NUMSERI")      ,NIL})
					aAdd(aTransf[2],{"D3_LOTECTL", CriaVar("D3_LOTECTL")      ,NIL})
					aAdd(aTransf[2],{"D3_NUMLOTE", CriaVar("D3_NUMLOTE")      ,NIL})
					aAdd(aTransf[2],{"D3_DTVALID", CriaVar("D3_DTVALID")		  ,NIL})
					aAdd(aTransf[2],{"D3_POTENCI", criavar("D3_POTENCI")      ,NIL})
					aAdd(aTransf[2],{"D3_QUANT"  , nQuant			            ,NIL})
					aAdd(aTransf[2],{"D3_QTSEGUM", criavar("D3_QTSEGUM")      ,NIL})
					aAdd(aTransf[2],{"D3_ESTORNO", criavar("D3_ESTORNO")      ,NIL})
					aAdd(aTransf[2],{"D3_NUMSEQ" , criavar("D3_NUMSEQ")		  ,NIL})
					aAdd(aTransf[2],{"D3_LOTECTL", CriaVar("D3_LOTECTL")		  ,NIL})
					aAdd(aTransf[2],{"D3_DTVALID", dValid			          	  ,NIL})
					
					
					lMsErroAuto := .f.
					MSExecAuto({|x| MATA261(x)},aTransf)
					
					
					If lMsErroAuto
						MostraErro()
						lContinuar:=.F.
						lComErro:=.T.
						
						Break
					EndIf
					
				EndIf
			EndIf
		EndIf
	EndIf
	
	nCont := nCont + 1
	
	ft_fskip() // Leitura da proxima linha do arquivo texto
EndDo


alert("Atualização efetuada com sucesso!!!")

Close(oLeTxt)

Return


//------------------------------------------------------------------------------------------
/*/{Protheus.doc} ValidPerg
Ajusta SX1

@author    Lucas Felipe
@version   1.00
@since     26/02/2016
/*/
//------------------------------------------------------------------------------------------

Static Function ValidPerg()

Local aArea	:= GetArea()
Local aHelp	:= {}
Local cText 	:= "Arquivo a ser importado ?"

cPerg := PADR(cPerg,10)
aRegs :={}

PutSx1(cPerg,"01",cText,cText,cText,"mv_ch1","C",80,0,0,"G","U_FindArq()","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp)

aHelpP	:= {}

RestArea(aArea)

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} FindArq
Busca o Arquivo que será importado.

@author    Lucas Felipe
@version   1.00
@since     26/02/2016
/*/
//------------------------------------------------------------------------------------------

User Function FindArq()

Local cSvAlias		:= Alias()
Local lAchou		:= .F.
Local cTipo			:= "Arquivos CSV (*.csv) |*.csv|"
Local cNewPathArq 	:= cGetFile( cTipo , "Selecione o arquivo" )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Limpa o parametro para a Carga do Novo Arquivo                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbSelectArea("SX1")
DbSetOrder(1)

IF lAchou := ( SX1->( dbSeek( PADR(cPerg,10) + "01" , .T. ) ) )
	RecLock("SX1",.F.,.T.)
	
	SX1->X1_CNT01 	:= cNewPathArq //Space( Len( SX1->X1_CNT01 ) )
	Mv_par01 		:= cNewPathArq
	
	MsUnLock()
EndIF

Return(.T.)