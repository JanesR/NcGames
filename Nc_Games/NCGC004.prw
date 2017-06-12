#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGC004   บAutor  ณ                    บ Data ณ  17/04/13	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monitor de travamento de interfaces WMS                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 												      		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGC004()

Local apItens	:= {"Pedido","Tipo Interface","Produto"}
Local cpEdit1	:= space(15)
Local cpCombo	:= ""
Local aHeader	:= {}
Local aCols	:= {}

Local bFconfirma	:= {|| IIF(msgyesno("Confirma o reprocessamento dos registros marcados?"),FCONFIRMA(),Nil) }
Local bFdesconsi	:= {|| IIF(msgyesno("Confirma desconsiderar os registros marcados?"),FDESCONSI(),Nil) }
Local bFAtuMonit	:= {|| NCGC04Cols() }

Private opEdit1 := Nil
Private olMsNewGet

aAdd(aHeader,{""		  		,"XLEGENDA"		,"@BMP"		,010						,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Deposito"   		,"DEPOSITO"		,""			,5							,0,"","","N","","" ,"",""})
aAdd(aHeader,{"Depositante"		,"DEPOSITANTE"	,""			,5							,0,"","","N","","" ,"",""})
aAdd(aHeader,{"Emissใo"			,"EMISSAO"		,"@!"		,10							,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Pedido"			,"PEDIDO"		,"@!"		,TamSx3("C5_NUM")[1]		,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Cliente"			,"CLIENTE"		,"@!"		,TamSx3("A1_NOME")[1]		,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Status"			,"STATUS"		,"@!"		,1					   		,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Descri็ใo Erro"	,"DESC_ERRO"	,"@!"		,15							,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Interface"		,"INTERF"  		,"@!"		,30							,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Produto"			,"PROD"  		,"@!"		,15							,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Quantidade"		,"QTDE"  		,""			,14							,2,"","","N","","" ,"",""})
aAdd(aHeader,{"Local Origem"	,"LOCORI"  		,""			,2							,0,"","","N","","" ,"",""})
aAdd(aHeader,{"Local Destino"	,"LOCDEST" 		,""			,2							,0,"","","N","","" ,"",""})
aAdd(aHeader,{"Usuแrio"			,"USUARIO" 		,"@!"		,10							,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Cod_chave"		,"COD_CHAVE"	,"@!"		,50							,0,"","","C","","" ,"",""})

//Chama a rotina NCGC04Cols para atualizar o aCols com os dados a serem visualizados
NCGC04Cols(@aCols,.F.)

If len(aCols) = 0
	alert("Nใo hแ registros com erros nas interfaces"+CRLF+" TB_FRTINTERF_DOC_SAIDA_TRANSP, TB_WMSINTERF_DOC_SAIDA ou TB_WMSINTERF_TROCA_TP_ESTOQUE")
	Return
EndIf

oDlg := MSDialog():New(000,000,550,1150,"Interfaces WMS com erro",,,,,CLR_BLACK,CLR_WHITE,,,.T.)

oFWLayer	:= FWLayer():New()

oFWLayer:Init(oDlg,.F.)

oFWLayer:AddCollumn("ALL"	,0100,.F.)

oFWLayer:AddWindow("ALL"	,"ACAO"	,"A็๕es"				,020,.F.,.F.,,,{ || })
oFWLayer:AddWindow("ALL"	,"PED"	,"Registros"			,080,.F.,.F.,,,{ || })

oPanelESQ3	:= oFWLayer:GetWinPanel("ALL"	,"ACAO")
oPanelESQ2	:= oFWLayer:GetWinPanel("ALL"	,"PED")

olCheck := TCheckBox():New(011,350,"Inverte Sele็ใo",,oPanelESQ3,050,050,,,,,,,,.T.,,,)
olCheck:BLCLICKED	:= {|| INVERTSELL() }


TBtnBmp2():New(5,1100,30,45,"FINAL",,,,{|| oDlg:End() },oPanelESQ3,"Sair",,.T. )
TBtnBmp2():New(5,1050,30,45,"PMSRRFSH",,,,bFconfirma,oPanelESQ3,"Reprocessar",,.T. )
TBtnBmp2():New(5,1000,30,45,"CANCEL",,,,bFdesconsi,oPanelESQ3,"Desconsiderar",,.T. )
TBtnBmp2():New(5,0950,30,45,"REFRESH",,,,bFAtuMonit,oPanelESQ3,"Atualiza Monitor",,.T. )
//TBtnBmp2():New(5,1050,30,45,"PMSRRFSH",,,,{|| IIF(FCONFIRMA(),oDlg:End(),Nil) },oPanelESQ3,"Reprocessar",,.T. )
//TBtnBmp2():New(5,1000,30,45,"CANCEL",,,,{|| IIF(FDESCONSI(),oDlg:End(),Nil) },oPanelESQ3,"Desconsiderar",,.T. )

TBtnBmp2():New(5,400,30,45,"PESQUISA",,,,{|| PESQUISA(cpCombo,cpEdit1)},oPanelESQ3,"Pesquisa",,.T. )
opCombo		:= TComboBox():New(007,001,{|u| If(PCount()>0,cpCombo:=u,cpCombo)},apItens,070,020,oPanelESQ3,,{|| Ordena(cpCombo,cpEdit1) },,,,.T.,,,,,,,,,"cpCombo")
opEdit1		:= TGet():New(007,085,{|u| if(PCount()>0,cpEdit1:=u,cpEdit1)},oPanelESQ3,100,009,"",{||  },,,,,,.T.,,,,,,,,,,"cpEdit1")

Set Key VK_F5 to NCGC04Cols()
olMsNewGet 						:= MsNewGetDados():New(000,000,000,000,001,,"AllWaysTrue()","",,,9999,"AllwaysTrue()",,,oPanelESQ2,aHeader,aCols)
olMsNewGet:oBrowse:Align 		:= CONTROL_ALIGN_ALLCLIENT
olMsNewGet:lInsert 				:= .F.
olMsNewGet:OBROWSE:BLDBLCLICK	:= {|x| SELREG()}

oDlg:Activate(,,,.T.,{|| },,{|| } )

SetKey(VK_F5,)


Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FCONFIRMA  บAutor  ณ Tiago Bizan      บ Data ณ  17/04/13	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo na confirama็ใo da tela de Libera็ใo de Pedido para  บฑฑ
ฑฑบ          ณ liberar o pedido para faturamneto e encaminhamento de email บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 												      		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FCONFIRMA()

Local nPEmp		:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'DEPOSITO' })
Local nPFil		:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'DEPOSITANTE' })
Local nPPed		:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'PEDIDO' })
Local nPInterf	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'INTERF' })
Local nPDthr	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'EMISSAO' })
Local nPProd	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'PROD' })
Local nPQtde	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'QTDE' })
Local nPLocOri	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'LOCORI' })
Local nPLocDest	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'LOCDEST' })
Local nPUser	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'USUARIO' })
Local nPCodChv	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'COD_CHAVE' })
Local lSelecao 	:= .F.
Local cQuery	:= ""
Local cErroDesc		:="NรO POSSUI NENHUM ITEM."
Local cErroDesc2 	:="na tabela TB_WMSINTERF_DOC_SAIDA_ITENS."

