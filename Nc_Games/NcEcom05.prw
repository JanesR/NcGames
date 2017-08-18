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
Local aErro		:= {}
Local _cError	:= ""
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
Local IntB2C	:=.F.
Local aKit		:={}
Local nItem		:= 1
Local lPossuiKit:= .F.
Local cEmailTo := U_MyNewSX6("NC_ECOM05E",;
"rciambarella@ncgames.com.br",;
"C",;
"Define o e-mail para envio de erro (Endere็o de entrega divergente).",;
"Define o e-mail para envio de erro (Endere็o de entrega divergente).",;
"Define o e-mail para envio de erro (Endere็o de entrega divergente).",;
.F. )
Local cTempleB2B := U_MyNewSX6("NC_TMPB2B",;
"2",;
"C",;
"Define o Template pertencente ao B2B.",;
"Define o Template pertencente ao B2B.",;
"Define o Template pertencente ao B2B.",;
.F. )
Local oSrv
Local cXML

PRIVATE lMsErroAuto 		:= .F.
Private lMsHelpAuto			:= .T.
PRIVATE lAutoErrNoFile		:= .T.

//U_NcEcom01()

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
			
			_aCli:=AchaCli(oXml,cTemplate)
			
			If empty(_aCli[1]) .And. !(cTemplate$cTempleB2B)
				IntB2C := .T.
			elseif !empty(_aCli[1])
				IntB2C := .T.
			else
				IntB2C := .F.
			EndIf
			
			//If !Empty(_aCli[1]) .and. (ValType( XmlChildEx(oXml:_RECEIPTLIST:_RECEIPT[i], "_RECEIPT_ITEM"))=="O" .or. ValType( XmlChildEx(oXml:_RECEIPTLIST:_RECEIPT[i], "_RECEIPT_ITEM"))=="A")
			If IntB2C .And. (ValType( XmlChildEx(oXml:_RECEIPTLIST:_RECEIPT[i], "_RECEIPT_ITEM"))=="O" .or. ValType( XmlChildEx(oXml:_RECEIPTLIST:_RECEIPT[i], "_RECEIPT_ITEM"))=="A")
				
				if !Empty(_aCli[1])
					SA1->(MsSeek(xFilial("SA1")+_aCli[1]+_aCli[2]))
				EndIf
				
				BEGIN TRANSACTION
				
				If !valtype(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM)=="A"
					XmlNode2Arr(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM,"_RECEIPT_ITEM")
				Endif
				
				lPossuiKit := .F.

				For nX := 1 To LEN(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM)
					
					
					if upper(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_type:Text) != "KIT"
						
						ZC6->(RecLock("ZC6",.T.))
						ZC6->ZC6_FILIAL:= xFilial("ZC6")
						ZC6->ZC6_NUM	:= val(oXml:_RECEIPTLIST:_RECEIPT[i]:_ORDER_ID:TEXT)
						ZC6->ZC6_ITEM	:= StrZero(nItem,2)
						ZC6->ZC6_PRODUT:= oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_PF_ID:TEXT
						ZC6->ZC6_QTDVEN:= val(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_QUANTITY:TEXT)
						ZC6->ZC6_VLRUNI:= Val(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_LIST_PRICE:TEXT)/100
						ZC6->ZC6_VLRTOT:= Val(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_ADJUSTED_PRICE:TEXT)/100
						
						//JR
						//Adicionado em 26/06/2017 para tratar pedidos do tipo B2B e B2C
						//de pedidos de vendas originados do CiaShop.
						//O armazem ้ equivaliente ao cadastrado jo Protheus.
						//ZC6->ZC6_LOCAL	:= SuperGetMV("MV_CIAESTO",,"01")
						
						if (XmlNodeExist(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_RECEIPT_ITEM_WAREHOUSES:_WAREHOUSEINTEG,"_ERP_ID"))
							cArmPed:= SubStr( alltrim(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_RECEIPT_ITEM_WAREHOUSES:_WAREHOUSEINTEG:_ERP_ID:Text) , 5, 2)
							ZC6->ZC6_LOCAL := cArmPed
						elseif cTemplate $ cTempleB2B .Or. UPPER(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_document_type:TEXT)) != "CPF"
							cArmPed:= "01"
							ZC6->ZC6_LOCAL := cArmPed
						else
							cArmPed:= "51"
							ZC6->ZC6_LOCAL := cArmPed
						EndIf
						
						ZC6->ZC6_TPPROD := "N"
						ZC6->(MsUnlock())
						nItem += 1
					Else
						//JR

						lPossuiKit := .T.

						For nXkit:= 1 to Len(OXML:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_KIT_ITEM)
							
							ZC6->(RecLock("ZC6",.T.))
							ZC6->ZC6_FILIAL:= xFilial("ZC6")
							ZC6->ZC6_NUM	:= val(oXml:_RECEIPTLIST:_RECEIPT[i]:_ORDER_ID:TEXT)
							ZC6->ZC6_ITEM	:= StrZero(nItem,2)
							ZC6->ZC6_PRODUT:= oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_KIT_ITEM[nXkit]:_PF_ID:TEXT
							ZC6->ZC6_QTDVEN:= val(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_KIT_ITEM[nXkit]:_QUANTITY:TEXT)
							ZC6->ZC6_VLRUNI:= Val(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_KIT_ITEM[nXkit]:_PRORATED_PRICE:TEXT)
							ZC6->ZC6_VLRTOT:= Val(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_KIT_ITEM[nXkit]:_PRORATED_PRICE:TEXT)*val(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_KIT_ITEM[nXkit]:_QUANTITY:TEXT)
													
							if (XmlNodeExist(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_RECEIPT_ITEM_WAREHOUSES:_WAREHOUSEINTEG,"_ERP_ID"))
								cArmPed:= SubStr( alltrim(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_RECEIPT_ITEM_WAREHOUSES:_WAREHOUSEINTEG:_ERP_ID:Text) , 5, 2)
								ZC6->ZC6_LOCAL := cArmPed
							elseif cTemplate $ cTempleB2B .Or. UPPER(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_document_type:TEXT)) != "CPF" 
								cArmPed:= "01"
								ZC6->ZC6_LOCAL := cArmPed
							else
								cArmPed:= "51"
								ZC6->ZC6_LOCAL := cArmPed
							EndIf
							
							if XmlNodeExist(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_KIT_ITEM[nXkit],UPPER("_receipt_item_id"))
								ZC6->ZC6_TPPROD := "K"
								ZC6->ZC6_KIT := oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_ITEM[nX]:_KIT_ITEM[nXkit]:_receipt_item_id:TEXT
							else
								ZC6->ZC6_TPPROD := "N"
								ZC6->ZC6_KIT := " "
							endif

							ZC6->(MsUnlock())
							nItem += 1
						Next nXkit

					EndIf

					
				Next nX
				
				nItem := 1

				ZC5->(Reclock("ZC5",.T.))
				
				ZC5->ZC5_FILIAL	:= xFilial("ZC5")
				ZC5->ZC5_NUM	:= val(oXml:_RECEIPTLIST:_RECEIPT[i]:_ORDER_ID:TEXT)
				ZC5->ZC5_CLIENT	:= iif(empty(_aCli[1])," ",_aCli[1])
				ZC5->ZC5_LOJA	:= iif(empty(_aCli[2])," ",_aCli[2])
				ZC5->ZC5_COND	:= AchaCond(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_COD_PG:TEXT)
				ZC5->ZC5_CODPAG := ALLTRIM(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_COD_PG:TEXT)
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
				
				//JR
				//Pedidos de vendas originados do CiaShop.
				//Utilizar "C" para B2C e "B" para B2B, basendo-se no template utilizado.
				IF cTemplate $ cTempleB2B  // ccriar um parametro para o template
					ZC5->ZC5_TPECOM := "B2B"
				ElseIf UPPER(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_document_type:TEXT)) != "CPF"
					ZC5->ZC5_TPECOM := "B2B"
				Else
					ZC5->ZC5_TPECOM := "B2C"
				EndIf
				
				if lPossuiKit
					ZC5->ZC5_KIT := "SIM"
				else
					ZC5->ZC5_KIT := "NรO"
				endif

				//Prj GET
				ZC5->ZC5_CODENT	:= U_V05CodEnt(ZC5->(Recno()),oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_SHIPPING_METHOD:TEXT,Upper(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_SHIP_TO_ADDRESS4:TEXT))
					

				if !empty(_aCli[1])
					ZC5->ZC5_CGC := _aCli[3]
					//ZC5->ZC5_CODENT:=	oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_DETAILS:_SHIPPING_METHOD:TEXT
					
					cMunic			:= AllTrim( Upper(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_SHIP_TO_ADDRESS2:TEXT))
					cMunic			:= StrTran(cMunic,"ร","A")
					cMunic			:= StrTran(cMunic,"ี","O")
					cMunic			:= StrTran(cMunic,"ว","C")
					cMunic			:= NoAcento(cMunic)
					
					DbSelectArea("SA1")
					SA1->(MsSeek(xFilial("SA1")+_aCli[1]+_aCli[2]))
				
					
					ZC5->ZC5_ENDENT	:= SA1->A1_END
					ZC5->ZC5_BAIROE	:= SA1->A1_BAIRRO
					ZC5->ZC5_CEPE	:= SA1->A1_CEP
					ZC5->ZC5_MUNE	:= SA1->A1_MUN
					ZC5->ZC5_CODMUE := SA1->A1_COD_MUN
					ZC5->ZC5_ESTE	:= SA1->A1_EST
					ZC5->ZC5_COMPLE	:= SA1->A1_COMPLEM
					ZC5->ZC5_FLAG 	:= '2'
					DbCloseArea("SA1")
					
				Else
					ZC5->ZC5_FLAG := '4'
				EndIf
				
				ZC5->(MsUnlock())
				
				
				END TRANSACTION
				IF !empty(_aCli[1])
					If SA1->A1_EST=="SP" .And. SA1->(AllTrim(A1_ENDENT)+AllTrim(A1_BAIRROE)+AllTrim(A1_CEPE)+AllTrim(A1_MUNE)+AllTrim(A1_ESTE))<>ZC5->(AllTrim(ZC5_ENDENT)+AllTrim(ZC5_COMPLE)+AllTrim(ZC5_BAIROE)+AllTrim(ZC5_CEPE)+AllTrim(ZC5_MUNE)+AllTrim(ZC5_ESTE)  )
						cBody:="<html>"
						cBody+="Pedido Site........:"+AllTrim(Str(ZC5->ZC5_NUM))+"<br>"
						cBody+="Cliente/Loja.......:"+SA1->A1_COD+'/'+SA1->A1_LOJA+Space(1)+SA1->A1_NOME+"<br>"
						cBody+="Endere็o Site.....:"+ZC5->(AllTrim(ZC5_ENDENT)+Space(1)+AllTrim(ZC5_COMPLE)+" Bairro:"+AllTrim(ZC5_BAIROE)+" CEP:"+AllTrim(ZC5_CEPE)+" Municipio:"+AllTrim(ZC5_MUNE)+" Estado:"+AllTrim(ZC5_ESTE)  )+"<br>"
						cBody+="Endere็o ERP....:"+SA1->(AllTrim(A1_ENDENT)+" Bairro:"+AllTrim(A1_BAIRROE)+" CEP:"+AllTrim(A1_CEPE)+" Munucipio:"+AllTrim(A1_MUNE)+" Estado:"+AllTrim(A1_ESTE))+"<br>"
						cBody+="</html>"
						
						U_MySndMail("Endere็o de Entrega Divergente", cBody,,cEmailTo )
					EndIf
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
Static Function AchaCli(oXml,cTemplate,_lIncl)
Local aAreaAtu	:= GetArea()
Local _aCli		:= {}
Local _cCli		:= ""
Local _cLoja	:= ""
Local _cQuery	:= ""
Local _cDoc		:= ""
Local cNPed		:= ""
Local cAliasQry:= GetNextAlias()
Local docCli := ""
Local docType := ""
Local docID := ""
Local _GrpCli := ""
Local _cCodMun := ""
Local _cMun
Local aVetor := {}
Local cErroAdiconal :=" "
Local aErro		:= {}
Local _cError	:= ""
Local aZA1_SA1	:= {}
Local cCGCCli := ""
Local lJaExist := .F.
Local cTempleB2B := U_MyNewSX6("NC_TMPB2B",;
"2",;
"C",;
"Define o Template pertencente ao B2B.",;
"Define o Template pertencente ao B2B.",;
"Define o Template pertencente ao B2B.",;
.F. )
Default _lIncl	:= .F.

