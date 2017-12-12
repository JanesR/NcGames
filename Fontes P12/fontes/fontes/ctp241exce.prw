#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CTP241EXCE  �Autor  �Rodrigo Okamoto     � Data �  21/08/12 ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada para realizar as movimenta��es internas   ���
���          � conforme leitura de arquivo texto em formato CSV           ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
Planilha dever� conter as colunas na seguinte ordem:
C�DIGO
TM
LOCAL
QTD
CUSTO
Todos os campos dever�o estar preenchidos

*/ 

User Function CTP241EXCE


//���������������������������������������������������������������������Ŀ
//� Montagem da tela de processamento.                                  �
//�����������������������������������������������������������������������

@ 200,001 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Movimenta��o Interna CSV")
@ 002,010 TO 080,190
@ 010,018 Say " Este programa ira ler o conteudo de um arquivo texto, ordenado  "
@ 018,018 Say " com as colunas na sequ�ncia e na primeira linha o nome do campo "
@ 026,018 Say " A planilha dever� conter as colunas na seguinte ordem:"
@ 034,018 Say " C�digo;Tipo Movimenta��o;Local;Quantidade;Custo"

@ 070,128 BMPBUTTON TYPE 01 ACTION OkLeTxt()
@ 070,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered

Return


//leitura do arquivo CSV
Static Function OkLeTxt

AjustaSx1()
//CRIAR PAR�METRO
Private cPerg	:= "CTPCSV"

if !Pergunte(cPerg,.t.)
	Return
Endif
Private cArqTxt  := mv_par01
Private nHdl     := fOpen(mv_par01,68)
Private cEOL     := "CHR(13)+CHR(10)"

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

if empty(MV_PAR01) //.OR. EMPTY(MV_PAR02)
	MsgAlert("Preencha todos os par�metros da rotina!")
	Return
Endif

Processa({|| EXECIMPCSV() },"Verificando tabelas...")

Return(.T.)


//Verifica��o dos registros
Static Function EXECIMPCSV

Local nTamFile, nTamLin, cBuffer, nBtLidos

PRIVATE lMsErroAuto := .F.

nTamFile := fSeek(nHdl,0,2)

ProcRegua(nTamFile) // Numero de registros a processar

ft_fuse(cArqTxt)

cProd := ""
nCont := 1
aProd :={}

While !ft_feof()
	
	cBuffer := ft_freadln()
	
	aRet := StrTokArr(cBuffer,";")
	
	IncProc("Lendo Refer�ncia : " + aRet[1] + " Linha : " + strzero((nCont ),4))
	
	if nCont > 1
		DBSELECTAREA("SB1")
		DBSETORDER(1)
		If !DBSEEK(XFILIAL("SB1")+aRet[1])
			cProd	:= "0"+aRet[1]
		Else
			cProd	:= aRet[1]
		Endif
		DBSELECTAREA("SB1")
		DBSETORDER(1)
		DBGOTOP()
		IF DBSEEK(XFILIAL("SB1")+cProd)
			aadd(aProd,{aRet[1],aRet[2],aRet[3],val(strtran(aret[4],",",".")),val(strtran(aret[5],",","."))})
		ELSE
			ALERT("PRODUTO N�O ENCONTRADO! "+cProd)
		ENDIF
	endif
	nCont := nCont + 1
	
	//���������������������������������������������������������������������Ŀ
	//� Leitura da proxima linha do arquivo texto.                          �
	//�����������������������������������������������������������������������
	
	ft_fskip() // Leitura da proxima linha do arquivo texto
	
EndDo

//Executa as movimenta��es internas
If len(aProd) > 0
	Processa({|| BxCSVExcel(aProd) },"Executando baixa da mat�ria prima...")
EndIf


alert("Atualiza��o efetuada com sucesso!!!")

Close(oLeTxt)


Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �AjustaSX1 � Autor �Rodrigo Okamoto        � Data �14/03/2011���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Acerta o arquivo de perguntas                               ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                      ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao Efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function AjustaSx1()

Local aArea := GetArea()
Local aHelpP	:= {}
Local aHelpE	:= {}
Local aHelpS	:= {}