//Add erros
Local nPDescErro := ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'DESC_ERRO' })
//Add variavel que conterแ as querys para reprocessamento de pedidos que nใo possuirem itens na interface

Local cQuery2 := {}
For nI := 1 to len(olMsNewGet:aCols)
	
	If olMsNewGet:aCols[nI,ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'XLEGENDA' })] == 'LBTIK'
		
		nEmp	:= olMsNewGet:aCols[nI,nPEmp] 
		nFil	:= olMsNewGet:aCols[nI,nPFil] 
		cPed	:= ALLTRIM(olMsNewGet:aCols[nI,nPPed] )
		cInterf	:= ALLTRIM(olMsNewGet:aCols[nI,nPInterf] )
		cDataHr	:= ALLTRIM(olMsNewGet:aCols[nI,nPDthr] )
		cProduto:= ALLTRIM(olMsNewGet:aCols[nI,nPProd] )
		nQtde	:= olMsNewGet:aCols[nI,nPQtde] 
		nLocOri	:= olMsNewGet:aCols[nI,nPLocOri] 
		nLocDest:= olMsNewGet:aCols[nI,nPLocDest] 
		cUser	:= ALLTRIM(olMsNewGet:aCols[nI,nPUser] )
		cCodChv	:= ALLTRIM(olMsNewGet:aCols[nI,nPCodChv] )
		
		//Passa a descri็ใo do erro encontrado para a variavel para poder compara-lo
		cDescErro:= ALLTRIM(olMsNewGet:aCols[nI,nPDescErro])
		If !(lSelecao)
			lSelecao := .T.
		EndIF
			
		If cInterf == "TB_FRTINTERF_DOC_SAIDA_TRANSP"
			If cErroDesc2 == Substr(cDescErro, 89, Len(AllTrim(cDescErro)))
			
				aadd(cQuery2,"DELETE WMS.TB_WMSINTERF_DOC_SAIDA WHERE DPCS_NUM_DOCUMENTO='"+cPed+"' AND DPCS_COD_DEPOSITANTE="+alltrim(str(nFil))+" AND DPCS_COD_DEPOSITO="+alltrim(str(nEmp)))
				aadd(cQuery2,"DELETE WMS.TB_WMSINTERF_DOC_SAIDA_ITENS WHERE DPIS_NUM_DOCUMENTO='"+cPed+"' AND DPIS_COD_DEPOSITO="+alltrim(str(nEmp))+" AND DPIS_COD_DEPOSITANTE="+alltrim(str(nFil)))
				aadd(cQuery2,"DELETE WMS.TB_FRTINTERF_DOC_SAIDA_TRANSP WHERE TRS_NUM_DOCUMENTO='"+cPed+"' AND TRS_COD_DEPOSITO="+alltrim(str(nEmp))+" AND TRS_COD_DEPOSITANTE="+alltrim(str(nFil)))
				aadd(cQuery2,"UPDATE "+RetSqlName("P0A")+" SET P0A_EXPORT='2' WHERE P0A_FILIAL='"+xFilial("P0A")+"'  AND D_E_L_E_T_=' ' AND P0A_CHAVE LIKE '"+xFilial("P0A")+"'||"+cPed+"||'%'")
				
				For nx:=1 To len(cQuery2)
					If TcSqlExec(cQuery2[nx]) >= 0
						TcSqlExec("COMMIT")
					EndIf
				Next nx
				
			Else		
				cQuery := " UPDATE WMS.TB_FRTINTERF_DOC_SAIDA_TRANSP
				cQuery += " SET STATUS = 'NP'
				cQuery += " WHERE TRS_COD_DEPOSITO = "+alltrim(str(nEmp))
				cQuery += " AND TRS_COD_DEPOSITANTE = "+alltrim(str(nFil))
				cQuery += " AND TRS_NUM_DOCUMENTO = '"+cPed+"' "
				cQuery += " AND STATUS = 'ER' "
			EndIF
		ElseIf cInterf == "TB_WMSINTERF_DOC_SAIDA"
		//Aletra็ใo realizada por Flavio Borges
		//Altera็ใo realizada para verificar se houve erro na descida dos itens, assim os pedidos serใo reprocessados automaticamente.
		//Aqui caso o erro seja identico ao da variavel 'cErroDesc' irแ executar a rotina abaixo que ira excluir as interfaces do WMS e coloar a P0A para ser reprocessada 
			If cErroDesc == Substr(cDescErro, 20, Len(AllTrim(cDescErro)))
			
				aadd(cQuery2,"DELETE WMS.TB_WMSINTERF_DOC_SAIDA WHERE DPCS_NUM_DOCUMENTO='"+cPed+"' AND DPCS_COD_DEPOSITANTE="+alltrim(str(nFil))+" AND DPCS_COD_DEPOSITO="+alltrim(str(nEmp)))
				aadd(cQuery2,"DELETE WMS.TB_WMSINTERF_DOC_SAIDA_ITENS WHERE DPIS_NUM_DOCUMENTO='"+cPed+"' AND DPIS_COD_DEPOSITO="+alltrim(str(nEmp))+" AND DPIS_COD_DEPOSITANTE="+alltrim(str(nFil)))
				aadd(cQuery2,"DELETE WMS.TB_FRTINTERF_DOC_SAIDA_TRANSP WHERE TRS_NUM_DOCUMENTO='"+cPed+"' AND TRS_COD_DEPOSITO="+alltrim(str(nEmp))+" AND TRS_COD_DEPOSITANTE="+alltrim(str(nFil)))
				aadd(cQuery2,"UPDATE "+RetSqlName("P0A")+" SET P0A_EXPORT='2' WHERE P0A_FILIAL='"+xFilial("P0A")+"'  AND D_E_L_E_T_=' ' AND P0A_CHAVE LIKE '"+xFilial("P0A")+"'||"+cPed+"||'%'")
				
				For nx:=1 To len(cQuery2)
					If TcSqlExec(cQuery2[nx]) >= 0
						TcSqlExec("COMMIT")
					EndIf
				Next nx
				
			Else			
					cQuery := " UPDATE WMS.TB_WMSINTERF_DOC_SAIDA
					cQuery += " SET STATUS = 'NP'
					cQuery += " WHERE DPCS_COD_DEPOSITO = "+alltrim(str(nEmp))
					cQuery += " AND DPCS_COD_DEPOSITANTE = "+alltrim(str(nFil))
					cQuery += " AND DPCS_NUM_DOCUMENTO = '"+cPed+"' "
					cQuery += " AND STATUS = 'ER' "
			EndIf
		ElseIf cInterf == "TB_WMSINTERF_TROCA_TP_ESTOQUE"
			cQuery := " UPDATE WMS.TB_WMSINTERF_TROCA_TP_ESTOQUE
			cQuery += " SET STATUS = 'NP'
			cQuery += " WHERE BDE_COD_DEPOSITO = "+alltrim(str(nEmp))
			cQuery += " AND BDE_COD_DEPOSITANTE = "+alltrim(str(nFil))
			cQuery += " AND BDE_QTDE = "+alltrim(str(nQtde))
			cQuery += " AND BDE_DATA_HORA = '"+cDataHr+"' "
			cQuery += " AND BDE_COD_PRODUTO = '"+cProduto+"' "
			cQuery += " AND BDE_COD_TIPO_ESTOQUE_ORIGEM = "+alltrim(str(nLocOri))
			cQuery += " AND BDE_COD_TIPO_ESTOQUE_DESTINO = "+alltrim(str(nLocDest))
			cQuery += " AND BDE_USUARIO = '"+cUser+"' "
			If !Empty(cCodChv)
				cQuery += " AND DPCE_COD_CHAVE = '"+cCodChv+"' "
			EndIf
			cQuery += " AND STATUS = 'ER' "		
		Else
			cQuery	:= ""
		EndIf		
		
		If !Empty(cQuery)
			If TcSqlExec(cQuery) >= 0
				TcSqlExec("COMMIT")
			EndIf
		EndIf
		
	EndIF