_cQuery:=" SELECT A1_COD,A1_LOJA,A1_END,A1_CGC "
_cQuery+=" FROM "+RetSqlName("SA1")
_cQuery+=" WHERE A1_FILIAL='"+xFilial("SA1")+"'"
_cQuery+=" AND D_E_L_E_T_=' '"
_cQuery+=" AND A1_ZCODCIA='"+ oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_SHOPPER_ID:TEXT +"'"
_cQuery+=" AND a1_cgc = '"+oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_document_id:TEXT+"' "
_cQuery+=" ORDER BY A1_COD,A1_LOJA "

_cQuery := ChangeQuery(_cQuery)
dbUseArea(.T., "TOPCONN", TCGenQry(,,_cQuery), cAliasQry, .T., .F.)

(cAliasQry)->(DbGoTop())


if cTemplate $ cTempleB2B .And. alltrim((cAliasQry)->A1_COD) != ""
		aAdd(_aCli,(cAliasQry)->A1_COD)
		aAdd(_aCli,"01")
		aAdd(_aCli,(cAliasQry)->A1_CGC)
		(cAliasQry)->(dbCloseArea())
		RestArea(aAreaAtu)
		Return _aCli
elseif cTemplate $ cTempleB2B
		aAdd(_aCli,"")
		aAdd(_aCli,"")
		aAdd(_aCli,"")
		(cAliasQry)->(dbCloseArea())
		RestArea(aAreaAtu)
		Return _aCli
