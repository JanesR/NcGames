#include 'rwmake.ch'

User Function Mt410Ace()

Local lContinua := .T.
Local nOpc  := PARAMIXB [1]
Local cCodUser			:= RetCodUsr(Substr(cUsuario,1,6))
Local cPerUserAE 	:= Alltrim(U_MyNewSX6("EC_NCG0017","","C","Permiss�o para alterar e\ou excluir pedido E-commerce","","",.F. )   )

aArea	:= getarea()

IF nOpc == 3 // copia
	cMensagem	:= ""
	lContinua	:= iif(SC5->C5_LIBEROK <> " " .OR. SC5->C5_NOTA <> " " , .F.,.T.)
	If SC5->C5_LIBEROK <> " " .and. SC5->C5_NOTA = " "
		cMensagem	:= "Liberado"
	Elseif SC5->C5_NOTA <> " "
		cMensagem	:= "Faturado"
	EndIf
	If !Empty(cMensagem)
		alert("N�o � poss�vel a c�pia do pedido. O pedido j� foi "+cMensagem+"!!! ")
	Endif
Endif

// Verifica se o pedido e de e-commerce e se o usu�rio tem permiss�o para alterar e\ou excluir
If Upper(Alltrim(SC5->C5_XECOMER)) == 'C'
   
	If cCodUser $ cPerUserAE .Or. IsInCallStack("A410Visual")
		lContinua  	:= .T.   
		
	Else
		Aviso("Permiss�o de usu�rio (E-commerce)",;
				"Usu�rio sem permiss�o para alterar e\ou excluir pedido do E-commerce. Entre em contato com o administrador.",{"Ok"},2)
				
		lContinua 	:= .F.
   EndIf
   
EndIf
	 

RestArea(aArea)
Return(lContinua)

