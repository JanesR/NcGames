#include 'protheus.ch'
#include 'parmtype.ch'
#include 'fwmvcdef.ch'


User Function NCGPR138(cNumPV)

	Local oTracking := Tracking_Vendedor():New()
	
	If !Empty(cNumPV)
		oTracking:MontaTela(cNumPV)
	Else
		Alert("Este pedido não possui pedido Protheus, por este motivo não será possivel emitir e tracking!")
	EndIf
	
return nil


CLASS Tracking_Vendedor
	
	Data aAreaAtu
	Data oHtml
	Data cHtml
	Data cPathTemp
	Data cNomeArq
	Data cPath
	Data cQuery
	Data aArea
	Data cPedido
	
	Method New() Constructor
	Method MontaTela()
	Method MontaHtml()
	Method MontaExecutaQuery()
	Method retornaDataFormatada(dData)
	
EndClass


Method New(cNumPV) Class Tracking_Vendedor
	
	Self:cHtml		:="Tracking_Vendedor.html"
	Self:cNomeArq 	:= CriaTrab(,.f.) + ".htm"
	Self:cPathTemp 	:= GETTEMPPATH()
	Self:aAreaAtu	:= GetNextAlias()
	Self:cPath		:= "\workflow\tracking_vendedor\"
	Self:oHtml		:=TWFHTML():New(Alltrim(Self:cPath) + Alltrim(Self:cHtml))
	Self:aArea	:=GetArea()
		
Return