elseif !(cTemplate $ cTempleB2B) .And. strTran( (cAliasQry)->A1_END," ","") == strTran( upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_address1:TEXT)) +", "+upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_street_number:TEXT))," ","")
		aAdd(_aCli,(cAliasQry)->A1_COD)
		aAdd(_aCli,"01")
		aAdd(_aCli,(cAliasQry)->A1_CGC)
		(cAliasQry)->(dbCloseArea())
		RestArea(aAreaAtu)
		Return _aCli
endif

//Verifica se existe o cliente
IF alltrim((cAliasQry)->A1_COD) != ""
	
	_cDoc = (cAliasQry)->A1_COD	
	cCGCCli := (cAliasQry)->A1_CGC	
	(cAliasQry)->(dbCloseArea())
	lJaExist := .T.

endif
	
	if !lJaExist
		DbSelectArea("SA1")
		SA1->(DbSetOrder(1))
		SA1->(DbGoTop())
		_cDoc := GETSXENUM("SA1","A1_COD")
		Do While SA1->(DbSeek(xFilial("SA1") +_cDoc+"01" ))
			ConfirmSX8()
			_cDoc := GETSXENUM("SA1","A1_COD")
		EndDo
		DbCloseArea("SA1")
	endif

	docCli 	:= iif( XmlNodeExist(oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing, "_document_type") , oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_document_type:TEXT, " ") 
	docType := iif( XmlNodeExist(oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing, "_regional_document_type"),  oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_regional_document_type:TEXT, " ") 
	docID 	:= iif( XmlNodeExist(oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing, "_regional_document_id"), oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_regional_document_id:TEXT, " ") 
	_cMun 	:= NoAcento(Padr( upper(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_SHIP_TO_ADDRESS2:TEXT), AvSx3("CC2_MUN",3) ))
	cNPed	:= iif( XmlNodeExist(oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing, "_ORDER_ID"), oXml:_RECEIPTLIST:_RECEIPT[i]:_ORDER_ID:TEXT, " ") 
	cCGCCli := iif( XmlNodeExist(oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing, "_document_id"), oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_document_id:TEXT, " ") 
	
	DbSelectArea("CC2")
	CC2->(DBSETORDER(2)) //CC2_FILIAL+CC2_MUN
	CC2->(DbGoTop())
	If CC2->(DbSeek(xFilial("CC2")+_cMun))
		Do While CC2->(!Eof()) .And.  CC2->CC2_MUN==_cMun
			If CC2->CC2_EST==oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_address3:TEXT
				_cCodMun	:= CC2->CC2_CODMUN
			EndIf
			CC2->(DbSkip())
		EndDo
	Else
		cErroAdiconal:="Codigo Municipio nใo encontrado para o Municipio "+_cMun
	EndIf
	DbCloseArea("CC2")
	
	AADD(aVetor,{"A1_FILIAL", xFilial("SA1") ,Nil})
	AADD(aVetor,{"A1_COD", _cDoc,Nil})
	AADD(aVetor,{"A1_LOJA", "01",Nil})
	AADD(aVetor,{"A1_PESSOA", IIF(UPPER(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_document_type:TEXT)) = "CPF","F","J"),Nil})
	AADD(aVetor,{"A1_NOME",  upper( NoAcento( oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_name:TEXT)),Nil})
	AADD(aVetor,{"A1_NREDUZ",upper( NoAcento( oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_name:TEXT)),Nil})
	AADD(aVetor,{"A1_END", upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_address1:TEXT)) +", "+upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_street_number:TEXT)),Nil})
	AADD(aVetor,{"A1_COMPLEM",iif(XmlNodeExist(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER,"_ship_to_street_compl"), upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_street_compl:TEXT ))," ") + "- Ref.:" + iif(XmlNodeExist(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER,"_REFERENCE"),upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_reference:TEXT ))," ") ,Nil})
	AADD(aVetor,{"A1_TIPO", IIF( upper(docCli) == "CPF", "F","S"),Nil})
	AADD(aVetor,{"A1_EST", upper(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_address3:TEXT),Nil})
	AADD(aVetor,{"A1_NATUREZ", "19101",Nil})
	AADD(aVetor,{"A1_COD_MUN", _cCodMun,Nil})
	AADD(aVetor,{"A1_MUN", Upper(NoAcento(_cMun)),Nil})
	AADD(aVetor,{"A1_BAIRRO", upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_district:TEXT)),Nil})
	AADD(aVetor,{"A1_CEP", oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_address4:TEXT,Nil})
	AADD(aVetor,{"A1_DDD", oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_ddd_phone:TEXT,Nil})
	AADD(aVetor,{"A1_TEL", oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_phone:TEXT,Nil})
	AADD(aVetor,{"A1_ENDCOB", upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_address1:TEXT)),Nil})
	AADD(aVetor,{"A1_BAIRROC", upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_district:TEXT)),Nil})
	AADD(aVetor,{"A1_CEPC", oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_zip_code:TEXT,Nil})
	AADD(aVetor,{"A1_MUNC", upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_city:TEXT)),Nil})
	AADD(aVetor,{"A1_ESTC", upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_address3:TEXT)),Nil})
	AADD(aVetor,{"A1_ENDENT", upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_address1:TEXT)),Nil})
	AADD(aVetor,{"A1_BAIRROE", upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_district:TEXT)),Nil})
	AADD(aVetor,{"A1_CEPE", oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_zip_code:TEXT,Nil})
	AADD(aVetor,{"A1_MUNE", upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_city:TEXT)),Nil})
	AADD(aVetor,{"A1_X_LOCZ", "C",Nil})
	AADD(aVetor,{"A1_ESTE", upper(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_address3:TEXT)),Nil})
	AADD(aVetor,{"A1_CGC", oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_document_id:TEXT,Nil})
	AADD(aVetor,{"A1_INSCR", iif( upper(docType) == "RG","ISENTO",docID),Nil})
	AADD(aVetor,{"A1_PFISICA", iif( upper(docType) == "RG" ,docID," "),Nil})
	AADD(aVetor,{"A1_VEND", iif(cTemplate == "2", "VN9901","VN9902"),Nil})
	AADD(aVetor,{"A1_CONTA", "11201010001",Nil})
	AADD(aVetor,{"A1_TRANSP", "000002",Nil})
	AADD(aVetor,{"A1_TPFRET", "C",Nil})
	AADD(aVetor,{"A1_GRPTRIB", iif(upper(docCli) == "CPF","CFS",iif(upper(docType) == "RG","CFI","SOL")),Nil})
	AADD(aVetor,{"A1_SATIV1", "000037",Nil})
	AADD(aVetor,{"A1_GRPVEN", "990000",Nil})
