#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#Include "XMLXFUN.CH"
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM05  บAutor  ณMicrosiga           บ Data ณ  03/20/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function com05Job()
u_Ecom05Job()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEcom05Job  บAutor  ณLucas Felipe        บ Data ณ  03/17/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Ecom05Job(aDados)

Default aDados:={"01","03"}
RpcSetEnv(aDados[1],aDados[2])

U_NcEcom05()
U_COM05GetCanc()

RpcClearEnv()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNcEcom05  บAutor  ณOctavio A. Estevam  บ Data ณ  23/12/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Integra็ใo Protheus x CiaShop                              บฑฑ
ฑฑบ          ณ Importa os pedidos de vendas atraves do metodo padrao na   บฑฑ
ฑฑบ          ณ ferramenta Ciashop.                                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NCECOM05()
Local aArea 	:= GetArea()
Local aCabec 	:= {}
Local aItens 	:= {}
Local aLinha 	:= {}
Local nX    	:= 0
Local _cDoc		:= ""
Local oobj		:= nil
Local oXml		:= nil
Local _cxml		:= ""
Local cError   := ""
Local cWarning := ""
Local _aCli
Local _aStatus	:= {}
Local nHDL
Local nRecZC5	:= 0
Local cCodMun	:=""
Local cMunic	:=""
Local cBody		:=""
Local cTemplate :=""
Local cArmPed  	:=""
Local cEmailTo := U_MyNewSX6("NC_ECOM05E",;
											"rciambarella@ncgames.com.br",;
											"C",;
											"Define o e-mail para envio de erro (Endere็o de entrega divergente).",;
											"Define o e-mail para envio de erro (Endere็o de entrega divergente).",;
											"Define o e-mail para envio de erro (Endere็o de entrega divergente).",;
											.F. )

Local oSrv
Local cXML

Private lMsErroAuto 		:= .F.
Private lMsHelpAuto 		:= .T.
PRIVATE lAutoErrNoFile 	:= .T.

If !Semaforo(.T.,@nHDL,"NCECOM05")
	Return()
EndIf

//oSrv:=RpcConnect( "192.168.0.217",1242,"TOTVSHOM_ECOMMERCE","01","03" )
//cXML:=(oSrv:callproc("U_NCECOM05"))
//oXml := XmlParser( cXML, "_", @cError, @cWarning )
//RpcDisconnect (oSrv )


//Cria o Obejto com os M้todos do Portal CiaShop
//M้todo paleativo//oXml :=XmlParserFile ( "\system\ciashop.xml", "_", @cError, @cWarning ) 
oobj:=NC_WSWSIntegracao():new()
//chama o metodo do portal

If oobj:pedidos(SuperGetMV("EC_NCG0010",,"wsncgames"),SuperGetMV("EC_NCG0011",,"apeei.1453"),"")
	oXml := XmlParser( oobj:cxml, "_", @cError, @cWarning )
Else
	U_COM09PV("PEDIDO","PEDIDO","IMPORTA_PEDIDO","",GetWSCError(),)
Endif

SA1->(DbSetOrder(1))