Method MontaTela(cNumPV) Class Tracking_Vendedor
	
	Local cNomeHtml;
	//DEFAULT cNumPV:= SC5->C5_NUM
	If !Empty(cNumPV)
	Self:cPedido := cNumPV
	EndIf
	
	Self:MontaHtml()
	
		Self:cNomeArq := Alltrim(Self:cPath) + Self:cNomeArq
		Self:cNomeArq := StrTran(Self:cNomeArq,'\\','\')
		Self:oHtml:SaveFile( Alltrim(Self:cNomeArq) )	// Grava o HTML temporario
		
		cNomeHtml:="PV"+SC5->C5_NUM+StrTran(Time(),":","")+Dtos(Date())
		
		If __CopyFile(Self:cNomeArq,Self:cPathTemp+cNomeHtml)
			Define MsDialog oDlg Title "Tracking Vendedor:"+SC5->C5_NUM FROM oMainWnd:nTop,oMainWnd:nLeft TO oMainWnd:nBottom,oMainWnd:nRight*0.98 Of oMainWnd PIXEL
			nWidth:= oDlg:nWidth/2
			nHeight:=(oDlg:nHeight/2)-10
			
			
			oTIBrowser:= TIBrowser():New(0,0,nWidth,nHeight,Self:cPathTemp+cNomeHtml,oDlg)
			//oTIBrowser:= TIBrowser():New(0,0,oDlg:nWidth,oDlg:nHeight,cPathTemp+cNomeHtml,oDlg )
			
			tButton():New(10,10	,  "Fechar"  	,oDlg,{|| oDlg:End()	},32,12,,,,.T.)
			
			ACTIVATE MSDIALOG oDlg CENTERED
		Else
			MsgStop("Ocorreu um erro ao gravar o arquivo.Contate o administrador do sistema")
		EndIf

Ferase(Self:cNomeArq)
RestArea(Self:aArea)

Return

Method MontaHtml() Class Tracking_Vendedor

Local cC9 		:= RetSQLName("SC9")
Local cA1		:= RetSQLName("SA1")
Local cC5		:= RetSQLName("SC5")
Local cC6		:= RetSQLName("SC6")
Local cFil		:= xFilial("SC5")
Local cF2		:= RetSQLName("SF2")
Local cP0b		:= RetSQLName("P0B")
Local cZ1		:= RetSQLName("SZ1")
Local cP0g		:= RetSQLName("P0G")

Local cBolCome	:= "https://www.ncgames.com.br/Assets/Uploads/Protheus_nao_mexer/Ras01.png"
Local cLinCome  := "https://www.ncgames.com.br/Assets/Uploads/Protheus_nao_mexer/Ras02.png"
Local cBolOk	:= "https://www.ncgames.com.br/Assets/Uploads/Protheus_nao_mexer/Ras03.png"
Local cLinOk	:= "https://www.ncgames.com.br/Assets/Uploads/Protheus_nao_mexer/Ras04.png"
Local cBolProx	:= "https://www.ncgames.com.br/Assets/Uploads/Protheus_nao_mexer/Ras09.png"
Local cLinProx	:= "https://www.ncgames.com.br/Assets/Uploads/Protheus_nao_mexer/Ras10.png"
Local cBolCance := "https://www.ncgames.com.br/Assets/Uploads/Protheus_nao_mexer/Ras07.png"
Local cLinCance := "https://www.ncgames.com.br/Assets/Uploads/Protheus_nao_mexer/Ras08.png"

Local aStatMarge :={'SUJEITO A APROVAÇÃO', 'PEDIDO LIBERADO NA MARGEM', 'MARGEM APROVADA', 'MARGEM REJEITADA', 'PENDENTE DE APROVAÇÃO DE MARGEM', 'EM PROCESSO DE APROVAÇÃO DE MARGEM'}
Local aStatCred  := {'LIBERADO NO CREDITO', 'REJEITADO NO CREDITO', 'PENDENTE DE APROVAÇÃO'}
Local aStatOpe	 := {'EM OPERACAO', 'FATURADO', 'PEDIDO AINDA NÃO ESTA EM WMS'}
Local aStatAdm	 := {'SIM', 'NÃO'}
Local aStatEntre := {'FATURADO - AGUARDANDO DATA DE AGENDAMENTO', 'FATURADO - AGENDADO', 'FATURADO - EXPEDIDO', 'FATURADO - ENTREGUE'}
Local aStatWMS	 := {'CONFERENCIA FINALIZADA','CONFERENCIA INICIADA','DISPONIVEL PARA CONFERENCIA','SEPARAÇÃO INICIADA','DISPONIVEL PARA SEPARAÇÃO',"CANCELADO NO WMS"}

Local cLinkRas  := superGetMv("EC_NCG0021",,"http://websro.correios.com.br/sro_bin/txect01$.QueryList?P_LINGUA=001&P_TIPO=001&P_COD_UNI=")
Local cLinkDir  := superGetMv("EC_NCG0025",,"https://www.directlog.com.br/tracking/index.asp?cod=28011&tipo=1&valor=")

Local cTransp

Local cHtml

//Processa({|| Self:MontaExecutaQuery()})
MsgRun("Processando os dados...","Processando",{|| Self:MontaExecutaQuery()})
	
	While (Self:aAreaAtu)->(!EOF())
		
		Self:oHtml:ValByName("cPedido",(Self:aAreaAtu)->(PEDIDO))
		
	If Val((Self:aAreaAtu)->(C5SF)) < 10 .Or. AllTrim((Self:aAreaAtu)->(CONDPAG)) == "000"
	
		Self:oHtml:ValByName("cTipoPedido","OUTRAS REMESSAS(RMA, MARKETING, ETC...)")
	
		Self:oHtml:ValByName("cNomeCliente",(Self:aAreaAtu)->(NOMECLI))
		Self:oHtml:ValByName("cCliente",(Self:aAreaAtu)->(CODCLI))
		Self:oHtml:ValByName("cLoja",(Self:aAreaAtu)->(LOJACLI))
		Self:oHtml:ValByName("cEndereco",(Self:aAreaAtu)->(ENDERECO))
		Self:oHtml:ValByName("cComplemento",(Self:aAreaAtu)->(COMPLE))
		Self:oHtml:ValByName("cMunicipio",(Self:aAreaAtu)->(MUNICIPIO))
		Self:oHtml:ValByName("cEstado",(Self:aAreaAtu)->(ESTADO))
		Self:oHtml:ValByName("dEmissao",Self:retornaDataFormatada((Self:aAreaAtu)->(EMISSAO)))
		
			Self:oHtml:ValByName("bImgPedido",cBolCome)
			Self:oHtml:ValByName("lImgPedido",cLinCome)
		SA3->(DbSelectArea("SA3"))
		SA3->(DbSetOrder(1))
		
		If SA3->(DbSeek(xFilial("SA3")+(Self:aAreaAtu)->(VENDEDOR)))
			Self:oHtml:ValByName("cVendedor",SA3->A3_NOME)
		Else
			Self:oHtml:ValByName("cVendedor",(Self:aAreaAtu)->(VENDEDOR))
		EndIf
		
		Self:oHtml:ValByName("fValDig",TRANSFORM(Round((Self:aAreaAtu)->(VDIGITADO),2),"@R 999,999.99"))
		
		If (Self:aAreaAtu)->(FATURADO) == 0
			Self:oHtml:ValByName("fFaturado"," ")
		Else
			Self:oHtml:ValByName("fFaturado",TRANSFORM(Round((Self:aAreaAtu)->(FATURADO),2),"@R 999,999.99"))
		EndIf
		
		
		
		//Tratativa no status das imagens  da liberação da margem						
		
			Self:oHtml:ValByName("bImgMargem",cBolCome)
			Self:oHtml:ValByName("lImgMargem",cLinCome)
						
		//Tratativa no status das imagens do pedido em operação	
			Self:oHtml:ValByName("bImgOperacao",cBolCome)			
			Self:oHtml:ValByName("lImgOperacao",cLinCome)
			
		
		//Tratativa no status das imagens  da liberação do crédito			
			Self:oHtml:ValByName("bImgAnalise",cBolCome)
			Self:oHtml:ValByName("lImgAnalise",cLinCome)

		//Tratativa no status das imagens  da liberação do adm			
			Self:oHtml:ValByName("bImgAdmVenda",cBolCome)
			Self:oHtml:ValByName("lImgAdmVenda",cLinCome)
		
		//Tratativa no status das imagens da entrega
			Self:oHtml:ValByName("bImgEntrega",cBolCome)
						
		Self:oHtml:ValByName("nQtdVendido",(Self:aAreaAtu)->(VENDIDO))
	
		ACA->(DbSelectArea("ACA"))
		ACA->(DbSetOrder(1))
		
		If ACA->(DbSeek(xFilial("ACA")+(Self:aAreaAtu)->(CANAL)))
			Self:oHtml:ValByName("cCanal",ACA->ACA_DESCRI)
		Else
			Self:oHtml:ValByName("cCanal",(Self:aAreaAtu)->(CANAL))
		EndIF
		
		
		SA4->(DbSelectArea("SA4"))
		SA4->(DbSetOrder(1))
		
		IF !Empty(AllTrim((Self:aAreaAtu)->(F2TRANSP)))
			
			SA4->(DbSeek(xFilial("SA4") + AllTrim((Self:aAreaAtu)->(F2TRANSP))))
			
			cTransp := SA4->A4_NOME 
		Else
			
			SA4->(DbSeek(xFilial("SA4") + AllTrim((Self:aAreaAtu)->(C5TRANSP))))			
			cTransp := SA4->A4_NOME 
		EndIf
		
			If (Self:aAreaAtu)->(WMS)== aStatWMS[6]
				Self:oHtml:ValByName("bImgOperacao",cBolCance)				
			EndIf
			
		//Tratativa no status das imagens da entrega
		If	AllTrim((Self:aAreaAtu)->(ENTREGA)) == aStatEntre[4]
			Self:oHtml:ValByName("bImgEntrega",cBoloK)
			
		ElseIf Empty(AllTrim((Self:aAreaAtu)->(ENTREGA)))
			Self:oHtml:ValByName("bImgEntrega",cBolCome)	
								
		Else
			Self:oHtml:ValByName("bImgEntrega",cBolProx)
			
		End IF
		
		/*Acrescentar a data de entrega*/
		If AllTrim((Self:aAreaAtu)->(ENTREGA)) == aStatEntre[4]
			Self:oHtml:ValByName("cStatEntre",AllTrim((Self:aAreaAtu)->(ENTREGA))+" - DATA DE ENTREGA: "+Self:retornaDataFormatada((Self:aAreaAtu)->(DTENTRE)))
		Else
			Self:oHtml:ValByName("cStatEntre",(Self:aAreaAtu)->(ENTREGA))
		EndIf
		
		If 	!Empty(AllTrim((Self:aAreaAtu)->(RASTRO)))
			If Len(AllTrim((Self:aAreaAtu)->(RASTRO))) == 13
				cHtml := '<td  bgcolor="#E8E8E8" ><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;" >TRANSPORTADORA</span></td>'
				If !Empty((Self:aAreaAtu)->(DTSAIDA))
					cHtml += '<td  bgcolor="#FFFFFF">'+ cTransp+" - DATA DE SAIDA: "+ Self:retornaDataFormatada((Self:aAreaAtu)->(DTSAIDA)) +'</td>'
				Else
					cHtml += '<td  bgcolor="#FFFFFF">'+ cTransp+'</td>'
				EndIf
                
				cHtml += '<td  bgcolor="#E8E8E8"><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;" >RASTREIO</span></td>'
                cHtml += '<td  bgcolor="#FFFFFF">'+ '<a href="'+cLinkRas+AllTrim((Self:aAreaAtu)->(RASTRO))+'">'+AllTrim((Self:aAreaAtu)->(RASTRO))+'</a>' +'</td>'
				Self:oHtml:ValByName("cDadosTran",cHtml)
			ElseIf Len(AllTrim((Self:aAreaAtu)->(RASTRO))) == 14
				cHtml := '<td  bgcolor="#E8E8E8" ><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;" >TRANSPORTADORA</span></td>'
				If !Empty((Self:aAreaAtu)->(DTSAIDA))
					cHtml += '<td  bgcolor="#FFFFFF">'+ cTransp+" - DATA DE SAIDA: "+ Self:retornaDataFormatada((Self:aAreaAtu)->(DTSAIDA)) +'</td>'
				Else
					cHtml += '<td  bgcolor="#FFFFFF">'+ cTransp+'</td>'
				EndIf
				cHtml += '<td  bgcolor="#E8E8E8"><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;" >RASTREIO</span></td>'
                cHtml += '<td  bgcolor="#FFFFFF">'+ '<a href="'+cLinkDir+AllTrim((Self:aAreaAtu)->(RASTRO))+'" target="_blank">'+AllTrim((Self:aAreaAtu)->(RASTRO))+'</a>' +'</td>'
				Self:oHtml:ValByName("cDadosTran",cHtml)
			EndIf
		Else
			If !Empty(AllTrim(cTransp))
			 	If AllTrim(cTransp) != "CORREIOS" && AllTrim(cTransp) != "SEDEX" && AllTrim(cTransp) != "PAC" && AllTrim(cTransp) != "E-SEDEX"
			 		cHtml := '<td  bgcolor="#E8E8E8" ><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;" >TRANSPORTADORA</span></td>'
	                If !Empty((Self:aAreaAtu)->(DTSAIDA))
						cHtml += '<td  bgcolor="#FFFFFF">'+ cTransp+" - DATA DE SAIDA: "+ Self:retornaDataFormatada((Self:aAreaAtu)->(DTSAIDA)) +'</td>'
					Else
						cHtml += '<td  bgcolor="#FFFFFF">'+ cTransp+'</td>'
					EndIf
					cHtml += '<td  bgcolor="#E8E8E8"><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;" >RASTREIO</span></td>'
					cHtml += '<td  bgcolor="#FFFFFF">NÃO POSSUI</td>'
					Self:oHtml:ValByName("cDadosTran",cHtml)
			 	EndIf
			EndIf
		EndIf
		
		SA4->(DbCloseArea("SA4"))
		ACA->(DbCloseArea("ACA"))
		SA3->(DbCloseArea("SA3"))
	Else
	
		Self:oHtml:ValByName("cTipoPedido","PEDIDO DE VENDA")
		
		If Val((Self:aAreaAtu)->(C5SF))>= 10  .And. AllTrim((Self:aAreaAtu)->(LIBMARGEM)) == aStatMarge[1]
			Self:oHtml:ValByName("bImgPedido",cBolProx)
			Self:oHtml:ValByName("lImgPedido",cLinProx)
			
		ElseIf Val((Self:aAreaAtu)->(C5SF))>= 10  .And.  AllTrim((Self:aAreaAtu)->(LIBMARGEM)) <> aStatMarge[1] .And. !Empty(AllTrim((Self:aAreaAtu)->(LIBMARGEM)))
			Self:oHtml:ValByName("bImgPedido",cBolOk)
			Self:oHtml:ValByName("lImgPedido",cLinOk)

		EndIF
				
		Self:oHtml:ValByName("dEmissao", Self:retornaDataFormatada((Self:aAreaAtu)->(EMISSAO)))	
			
		Self:oHtml:ValByName("cNomeCliente",(Self:aAreaAtu)->(NOMECLI))
		Self:oHtml:ValByName("cCliente",(Self:aAreaAtu)->(CODCLI))
		Self:oHtml:ValByName("cLoja",(Self:aAreaAtu)->(LOJACLI))
		Self:oHtml:ValByName("cEndereco",(Self:aAreaAtu)->(ENDERECO))
		Self:oHtml:ValByName("cComplemento",(Self:aAreaAtu)->(COMPLE))
		Self:oHtml:ValByName("cMunicipio",(Self:aAreaAtu)->(MUNICIPIO))
		Self:oHtml:ValByName("cEstado",(Self:aAreaAtu)->(ESTADO))
		
		SA3->(DbSelectArea("SA3"))
		SA3->(DbSetOrder(1))
		
		If SA3->(DbSeek(xFilial("SA3")+(Self:aAreaAtu)->(VENDEDOR)))
			Self:oHtml:ValByName("cVendedor",SA3->A3_NOME)
		Else
			Self:oHtml:ValByName("cVendedor",(Self:aAreaAtu)->(VENDEDOR))
		EndIf
		
		Self:oHtml:ValByName("fValDig",TRANSFORM(Round((Self:aAreaAtu)->(VDIGITADO),2),"@R 999,999.99"))
		
		If (Self:aAreaAtu)->(FATURADO) == 0
			Self:oHtml:ValByName("fFaturado"," ")
		Else
		Self:oHtml:ValByName("fFaturado",TRANSFORM(Round((Self:aAreaAtu)->(FATURADO),2),"@R 999,999.99"))
		EndIf
		
		
		//Tratativa no status das imagens  da liberação da margem						
		If Empty(AllTrim((Self:aAreaAtu)->(LIBMARGEM))) .Or. AllTrim((Self:aAreaAtu)->(LIBMARGEM)) == aStatMarge[1]	
			Self:oHtml:ValByName("bImgMargem",cBolCome)
			Self:oHtml:ValByName("lImgMargem",cLinCome)
			Self:oHtml:ValByName("cAprovMargem",(Self:aAreaAtu)->(LIBMARGEM) )						
		//ElseIf (AllTrim((Self:aAreaAtu)->(LIBMARGEM)) == aStatMarge[3]	.Or. AllTrim((Self:aAreaAtu)->(LIBMARGEM)) == aStatMarge[2])	.And. ((Self:aAreaAtu)->(C5SF)== '10' .Or. (Self:aAreaAtu)->(C5SF)== '15')
		ElseIf AllTrim((Self:aAreaAtu)->(LIBMARGEM)) == aStatMarge[3]	.Or. AllTrim((Self:aAreaAtu)->(LIBMARGEM)) == aStatMarge[2]
			Self:oHtml:ValByName("bImgMargem",cBolOk)
			Self:oHtml:ValByName("lImgMargem",cLinOk)
			Self:oHtml:ValByName("cAprovMargem",(Self:aAreaAtu)->(LIBMARGEM))		
		
		ElseIf AllTrim((Self:aAreaAtu)->(LIBMARGEM)) ==aStatMarge[4]
			Self:oHtml:ValByName("bImgMargem",cBolCance)
			//Self:oHtml:ValByName("lImgMargem",cLinCance)
			Self:oHtml:ValByName("cAprovMargem",(Self:aAreaAtu)->(LIBMARGEM))	
			
		Else
			Self:oHtml:ValByName("bImgMargem",cBolProx)
			Self:oHtml:ValByName("lImgMargem",cLinProx)
			Self:oHtml:ValByName("cAprovMargem",(Self:aAreaAtu)->(LIBMARGEM))
		EndIf
		
		
		//Tratativa no status das imagens do pedido em operação	
		If Empty(AllTrim((Self:aAreaAtu)->(OPERACAO)))
			Self:oHtml:ValByName("bImgOperacao",cBolCome)			
			Self:oHtml:ValByName("lImgOperacao",cLinCome)
			
		ElseIf AllTrim((Self:aAreaAtu)->(OPERACAO)) == aStatOpe[2]
			Self:oHtml:ValByName("bImgOperacao",cBolOk)			
			Self:oHtml:ValByName("lImgOperacao",cLinOk)
					
		Else
			Self:oHtml:ValByName("bImgOperacao",cBolProx)			
			Self:oHtml:ValByName("lImgOperacao",cLinProx)		
		EndIf
		
		//Tratativa no status das imagens  da liberação do crédito			
		If AllTrim((Self:aAreaAtu)->(LIBCREDITO)) == aStatCred[2]
			Self:oHtml:ValByName("bImgAnalise",cBolCance)
			//Self:oHtml:ValByName("lImgAnalise",cLinCance)		
		ElseIf AllTrim((Self:aAreaAtu)->(LIBCREDITO)) == aStatCred[3]
			Self:oHtml:ValByName("bImgAnalise",cBolProx)
			Self:oHtml:ValByName("lImgAnalise",cLinProx)
		ElseIf AllTrim((Self:aAreaAtu)->(LIBADM)) == aStatAdm[1] .And. Empty(AllTrim((Self:aAreaAtu)->(LIBCREDITO))) .Or. Empty(AllTrim((Self:aAreaAtu)->(LIBCREDITO)))  .And. !Empty(AllTrim((Self:aAreaAtu)->(OPERACAO))) .Or. AllTrim((Self:aAreaAtu)->(LIBCREDITO)) == aStatCred[1]
			Self:oHtml:ValByName("bImgAnalise",cBolOk)
			Self:oHtml:ValByName("lImgAnalise",cLinOK)
		ElseIf Empty(AllTrim((Self:aAreaAtu)->(LIBCREDITO)))
			Self:oHtml:ValByName("bImgAnalise",cBolCome)
			Self:oHtml:ValByName("lImgAnalise",cLinCome)
		
		EndIF		
		Self:oHtml:ValByName("cLibCred",(Self:aAreaAtu)->(LIBCREDITO))
		
		//Tratativa no status das imagens  da liberação do adm			
		If AllTrim((Self:aAreaAtu)->(LIBADM)) == aStatAdm[1]
			Self:oHtml:ValByName("bImgAdmVenda",cBoloK)
			Self:oHtml:ValByName("lImgAdmVenda",cLinoK)
		ElseIf ((Self:aAreaAtu)->(C5SF)== '10' .Or. (Self:aAreaAtu)->(C5SF)== '15') .And. (AllTrim((Self:aAreaAtu)->(LIBMARGEM)) == aStatMarge[3]	.Or. AllTrim((Self:aAreaAtu)->(LIBMARGEM)) == aStatMarge[2]) .And. AllTrim((Self:aAreaAtu)->(LIBADM)) == aStatAdm[2] 
			Self:oHtml:ValByName("bImgAdmVenda",cBolProx)
			Self:oHtml:ValByName("lImgAdmVenda",cLinProx)
		Else 
			Self:oHtml:ValByName("bImgAdmVenda",cBolCome)
			Self:oHtml:ValByName("lImgAdmVenda",cLinCome)
		EndIf
		Self:oHtml:ValByName("cLibAdm",(Self:aAreaAtu)->(LIBADM))
		
		//Tratativa no status das imagens da entrega
		If	AllTrim((Self:aAreaAtu)->(ENTREGA)) == aStatEntre[4]
			Self:oHtml:ValByName("bImgEntrega",cBoloK)
			Self:oHtml:ValByName("bImgOperacao",cBoloK)		
			Self:oHtml:ValByName("lImgOperacao",cLinoK)
			
		ElseIf Empty(AllTrim((Self:aAreaAtu)->(ENTREGA)))
			Self:oHtml:ValByName("bImgEntrega",cBolCome)
						
		Else
			Self:oHtml:ValByName("bImgEntrega",cBolProx)
			Self:oHtml:ValByName("bImgOperacao",cBoloK)			
			Self:oHtml:ValByName("lImgOperacao",cLinoK)
		End IF
		
		If AllTrim((Self:aAreaAtu)->(ENTREGA)) == aStatEntre[4]
			Self:oHtml:ValByName("cStatEntre",AllTrim((Self:aAreaAtu)->(ENTREGA))+" - DATA DE ENTREGA: "+Self:retornaDataFormatada((Self:aAreaAtu)->(DTENTRE)))
		Else
			Self:oHtml:ValByName("cStatEntre",(Self:aAreaAtu)->(ENTREGA))
		EndIf
		//Self:oHtml:ValByName("nQtdLinhas",(Self:aAreaAtu)->(LINHAS))
		
		Self:oHtml:ValByName("nQtdVendido",(Self:aAreaAtu)->(VENDIDO))
	
		
		IF (Self:aAreaAtu)->(LIBERADO) == 0
			Self:oHtml:ValByName("nQtdLiberado"," ")
		Else
			Self:oHtml:ValByName("nQtdLiberado",(Self:aAreaAtu)->(LIBERADO))
		EndIf
		
		Self:oHtml:ValByName("nNumNF",(Self:aAreaAtu)->(NOTA))
		
		ACA->(DbSelectArea("ACA"))
		ACA->(DbSetOrder(1))
		
		If ACA->(DbSeek(xFilial("ACA")+(Self:aAreaAtu)->(CANAL)))
			Self:oHtml:ValByName("cCanal",ACA->ACA_DESCRI)
		Else
			Self:oHtml:ValByName("cCanal",(Self:aAreaAtu)->(CANAL))
		EndIF
		
		
		SA4->(DbSelectArea("SA4"))
		SA4->(DbSetOrder(1))
		
		//Verifica se a transportadora da F2 ja existe e insere na variavel cTransp o nome da transportadora
		IF !Empty(AllTrim((Self:aAreaAtu)->(F2TRANSP)))
			
			SA4->(DbSeek(xFilial("SA4") + AllTrim((Self:aAreaAtu)->(F2TRANSP))))
			
			cTransp := SA4->A4_NOME 
		Else
			
			SA4->(DbSeek(xFilial("SA4") + AllTrim((Self:aAreaAtu)->(C5TRANSP))))
			
			cTransp := SA4->A4_NOME 
		EndIf
		
		//Busca o historicodo do agendamento se houver
		SE1->(DbSelectArea("SE1"))
		SE1->(DbSetOrder(29))
		SE1->(DbSeek(xFilial("SE1")+AllTrim((Self:aAreaAtu)->(NOTA))+AllTrim((Self:aAreaAtu)->(SERIE))))
		
		Self:oHtml:ValByName("cAgenda",AllTrim(SE1->E1_HISTWF))
		
		
		//Trativa do status da operação no WMS
			If (Self:aAreaAtu)->(WMS)== aStatWMS[6]
				Self:oHtml:ValByName("bImgOperacao",cBolCance)		
				//Self:oHtml:ValByName("lImgOperacao",cLinCome)			
			EndIf
			
			Self:oHtml:ValByName("cStatWms",(Self:aAreaAtu)->(WMS))
		
		If 	!Empty(AllTrim((Self:aAreaAtu)->(RASTRO))) && (AllTrim(cTransp) == "CORREIOS" .Or. AllTrim(cTransp) == "SEDEX" .Or. AllTrim(cTransp) == "PAC" .Or. AllTrim(cTransp) == "E-SEDEX"))
			If Len(AllTrim((Self:aAreaAtu)->(RASTRO))) == 13
				cHtml := '<td  bgcolor="#E8E8E8" ><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;" >TRANSPORTADORA</span></td>'
				If !Empty((Self:aAreaAtu)->(DTSAIDA))
					cHtml += '<td  bgcolor="#FFFFFF">'+ cTransp+" - DATA DE SAIDA: "+ Self:retornaDataFormatada((Self:aAreaAtu)->(DTSAIDA)) +'</td>'
				Else
					cHtml += '<td  bgcolor="#FFFFFF">'+ cTransp+'</td>'
				EndIf
                
				cHtml += '<td  bgcolor="#E8E8E8"><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;" >RASTREIO</span></td>'
                cHtml += '<td  bgcolor="#FFFFFF">'+ '<a href="'+cLinkRas+AllTrim((Self:aAreaAtu)->(RASTRO))+'">'+AllTrim((Self:aAreaAtu)->(RASTRO))+'</a>' +'</td>'
				Self:oHtml:ValByName("cDadosTran",cHtml)
			ElseIf Len(AllTrim((Self:aAreaAtu)->(RASTRO))) == 14
				cHtml := '<td  bgcolor="#E8E8E8" ><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;" >TRANSPORTADORA</span></td>'
				If !Empty((Self:aAreaAtu)->(DTSAIDA))
					cHtml += '<td  bgcolor="#FFFFFF">'+ cTransp+" - DATA DE SAIDA: "+ Self:retornaDataFormatada((Self:aAreaAtu)->(DTSAIDA)) +'</td>'
				Else
					cHtml += '<td  bgcolor="#FFFFFF">'+ cTransp+'</td>'
				EndIf
				cHtml += '<td  bgcolor="#E8E8E8"><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;" >RASTREIO</span></td>'
                cHtml += '<td  bgcolor="#FFFFFF">'+ '<a href="'+cLinkDir+AllTrim((Self:aAreaAtu)->(RASTRO))+'" target="_blank">'+AllTrim((Self:aAreaAtu)->(RASTRO))+'</a>' +'</td>'
				Self:oHtml:ValByName("cDadosTran",cHtml)
			EndIf
		Else
			If !Empty(AllTrim(cTransp))
			 	If AllTrim(cTransp) != "CORREIOS" && AllTrim(cTransp) != "SEDEX" && AllTrim(cTransp) != "PAC" && AllTrim(cTransp) != "E-SEDEX"
			 		cHtml := '<td  bgcolor="#E8E8E8" ><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;" >TRANSPORTADORA</span></td>'
	                If !Empty((Self:aAreaAtu)->(DTSAIDA))
						cHtml += '<td  bgcolor="#FFFFFF">'+ cTransp+" - DATA DE SAIDA: "+ Self:retornaDataFormatada((Self:aAreaAtu)->(DTSAIDA)) +'</td>'
					Else
						cHtml += '<td  bgcolor="#FFFFFF">'+ cTransp+'</td>'
					EndIf
					cHtml += '<td  bgcolor="#E8E8E8"><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;" >RASTREIO</span></td>'
					cHtml += '<td  bgcolor="#FFFFFF">NÃO POSSUI</td>'
					Self:oHtml:ValByName("cDadosTran",cHtml)

			 	EndIf
			EndIf
		EndIf
		
		SE1->(DbCloseArea("SE1"))
		SA4->(DbCloseArea("SA4"))
		ACA->(DbCloseArea("ACA"))
		SA3->(DbCloseArea("SA3"))
	EndIF	
		(Self:aAreaAtu)->(DbSkip())
		
	
	EndDo
	 
	 dbCloseArea(Self:aAreaAtu)
	
