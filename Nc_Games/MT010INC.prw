#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TopConn.ch"
#INCLUDE "vKey.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT010INC  ºAutor  ³ERICH BUTTNER       º Data ³  22/07/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ PONTO DE ENTRADA UTILIZADO NA ALTERACAO DE CADASTRO DE     º±±
±±º	³ PRODUTO ONDE IRA VERIFICAR A EXISTENCIA DA AMARRACAO DE 	     	  º±±
±±º	³ PRODUTO X FORNECEDOR, CASO NAO EXISTE INCLUI		          		  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MT010INC()

Local aArea	:= GetArea()
Local cPROD 	:= ALLTRIM(SB1->B1_COD)
Local cAltInc 	:= "I"
Local aDados	:= {}
Local CFORNEC	:= "000184"
Local CLOJA	:= "02"
LOCAL CFABRIC	:= ""
Local cMicrosoft:= Alltrim(U_MyNewSX6("NCG_000053","002089","C","FABRICANTE FORNECEDOR MICROSOFT"," "," ",.F. ))
Local cMostSite := SB1->B1_XMOSTSI //1="SIM AMBOS";2="NAO AMBOS";3="SO LATAM";4="SO BRASIL"
Local cMensagem:=""     
Local aAreaSA7

If lCopia //Copia de produto
	If !Empty(SB1->B1_XCODUSA)
		SB1->(RecLock("SB1",.F.))
		SB1->B1_XCODUSA:=""
		SB1->(MsUnLock())
	EndIf	
EndIf


//Tratamento efetuado para limpar os campos B5_YSOFTW e B5_YCODMS (referente o software) em caso de cópia do produto.
ClearSftw(SB1->B1_COD)

U_PR121SB1(SB1->B1_COD, SB1->B1_XMOSTSI) //Inclusão do produto na tabela ZC3 - Itens que vão para o Site


//Chama a rotina para criar o produto software (Projeto Software e Midia)
/*If Alltrim(SB1->B1_MIDIA) == '1'//Verifica se o produto tem midia
	
	MsgRun("Efetuando o cadastro do produto Software... ",;
	"Aguarde..",{|| U_PEProdSoft(SB1->B1_COD, 3)  })
	
EndIf*/

SB5->(DbSetOrder(1))
SB5->(DbSeek(xFilial("SB5")+SB1->B1_COD))

If SB1->B1_TIPO == 'PA'//If SB5->B5_YSOFTW == "2" //Adicionado 08/04/2014 - Verifica se o produto é Software
	//TIAGO BIZAN - INCLUSÃO DO PRODUTO NA TABELA DE INTEGRAÇÃO DO WMS
	DBSelectArea("P0A")
	P0A->(DBSetOrder(1))
	If SB1->B1_TIPO == 'PA'
		If P0A->(RecLock("P0A",.T.))
			P0A->P0A_FILIAL	:= xFilial("P0A")
			P0A->P0A_CHAVE	:= SB1->B1_FILIAL+SB1->B1_COD
			P0A->P0A_TABELA	:= "SB1"
			P0A->P0A_EXPORT := '2'
			P0A->P0A_INDICE	:= 'B1_FILIAL+B1_COD'
			P0A->P0A_TIPO	:= '1'
			P0A->(MsUnlock())
		EndIF
		SB1->( U_PR109Grv("SB1",SB1->B1_FILIAL+SB1->B1_COD,"3"))
	EndIF
EndIf
P0A->(DBCloseArea())
//Gravar o valor da mídia caso o NCM igual a 85234990
If alltrim(SB1->B1_POSIPI) == "85234990"
	RECLOCK("SB1",.F.)
	SB1->B1_YVLMID := 4.8
	SB1->(MSUNLOCK())
EndIf

DbSelectArea("SB1")

IF SUBSTR(CPROD,1,2)== '01'
	RECLOCK("SB1",.F.)
	MSMM( SB1->B1_DESC_I, 80,,ALLTRIM(SB1->B1_XDESC), 1,,, "SB1", "B1_DESC_I")
	MSMM( SB1->B1_DESC_P, 80,,ALLTRIM(SB1->B1_XDESC), 1,,, "SB1", "B1_DESC_P")
	SB1->(MSUNLOCK())
ENDIF