//Verifica se ha pedidos para importar
If XmlChildCount(oXml:_RECEIPTLIST) > 4
	
	If !valtype(oXml:_RECEIPTLIST:_RECEIPT)=="A"
		XmlNode2Arr(oXml:_RECEIPTLIST:_RECEIPT,"_RECEIPT")
	Endif
	
	For i:=1 to Len(oXml:_RECEIPTLIST:_RECEIPT)
		
		cTemplate := ALLTRIM(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_TEMPLATE_ID:TEXT)

		ZC5->(DbSetOrder(1))
		If ZC5->(!DbSeek(xFilial("ZC5")+oXml:_RECEIPTLIST:_RECEIPT[i]:_ORDER_ID:TEXT))
			
			_aCli:=AchaCli(oXml)
			
			
			If !Empty(_aCli[1]) .and. (ValType( XmlChildEx(oXml:_RECEIPTLIST:_RECEIPT[i], "_RECEIPT_ITEM"))=="O" .or. ValType( XmlChildEx(oXml:_RECEIPTLIST:_RECEIPT[i], "_RECEIPT_ITEM"))=="A")
				
				SA1->(MsSeek(xFilial("SA1")+_aCli[1]+_aCli[2]))
				
				BEGIN TRANSACTION
				
				If !valtype(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM)=="A"
					XmlNode2Arr(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM,"_RECEIPT_ITEM")
				Endif
				
				
				For nX := 1 To LEN(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM)
					ZC6->(RecLock("ZC6",.T.))
					
					ZC6->ZC6_FILIAL:= xFilial("ZC6")
					ZC6->ZC6_NUM	:= val(oXml:_RECEIPTLIST:_RECEIPT[i]:_ORDER_ID:TEXT)
					ZC6->ZC6_ITEM	:= StrZero(nX,2)
					ZC6->ZC6_PRODUT:= oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_PF_ID:TEXT
					ZC6->ZC6_QTDVEN:= val(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_QUANTITY:TEXT)
					ZC6->ZC6_VLRUNI:= Val(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_LIST_PRICE:TEXT)/100
					ZC6->ZC6_VLRTOT:= Val(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_ADJUSTED_PRICE:TEXT)/100
					
					//JR
					//Adicionado em 26/06/2017 para tratar pedidos do tipo B2B e B2C
					//de pedidos de vendas originados do CiaShop.
					//O armazem ้ equivaliente ao cadastrado jo Protheus.
					//ZC6->ZC6_LOCAL	:= SuperGetMV("MV_CIAESTO",,"01")
										
					if !empty(alltrim(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:ERP_ID:TEXT))
						cArmPed:= alltrim(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:ERP_ID:TEXT)
						ZC6->ZC6_LOCAL := cArmPed
					EndIf
					
					ZC6->(MsUnlock())
				Next nX

				ZC5->(Reclock("ZC5",.T.))
				
				ZC5->ZC5_FILIAL	:= xFilial("ZC5")
				ZC5->ZC5_NUM	:= val(oXml:_RECEIPTLIST:_RECEIPT[i]:_ORDER_ID:TEXT)
				ZC5->ZC5_CLIENT	:= _aCli[1]
				ZC5->ZC5_LOJA	:= _aCli[2]
				ZC5->ZC5_COND	:= AchaCond(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_COD_PG:TEXT)
				ZC5->ZC5_PLATAF	:= '01'
				ZC5->ZC5_STATUS	:= oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_PASSO:TEXT
				ZC5->ZC5_ATUALI	:= "S"
				
				If Alltrim(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_PASSO:TEXT) == "10"
					ZC5->ZC5_PAGTO := "2"
				EndIf
				
				ZC5->ZC5_QTDPAR	:= val(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_INSTALLMENT:TEXT)
				ZC5->ZC5_TOTAL	:= val(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_TOTAL:TEXT)/100
				ZC5->ZC5_FRETE	:= VAL(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_SHIPPING_COST:TEXT)/100
				ZC5->ZC5_IDTRAN	:= oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_COD_TRANS:TEXT
				
				ZC5->ZC5_VDESCON:= Val( oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_DISCOUNT_COUPON:TEXT ) /100  //Valor Desconto
				If ZC5->ZC5_VDESCON>0
					ZC5->ZC5_PDESCON:= ZC5->ZC5_VDESCON/(ZC5->ZC5_TOTAL-ZC5->ZC5_FRETE+ZC5->ZC5_VDESCON)*100//Percentual Desconto
				EndIf
				
				ZC5->ZC5_CGC := _aCli[3]
				//ZC5->ZC5_CODENT:=	oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_SHIPPING_METHOD:TEXT
				
				cMunic			:= AllTrim( Upper(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_SHIP_TO_ADDRESS2:TEXT))
				cMunic			:= StrTran(cMunic,"ร","A")
				cMunic			:= StrTran(cMunic,"ี","O")
				cMunic			:= StrTran(cMunic,"ว","C")
				cMunic			:= NoAcento(cMunic)
				
				
				
				ZC5->ZC5_ENDENT	:= Upper( AllTrim(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_SHIP_TO_ADDRESS1:TEXT) +","+oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_SHIP_TO_STREET_NUMBER:TEXT)
				ZC5->ZC5_BAIROE	:= Upper(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_SHIP_TO_DISTRICT:TEXT)
				ZC5->ZC5_CEPE	:= Upper(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_SHIP_TO_ADDRESS4:TEXT)
				ZC5->ZC5_MUNE	:= cMunic
				ZC5->ZC5_ESTE	:= Upper(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_SHIP_TO_ADDRESS3:TEXT)
				ZC5->ZC5_COMPLE	:= Upper(AllTrim(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_SHIP_TO_STREET_COMPL:TEXT))
				
				//Prj GET
				ZC5->ZC5_CODENT	:= U_V05CodEnt(ZC5->(Recno()),oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_SHIPPING_METHOD:TEXT,Upper(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_SHIP_TO_ADDRESS4:TEXT))
				
				cCodMun:=""
				CC2->(DBSETORDER(2)) //CC2_FILIAL+CC2_MUN
				CC2->(DbSeek(xFilial("CC2")+ZC5->ZC5_MUNE))
				Do While CC2->(!Eof()) .And.  CC2->CC2_MUN==ZC5->ZC5_MUNE
					If CC2->CC2_EST==ZC5->ZC5_ESTE
						cCodMun	:= CC2->CC2_CODMUN
						Exit
					EndIf
					CC2->(DbSkip())
				EndDo
				CC2->(DBSETORDER(1))
				
				ZC5->ZC5_CODMUE:=cCodMun
				//JR
				//Pedidos de vendas originados do CiaShop.
				//Utilizar "C" para B2C e "B" para B2B, basendo-se no template utilizado.
				IF cTemplate == "2" .And. cArmPed == "51"
					ZC5->ZC5_TPECOM := "C"
				Else
					ZC5->ZC5_TPECOM := "B"
				EndIf

				ZC5->(MsUnlock())
				
				//U_COM09PV(oXml:_RECEIPTLIST:_RECEIPT[i]:_ORDER_ID:TEXT, "PV","IMPORTA_PEDIDO","Pedido Importado")
				
				END TRANSACTION
				
				If SA1->A1_EST=="SP" .And. SA1->(AllTrim(A1_ENDENT)+AllTrim(A1_BAIRROE)+AllTrim(A1_CEPE)+AllTrim(A1_MUNE)+AllTrim(A1_ESTE))<>ZC5->(AllTrim(ZC5_ENDENT)+AllTrim(ZC5_COMPLE)+AllTrim(ZC5_BAIROE)+AllTrim(ZC5_CEPE)+AllTrim(ZC5_MUNE)+AllTrim(ZC5_ESTE)  )
					cBody:="<html>"
					cBody+="Pedido Site........:"+AllTrim(Str(ZC5->ZC5_NUM))+"<br>"
					cBody+="Cliente/Loja.......:"+SA1->A1_COD+'/'+SA1->A1_LOJA+Space(1)+SA1->A1_NOME+"<br>"
					cBody+="Endere็o Site.....:"+ZC5->(AllTrim(ZC5_ENDENT)+Space(1)+AllTrim(ZC5_COMPLE)+" Bairro:"+AllTrim(ZC5_BAIROE)+" CEP:"+AllTrim(ZC5_CEPE)+" Municipio:"+AllTrim(ZC5_MUNE)+" Estado:"+AllTrim(ZC5_ESTE)  )+"<br>"
					cBody+="Endere็o ERP....:"+SA1->(AllTrim(A1_ENDENT)+" Bairro:"+AllTrim(A1_BAIRROE)+" CEP:"+AllTrim(A1_CEPE)+" Munucipio:"+AllTrim(A1_MUNE)+" Estado:"+AllTrim(A1_ESTE))+"<br>"
					cBody+="</html>"
					
					U_MySndMail("Endere็o de Entrega Divergente", cBody,,cEmailTo )
				EndIf
				
			Else
				U_COM09PV(oXml:_RECEIPTLIST:_RECEIPT[i]:_ORDER_ID:TEXT,"PV","IMPORTA_PEDIDO","Cliente Invalido","Nใo Foi possivel identificar o cliente","")
			Endif
		Else
			//Pagamento Confirmado Ou Cancelado
			If ( oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_PASSO:TEXT=="10" .and. (ALLTRIM(ZC5->ZC5_STATUS)=="4" .OR. ALLTRIM(ZC5->ZC5_STATUS)=="5") )  .Or. (oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_PASSO:TEXT=="96" )
				ZC5->(Reclock("ZC5",.F.))
				
				ZC5->ZC5_STATUS	:= oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_PASSO:TEXT
				
				//Atualiza a flag de pagamento
				If Alltrim(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_PASSO:TEXT) == "10" .And. (Alltrim(ZC5->ZC5_PAGTO) != "2")
					ZC5->ZC5_PAGTO := "2"
				EndIf
				
				ZC5->ZC5_ATUALI	:= "S"
				
				ZC5->(MsUnlock())
				
			ElseIf ALLTRIM(ZC5->ZC5_STATUS) == "93"//Verifica se o pedido foi estornado e se existe outro pedido reimportado
				nRecZC5 := GetRecPVEs(ZC5->ZC5_NUM)
				
				If nRecZC5 != 0
					ZC5->(DbGoTo(nRecZC5))
					ZC5->(Reclock("ZC5",.F.))
					
					ZC5->ZC5_STATUS	:= oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_PASSO:TEXT
					ZC5->ZC5_ATUALI	:= "S"
					
					ZC5->(MsUnlock())
					
				EndIf
				
			Endif
		Endif
	Next i