Next nI

If !(lSelecao)
	MSGINFO("Nenhum registro foi selecionado.","ATENวรO")
EndIF

//Atualiza o monitor ap๓s desmarcar os registros
NCGC04Cols()

Return(lSelecao)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FDESCONSI  บAutor  ณ Tiago Bizan      บ Data ณ  17/04/13	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo na confirama็ใo da tela de Libera็ใo de Pedido para  บฑฑ
ฑฑบ          ณ liberar o pedido para faturamneto e encaminhamento de email บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 												      		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FDESCONSI()

Local nPEmp		:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'DEPOSITO' })
Local nPFil		:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'DEPOSITANTE' })
Local nPPed		:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'PEDIDO' })
Local nPInterf	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'INTERF' })
Local nPDthr	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'EMISSAO' })
Local nPProd	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'PROD' })
Local nPQtde	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'QTDE' })
Local nPLocOri	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'LOCORI' })
Local nPLocDest	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'LOCDEST' })
Local nPUser	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'USUARIO' })
Local nPCodChv	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'COD_CHAVE' })
Local lSelecao 	:= .F.
Local cQuery	:= ""

For nI := 1 to len(olMsNewGet:aCols)
	
	If olMsNewGet:aCols[nI,ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'XLEGENDA' })] == 'LBTIK'
		
		nEmp	:= olMsNewGet:aCols[nI,nPEmp] 
		nFil	:= olMsNewGet:aCols[nI,nPFil] 
		cPed	:= ALLTRIM(olMsNewGet:aCols[nI,nPPed] )
		cInterf	:= ALLTRIM(olMsNewGet:aCols[nI,nPInterf] )
		cDataHr	:= ALLTRIM(olMsNewGet:aCols[nI,nPDthr] )
		cProduto:= ALLTRIM(olMsNewGet:aCols[nI,nPProd] )
		nQtde	:= olMsNewGet:aCols[nI,nPQtde]
		nLocOri	:= olMsNewGet:aCols[nI,nPLocOri] 
		nLocDest:= olMsNewGet:aCols[nI,nPLocDest] 
		cUser	:= ALLTRIM(olMsNewGet:aCols[nI,nPUser] )
		cCodChv	:= ALLTRIM(olMsNewGet:aCols[nI,nPCodChv] )
		
		If !(lSelecao)
			lSelecao := .T.
		EndIF
			
		If cInterf == "TB_FRTINTERF_DOC_SAIDA_TRANSP"
			cQuery := " UPDATE WMS.TB_FRTINTERF_DOC_SAIDA_TRANSP
			cQuery += " SET STATUS = 'DS'
			cQuery += " WHERE TRS_COD_DEPOSITO = "+alltrim(str(nEmp))
			cQuery += " AND TRS_COD_DEPOSITANTE = "+alltrim(str(nFil))
			cQuery += " AND TRS_NUM_DOCUMENTO = '"+cPed+"' "
			cQuery += " AND STATUS = 'ER' "
		ElseIf cInterf == "TB_WMSINTERF_DOC_SAIDA"
			cQuery := " UPDATE WMS.TB_WMSINTERF_DOC_SAIDA
			cQuery += " SET STATUS = 'DS'
			cQuery += " WHERE DPCS_COD_DEPOSITO = "+alltrim(str(nEmp))
			cQuery += " AND DPCS_COD_DEPOSITANTE = "+alltrim(str(nFil))
			cQuery += " AND DPCS_NUM_DOCUMENTO = '"+cPed+"' "
			cQuery += " AND STATUS = 'ER' "
		ElseIf cInterf == "TB_WMSINTERF_TROCA_TP_ESTOQUE"
			cQuery := " UPDATE WMS.TB_WMSINTERF_TROCA_TP_ESTOQUE
			cQuery += " SET STATUS = 'DS'
			cQuery += " WHERE BDE_COD_DEPOSITO = "+alltrim(str(nEmp))
			cQuery += " AND BDE_COD_DEPOSITANTE = "+alltrim(str(nFil))
			cQuery += " AND BDE_QTDE = "+alltrim(str(nQtde))
			cQuery += " AND BDE_DATA_HORA = '"+cDataHr+"' "
			cQuery += " AND BDE_COD_PRODUTO = '"+cProduto+"' "
			cQuery += " AND BDE_COD_TIPO_ESTOQUE_ORIGEM = "+alltrim(str(nLocOri))
			cQuery += " AND BDE_COD_TIPO_ESTOQUE_DESTINO = "+alltrim(str(nLocDest))
			cQuery += " AND BDE_USUARIO = '"+cUser+"' "
			If !Empty(cCodChv)
				cQuery += " AND DPCE_COD_CHAVE = '"+cCodChv+"' "
			EndIf
			cQuery += " AND STATUS = 'ER' "		
		Else
			cQuery	:= ""
		EndIf		
		
		If !Empty(cQuery)
			If TcSqlExec(cQuery) >= 0
				TcSqlExec("COMMIT")
			EndIf
		EndIf
		
	EndIF
