///////////////////////////////////////////////////////////////////////////////////////
//+---------------------------------------------------------------------------------+//
//| PROGRAMA  | ListBoxSemaforo.prw  | AUTOR | Sidney Oliveira  | DATA | 18/01/2004 |//
//+---------------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_ListBoxSem()                                             |//
//|           | Fonte utilizado no curso oficina de programacao.                    |//
//|           | Funcao que demonstra a utilizacao de listbox com semaforo           |//
//+---------------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                    |//
//+---------------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                     |//
//+---------------------------------------------------------------------------------+//
//|          |                      |                                               |//
//+---------------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////////
User Function Vencimento()	

Local aSalvAmb := {}
Local aVetor   := {}
Local oDlg     := Nil
Local oLbx     := Nil
Local cTitulo  := "Vencimentos"
Local lVenc   := .F.
Local oOk      := LoadBitmap( GetResources(), "BR_VERDE" )
Local oNo      := LoadBitmap( GetResources(), "BR_AMARELO" )

dbSelectArea("SZG") 
aSalvAmb := GetArea()
dbSetOrder(1)
dbSeek(xFilial("SZG"))

//+-------------------------------------+
//| Carrega o vetor conforme a condicao |
//+-------------------------------------+
While !Eof() .And. ZG_FILIAL == xFilial("SZG")	
   lVenc := Iif(ZG_FIMCONT > DDATABASE,.T.,.F.)
   aAdd( aVetor, { lVenc, ZG_CODIGO, ZG_NOME, ZG_FIMCONT } )
	dbSkip()
End

If Len( aVetor ) == 0
   Aviso( cTitulo, "Fim da Consulta", {"Ok"} )
   Return
Endif

//+-----------------------------------------------+
//| Monta a tela para usuario visualizar consulta |
//+-----------------------------------------------+
DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 240,500 PIXEL
@ 10,10 LISTBOX oLbx FIELDS HEADER ;
   " ", "Codigo", "Nome", "Vencimento" ;
   SIZE 230,095 OF oDlg PIXEL	

oLbx:SetArray( aVetor )
oLbx:bLine := {|| {Iif(aVetor[oLbx:nAt,1],oOk,oNo),;
	                    aVetor[oLbx:nAt,2],;
	                    aVetor[oLbx:nAt,3],;
	                    aVetor[oLbx:nAt,4]}}
	                    
DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg CENTER
RestArea( aSalvAmb )
Return .T.