Endif

Semaforo(.F.,nHDL,"NCECOM05")

RestArea(aArea)

Return

//Esta Funcao tem a finalidade de encontrar o cliente correto no protheus

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM05  บAutor  ณMicrosiga           บ Data ณ  03/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AchaCli(oXml,_lIncl)
Local aAreaAtu	:= GetArea()
Local _aCli		:= {}
Local _cCli		:= ""
Local _cLoja	:= ""
Local _cQuery	:= ""
Local cAliasQry:= GetNextAlias()

Default _lIncl	:= .F.

_cQuery:=" SELECT A1_COD,A1_LOJA,A1_END,A1_CGC "
_cQuery+=" FROM "+RetSqlName("SA1")
_cQuery+=" WHERE A1_FILIAL='"+xFilial("SA1")+"'"
_cQuery+=" AND D_E_L_E_T_=' '"
_cQuery+=" AND A1_ZCODCIA='"+ oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_SHOPPER_ID:TEXT +"'"
_cQuery+=" ORDER BY A1_COD,A1_LOJA "

_cQuery := ChangeQuery(_cQuery)
dbUseArea(.T., "TOPCONN", TCGenQry(,,_cQuery), cAliasQry, .T., .F.)

(cAliasQry)->(DbGoTop())
//Verifica se existe o cliente
aAdd(_aCli,(cAliasQry)->A1_COD)
aAdd(_aCli,(cAliasQry)->A1_LOJA)
aAdd(_aCli,(cAliasQry)->A1_CGC)

