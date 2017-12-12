#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#include "COLORS.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ MA450MNU ºAutor  ³Microsiga           º Data ³  14/10/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MA450MNU

//Local aMyRot := {}
If alltrim(Funname()) == "MATA450"
	aAdd(aRotina, { 'Analise Crédito','U_OCOR450B', 0 , 2} )
EndIf
aAdd(aRotina, { 'Visualiza Ocorr Crédito','U_OCOR450', 0 , 2} )

Return


/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Rotina para iserir observações da analise de crédito por pedido³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

User Function OCOR450B

Local aArea	:= getarea()
Local cPed	:= SC9->C9_PEDIDO

Private cCliAtu	:= SC9->C9_CLIENTE
Private cLojaAtu:= SC9->C9_LOJA
Private	cObsfin	:= space(354)
Private cTexto	:= ""
Private dData	:= ctod("  /  /  ")
Private cPed450	:= SC9->C9_PEDIDO

@ 100,001 To 550,800 Dialog oDlg Title "Analise de crédito do Pedido: " + cPed450 + ", Cliente: "+getadvfval("SA1","A1_NOME",xFilial("SA1")+cCliAtu+cLojaAtu,1,"")+" " + cCliAtu+" / "+cLojaAtu
@ 003,010 To 375,500
@ 014,014 Say OemToAnsi("Observações Crédito")
@ 034,014 Get cObsfin PICTURE "@e" Size 300,10 valid naovazio()
@ 054,014 Say OemToAnsi("Informações Adicionais Crédito")
@ 074,010 GET cTexto   Size 300,080  MEMO                // Object oMemo
@ 160,014 Say OemToAnsi("Data Limite?")
@ 180,014 Get dData Size 50,10 valid naovazio()

@ 204,130 BMPBUTTON TYPE 01 ACTION ObsFinB()
@ 204,160 BmpButton Type 02 Action Close(oDlg)
Activate Dialog oDlg Centered

RestArea(aArea)

Return

/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Gravação das informações e envio de e-mail³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

Static Function ObsFinB

Local  aAreaSC5:= SC5->(getarea())
Public cVend1	:= ""

If empty(dData) .or. dData < ddatabase
	alert("Defina corretamente a data limite para a apresentação dos documentos solicitados!")
	Return
Endif

cTMPPeds	:= ""

Begin Transaction

cTMPPeds	+= " "+SC9->C9_PEDIDO+","

DbSelectArea("SC5")
DbSetOrder(1)
If DbSeek(xFilial("SC5")+SC9->C9_PEDIDO)
	cVend1	:= SC5->C5_VEND1
	//		alert(cObsfin)
	RECLOCK("SC5",.F.)
	SC5->C5_YOBSFIN	:= cObsfin
	SC5->C5_YTEMOBS	:= "1"
	SC5->C5_YDLIMIT	:= dData
	SC5->C5_YFINOBS	:= cTexto
	MSUNLOCK()
	
	//Realiza a gravação na tabela de ocorrências da analise do crédito
	DbSelectArea("SZR")
	SET FILTER TO SZR->ZR_FILIAL+SZR->ZR_PEDIDO == xFilial("SZR")+SC9->C9_PEDIDO
	DbSetOrder(1)
	If DbSeek(xFilial("SZR")+SC9->C9_PEDIDO)
		While !eof() .and. SC9->C9_PEDIDO == SZR->ZR_PEDIDO
			cSequen	:= SZR->ZR_ITEM
			SZR->(DbSkip())
		End
		cSequen := SOMA1(cSequen)
	Else
		cSequen	:= "000001"
	EndIf
	
	RECLOCK("SZR",.T.)
	SZR->ZR_FILIAL	:= xFilial("SZR")
	SZR->ZR_ITEM	:= cSequen
	SZR->ZR_PEDIDO	:= SC9->C9_PEDIDO
	SZR->ZR_TEXTO	:= cObsfin
	SZR->ZR_DTLIMIT	:= dData
	SZR->ZR_DTOCORR	:= dDatabase
	SZR->ZR_HORA	:= Time()
	SZR->ZR_INFADIC := cTexto
	SZR->ZR_TIPO	:= "1"
	SZR->ZR_CLIENTE := SC9->C9_CLIENTE
	SZR->ZR_LOJA	:= SC9->C9_LOJA
	SZR->ZR_USER	:= cUsername
	MSUNLOCK()
	SET FILTER TO
	SZR->(DBCLOSEAREA())
	
