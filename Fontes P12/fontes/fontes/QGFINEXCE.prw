#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �QGFINEXCE   �Autor  �Rodrigo Okamoto     � Data �  21/08/12 ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada para realizar as movimenta��es internas   ���
���          � conforme leitura de arquivo texto em formato CSV           ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
Planilha dever� conter as colunas na seguinte ordem:
*/

User Function QGFINEXCE()


//���������������������������������������������������������������������Ŀ
//� Montagem da tela de processamento.                                  �
//�����������������������������������������������������������������������

@ 200,001 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Gera��o Contas a Receber CSV")
@ 002,010 TO 080,190
@ 010,018 Say " Este programa ira ler o conteudo de um arquivo texto, ordenado  "
@ 018,018 Say " com as colunas na sequ�ncia e na primeira linha o nome do campo "
@ 026,018 Say " A planilha dever� conter as colunas na seguinte ordem:"
@ 034,018 Say " D2_DOC;D2_PEDIDO;D2_EMISSAO;F2_ICMSRET;F2_VALBRUT;F2_COND;F2_CLIENTE;F2_LOJA;VEND1"

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
		IF len(aRet) > 0
			aadd(aProd,{aRet[1],aRet[2],aRet[3],val(strtran(aret[4],",",".")),val(strtran(aret[5],",",".")),aret[6],aret[7],aret[8],aret[9]})
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
	Processa({|| BxCSVExcel(aProd) },"Executando a gera��o dos t�tulos...")
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
PutSx1("CTPCSV","01","Arquivo a ser importado ?     "  ,"Arquivo a ser importado ?     ","Arquivo a ser importado ?     ","mv_ch1","C",80,0,0,"G","U_SELCSVA()","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP)
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



User Function SELCSVA()

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
���Uso       � AP                                                         ���
�������������������������������������������������������������������������͹��
���Alteracao � Ajustado para atender ecommerce b2b/b2c e melhorar o contro���
���          � le dos titulos gerados                                     ���
�������������������������������������������������������������������������͹��
���Analista  � Lucas Felipe - em 22/09/15                                 ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function BxCSVExcel(aProd)

Local cAliasSE1 := SE1->(GetArea())
Local cAliasSF2 := SF2->(GetArea())

Local cPrefix := ""
Local _aPgto  := {}

If !Empty(aProd)
	
	ProcRegua(len(aProd)) // Numero de registros a processar
	
	For nx:=1 to len(aProd)
		
		cPrefix := IIf(aProd[nx,6]=="WEB","ECO",IIf(aProd[nx,6]$"EMP|EUZ",aProd[nx,6],"3"))
		_aPgto 	:= {}
		
		
		If aProd[nx,6] $ "WEB|EMP|EUZ"
			Aadd(_aPgto,{DataValida(StoD(aProd[nx,3])+30),aProd[nx,5]})
		Else
			_aPgto     := Condicao(aProd[nx,5],aProd[nx,6],,stod(aProd[nx,3]) ) // Total para o calculo, cod. cond.pgto,data base
		EndIf
		IncProc("Gravando os t�tulos : " + aProd[nx,1])
		//���������������������������������������������������Ŀ
		//�	Grava dupliacatas em SE1					      �
		//�����������������������������������������������������
		For ny := 1 to Len(_aPgto)
			
			SE1->(DbSetOrder(1))//E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA
			
			If !SE1->(MsSeek(xFilial("SE1")+cPrefix+aProd[nx,1]+AllTrim(Str(ny))))
				
				SE1->(RecLock("SE1",.T.))
				
				SE1->E1_FILIAL	:= xFilial("SE1")
				SE1->E1_PREFIXO	:= cPrefix
				SE1->E1_NUM		:= aProd[nx,1]
				SE1->E1_PARCELA	:= AllTrim(Str(ny))
				SE1->E1_TIPO	:= "NF"
				SE1->E1_NATUREZ	:= "19101"
				SE1->E1_CLIENTE	:= aProd[nx,7]
				SE1->E1_LOJA	:= aProd[nx,8]
				SE1->E1_NOMCLI	:= GetAdvfVal("SA1","A1_NREDUZ",XFILIAL("SA1")+padr(aProd[nx,7],6)+padr(aProd[nx,8],2),1,"")
				SE1->E1_EMISSAO	:= StoD(aProd[nx,3])
				SE1->E1_VENCTO	:= _aPgto[ny,1]
				SE1->E1_VENCREA	:= _aPgto[ny,1]
				SE1->E1_VALOR	:= _aPgto[ny,2]
				SE1->E1_EMIS1	:= StoD(aProd[nx,3])
				SE1->E1_LA		:= "S"
				SE1->E1_SALDO	:= _aPgto[ny,2]
				SE1->E1_VEND1	:= aProd[nx,9]
				SE1->E1_SERIE   := "3"
				SE1->E1_VLCRUZ	:= _aPgto[ny,2]
				SE1->E1_LA 		:= "S"
				SE1->E1_SITUACA	:= "0"
				SE1->E1_FILORIG	:= "03"
				SE1->E1_MSFIL	:= "03"
				SE1->E1_MSEMP	:= "01"
				SE1->E1_MOEDA 	:= 1
				SE1->E1_VENCORI	:= _aPgto[ny,1]
				SE1->E1_STATUS	:= "A"
				SE1->E1_PEDIDO	:= aProd[nx,2]
				SE1->E1_OCORREN := CriaVar("E1_OCORREN")
				SE1->E1_ORIGEM := 'MATA460'
				
				SE1->(MsUnlock())
				
			Else
				SE1->(RecLock("SE1",.F.))
				
				SE1->E1_FILIAL	:= xFilial("SE1")
				SE1->E1_PREFIXO	:= cPrefix
				SE1->E1_NUM		:= aProd[nx,1]
				SE1->E1_PARCELA	:= AllTrim(Str(ny))
				SE1->E1_VALOR	:= _aPgto[ny,2]
				
				SE1->(MsUnlock())
			EndIf
		Next ny
		
		SF2->(DbSetOrder(1))
		If SF2->(MsSeek(xFilial("SF2")+aProd[nx,1]))
			
			SF2->(RecLock("SF2",.F.))
			
			SF2->F2_DUPL := SE1->E1_NUM
			
			SF2->(MsUnLock())
		EndIf
		
	Next nx
	
	SE1->(DbCloseArea())
	
EndIf

RestArea(cAliasSF2)
RestArea(cAliasSE1)

Return Nil