Next nI

If !(lSelecao)
	MSGINFO("Nenhum registro foi selecionado.","ATENวรO")
EndIF

//Atualiza o monitor ap๓s desmarcar os registros
NCGC04Cols()

Return(lSelecao)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ PESQUISA  บAutor  ณ Tiago Bizan      บ Data ณ  16/04/13	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para pesquisar na Getdados o conteudo informado 	 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 												      		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PESQUISA(cpCombo,cpEdit1)

If cpCombo == "Pedido"
	nlInd	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'PEDIDO' })
ElseIF cpCombo == "Tipo Interface"
	nlInd	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'INTERF' })
ElseIF cpCombo == "Produto"
	nlInd	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'PROD' })
EndIF

nlPos := ASCAN(olMsNewGet:aCols,{|x| alltrim(x[nlInd])==alltrim(cpEdit1) })

olMsNewGet:GoTo(nlPos)
olMsNewGet:Refresh(.T.)
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ INVERTSELL  บAutor  ณ Tiago Bizan      บ Data ณ  16/04/13  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para inverter a sele็ใo dos registros na Getdados   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 												      		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function INVERTSELL()
For nI := 1 to len(olMsNewGet:aCols)
	If Alltrim(olMsNewGet:aCols[nI][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]) == "LBNO"
		olMsNewGet:aCols[nI][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]	:= "LBTIK"
	Else
		olMsNewGet:aCols[nI][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]	:= "LBNO"
	EndIF