AADD(aVetor,{"A1_CODPAIS", "01058",Nil})
	AADD(aVetor,{"A1_FRETE", "1",Nil})
	AADD(aVetor,{"A1_TEMODAL", "2",Nil})
	AADD(aVetor,{"A1_YCANAL", iif(cTemplate=="2","990000","990001") ,Nil})
	AADD(aVetor,{"A1_XGRPCOM", "ECOMME",Nil})
	AADD(aVetor,{"A1_CONTRIB", iif( upper(docType) == "RG","2","1")	,Nil})
	AADD(aVetor,{"A1_RISCO" , 'E',Nil})
	AADD(aVetor,{"A1_DTNASC" , msdate(),Nil})
	if cTemplate $ cTempleB2B
		AADD(aVetor,{"A1_TABELA", iif(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_address3:TEXT=="SP","018",IIf(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_address3:TEXT$"RJ;RS;SC;PR;MG","112","107")),Nil})
	else
		AADD(aVetor,{"A1_TABELA", "CON",Nil})
	EndIf
	
	AADD(aVetor,{"A1_COND", "WEB",Nil})
	AADD(aVetor,{"A1_XSORTER", "1",Nil})
	AADD(aVetor,{"A1_AGEND", "2",Nil})
	AADD(aVetor,{"A1_OPER", " ",Nil})
	AADD(aVetor,{"A1_ZSEXO", iif( oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_gender:TEXT == "Male","M","F"),Nil})
	AADD(aVetor,{"A1_ZESTCIV", " ",Nil})
	AADD(aVetor,{"A1_EMAIL", oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_email:Text,Nil})

	if cTemplate$cTempleB2B .And. lJaExist
		AADD(aVetor,{"A1_MSBLQL", "2",Nil})
	elseif cTemplate$cTempleB2B .And. !lJaExist
		AADD(aVetor,{"A1_MSBLQL", "1",Nil})
	elseif UPPER(NoAcento(oXml:_RECEIPTLIST:_RECEIPT[i]:_receipt_billing:_document_type:TEXT)) == "CPF"
		AADD(aVetor,{"A1_MSBLQL", "2",Nil})
	else
		AADD(aVetor,{"A1_MSBLQL", "1",Nil})
	endif

	
	AADD(aVetor,{"A1_ZCODCIA", val(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_SHOPPER_ID:TEXT),Nil})
	AADD(aVetor,{"A1_REGIAO", U_AchaReg(oXml:_RECEIPTLIST:_RECEIPT[i]:_RECEIPT_SHOPPER:_ship_to_address3:TEXT),Nil})
		
	
	if u_CriaCli(aVetor,cNPed, lJaExist)
		aAdd(_aCli,_cDoc)
		aAdd(_aCli,"01")
		aAdd(_aCli,cCGCCli)
	else
		aAdd(_aCli,"")
		aAdd(_aCli,"")
		aAdd(_aCli,"")
	EndIf
	
	