Return

Method MontaExecutaQuery() Class Tracking_Vendedor

Local cC9 		:= RetSQLName("SC9")
Local cA1		:= RetSQLName("SA1")
Local cC5		:= RetSQLName("SC5")
Local cC6		:= RetSQLName("SC6")
Local cFil		:= xFilial("SC5")
Local cF2		:= RetSQLName("SF2")
Local cP0b		:= RetSQLName("P0B")
Local cZ1		:= RetSQLName("SZ1")
Local cP0g		:= RetSQLName("P0G")


//ProcRegua(RecCount()) 
//IncRegua("Processando dados")

Self:cQuery :="SELECT DISTINCT PROTHEUS_PRINCIPAL.pedido,                                                                                           "
Self:cQuery += "                PROTHEUS_PRINCIPAL.c5sf,                                                                                            "
Self:cQuery += "                PROTHEUS_PRINCIPAL.emissao,                                                                                         "
Self:cQuery += "                PROTHEUS_PRINCIPAL.nomecli,                                                                                         "
Self:cQuery += "                PROTHEUS_PRINCIPAL.codcli,                                                                                          "
Self:cQuery += "                PROTHEUS_PRINCIPAL.lojacli,                                                                                         "
Self:cQuery += "                PROTHEUS_PRINCIPAL.endereco,                                                                                        "
Self:cQuery += "                PROTHEUS_PRINCIPAL.comple,                                                                                          "
Self:cQuery += "                PROTHEUS_PRINCIPAL.municipio,                                                                                       "
Self:cQuery += "                PROTHEUS_PRINCIPAL.estado,                                                                                          "
Self:cQuery += "                PROTHEUS_PRINCIPAL.vendedor,                                                                                        "
Self:cQuery += "                PROTHEUS_PRINCIPAL.vdigitado,                                                                                       "
Self:cQuery += "                PROTHEUS_NF.FATURADO,          			                                                                            "
Self:cQuery += "                PROTHEUS_PRINCIPAL.operacao,                                                                                        "
Self:cQuery += "                PROTHEUS_PRINCIPAL.libcredito,                                                                                      "
Self:cQuery += "                CASE WHEN P0B.LIBMARGEM IS NULL OR P0B.LIBMARGEM=' ' THEN  PROTHEUS_PRINCIPAL.C5MARGEM                              "
Self:cQuery += "                ELSE P0B.LIBMARGEM END LIBMARGEM,                                                                                   "
Self:cQuery += "                PROTHEUS_PRINCIPAL.libadm,                                                                                          "
Self:cQuery += "                PROTHEUS_PRINCIPAL.entrega,                                                                                         "
Self:cQuery += "                PROTHEUS_PRINCIPAL.linhas,                                                                                          "
Self:cQuery += "                PROTHEUS_PRINCIPAL.vendido,                                                                                         "
Self:cQuery += "                PROTHEUS_PRINCIPAL.liberado,                                                                                        "
Self:cQuery += "                PROTHEUS_NF.nota,                                                                                                   "
Self:cQuery += "                PROTHEUS_PRINCIPAL.canal,                                                                                           "
Self:cQuery += "                PROTHEUS_PRINCIPAL.c5transp,                                                                                        "
Self:cQuery += "                PROTHEUS_PRINCIPAL.wms,                                                                                             "
Self:cQuery += "                P0G.rastro,                					                                                                        "
Self:cQuery += "                PROTHEUS_PRINCIPAL.condpag,                                                                                         "
Self:cQuery += "                PROTHEUS_NF.f2transp,                                                                                               "
Self:cQuery += "                PROTHEUS_NF.SERIE,	                                                                                                "
Self:cQuery += "                PROTHEUS_PRINCIPAL.DTSAIDA,	                                                                                        "
Self:cQuery += "                PROTHEUS_PRINCIPAL.DTENTRE	                                                                                        "
Self:cQuery += "FROM   (SELECT C5.c5_num                        AS PEDIDO,                                                                          "
Self:cQuery += "               C5.c5_xstaped                    AS C5SF,                                                                            "
Self:cQuery += "               C5.c5_emissao                    AS EMISSAO,                                                                         "
Self:cQuery += "               C5.c5_client                     AS CODCLI,                                                                          "
Self:cQuery += "               C5.c5_lojacli                    AS LOJACLI,                                                                         "
Self:cQuery += "               C5.c5_vend1                      AS VENDEDOR,                                                                        "
Self:cQuery += "               A1.a1_nome                       AS NOMECLI,                                                                         "
Self:cQuery += "               A1.a1_endent                     AS ENDERECO,                                                                        "
Self:cQuery += "               A1.a1_complem                    AS COMPLE,                                                                          "
Self:cQuery += "               A1.a1_mune                       AS MUNICIPIO,                                                                       "
Self:cQuery += "               A1.a1_este                       AS ESTADO,                                                                          "
Self:cQuery += "               C5.c5_transp                     AS C5TRANSP,                                                                        "
Self:cQuery += "               Sum(C6.c6_qtdven * C6.c6_prcven) AS VDIGITADO,                                                                       "