Next nI
olMsNewGet:Refresh()
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ SELREG  บAutor  ณ Tiago Bizan    	  บ Data ณ  16/04/13  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para marca็ใo dos registros na Getdados   		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 												      		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SELREG()

If Alltrim(olMsNewGet:aCols[olMsNewGet:nAt][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]) == "LBNO"
	olMsNewGet:aCols[olMsNewGet:nAt][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]	:= "LBTIK"
Else
	olMsNewGet:aCols[olMsNewGet:nAt][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]	:= "LBNO"
EndIf

olMsNewGet:Refresh()

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ Ordena  บAutor  ณ Tiago Bizan    	  บ Data ณ  16/04/13  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo de ordena็ใo na altera็ใo do Comobo Box   		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 												      		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Ordena(cpCombo,cpEdit1)
cpEdit1 := space(15)
opEdit1:Refresh()

If cpCombo == "Pedido"
	nlIndAux	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'PEDIDO' }) //"5"
ElseIF cpCombo == "Tipo Interface"
	nlIndAux	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'INTERF' })//"9"
ElseIF cpCombo == "Produto"
	nlIndAux	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'PROD' })
EndIF

olMsNewGet:aCols := ASort (olMsNewGet:aCols,,,{|x,y| ALLTRIM(x[nlIndAux]) < ALLTRIM(y[nlIndAux]) } )
olMsNewGet:ForceRefresh()