Aadd( aHelpP, "Informe o local e nome do arquivo de origem dos dados a serem importados " )
PutSx1("CTPCSV","01","Arquivo a ser importado ?     "  ,"Arquivo a ser importado ?     ","Arquivo a ser importado ?     ","mv_ch1","C",80,0,0,"G","U_SELCSV()","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP)
//� mv_par01        // Data de                  		         �
aHelpP	:= {}

RestArea(aArea)

Return



//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������
//�������������������������������������������������������������������������ͻ��
//���Programa  �SEL_ARQ   �Autor  �Rafael Augusto      � Data �  04/08/10   ���
//�������������������������������������������������������������������������͹��
//���Desc.     � Abre tela no servidor para o usuario localizar o arquivo   ���
//���          � que sera utilizado.                                        ���
//�������������������������������������������������������������������������͹��
//���Uso       � P10                                                        ���
//�������������������������������������������������������������������������ͼ��
//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������


User Function SELCSV()

Local cSvAlias		:= Alias()
Local lAchou		:= .F.
Local cTipo			:=  "Arquivos CSV (*.csv) |*.csv|"
Local cNewPathArq :=  cGetFile( "Arquivos CSV (*.csv) |*.csv|" , "Selecione o arquivo" )
//�����������������������������������������������������������������������Ŀ
//�Limpa o parametro para a Carga do Novo Arquivo                         �
//�������������������������������������������������������������������������

DbSelectArea("SX1")
DBSETORDER(1)

IF lAchou := ( SX1->( dbSeek( PADR(cPerg,10) + "01" , .T. ) ) )
	RecLock("SX1",.F.,.T.)
	SX1->X1_CNT01 := cNewPathArq //Space( Len( SX1->X1_CNT01 ) )
	MV_PAR01 	  := cNewPathArq
	MsUnLock()
EndIF

Return(.T.)



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BxCSVExcel �Autor  �Rodrigo Okamoto    � Data �  28/08/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function BxCSVExcel(aProd)

Local ExpA1 	:= {}
Local ExpN2 	:= {}
Local cUnidade	:= ""
Local cArmazem	:= ""
Local dEmissao	:= ddatabase

PRIVATE lMsErroAuto := .F.

//��������������������������������������������������������������Ŀ
//| Abertura do ambiente                                         |
//����������������������������������������������������������������
//ordena por tipo de movimenta��o
aProd := Asort(aProd,,,{|x,y| x[2] > y[2]})

cTpMov	:= ""

For nx:=1 to len(aProd)
	
	
	If cTpMov <> aProd[nx,2]
		cTpMov	:= STRZERO(VAL(aProd[nx,2]),3)
		ExpA1     := {}
		aadd(ExpA1,{"D3_DOC",NextNumero("SD3",2,"D3_DOC",.T.),})
		aadd(ExpA1,{"D3_TM" ,cTpMov,})
		aadd(ExpA1,{"D3_EMISSAO",ddatabase,})
		ExpA2 	  := {}
	EndIf
	
	cUnidade := Posicione("SB1",1,xFilial("SB1")+cProd,"B1_UM")
	
	xAutoItem := {}
	AADD(xAutoItem,{"D3_COD"    , aProd[nx,1] 	, Nil})
	AADD(xAutoItem,{"D3_QUANT" 	, aProd[nx,4]  	, Nil})
	AADD(xAutoItem,{"D3_LOCAL" 	, STRZERO(VAL(aProd[nx,3]),2) 	, Nil})
	AADD(xAutoItem,{"D3_UM"		, cUnidade 	 	, Nil})
	AADD(xAutoItem,{"D3_CUSTO1"	, aProd[nx,5] 	, Nil})
	
	AADD(ExpA2, xAutoItem)
	
	//��������������������������������������������������������������Ŀ
	//| Inclusao                                                     |
	//����������������������������������������������������������������
	If len(ExpA2) > 0 .and. iif(nx==len(aProd),.T.,cTpMov<>aProd[iif(nx==len(aProd),nx,nx+1),2])
		
		Begin Transaction
		MSExecAuto({|x,y,z| mata241(x,y,z)},ExpA1,ExpA2,3)
		
		If !lMsErroAuto
			ConOut("Incluido com sucesso! "+cTpMov)
		Else
			Mostraerro()
			//ConOut("Erro na inclusao!")
		EndIf
		End Transaction
	EndIf
	      
Next nx



Return Nil