Self:cQuery += "               Z1.Z1_DTSAIDA                    AS DTSAIDA,                                                                       "
Self:cQuery += "               Z1.Z1_DTENTRE                    AS DTENTRE,                                                                       "

Self:cQuery += "               CASE                                                                                                                 "
Self:cQuery += "                 WHEN Sum(CASE WHEN C9.c9_blcred IN ( ' ', '10' ) THEN 1 ELSE 0 END) > 0                                            "
Self:cQuery += "                        AND Sum(CASE WHEN C9.c9_blest IN ( ' ', '10' ) THEN 1 ELSE 0 END) > 0                                       "
Self:cQuery += "                        AND Sum(CASE WHEN C9.c9_blwms = '02' THEN 1 ELSE 0 END) > 0 THEN 'LIBERADO NO CREDITO'                      "
Self:cQuery += "                 WHEN Sum(CASE WHEN C9.c9_blcred ='10' AND C9.c9_blest ='10' AND C9.c9_blwms=' '  THEN 1 ELSE 0 END) > 0  			"
Self:cQuery += "                 THEN   'LIBERADO NO CREDITO'											                                            "
Self:cQuery += "                 WHEN Sum(CASE WHEN C9.c9_blest IN ( ' ', '10' ) THEN 1 ELSE 0 END) > 0                                             "
Self:cQuery += "                      AND Sum(CASE WHEN C9.c9_blcred = '09' THEN 1 ELSE 0 END) > 0                                                  "
Self:cQuery += "                      AND Sum(CASE WHEN C9.c9_blcred IN ( ' ', '10' ) THEN 1 ELSE 0 END) = 0 THEN 'REJEITADO NO CREDITO'            "
Self:cQuery += "                 WHEN Sum(CASE WHEN C9.c9_blest IN ( ' ', '10' ) THEN 1 ELSE 0 END) > 0                                             "
Self:cQuery += "                      AND Sum(CASE WHEN C9.c9_blcred = '01' THEN 1 ELSE 0 END) > 0                                                  "
Self:cQuery += "                      AND Sum(CASE WHEN C9.c9_blcred IN ( ' ', '10' ) THEN 1 ELSE 0 END) = 0 THEN 'PENDENTE DE APROVAÇÃO'           "
Self:cQuery += "                 ELSE ' '                                                                                                           "
Self:cQuery += "               END AS LIBCREDITO,                                                                                                   "
Self:cQuery += "               CASE                                                                                                                 "
Self:cQuery += "                 WHEN DC.status = 'P' THEN 'EM OPERACAO'                                                                            "
Self:cQuery += "                 WHEN Sum(CASE WHEN C9.c9_blcred = '10' THEN 1 ELSE 0 END) > 0 THEN 'FATURADO'                                      "
Self:cQuery += "                 WHEN DC.status <> 'P'                                                                                              "
Self:cQuery += "                      AND Sum(CASE WHEN C9.c9_blwms = '02' THEN 1 ELSE 0 END) > 0 THEN 'PEDIDO AINDA NÃO ESTA EM WMS'               "
Self:cQuery += "                 ELSE ' '                                                                                                           "
Self:cQuery += "               END AS  OPERACAO,                                                                                                        "
Self:cQuery += "               CASE                                                                                                                 "
Self:cQuery += "                 WHEN C5.c5_ystatus = '02' THEN 'SUJEITO A APROVAÇÃO'                                                               "
Self:cQuery += "                 WHEN C5.c5_ystatus = '01' THEN 'PEDIDO LIBERADO NA MARGEM'                                                         "
Self:cQuery += "                 WHEN C5.c5_ystatus = '06'  THEN 'MARGEM APROVADA'                                                                  "
Self:cQuery += "                 END AS C5MARGEM,                                                                                                      "
Self:cQuery += "               CASE                                                                                                                 "
Self:cQuery += "                 WHEN Sum(CASE WHEN C9.c9_datalib <> ' ' THEN 1 ELSE 0 END) > 0                                                     "
Self:cQuery += "                       OR C5.c5_dtlib <> ' ' THEN 'SIM'                                                                             "
Self:cQuery += "                 ELSE 'NÃO'                                                                                                         "
Self:cQuery += "               END AS LIBADM,                                                                                                         "
Self:cQuery += "               CASE                                                                                                                 "
Self:cQuery += "                 WHEN Sum(CASE                                                                                                      "
Self:cQuery += "                            WHEN C9.c9_nfiscal <> ' '                                                                               "
Self:cQuery += "                                 AND Z1.z1_dtsaida = ' '                                                                            "
Self:cQuery += "                                 AND Z1.z1_dtentre = ' '                                                                            "
Self:cQuery += "                                 AND F2.f2_dataag = ' '                                                                             "
Self:cQuery += "                                 AND A1.a1_agend = '1' THEN 1                                                                       "
Self:cQuery += "                            ELSE 0                                                                                                  "
Self:cQuery += "                          END) > 0 THEN                                                                                             "
Self:cQuery += "                 'FATURADO - AGUARDANDO DATA DE AGENDAMENTO'                                                                        "
Self:cQuery += "                 WHEN Sum(CASE                                                                                                      "
Self:cQuery += "                            WHEN C9.c9_nfiscal <> ' '                                                                               "
Self:cQuery += "                                 AND Z1.z1_dtsaida = ' '                                                                            "
Self:cQuery += "                                 AND Z1.z1_dtentre = ' '                                                                            "
Self:cQuery += "                                 AND F2.f2_dataag <> ' '                                                                            "
Self:cQuery += "                                 AND A1.a1_agend = '1' THEN 1                                                                       "
Self:cQuery += "                            ELSE 0                                                                                                  "
Self:cQuery += "                          END) > 0 THEN 'FATURADO - AGENDADO'                                                                       "
Self:cQuery += "                 WHEN Sum(CASE                                                                                                      "
Self:cQuery += "                            WHEN C9.c9_nfiscal <> ' '                                                                               "
Self:cQuery += "                                 AND Z1.z1_dtsaida <> ' '                                                                           "
Self:cQuery += "                                 AND Z1.z1_dtentre = ' ' THEN 1                                                                     "
Self:cQuery += "                            ELSE 0                                                                                                  "
Self:cQuery += "                          END) > 0 THEN 'FATURADO - EXPEDIDO'                                                                       "
Self:cQuery += "                 WHEN Sum(CASE                                                                                                      "
Self:cQuery += "                            WHEN C9.c9_nfiscal <> ' '                                                                               "
Self:cQuery += "                                 AND Z1.z1_dtsaida <> ' '                                                                           "
Self:cQuery += "                                 AND Z1.z1_dtentre <> ' ' THEN 1                                                                    "
Self:cQuery += "                            ELSE 0                                                                                                  "
Self:cQuery += "                          END) > 0 THEN 'FATURADO - ENTREGUE'                                                                       "
Self:cQuery += "                 ELSE ' '                                                                                                           "
Self:cQuery += "               END AS ENTREGA,                          							                                                "
Self:cQuery += "               Count(C6.c6_produto) AS LINHAS,             				                                                            "
Self:cQuery += "               Sum(C6.c6_qtdven)                VENDIDO,                                                                            "
Self:cQuery += "               CASE                                                                                                                 "
Self:cQuery += "                 WHEN Sum(C9.c9_qtdlib) IS NULL THEN 0                                                                              "
Self:cQuery += "                 ELSE Sum(C9.c9_qtdlib)                                                                                             "
Self:cQuery += "               END AS LIBERADO,                                         							                                "
Self:cQuery += "               C5.c5_ycanal                     AS CANAL,           	                                                            "
Self:cQuery += "               CASE                                                                                                                 "
Self:cQuery += "                 WHEN  SUM(CASE WHEN DCSE.DT_HOR_DISPONIVEL_CONFERENCIA IS NOT NULL THEN 1 ELSE 0 END) > 0							"
Self:cQuery += "							THEN 'CONFERENCIA FINALIZADA'																			" 
Self:cQuery += "                 WHEN DCE.dt_hor_inicio_separacao IS NOT NULL THEN                                                                  "
Self:cQuery += "                 'SEPARAÇÃO INICIADA'                                                                                               "
Self:cQuery += "                 WHEN DCE.dt_hor_disponivel_separacao IS NOT NULL THEN                                                              "
Self:cQuery += "                 'DISPONIVEL PARA SEPARAÇÃO'                                                                                        "
Self:cQuery += "                 WHEN WCES.ces_num_documento IS NOT NULL                                                                            "
Self:cQuery += "                      AND DC.status NOT IN ( 'P', 'NP' )                                                                            "
Self:cQuery += "                      AND Sum(CASE                                                                                                  "
Self:cQuery += "                                WHEN C9.c9_blwms = '02' THEN 1                                                                      "
Self:cQuery += "                                ELSE 0                                                                                              "
Self:cQuery += "                              END) > 0 THEN 'CACELADO NO WMS'                                                                       "
Self:cQuery += "                 ELSE ' '                                                                                                           "
Self:cQuery += "               END                              AS WMS,                                                                             "
Self:cQuery += "               C5.c5_condpag                    AS CONDPAG                                                                          "
Self:cQuery += "        FROM   "+ cC5 +" C5                                                                                                         "
Self:cQuery += "               LEFT JOIN "+ cC6 +" C6                                                                                               "
Self:cQuery += "                      ON C5.c5_num = C6.c6_num                                                                                      "
Self:cQuery += "                         AND C6.c6_filial = C5.c5_filial                                                                            "
Self:cQuery += "                         AND C6.d_e_l_e_t_ = ' '                                                                                    "
Self:cQuery += "                         AND C6.c6_cli = C5.c5_client                                                                               "
Self:cQuery += "                         AND C6.c6_loja = C5.c5_lojacli                                                                             "
Self:cQuery += "               LEFT JOIN "+ cC9 +" C9                                                                                               "
Self:cQuery += "                      ON C9.c9_pedido = C5.c5_num                                                                                   "
Self:cQuery += "                         AND C9.c9_filial = C5.c5_filial                                                                            "
Self:cQuery += "                         AND C9.c9_pedido = C6.c6_num                                                                               "
Self:cQuery += "                         AND C9.d_e_l_e_t_ = ' '                                                                                    "
Self:cQuery += "                         AND C9.c9_cliente = C5.c5_client                                                                           "
Self:cQuery += "                         AND C9.c9_loja = C5.c5_lojacli                                                                             "
Self:cQuery += "                         AND C9.c9_produto IN (C6.c6_produto)                                                                       "
Self:cQuery += "               LEFT JOIN "+ cF2 +" F2                                                                                               "
Self:cQuery += "                      ON F2.f2_doc = C9.c9_nfiscal                                                                                  "
Self:cQuery += "                         AND F2.f2_filial = C9.c9_filial                                                                            "
Self:cQuery += "                         AND F2.d_e_l_e_t_ = ' '                                                                                    "
Self:cQuery += "                         AND F2.f2_client = C9.c9_cliente                                                                           "
Self:cQuery += "                         AND F2.f2_loja = C9.c9_loja                                                                                "
Self:cQuery += "               LEFT JOIN "+ cZ1 +" Z1                                                                                               "
Self:cQuery += "                      ON Z1.z1_doc = F2.f2_doc                                                                                      "
Self:cQuery += "                         AND Z1.z1_filial = F2.f2_filial                                                                            "
Self:cQuery += "                         AND Z1.d_e_l_e_t_ = ' '                                                                                    "
Self:cQuery += "                         AND Z1.z1_cliente = C5.c5_client                                                                           "
Self:cQuery += "                         AND Z1.z1_loja = C5.c5_lojacli                                                                             "
Self:cQuery += "               LEFT JOIN "+ cA1 +" A1                                                                                               "
Self:cQuery += "                      ON A1.a1_cod = C5.c5_client                                                                                   "
Self:cQuery += "                         AND A1.a1_loja = C5.c5_lojacli                                                                             "
Self:cQuery += "                         AND A1.d_e_l_e_t_ = ' '                                                                                    "
Self:cQuery += "               LEFT JOIN wms.tb_wmsinterf_doc_saida DC                                                                              "
Self:cQuery += "                      ON Trim(C5.c5_num) = DC.dpcs_num_documento                                                                    "
Self:cQuery += "               LEFT JOIN wms.viw_doc_separacao_erp DCE                                                                              "
Self:cQuery += "                      ON Substr(DCE.documento_erp, 3, Length(DCE.documento_erp))                                                    "
Self:cQuery += "                         =                                                                                                          "
Self:cQuery += "                         Trim(C5.c5_num)                                                                                            "
Self:cQuery += " 			   LEFT JOIN wms.VIW_DOC_SAIDA_ERP DCSE																					"
Self:cQuery += " 				      ON Substr(DCSE.documento_erp, 3, Length(DCSE.documento_erp)) = Trim(C5.c5_num)								"
Self:cQuery += "               LEFT JOIN wms.tb_wmsinterf_canc_ent_sai WCES                                                                         "
Self:cQuery += "                      ON WCES.ces_num_documento = Trim(C5.c5_num)                                                                   "
Self:cQuery += "        WHERE  C5.c5_filial = '"+cFil+"'                                                                                            "
Self:cQuery += "               AND C5.d_e_l_e_t_ = ' '                                                                                              "
Self:cQuery += "               AND C5.c5_num = '"+ Self:cPedido +"'                                                                                 "
Self:cQuery += "        GROUP  BY C5.c5_num,                                                                                                        "
Self:cQuery += "                  C5.c5_xstaped,                                                                                                    "
Self:cQuery += "                  C5.c5_client,                                                                                                     "
Self:cQuery += "                  C5.c5_lojacli,                                                                                                    "
Self:cQuery += "                  C5.c5_dtlib,                                                                                                      "
Self:cQuery += "                  C5.c5_ycanal,                                                                                                     "
Self:cQuery += "                  C5.c5_vend1,                                                                                                      "
Self:cQuery += "                  C5.c5_emissao,                                                                                                    "
Self:cQuery += "                  C5.c5_ystatus,                                                                                                    "
Self:cQuery += "                  A1.a1_nome,                                                                                                       "
Self:cQuery += "                  A1.a1_endent,                                                                                                     "
Self:cQuery += "                  A1.a1_mune,                                                                                                       "
Self:cQuery += "                  A1.a1_este,                                                                                                       "
Self:cQuery += "                  A1.a1_complem,                                                                                                    "
Self:cQuery += "                  C5.c5_transp,                                                                                                     "
Self:cQuery += "                  DC.status,                                                                                                        "
Self:cQuery += "                  DCE.dt_hor_inicio_separacao,                                                                                      "
Self:cQuery += "                  DCE.dt_hor_disponivel_separacao,                                                                                  "
Self:cQuery += "                  WCES.ces_num_documento,                                                                                           "
Self:cQuery += "                  C5.c5_condpag,                                                                                                    "
Self:cQuery += " 				  Z1.Z1_DTSAIDA,																									"
Self:cQuery += " 				  Z1.Z1_DTENTRE																										"	
Self:cQuery += "                  ) PROTHEUS_PRINCIPAL                                                                                              "
Self:cQuery += "       LEFT JOIN (SELECT C9NF.c9_pedido AS PEDIDO,                                                                                  "
Self:cQuery += "                         F2NF.f2_doc    AS NOTA,                                                                                    "
Self:cQuery += "                         F2NF.f2_transp AS F2TRANSP,                                                                                "
Self:cQuery += "                         F2NF.F2_SERIE AS SERIE,                                                                                    "
Self:cQuery += "                         F2NF.F2_VALBRUT AS FATURADO                                                                        	    "
Self:cQuery += "                  FROM   "+ cC9 +" C9NF                                                                                             "
Self:cQuery += "                         LEFT JOIN "+ cF2 +" F2NF                                                                                   "
Self:cQuery += "                                ON C9NF.c9_nfiscal = F2NF.f2_doc                                                                    "
Self:cQuery += "                  WHERE  C9NF.c9_filial = '"+ cFil +"'                                                                              "
Self:cQuery += "                         AND C9NF.d_e_l_e_t_ = ' '                                                                                  "
Self:cQuery += "                         AND F2NF.f2_filial = '"+ cFil +"'                                                                          "
Self:cQuery += "                         AND F2NF.d_e_l_e_t_ = ' '                                                                                  "
Self:cQuery += "                         AND C9NF.c9_pedido = '"+ Self:cPedido+"'                                                                   "
Self:cQuery += "                  GROUP  BY C9NF.c9_pedido,                                                                                         "
Self:cQuery += "                            F2NF.f2_doc,                                                                                            "
Self:cQuery += "                            F2NF.f2_SERIE,                                                                                          "
Self:cQuery += "                            F2NF.F2_VALBRUT,                                                                                        "
Self:cQuery += "                            F2NF.f2_transp) PROTHEUS_NF                                                                             "
Self:cQuery += "              ON PROTHEUS_PRINCIPAL.pedido = PROTHEUS_NF.pedido                                                                     "
Self:cQuery += "                 AND PROTHEUS_NF.nota IS NOT NULL                                                                                   "
Self:cQuery += "        LEFT JOIN (                                                                                                                 "
Self:cQuery += "          SELECT                                                                                                                    "
Self:cQuery += "          P0B_PEDIDO AS PEDIDO,                                                                                                     "
Self:cQuery += "          P0B_CODCLI AS CLIENTE,                                                                                                    "
Self:cQuery += "          P0B_LOJA AS LOJA,                                                                                                         "
Self:cQuery += "          CASE                                                                                                                      "
Self:cQuery += "           WHEN Count(p0b_status) = Sum(CASE WHEN p0b_status = '04'THEN 1 ELSE 0 END) THEN 'MARGEM APROVADA'                        "
Self:cQuery += "                 WHEN Count(p0b_status) = Sum(CASE WHEN p0b_status = '05' THEN 1 ELSE 0 END) THEN 'MARGEM REJEITADA'                "
Self:cQuery += "                 WHEN Sum(CASE WHEN p0b_status = '01' THEN 1 ELSE 0 END) > 0                                                        "
Self:cQuery += "                      AND Sum(CASE WHEN p0b_status = ' ' THEN 1 ELSE 0 END) > 0 THEN 'PENDENTE DE APROVAÇÃO DE MARGEM'              "
Self:cQuery += "                 WHEN Count(p0b_status) < Sum(CASE WHEN p0b_status = '03' THEN 1 ELSE 0 END)                                        "
Self:cQuery += "                      AND ( Sum(CASE WHEN p0b_status = '04' THEN 1 ELSE 0 END) > 0                                                  "
Self:cQuery += "                             OR Sum(CASE WHEN p0b_status = '05' THEN 1 ELSE 0 END) > 0 )                                            "
Self:cQuery += "                      AND Count(p0b_status) < Sum(CASE WHEN p0b_status = '05' THEN 1 ELSE 0 END)                                    "
Self:cQuery += "                       OR ( Sum(CASE WHEN p0b_status = '03' THEN 1 ELSE 0 END) > 0                                                  "
Self:cQuery += "                            AND Sum(CASE WHEN p0b_status = '02' THEN 1 ELSE 0 END) > 0 )                                            "
Self:cQuery += "                       OR ( Sum(CASE WHEN p0b_status = '03' THEN 1 ELSE 0 END) > 0                                                  "
Self:cQuery += "                            AND Sum(CASE WHEN p0b_status = '01' THEN 1 ELSE 0 END) > 0 ) THEN 'EM PROCESSO DE APROVAÇÃO DE MARGEM'  "
Self:cQuery += "                 ELSE ' '                                                                                                           "
Self:cQuery += "               END AS LIBMARGEM                                                                                                     "
Self:cQuery += "               FROM " + cP0b +"                                                                                                     "
Self:cQuery += "               WHERE D_E_L_E_T_ = ' '                                                                                               "
Self:cQuery += "               GROUP BY P0B_PEDIDO,                                                                                                 "
Self:cQuery += "                P0B_CODCLI ,                                                                                                        "
Self:cQuery += "                P0B_LOJA                                                                                                            "
Self:cQuery += "        )P0B                                                                                                                        "
Self:cQuery += "        ON P0B.PEDIDO = PROTHEUS_PRINCIPAL.pedido                                                                                   "
Self:cQuery += "        AND P0B.CLIENTE = PROTHEUS_PRINCIPAL.codcli                                                                                 "
Self:cQuery += "        AND P0B.LOJA= PROTHEUS_PRINCIPAL.lojacli																					"
Self:cQuery += "               LEFT JOIN (                                                          "
Self:cQuery += "               SELECT P0G_PEDIDO PEDIDO,                                            "
Self:cQuery += "                 CASE WHEN COUNT(P0G_RAST ) = 1 THEN  P0G_RAST ELSE ' ' END RASTRO	"
Self:cQuery += "                 FROM "+ cP0g +"                                                    "
Self:cQuery += "               WHERE D_E_L_E_T_=' '                                                 "
Self:cQuery += "               AND P0G_FILIAL = '" +cFil+ "'                                        "
Self:cQuery += "               GROUP BY P0G_PEDIDO,                                                 "
Self:cQuery += "                         P0G_RAST                                                   "
Self:cQuery += "               )P0G                                                                 "
Self:cQuery += "               ON P0G.PEDIDO =  PROTHEUS_PRINCIPAL.pedido							"


	Self:cQuery := ChangeQuery(Self:cQuery)
	dbUseArea(.T., 'TOPCONN', TCGenQry(,,Self:cQuery),Self:aAreaAtu, .F., .T.)
	
	//IndRegua( 'TRB', cIndArqA,'A1_COD+A1_NOME',,,"Selecionando Registros...")
	
	dbSelectArea(Self:aAreaAtu)
	// IncProc()
Return

Method retornaDataFormatada(dData) Class Tracking_Vendedor
	If !Empty(dData)
		dData = substr(dData,7,2)+"/"+substr(dData,5,2)+"/"+substr(dData,1,4)
	EndIF
Return dData