IF SUBSTR(B1_COD,5,2) = '01'
	cmsg := "DVD GRAVADO CONTENDO JOGO DE VIDEO GAME PARA CONSOLE PS2 - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	SB1->B1_MIDIA:= IIF(SUBSTR(CPROD,1,2)== '01',"1","")
	SB1->B1_QTMIDIA:= IIF(SUBSTR(CPROD,1,2)== '01',1,0)
	MSMM( SB1->B1_DESC_GI,80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '03'
	cmsg := "CARTUCHO CONTENDO JOGO DE VIDEO PARA CONSOLE PORTÁTIL GAME-BOY ADVANCED - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '04'
	cmsg := "CD GRAVADO CONTENDO JOGO DE VIDEO GAME PARA CONSOLE XBOX - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '05'
	cmsg := "CD GRAVADO CONTENDO JOGO DE VIDEO GAME PARA CONSOLE PS1 - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '06'
	cmsg := "CARTUCHO CONTENDO JOGO DE VIDEO PARA CONSOLE PORTÁTIL GAME-BOY - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '08' .AND. SUBSTR(B1_COD,1,2) == '01'
	cmsg := "CARTUCHO CONTENDO JOGO DE VIDEO PARA CONSOLE PORTÁTIL N-CAGE - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '08' .AND. SUBSTR(B1_COD,1,2) == '04'
	cmsg := "DVD GRAVADO CONTENDO JOGO DE VIDEO GAME PARA CONSOLE WII - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '11'
	cmsg := "CARTUCHO CONTENDO JOGO DE VIDEO PARA CONSOLE PORTÁTIL NINTENDO DS - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	SB1->B1_MIDIA:= IIF(SUBSTR(CPROD,1,2)== '01',"2","")
	SB1->B1_QTMIDIA:= IIF(SUBSTR(CPROD,1,2)== '01',0,0)
	CFABRIC:= "002795"
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '09'.AND. SUBSTR(B1_COD,1,2) == '04'
	cmsg := "DISCO BLU RAY GRAVADO CONTENDO JOGO DE VIDEO GAME PARA CONSOLE PS3 - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	SB1->B1_MIDIA:= IIF(SUBSTR(CPROD,1,2)== '04',"1","")
	SB1->B1_QTMIDIA:= IIF(SUBSTR(CPROD,1,2)== '04',1,0)
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '10' .AND. SUBSTR(B1_COD,1,2) == '04'
	cmsg := "DVD GRAVADO CONTENDO JOGO DE VIDEO GAME PARA CONSOLE XBOX 360 - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	SB1->B1_MIDIA:= IIF(SUBSTR(CPROD,1,2)== '04',"1","")
	SB1->B1_QTMIDIA:= IIF(SUBSTR(CPROD,1,2)== '04',1,0)
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '12' .AND. SUBSTR(B1_COD,1,2) == '01'
	cmsg := "DISCO UMD GRAVADO CONTENDO JOGO DE VIDEO GAME PARA CONSOLE PSP - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	SB1->B1_MIDIA:= IIF(SUBSTR(CPROD,1,2)== '01',"1","")
	SB1->B1_QTMIDIA:= IIF(SUBSTR(CPROD,1,2)== '01',1,0)
	CFABRIC:= "002786"
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '12' .AND. SUBSTR(B1_COD,1,2) == '04'
	cmsg := "DVD GRAVADO CONTENDO JOGO DE COMPUTADOR - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '13'.AND. SUBSTR(B1_COD,1,2) == '01'
	cmsg := "DVD GRAVADO CONTENDO JOGO DE VIDEO GAME PARA CONSOLE XBOX 360 - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	SB1->B1_MIDIA:= IIF(SUBSTR(CPROD,1,2)== '01',"1","")
	SB1->B1_QTMIDIA:= IIF(SUBSTR(CPROD,1,2)== '01',1,0)
	CFABRIC:= cMicrosoft   //alterado em 10/01 - Janes Isidoro
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '13'.AND. SUBSTR(B1_COD,1,2) == '04'
	cmsg := "DISCO UMD GRAVADO CONTENDO JOGO DE VIDEO GAME PARA CONSOLE PSP - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '14'.AND. SUBSTR(B1_COD,1,2) == '01'
	cmsg := "DISCO BLU RAY GRAVADO CONTENDO JOGO DE VIDEO GAME PARA CONSOLE PS3 - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	SB1->B1_MIDIA:= IIF(SUBSTR(CPROD,1,2)== '01',"1","")
	SB1->B1_QTMIDIA:= IIF(SUBSTR(CPROD,1,2)== '01',1,0)
	CFABRIC:= "002786"
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '15'.AND. SUBSTR(B1_COD,1,2) == '01'
	cmsg := "DVD GRAVADO CONTENDO JOGO DE VIDEO GAME PARA CONSOLE WII - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	SB1->B1_MIDIA:= IIF(SUBSTR(CPROD,1,2)== '01',"1","")
	SB1->B1_QTMIDIA:= IIF(SUBSTR(CPROD,1,2)== '01',1,0)
	CFABRIC:= "002787"
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '16'.AND. SUBSTR(B1_COD,1,2) == '01'
	cmsg := "DVD GRAVADO CONTENDO JOGO DE COMPUTADOR - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1")
	SB1->B1_MIDIA:= IIF(SUBSTR(CPROD,1,2)== '01',"1","")
	SB1->B1_QTMIDIA:= IIF(SUBSTR(CPROD,1,2)== '01',1,0)
	CFABRIC:= cMicrosoft  //alterado em 10/01 - Janes Isidoro
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(B1_COD,5,2) = '18'.AND. (SUBSTR(B1_COD,1,2)== '01' .OR. SUBSTR(CPROD,1,2) == '04')
	cmsg := "CARTÃO DE MEMÓRIA CONTENDO JOGO DE VIDEO PARA CONSOLE PORTÁTIL NINTENDO DSI - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1",.F.)
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(CPROD,5,2) = '22'.AND. (SUBSTR(CPROD,1,2)== '01' .OR. SUBSTR(CPROD,1,2) == '04')
	cmsg := "CARTÃO DE MEMÓRIA CONTENDO JOGO DE VIDEO PARA CONSOLE PORTÁTIL NINTENDO 3DS - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1",.F.)
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(CPROD,5,2) = '23'.AND. (SUBSTR(CPROD,1,2)== '01' .OR. SUBSTR(CPROD,1,2) == '04')
	cmsg := "CARTÃO DE MEMORIA CONTENDO JOGO DE VÍDEO PARA CONSOLE PORTÁTIL PS VITA - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1",.F.)
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
	CFABRIC:= "002786"
