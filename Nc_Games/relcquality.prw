#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RelaFrete � Autor � Rafael Augusto     � Data �  21/06/10   ���
�������������������������������������������������������������������������͹��
���Descricao � Relatorio que ira verificar as origens dos Frete calculados���
���          � pelos frete cobrados.                                      ���
�������������������������������������������������������������������������͹��
���Uso       � AP10 - NC GAMES											  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function RELQUAL()


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Rela��o do CONTROLE CQ"
Local cPict          := ""
Local titulo         := "Rela��o do Controle de Qualidade"
Local nLin           := 80
Local Cabec1         := ""
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd 			 := {}
Local Emissao        := CTOD("  /  /    ")

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "RELCQ" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "RELCQ"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "RELCQ" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString      := ""

VALIDPERG()
pergunte(cPerg,.F.)

//���������������������������������������������������������������������Ŀ
//� Monta a interface padrao com o usuario...                           �
//�����������������������������������������������������������������������

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//���������������������������������������������������������������������Ŀ
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//�����������������������������������������������������������������������
Cabec1 := "                                                                                                              									
		// 0         1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
		// 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
Cabec2 := "  NOTA       PRODUTO            			ARM. ORIG ARM. DEST  SALDO        QUANT        HISTORICO                              USUARIO "


RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)




Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �RUNREPORT � Autor � AP6 IDE            � Data �  21/06/10   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local li := 9

cQuery:= ""

	cQuery:= "SELECT D7_DOC, D7_TIPO, D7_PRODUTO,D7_LOCAL, D7_LOCDEST, SUM(D7_SALDO) SALDO, D7_QTDE, D7_DATA, D7_USUARIO,D7_XJUST" 
	cQuery+= " FROM SD7010 "
	cQuery+= " WHERE D7_TIPO <> '0'AND D_E_L_E_T_<>'*'  "	
	cQuery+= " 	GROUP BY D7_DOC, D7_TIPO, D7_PRODUTO,D7_LOCAL, D7_LOCDEST, D7_QTDE, D7_DATA, D7_USUARIO,D7_XJUST  "


cQuery := ChangeQuery(cQuery)
    	
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB1",.T.,.T.)

//���������������������������������������������������������������������Ŀ
//� SETREGUA -> Indica quantos registros serao processados para a regua �
//�����������������������������������������������������������������������

SetRegua(RecCount())


TRB1->(dbGoTop())

WHILE TRB1->(!EOF())

	
   //���������������������������������������������������������������������Ŀ
   //� Verifica o cancelamento pelo usuario...                             �
   //�����������������������������������������������������������������������

   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   //���������������������������������������������������������������������Ŀ
   //� Impressao do cabecalho do relatorio. . .                            �
   //�����������������������������������������������������������������������

   If nLin > 65 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
      LI:= 9
   Endif


		@ li, 02	Psay TRB1->D7_DOC 
        @ li, 13	Psay TRB1->D7_PRODUTO+SUBSTR(POSICIONE("SB1",1,XFILIAL("SB1")+TRB1->D7_PRODUTO, "B1_DESC"),1,15)
		@ li, 41	Psay TRB1->D7_LOCAL
		@ li, 51 	Psay TRB1->D7_LOCDEST
		@ li, 62	Psay TRB1->SALDO Picture "@E 99999"
		@ li, 75	Psay TRB1->D7_QTDE Picture "@E 99999"
		@ li, 88	Psay TRB1->D7_XJUST 
		@ li, 127	Psay TRB1->D7_USUARIO

        li++       
  
  NLIN++
        
       TRB1->(DBSKIP())
EndDo


//���������������������������������������������������������������������Ŀ
//� Finaliza a execucao do relatorio...                                 �
//�����������������������������������������������������������������������

SET DEVICE TO SCREEN

//���������������������������������������������������������������������Ŀ
//� Se impressao em disco, chama o gerenciador de impressao...          �
//�����������������������������������������������������������������������

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

TRB1->(DBCLOSEAREA())

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �VALIDPERG � Autor � RAIMUNDO PEREIRA      � Data � 01/08/02 ���
�������������������������������������������������������������������������Ĵ��
���          � Verifica as perguntas inclu�ndo-as caso n�o existam        ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico para Clientes Microsiga                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function ValidPerg()
_aAreaVP := GetArea()
DBSelectArea("SX1")
DBSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AADD(aRegs,{cPerg,"01","Nota Fiscal De ?","","","mv_ch1","C", 6,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SF1"})
AADD(aRegs,{cPerg,"02","Nota Fiscal Ate ?","","","mv_ch2","C",6,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SF1"})
AADD(aRegs,{cPerg,"03","Tipo ?","","","mv_ch3","C",1,0,1,"C","","mv_par03","LIBERADO","","","","","REJEITADO","","","","","","","","","","","","","","","","","","",""})

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
                