(cAliasQry)->(dbCloseArea())

RestArea(aAreaAtu)
Return _aCli

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM05  บAutor  ณMicrosiga           บ Data ณ  01/30/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Semaforo(lTipo,nHdl,cArq)
Local lRet		:=	.f.
Local cSemaf	:=	"SEMAFORO\"+cArq+".LCK"

If lTipo
	nHdl := MSFCREATE(cSemaf,1 + 16)
	lRet := nHdl > 0
Else
	lRet :=	Fclose(nHdl)
	Ferase(cSemaf)
EndIf

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM05  บAutor  ณMicrosiga           บ Data ณ  03/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AchaCond(_cCond)
Local _cRet:=""
/*
D้bito-DC
080 - D้bito em conta Banco do Brasil
081 - Transfer๊ncia Eletr๔nica Bradesco
082 - Ita๚ Shopline
083 - Banrisul

BOLETO-BOL
084 - Boleto Bancแrio

CARTรO DE CRษDITO-CC
075 - Cartใo American Express
076 - Cartใo Diners Online
077 - Cartใo Hipercard
078 - Cartใo MasterCard
079 - Cartใo Visa Online
*/
If _cCond$"080/081/082/083"
	_cRet:="DC"
ElseIf _cCond$"084"
	_cRet:="BOL"
ElseIf _cCond$"075/076/077/078/079"
	_cRet:="CC"
Endif

Return _cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM05  บAutor  ณMicrosiga           บ Data ณ  03/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AchaTrans(_nCod)
Local _cRet:="000002"
Return _cRet




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetRecPVEs	บAutor  ณElton C.      บ   Data ณ  02/2014     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para retornar o recno do novo pedido ap๓s  บฑฑ
ฑฑบ          ณo estorno                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetRecPVEs(nPVSite)

Local aArea 	:= GetArea()
Local cQuery   := ""
Local cArqTmp	:= GetNextAlias()
Local nRecRet	:= 0
Local lReimp	:= .F.
Local nRet		:= 0

Default nPVSite	:= 0

cQuery   := " SELECT R_E_C_N_O_ RECNOZC5 FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF
cQuery   += " WHERE D_E_L_E_T_ = ' ' "+CRLF
cQuery   += " AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
cQuery   += " AND ZC5.ZC5_NUM = '"+Alltrim(Str(nPVSite))+"' "+CRLF
cQuery   += " AND ZC5.ZC5_STATUS != '90'"+CRLF
cQuery   += " AND ZC5.ZC5_ESTORN != 'S' "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

If (cArqTmp)->(!Eof())
	nRet := (cArqTmp)->RECNOZC5
EndIf