ELSEIF SUBSTR(CPROD,5,2) = '24'.AND. (SUBSTR(CPROD,1,2)== '01' .OR. SUBSTR(CPROD,1,2) == '04')
	cmsg := "DVD GRAVADO CONTENDO JOGO DE VIDEO GAME PARA CONSOLE WIIU - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1",.F.)
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(CPROD,5,2) = '25'.AND. (SUBSTR(CPROD,1,2)== '01' .OR. SUBSTR(CPROD,1,2) == '04')
	cmsg := "DISCO BLU RAY GRAVADO CONTENDO JOGO DE VIDEO GAME PARA CONSOLE PS4 - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1",.F.)
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ELSEIF SUBSTR(CPROD,5,2) = '26'.AND. (SUBSTR(CPROD,1,2)== '01' .OR. SUBSTR(CPROD,1,2) == '04')
	cmsg := "DISCO BLU RAY GRAVADO CONTENDO JOGO DE VIDEO GAME PARA CONSOLE XBOX ONE - "+ALLTRIM(SB1->B1_XDESC)
	RECLOCK("SB1",.F.)
	MSMM( SB1->B1_DESC_GI, 80,, cmsg, 1,,, "SB1", "B1_DESC_GI" )
	SB1->(MSUNLOCK())
ENDIF

DBSELECTAREA("SA5")
DBSETORDER(1)

IF !DBSEEK(XFILIAL("SA5")+CFORNEC+CLOJA+CPROD) .AND. SB1->B1_LOCPAD == '01'
	//Se o código de fabriante estiver vazio, então efetua a busca no cadastro de produto
	If Empty(CFABRIC)
		DbSelectArea("SA2")
		DbSetOrder(2)
		If SA2->(DbSeek(xFilial("SA2") +PADR(SB1->B1_FABRIC, TAMSX3("A2_NOME")[1])+"01"    )  )
			CFABRIC := SA2->A2_COD
		EndIf
	EndIf
	
	RECLOCK("SA5",.T.)
	SA5->A5_FILIAL := xFilial("SA5")
	SA5->A5_FORNECE	:= CFORNEC
	SA5->A5_LOJA	:= CLOJA
	SA5->A5_NOMEFOR	:= "NC GAMES & ARCADES OF AMERICA, INC"
	SA5->A5_PRODUTO	:= CPROD
	SA5->A5_TIPATU	:= "0"
	SA5->A5_NOMPROD	:= SB1->B1_DESC
	SA5->A5_FABR	:= CFABRIC
	SA5->A5_FALOJA	:= "01"
	MSUNLOCK()
	
ENDIF 



If SB1->B1_TIPO == 'PA'   
	U_PR117Copia(.F.)
EndIf	
aadd(aDados,"Aviso de inclusão no Cadastro de Produtos")
aadd(aDados,"Filial: "+xFilial("SB1"))
aadd(aDados,"Código: "+SB1->B1_COD)
aadd(aDados,"Descrição: "+SB1->B1_DESC)
aadd(aDados,"Conta Contabil: "+SB1->B1_CONTA)
aadd(aDados,"Incluido por: "+cUsername)
MEnviaMail("Z05",aDados)
RestArea(aArea)

Return
/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ClearSftw  ³ Autor ³ELTON SANTANA		    ³ Data ³ 02/09/13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rotina utilizada para limpar os dados referente		      ³±±
±±³			 ³ o software no cadastro do complemento do produto. Esse	  ³±±
±±³			 ³ item faz necessário em caso de cópia do produto	 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 							                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ClearSftw(cCodProd)

Local aArea := GetArea()

Default cCodProd := ""

If !Empty(cCodProd)
	DbSelectArea("SB5")
	DbSetOrder(1)
	If SB5->(DbSeek(xFilial("SB5") + cCodProd))
		If !Empty(SB5->B5_YCODMS) .Or. !Empty(SB5->B5_YSOFTW)
			RecLock("SB5",.F.)
			SB5->B5_YCODMS 	:= ""
			SB5->B5_YSOFTW  := ""
			SB5->(MsUnlock())
		EndIf
	EndIf
EndIf

RestArea(aArea)
Return