EndIf
 
DBSELECTAREA("SA3")
DBSETORDER(1)
DBSEEK(xFilial("SA3")+cVend1)


//QUANDO FOR IMPLANTAR EM AMBIENTE OFICIAL, SUBSTITUIR A LINHA DO E-MAIL cTO
cTO	 := ALLTRIM(SA3->A3_EMAIL) //getadvfval("SA3","A3_EMAIL",xFilial("SA3")+cVend1,1,"")
//cTO	 := "pcesar@ncgames.com.br;halves@ncgames.com.br"
cCC	 := ""
cBCC	 := ""
cSUBJECT := "[NC GAMES] Analise de Crédito do cliente: "+alltrim(posicione("SA1",1,xFilial("SA1")+cCliAtu+cLojaAtu,"A1_NOME"))+"( "+cCliAtu+" / "+cLojaAtu+" )"
cBODY	:= "Pedidos em análise: "+substr(cTMPPeds,1,len(cTMPPeds)-1)+chr(13)+chr(10)+chr(13)+chr(10)
cBODY	+= "Prezado Vendedor: "+getadvfval("SA3","A3_NOME",xFilial("SA3")+cVend1,1,"")+","+chr(13)+chr(10)+"Os pedidos informados necessitam de informações para a aprovação de crédito:"+chr(13)+chr(10)+chr(13)+chr(10)+chr(13)+chr(10)
cBODY	+= alltrim(cObsfin)+chr(13)+chr(10)+ctexto+chr(13)+chr(10)+chr(13)+chr(10)
cBODY	+= "Data limite para retorno das informações: "+dtoc(dData)+chr(13)+chr(10)+chr(13)+chr(10)
cBODY	+= "Esta notificação também está disponível para visualização no seu pedido de vendas."
aFiles	:= {}

End Transaction

RestArea(aAreaSC5)

Close(oDlg)

u_ENVIAEMAIL(cTO, cCC, cBCC, cSUBJECT, cBODY, aFiles)
alert("E-mail de notificação enviado para: "+cTO)

Return



/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Busca das ocorrências do registro posicionado e exibe na tela³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

User Function OCOR450


Processa({|| CalcOC450() },"Verificando ocorrências...")


Return


Static Function CalcOC450

Local oVermelho   := LoadBitmap( GetResources(), "BR_VERMELHO" )
Local oAmarelo    := LoadBitmap( GetResources(), "BR_AMARELO" )
local oVerde      := LoadBitmap( GetResources(), "BR_VERDE" )

Private cArqTRB 	:= CriaTrab(Nil, .F.)		//Nome do arq. temporario

If alltrim(funname()) == "MATA450A"
	
	DbSelectArea("SZR")
	DbSetOrder(2)
	If !DbSeek(xFilial("SZR")+TRB->A1_COD+TRB->A1_LOJA)
		alert("Não há ocorrências de análise de crédito para o cliente posionado e com pedidos em aberto")
		Return
	Else
		
		cQry	:= " SELECT * FROM "+RetSqlName("SZR")
		cQry	+= " WHERE D_E_L_E_T_  = ' '
		cQry	+= " AND ZR_FILIAL = '"+xFilial("SZR")+"'
		cQry	+= " AND ZR_CLIENTE = '"+TRB->A1_COD+"' AND ZR_LOJA = '"+TRB->A1_LOJA+"'
		cQry	+= " AND ZR_PEDIDO NOT IN(
		cQry	+= " SELECT DISTINCT(D2_PEDIDO) FROM "+RetSqlName("SD2")
		cQry	+= " WHERE D2_FILIAL = '"+xFilial("SD2")+"' AND D_E_L_E_T_ = ' ')
		cQry	+= " ORDER BY ZR_PEDIDO, ZR_ITEM
		cQry	:= ChangeQuery(cQry)
		
		MsAguarde({|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cArqTRB,.T.,.T.)},"Aguarde...") //"Selecionando Registros..."
	EndIf