Return()



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGC04ColsบAutor  ณMicrosiga           บ Data ณ  11/08/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Atualiza o aCols                                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function NCGC04Cols(aCols,lRefresh)

Local cAlias	:= GetNextAlias()
Local cQry		:= ""

Default lRefresh	:= .T.
Default aCols	:= {}

aCols	:= {}

//--ERROS NA INTERFACE DE SUGESTรO TRANSPORTADORA
cQry := " SELECT TRS_COD_DEPOSITO DEPOSITO, 
cQry += " TRS_COD_DEPOSITANTE DEPOSITANTE, 
cQry += " TRS_DATA_EMISSAO EMISSAO,
cQry += " TRS_NUM_DOCUMENTO PEDIDO,
cQry += " TRS_DESCRICAO_CLIENTE CLIENTE,
cQry += " STATUS XSTATUS, 
cQry += " DESC_ERRO,
cQry += " 'TB_FRTINTERF_DOC_SAIDA_TRANSP' INTERF,
cQry += " ' ' PROD, 0 QTDE, 0 LOCORI, 0 LOCDEST, ' ' USUARIO, ' ' COD_CHAVE
cQry += " FROM WMS.TB_FRTINTERF_DOC_SAIDA_TRANSP 
cQry += " WHERE STATUS = 'ER'
cQry += " UNION ALL
//--ERROS NA INTERFACE DE PEDIDOS DE VENDAS
cQry += " SELECT DPCS_COD_DEPOSITO DEPOSITO,
cQry += " DPCS_COD_DEPOSITANTE DEPOSITANTE,
cQry += " DPCS_DATA_EMISSAO EMISSAO,
cQry += " DPCS_NUM_DOCUMENTO PEDIDO,
cQry += " DPCS_DESCRICAO_CLIENTE CLIENTE,
cQry += " STATUS XSTATUS, 
cQry += " DESC_ERRO,
cQry += " 'TB_WMSINTERF_DOC_SAIDA' INTERF,
cQry += " ' ' PROD, 0 QTDE, 0 LOCORI, 0 LOCDEST, ' ' USUARIO, ' ' COD_CHAVE
cQry += " FROM WMS.TB_WMSINTERF_DOC_SAIDA 
cQry += " WHERE STATUS = 'ER'
cQry += " UNION ALL
//-- ERROS NA INTERFACE DE TRANSFERENCIA ENTRE ARMAZENS
cQry += " SELECT BDE_COD_DEPOSITO DEPOSITO, 
cQry += " BDE_COD_DEPOSITANTE DEPOSITANTE, 
cQry += " BDE_DATA_HORA EMISSAO, 
cQry += " ' ' PEDIDO, ' ' CLIENTE, 
cQry += " STATUS XSTATUS, 
cQry += " DESC_ERRO, 
cQry += " 'TB_WMSINTERF_TROCA_TP_ESTOQUE' INTERF,
cQry += " BDE_COD_PRODUTO PROD, 
cQry += " BDE_QTDE QTDE, 
cQry += " BDE_COD_TIPO_ESTOQUE_ORIGEM LOCORI,
cQry += " BDE_COD_TIPO_ESTOQUE_DESTINO LOCDEST, 
cQry += " BDE_USUARIO USUARIO, 
cQry += " DPCE_COD_CHAVE COD_CHAVE
cQry += " FROM WMS.TB_WMSINTERF_TROCA_TP_ESTOQUE WHERE STATUS = 'ER'
cQry += " ORDER BY INTERF, EMISSAO, PEDIDO
Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAlias  ,.F.,.T.)

While (cAlias)->(!EOF())
		
	AADD(aCols,	{	"LBNO"	,;
	(cAlias)->DEPOSITO 		,;
	(cAlias)->DEPOSITANTE	,;
	(cAlias)->EMISSAO		,;
	(cAlias)->PEDIDO		,;
	(cAlias)->CLIENTE		,;
	(cAlias)->XSTATUS		,;
	(cAlias)->DESC_ERRO		,;
	(cAlias)->INTERF		,;
	(cAlias)->PROD	 		,;
	(cAlias)->QTDE			,;
	(cAlias)->LOCORI		,;
	(cAlias)->LOCDEST		,;
	(cAlias)->USUARIO		,;
	(cAlias)->COD_CHAVE		,;
	.F. 	   	   			} )
	
	(cAlias)->(DBSkip())
EndDO
(cAlias)->(dbCloseArea())

If lRefresh
	olMsNewGet:aCols := aCols
	olMsNewGet:ForceRefresh()
EndIf

Return