RestArea(aAreaAtu)
Return _aCli


static FUNCTION NoAcento(cString)
Local cChar  := ""
Local nX     := 0
Local nY     := 0
Local cVogal := "aeiouAEIOU"
Local cAgudo := "แ้ํ๓๚"+"มษอำฺ"
Local cCircu := "โ๊๎๔๛"+"ยสฮิÛ"
Local cTrema := "ไ๋๏๖ü"+"ฤหฯึÜ"
Local cCrase := "เ่์๒๙"+"ภศฬาู"
Local cTio   := "ใ๕รี"
Local cCecid := "็ว"
Local cMaior := "&lt;"
Local cMenor := "&gt;"
Local cSimbolo:=Chr(39)

For nX:= 1 To Len(cString)
	cChar:=SubStr(cString, nX, 1)
	IF cChar$cAgudo+cCircu+cTrema+cCecid+cTio+cCrase
		nY:= At(cChar,cAgudo)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cCircu)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cTrema)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cCrase)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cTio)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr("aoAO",nY,1))
		EndIf
		nY:= At(cChar,cCecid)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr("cC",nY,1))
		EndIf
	Endif
Next

If cMaior$ cString
	cString := strTran( cString, cMaior, "" )
EndIf
If cMenor$ cString
	cString := strTran( cString, cMenor, "" )