Else
	
	DbSelectArea("SZR")
	DbSetOrder(1)
	If !DbSeek(xFilial("SZR")+SC9->C9_PEDIDO)
		alert("Não há ocorrências de análise de crédito para o pedido!")
		Return
	Else
		
		cQry	:= " SELECT * FROM "+RetSqlName("SZR")
		cQry	+= " WHERE D_E_L_E_T_  = ' '
		cQry	+= " AND ZR_FILIAL = '"+xFilial("SZR")+"'
		cQry	+= " AND ZR_CLIENTE = '"+SC9->C9_CLIENTE+"' AND ZR_LOJA = '"+SC9->C9_LOJA+"' AND ZR_PEDIDO = '"+SC9->C9_PEDIDO+"'
		cQry	+= " AND ZR_PEDIDO NOT IN(
		cQry	+= " SELECT DISTINCT(D2_PEDIDO) FROM "+RetSqlName("SD2")
		cQry	+= " WHERE D2_FILIAL = '"+xFilial("SD2")+"' AND D_E_L_E_T_ = ' ')
		cQry	+= " ORDER BY ZR_PEDIDO, ZR_ITEM
		cQry	:= ChangeQuery(cQry)
		
		MsAguarde({|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cArqTRB,.T.,.T.)},"Aguarde...") //"Selecionando Registros..."
		
	EndIf
EndIf

aDadosTMP	:= {}
WHILE (cArqTRB)->(!EOF())
	
	cInfAds	:= getadvfval("SZR","ZR_INFADIC",xFilial("SZR")+(cArqTRB)->ZR_PEDIDO+(cArqTRB)->ZR_ITEM,1,"")
	nlinSINOPSE := mlcount(cInfAds)
	clinSINOPSE	:= ""
	For nx := 1 to nlinSINOPSE
		clinSINOPSE += if(right(MemoLine( cInfAds,,nx ),1) == " ",alltrim(MemoLine( cInfAds,,nx ))+" ",alltrim(MemoLine( cInfAds,,nx )))
	Next nx
	
	
	aadd(aDadosTMP,{(cArqTRB)->ZR_PEDIDO,;
	(cArqTRB)->ZR_ITEM,;
	(cArqTRB)->ZR_TEXTO,;
	clinSINOPSE,;
	DTOC(STOD((cArqTRB)->ZR_DTOCORR)),;
	(cArqTRB)->ZR_HORA,;
	DTOC(STOD((cArqTRB)->ZR_DTLIMIT)),;
	iif((cArqTRB)->ZR_TIPO=="1","Analise Crédito","Rejeição de Crédito"),;
	(cArqTRB)->ZR_USER})
	
	(cArqTRB)->(DbSkip())
END

(cArqTRB)->(dbCloseArea())

If len(aDadosTMP) > 0
	If alltrim(Funname()) == "MATA450A"
		@ 001,001 To 400,900 Dialog oDlgLib Title "Ocorrências do cliente: "+TRB->A1_COD+" / "+TRB->A1_LOJA
	Else
		@ 001,001 To 400,900 Dialog oDlgLib Title "Ocorrências do pedido: "+SC9->C9_PEDIDO
	EndIf
	@ 005,005 LISTBOX oItems Fields Title Padr('Pedido',20),;
	"Sequencia",;
	padr("Observações",70),;
	padr('Inf Adicionais',50),;
	padr("Data Ocorrência",10),;
	'Hora',;
	padr("Data Limite",10),;
	'Tipo Ocorrência',;
	PADR('Usuário',15) SIZE 440,155 PIXEL OF oDlgLib PIXEL
	oItems:SetArray(aDadosTMP)
	
	oItems:bLine := { || {aDadosTMP[oItems:nAt,1] ,;
	aDadosTMP[oItems:nAt,2] ,;
	aDadosTMP[oItems:nAt,3] ,;
	aDadosTMP[oItems:nAt,4] ,;
	aDadosTMP[oItems:nAt,5] ,;
	aDadosTMP[oItems:nAt,6] ,;
	aDadosTMP[oItems:nAt,7] ,;
	aDadosTMP[oItems:nAt,8] ,;
	aDadosTMP[oItems:nAt,9] }}
	
	@ 180,350 BMPBUTTON TYPE 01 ACTION Close( oDlgLib )
	@ 180,380 BMPBUTTON TYPE 02 ACTION Close( oDlgLib )
	Activate Dialog oDlgLib Centered
	
EndIf

Return