(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return nRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM05  บAutor  ณMicrosiga           บ Data ณ  12/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function COM05EndEnt(cNumPV,cEndereco,cBairro,cCEP,cMunicipio,cEstado,cComplem,lConcatena,cCodMun)
Local aAreaAtu	:= GetArea()
Local aAreaZC5	:= ZC5->(GetArea())
Local aAreaSA1	:= SA1->(GetArea())
Local cNotImp	:= Alltrim(U_MyNewSX6("EC_NCG0002","96","C","Status PV que nใo deve ser importado","Status PV que nใo deve ser importado","Condicao Status PV que nใo deve ser importado",.F. ))
Local cQuery
Local clAlias		:= GetNextAlias()
Local lContinuar	:=.F.

Default cCodMun	:=""
Default cComplem	:=""
Default lConcatena:=.T.


cQuery:=" Select ZC5_ENDENT,ZC5_BAIROE,ZC5_CEPE,ZC5_MUNE,ZC5_ESTE,ZC5_COMPLE,ZC5_CODMUE,ZC5_CLIENT,ZC5_LOJA,ZC5_PVVTEX"+CRLF
cQuery+=" From "+RetSqlName("ZC5")+" ZC5"
cQuery+=" Where ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"'"+CRLF
cQuery+=" And ZC5.ZC5_NUMPV='"+cNumPV+"'"+CRLF
cQuery+=" And ZC5.ZC5_ESTORN<>'S'"+CRLF
cQuery+=" And ZC5.ZC5_STATUS Not In "+FormatIn(cNotImp,",")+CRLF
cQuery+=" And ZC5.D_E_L_E_T_=' '"+CRLF
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)

If !(clAlias)->(Eof() .And. Bof()) .And. SA1->(MsSeek(xFilial("SA1")+(clAlias)->(ZC5_CLIENT+ZC5_LOJA) ))


	If Empty( (clAlias)->ZC5_PVVTEX )
		lContinuar:=( SA1->A1_EST=="SP" )
	Else
		lContinuar:=.T.
	EndIf	
	
	If lContinuar .And. !Empty((clAlias)->ZC5_ENDENT)		
	
		cEndereco	:=AllTrim((clAlias)->ZC5_ENDENT)
		cBairro		:=AllTrim((clAlias)->ZC5_BAIROE)
		cCEP			:=AllTrim((clAlias)->ZC5_CEPE)
		cMunicipio	:=AllTrim((clAlias)->ZC5_MUNE)
		cEstado		:=AllTrim((clAlias)->ZC5_ESTE)
		cComplem		:=AllTrim((clAlias)->ZC5_COMPLE)
		cCodMun		:=AllTrim((clAlias)->ZC5_CODMUE)
		
		
		If lConcatena
			cEndereco+=" "+cComplem
		Endif
	EndIf
	
EndIf

(clAlias)->(DbCloseArea()) 

RestArea(aAreaSA1)
RestArea(aAreaZC5)
RestArea(aAreaAtu)
Return lContinuar



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM05  บAutor  ณMicrosiga           บ Data ณ  12/11/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function COM05GetCanc()
Local aArea 	:= GetArea()
Local cArqTmp	:= GetNextAlias()
Local cQuery   := ""
Local oApiSite

cQuery   := " SELECT R_E_C_N_O_ RECNOZC5,ZC5_NUM FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF
cQuery   += " Where ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
cQuery   += " And ZC5.ZC5_STATUS = '04'"+CRLF
cQuery   += " And ZC5.ZC5_ESTORN <> 'S' "+CRLF
cQuery   += " And ZC5.ZC5_NUM>0"+CRLF
cQuery   += " And D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

oApiSite:= ApiCiaShop():New()
oApiSite:lSemAcento:=.T.
oApiSite:lUpperCase:=.T.

Do While !(cArqTmp)->(Eof())
	
	ZC5->(DbGoTo((cArqTmp)->RECNOZC5))
	oApiSite:cUrl:="orders/"+AllTrim(Str(ZC5->ZC5_NUM))+"?fields=status,cancellationreason"
	oApiSite:HttpGet()
	
	If "CANCELLED"$oApiSite:cResponse
		ZC5->(DbGoTo((cArqTmp)->RECNOZC5))
		ZC5->(RecLock("ZC5",.F.))
		ZC5->ZC5_STATUS:=Iif("PAYMENTTRANSACTIONDECLINED"$oApiSite:cResponse,"96","90")
		ZC5->(MsUnLock())
	EndIf
	
	(cArqTmp)->(DbSkip())