EndIf

If cSimbolo$ cString
	cString := strTran( cString, cSimbolo, "" )
EndIf


For nX:=1 To Len(cString)
	cChar:=SubStr(cString, nX, 1)
	If (Asc(cChar) < 32 .Or. Asc(cChar) > 123) .and. !cChar $ '|'
		cString:=StrTran(cString,cChar,".")
	Endif
Next nX
cString:=upper(cString)
Return cString

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
ElseIf _cCond$"024/084"
	_cRet:="BOL"
ElseIf _cCond$"075/076/077/078/079"
	_cRet:="CC"
ElseIf  _cCond$"054"
	_cRet:="FAT"
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


cQuery:=" Select ZC5_ENDENT,ZC5_BAIROE,ZC5_CEPE,ZC5_MUNE,ZC5_ESTE,ZC5_COMPLE,ZC5_CODMUE,ZC5_CLIENT,ZC5_LOJA,ZC5_PVVTEX,ZC5_TPECOM"+CRLF
cQuery+=" From "+RetSqlName("ZC5")+" ZC5"
cQuery+=" Where ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"'"+CRLF
cQuery+=" And ZC5.ZC5_NUMPV='"+cNumPV+"'"+CRLF
cQuery+=" And ZC5.ZC5_ESTORN<>'S'"+CRLF
cQuery+=" And ZC5.ZC5_STATUS Not In "+FormatIn(cNotImp,",")+CRLF
cQuery+=" And ZC5.D_E_L_E_T_=' '"+CRLF
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)

