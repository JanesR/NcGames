/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ±±
* SEL_ARQ3.PRW															   	±±
* 07/04/2011 16:57															±±
*																			±±
* Programa para validar o caminho do arquivo a ser gravado					±±
* Especifico para : NC Games												±±
* Requerente .....: NC Games												±±
* Modulo(s) ......: Financeiro												±±
* Nome no menu ...: " "														±±
*																			±±
* Rogerio de Souza Costa													±±
* Supertech																	±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function SEL_ARQ3()

Local cSvAlias		:= Alias()
Local lAchou		:= .F.
Local cNewPathArq   :=  cGetFile("Selecione o arquivo" )

cPerg:='AFI420'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Limpa o parametro para a Carga do Novo Arquivo                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


DbSelectArea("SX1")
DBSETORDER(1)

IF lAchou := ( SX1->( dbSeek( cPerg , .T. ) ) )
	RecLock("SX1",.F.,.T.)
	SX1->X1_CNT01 	:= cNewPathArq //Space( Len( SX1->X1_CNT01 ) )
	mv_par04 		:= cNewPathArq
	MsUnLock()
EndIF

Return(.T.)