EndDo


(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM05  บAutor  ณMicrosiga           บ Data ณ  01/20/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GetEndSite()
Local aArea 	:= GetArea()
Local cArqTmp	:= "PVSITE"
Local cQuery   := ""
Local oApiSite
Local aCols 	:={}
Local aHeader	:={}
Local aPosEnd	  :={12,13,09}


RpcSetEnv('01','03')

cQuery   := " SELECT R_E_C_N_O_ RECNOZC5,ZC5_NUM FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF
cQuery   += " Where ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
//cQuery   += " And ZC5.ZC5_STATUS In ('10','15','16')"+CRLF
cQuery   += " And ZC5.ZC5_NUMPV = '053728'"+CRLF
cQuery   += " And ZC5.ZC5_ESTORN <> 'S' "+CRLF
cQuery   += " And ZC5.ZC5_NUM>0"+CRLF
cQuery   += " And D_E_L_E_T_ = ' ' "+CRLF
cQuery   += " And ZC5_ENDENT=' ' "+CRLF
cQuery   += " Order By ZC5_NUM Desc"

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

oApiSite:= ApiCiaShop():New()
oApiSite:lSemAcento:=.T.
oApiSite:lUpperCase:=.T.

Do While !(cArqTmp)->(Eof())
	
	ZC5->(DbGoTo((cArqTmp)->RECNOZC5))
	oApiSite:cUrl:="orders/"+AllTrim(Str(ZC5->ZC5_NUM))+"?fields=shippingAddress"
	oApiSite:HttpGet()
	
	If (nAt:=At( '"SHIPPINGADDRESS"',oApiSite:cResponse))==0
		(cArqTmp)->(DbSkip())
		Loop
	EndIf
	
	cEndAux:= SubStr(oApiSite:cResponse,nAt)
	nAt:= At( '[',cEndAux)
	cEndAux:= SubStr(cEndAux,nAt+1)
	
	
	aEndAux:=Separa(cEndAux,Chr(13)+Chr(10))
	
	aCols 	:={}
	AADD(aCols,{})
	aAuxEndCob:=aCols[Len(aCols)]
	
	
	For nInd:=1 To Len(aEndAux)
		
		aEndAux[nInd]:=AllTrim(aEndAux[nInd])
		
		If Empty(aEndAux[nInd]) .Or. aEndAux[nInd]$"}*]"
			Loop
		EndIf
		
		
		aDados:=Separa(StrTran(aEndAux[nInd],'"',''),":")
		
		If Len(aDados)==1
			AADD(aDados,"")
		EndIf
		
		
		AADD(aHeader,AllTrim(aDados[1]))
		
		If aDados[1]=="STREET"
			aPosEnd[1]:=Len(aHeader)
		EndIf
		
		If aDados[1]=="STREETNUMBER"
			aPosEnd[2]:=Len(aHeader)
		EndIf
		If aDados[1]=="STREETCOMPLEMENT"
			aPosEnd[3]:=Len(aHeader)
		EndIf
		
		
		
		
		AADD(aAuxEndCob,AllTrim(StrTran(aDados[2],',','')))
	Next
	
	If Len(aCols)>0
	   Begin Transaction
		ZC5->(RecLock("ZC5",.F.))
		ZC5->ZC5_ENDENT:=AllTrim(acols[1][13])+","+AllTrim(acols[1][14])
		ZC5->ZC5_COMPLE:=acols[1][10]
		ZC5->ZC5_BAIROE:=acols[1][12]
		ZC5->ZC5_CEPE	:=acols[1][16]
		ZC5->ZC5_MUNE	:=acols[1][9]
		ZC5->ZC5_ESTE  :=acols[1][15]
		
		cCodMun:=""
		CC2->(DBSETORDER(2)) //CC2_FILIAL+CC2_MUN
		CC2->(DbSeek(xFilial("CC2")+ZC5->ZC5_MUNE))
		Do While CC2->(!Eof()) .And.  CC2->CC2_MUN==ZC5->ZC5_MUNE
			If CC2->CC2_EST==ZC5->ZC5_ESTE
				cCodMun	:= CC2->CC2_CODMUN
				Exit
			EndIf
			CC2->(DbSkip())
		EndDo
		CC2->(DBSETORDER(1))
		
		ZC5->ZC5_CODMUE:=cCodMun
	
		ZC5->(MsUnLock())
		End Transaction
	EndIf
	
	
	
	
	(cArqTmp)->(DbSkip())
EndDo


(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return