If !(clAlias)->(Eof() .And. Bof()) .And. SA1->(MsSeek(xFilial("SA1")+(clAlias)->(ZC5_CLIENT+ZC5_LOJA) ))
	
	//JR
	If Empty( (clAlias)->ZC5_PVVTEX )
		lContinuar:= ( SA1->A1_EST=="SP" ) .and. ((clAlias)->ZC5_PVVTEX == "B2B")
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

User Function reprPedido(cPedido)
Local aArea := GetArea()
Local aDadaCli := {}
Local cCGC := ""
Local cQuery := ""
Local cAliasQry := GetNextAlias()

DbSelectArea("ZA1")
ZA1->(DbSetOrder(1))
If ZA1->(MsSeek(xFilial("ZA1")+padr(cPedido,AvSx3("ZA1_PVVTEX",3) )))
	cCGC := ZA1->ZA1_CGC
endif
ZA1->(DbCloseArea())

_cQuery:=" SELECT * "
_cQuery+=" FROM "+RetSqlName("SA1")
_cQuery+=" WHERE A1_FILIAL='"+xFilial("SA1")+"'"
_cQuery+=" AND D_E_L_E_T_=' '"
_cQuery+=" AND a1_cgc = '"+ cCGC +"' "
_cQuery+=" ORDER BY A1_COD,A1_LOJA "

dbUseArea(.T., "TOPCONN", TCGenQry(,,_cQuery), cAliasQry, .T., .F.)

DbSelectArea("ZC5")
ZC5->(DBSETORDER(1))

If ZC5->(MsSeek(xFilial("ZC5")+STR(cPedido,6,0))) .AND. ALLTRIM((cAliasQry)->A1_COD) != ""


	if ZC5->(Reclock("ZC5",.F.)) .And. ALLTRIM(ZC5->ZC5_ENDENT) == "" .AND. alltrim(ZC5->ZC5_NUMPV) == ""
		ZC5->ZC5_CLIENT	:= ALLTRIM((cAliasQry)->A1_COD)
		ZC5->ZC5_LOJA	:= ALLTRIM((cAliasQry)->A1_LOJA)
		ZC5->ZC5_PLATAF	:= '01'
		ZC5->ZC5_ATUALI	:= "S"
		ZC5->ZC5_ENDENT	:= (cAliasQry)->A1_END
		ZC5->ZC5_BAIROE	:= (cAliasQry)->A1_BAIRRO
		ZC5->ZC5_CEPE	:= (cAliasQry)->A1_CEP
		ZC5->ZC5_MUNE	:= (cAliasQry)->A1_MUN
		ZC5->ZC5_CODMUE := (cAliasQry)->A1_COD_MUN
		ZC5->ZC5_ESTE	:= (cAliasQry)->A1_EST
		ZC5->ZC5_COMPLE	:= (cAliasQry)->A1_COMPLEM
		ZC5->ZC5_FLAG 	:= '2'
		ZC5->(MsUnlock())
	elseif alltrim(ZC5->ZC5_NUMPV) != ""
		Msginfo("O pedido de venda jแ foi gravado! Nใo ้ possํvel reprocessar um pedido que jแ tenha Pv Protheus! ")
	elseif ALLTRIM(ZC5->ZC5_ENDENT) != ""
		Msginfo("Informa็๕es de entrega jแ informadas no Pedido.")
	endif
EndIf

ZC5->(DbCloseArea())
(cAliasQry)->(DbCloseArea())

RestArea(aArea)
Return