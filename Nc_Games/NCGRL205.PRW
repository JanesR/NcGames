#INCLUDE "PROTHEUS.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPRINTSETUP.CH"

User Function NCGRL205()

Local aArea 		:= GetArea()
Local alParams		:= {}
Local lImpRel		:= .T.

Private cAliasTmp	:= GetNextAlias()
Private opReport	:= NIL


If PergRel(@alParams)
	
	If TRepInUse()	//verifica se relatorios personalizaveis esta disponivel
		
		//Verifica se existe dados a serem impressos
		lImpRel := GetDadPP(alParams)
		
		If lImpRel 
			opReport :=  GeraReport(alParams)  
			opReport:SetLandscape()
			opReport:PrintDialog()
		EndIf
		(cAliasTmp)->(DbCloseArea())
		
	Endif
	
	
EndIf

RestArea(aArea)
Return



/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGeraReportบAutor  ณElton C	     บ Data ณ  14/12/09       บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cria o objeto do relatorio e o configura.                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function GeraReport(aParam)

Local olReport	:= NIL

olReport:= TReport():New("U_NCGRL205","Documento de Aceite Publisher","U_NCGRL205",{|opReport|PrintReport(aParam)},"")
olReport:lHeaderVisible		:= .F.	// Nใo imprime cabe็alho do protheus
olReport:lFooterVisible		:= .F.	// Nใo imprime rodap้ do protheus
olReport:lParamPage			:= .F.	// Nใo imprime pagina de parametros
olReport:oPage:nPaperSize	:= 9	// Impressใo em papel A4
olReport:NFONTBODY			:= 9	// TAMANHO DA FONTE

Return olReport


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrintReport บAutor  ณElton C.          บ Data ณ  14/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime o relatorio a partir do array.                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function PrintReport(aParam)

Local aArea			:= GetArea()
Local nLinha		:= 0
Local nContPag		:= 0
Local aInfo			:= {}
Local lIni			:= .T.
Local cPaisAux		:= ""
Local cPPAux		:= ""
Local lVeriQbPais 	:= .F.
Local nTotQtd		:= 0
Local nTotVal		:= 0
Local nTotDolar		:= 0 

//Variaveis de aglutinacao
Local nAgQtd		:= 0
Local nAgTotal  	:= 0
Local nAgDolar		:= 0
Local nVlUnit		:= 0
Local nPag			:= 1


//Variavel de totais por pais
Local aTotaisPais	:= {}

While (cAliasTmp)->(!eof())
	
	
	If lIni == .T.
		
		cPaisAux := (cAliasTmp)->P06_PAIS
		cPPAux	 := (cAliasTmp)->P06_CODPP
		
		If aParam[4] == "1"
			aTotaisPais := GetVlCabec((cAliasTmp)->P06_CODPP, cPaisAux)
			
			lIni := .F.
			aInfo := {}
			aInfo :=	{ ;
			(cAliasTmp)->P06_CODPP,;
			(cAliasTmp)->(Alltrim(B1_COD) + " - " + Alltrim(B1_DESC)),;
			Alltrim((cAliasTmp)->P05_CODBAR),;
			(cAliasTmp)->P05_PUBLIS,;
			(cAliasTmp)->P05_XDTAPL,;
			(cAliasTmp)->P05_DTACEI,;
			(cAliasTmp)->P05_DTEFET,;
			aTotaisPais[2],;
			(cAliasTmp)->P05_TXDOLA,;
			aTotaisPais[3],;
			aTotaisPais[1],;
			(cAliasTmp)->P05_PPPUB,;
			(cAliasTmp)->P05_CONTAT,;
			(cAliasTmp)->P05_CEMAIL ;
			}
			
		Else
			lIni := .F.
			aInfo := {}
			aInfo :=	{ ;
			(cAliasTmp)->P06_CODPP,;
			(cAliasTmp)->(Alltrim(B1_COD) + " - " + Alltrim(B1_DESC)),;
			Alltrim((cAliasTmp)->P05_CODBAR),;
			(cAliasTmp)->P05_PUBLIS,;
			(cAliasTmp)->P05_XDTAPL,;
			(cAliasTmp)->P05_DTACEI,;
			(cAliasTmp)->P05_DTEFET,;
			(cAliasTmp)->TOTAL,;
			(cAliasTmp)->P05_TXDOLA,;
			(cAliasTmp)->P05_DLCONV,;
			(cAliasTmp)->P05_QUANT,;
			(cAliasTmp)->P05_PPPUB,;
			(cAliasTmp)->P05_CONTAT,;
			(cAliasTmp)->P05_CEMAIL ;
			}
			
		EndIf
		
		
		ImpLayOut(aInfo[1],aInfo[2], aInfo[3], aInfo[4], aInfo[5], aInfo[6], aInfo[7], aInfo[8], aInfo[9], aInfo[10], aInfo[11], aInfo[12], aInfo[13], aInfo[14], nPag)
		
	Else
		
		//Verifica se e o mesmo codigo de price para efetuar a quebra da pagina
		If cPPAux	 != (cAliasTmp)->P06_CODPP
			
			//Imprime o total do item anterior
			ImpLinTotal(nLinha, nTotQtd, nTotVal, nTotDolar )
			nTotQtd		:= 0
			nTotVal		:= 0
			nTotDolar	:= 0
			nPag		:= 1
			
			cPPAux	 := (cAliasTmp)->P06_CODPP
			cPaisAux := (cAliasTmp)->P06_PAIS
			
			//Quebra pagina
			QbrPag(nContPag)
			
			//Atualiza o cabe็alho
			If aParam[4] == "1"
				aTotaisPais := GetVlCabec((cAliasTmp)->P06_CODPP, cPaisAux)
				
				
				aInfo := {}
				aInfo :=	{ ;
				(cAliasTmp)->P06_CODPP,;
				(cAliasTmp)->(Alltrim(B1_COD) + " - " + Alltrim(B1_DESC)),;
				Alltrim((cAliasTmp)->P05_CODBAR),;
				(cAliasTmp)->P05_PUBLIS,;
				(cAliasTmp)->P05_XDTAPL,;
				(cAliasTmp)->P05_DTACEI,;
				(cAliasTmp)->P05_DTEFET,;
				aTotaisPais[2],;
				(cAliasTmp)->P05_TXDOLA,;
				aTotaisPais[3],;
				aTotaisPais[1],;
				(cAliasTmp)->P05_PPPUB,;
				(cAliasTmp)->P05_CONTAT,;
				(cAliasTmp)->P05_CEMAIL ;
				}
				
			Else
				
				aInfo := {}
				aInfo :=	{ ;
				(cAliasTmp)->P06_CODPP,;
				(cAliasTmp)->(Alltrim(B1_COD) + " - " + Alltrim(B1_DESC)),;
				Alltrim((cAliasTmp)->P05_CODBAR),;
				(cAliasTmp)->P05_PUBLIS,;
				(cAliasTmp)->P05_XDTAPL,;
				(cAliasTmp)->P05_DTACEI,;
				(cAliasTmp)->P05_DTEFET,;
				(cAliasTmp)->TOTAL,;
				(cAliasTmp)->P05_TXDOLA,;
				(cAliasTmp)->P05_DLCONV,;
				(cAliasTmp)->P05_QUANT,;
		  		(cAliasTmp)->P05_PPPUB,;
		  		(cAliasTmp)->P05_CONTAT,;
		  		(cAliasTmp)->P05_CEMAIL ;
				}
				
			EndIf
			

			ImpLayOut(aInfo[1],aInfo[2], aInfo[3], aInfo[4], aInfo[5], aInfo[6], aInfo[7], aInfo[8], aInfo[9], aInfo[10], aInfo[11], aInfo[12], aInfo[13], aInfo[14], nPag)
			
			nLinha 		:= 0
			nContPag 	:= 0
			lVeriQbPais := .F.
		Else
			lVeriQbPais	:= .T.
		EndIf
		
		
		//Verifica se quebra pagina por pais
		If aParam[4] == "1" .And. lVeriQbPais
			
			If cPaisAux != (cAliasTmp)->P06_PAIS
				
				//Imprime o total do item anterior
				ImpLinTotal(nLinha, nTotQtd, nTotDolar, nTotVal )
				nTotQtd		:= 0
				nTotVal		:= 0
				nTotDolar	:= 0  
				nPag		:= 1
				
				cPaisAux := (cAliasTmp)->P06_PAIS
				
				//Quebra pagina
				QbrPag(nContPag)
				
				//Atualiza o cabe็alho
				If aParam[4] == "1"
					aTotaisPais := GetVlCabec((cAliasTmp)->P06_CODPP, cPaisAux)
					
					
					aInfo := {}
					aInfo :=	{ ;
					(cAliasTmp)->P06_CODPP,;
					(cAliasTmp)->(Alltrim(B1_COD) + " - " + Alltrim(B1_DESC)),;
					Alltrim((cAliasTmp)->P05_CODBAR),;
					(cAliasTmp)->P05_PUBLIS,;
					(cAliasTmp)->P05_XDTAPL,;
					(cAliasTmp)->P05_DTACEI,;
					(cAliasTmp)->P05_DTEFET,;
					aTotaisPais[2],;
					(cAliasTmp)->P05_TXDOLA,;
					aTotaisPais[3],;
					aTotaisPais[1],;
		  			(cAliasTmp)->P05_PPPUB,;
		   			(cAliasTmp)->P05_CONTAT,;
		  			(cAliasTmp)->P05_CEMAIL ;
					}
					
				Else
					
					aInfo := {}
					aInfo :=	{ ;
					(cAliasTmp)->P06_CODPP,;
					(cAliasTmp)->(Alltrim(B1_COD) + " - " + Alltrim(B1_DESC)),;
					Alltrim((cAliasTmp)->P05_CODBAR),;
					(cAliasTmp)->P05_PUBLIS,;
					(cAliasTmp)->P05_XDTAPL,;
					(cAliasTmp)->P05_DTACEI,;
					(cAliasTmp)->P05_DTEFET,;
					(cAliasTmp)->TOTAL,;
					(cAliasTmp)->P05_TXDOLA,;
					(cAliasTmp)->P05_DLCONV,;
					(cAliasTmp)->P05_QUANT ,;
					(cAliasTmp)->P05_PPPUB,;
					(cAliasTmp)->P05_CONTAT,;
					(cAliasTmp)->P05_CEMAIL ;
					}
					
				EndIf
				
				ImpLayOut(aInfo[1],aInfo[2], aInfo[3], aInfo[4], aInfo[5], aInfo[6], aInfo[7], aInfo[8], aInfo[9], aInfo[10], aInfo[11],aInfo[12], aInfo[13], aInfo[14], nPag)
				nLinha := 0
				nContPag := 0
				
				
			EndIf
		EndIf
		
	EndIf
	
	
	//Verifica a necessidade de pular pagina
	If nContPag >= 22
		nContPag := 0
		nLinha := 0
		
		++nPag
		ImpLayOut(aInfo[1],aInfo[2], aInfo[3], aInfo[4], aInfo[5], aInfo[6], aInfo[7], aInfo[8], aInfo[9], aInfo[10], aInfo[11], aInfo[12], aInfo[13], aInfo[14],nPag)
	EndIf
	
	
	//Impressใo dos itens aglutinados
	If aParam[5] == '1'
		
		nAgQtd		:= 0
		nAgTotal  	:= 0
		nAgDolar	:= 0 
		nCOld		:= 0
		nCNew       := 0
		
		If aParam[5] == "1"
			
			While (cAliasTmp)->(!eof()) .And. (cPaisAux == (cAliasTmp)->P06_PAIS) .And. ((cAliasTmp)->P06_CODPP == cPPAux)
				
				nAgQtd		+= (cAliasTmp)->P06_QUANT
				nAgTotal  	+= (cAliasTmp)->P06_TOTAL
				nAgDolar	+= (cAliasTmp)->P06_DLCONV
				nVlUnit		:= (cAliasTmp)->P06_VLUNIT
				nCOld		:= (cAliasTmp)->P06_COLD
				nCNew       := (cAliasTmp)->P06_CNEW
						
				(cAliasTmp)->(DbSkip())
			EndDo
			
			//Imprime a linha do relatorio
			ImpLinha(@nLinha, @nContPag,Alltrim(GetDescPa(cPaisAux)), "--------", "---", "---",;
				   		nAgQtd, nCOld, nCNew, (nAgDolar / nAgQtd) , nAgDolar , nVlUnit, nAgTotal )
			nTotQtd		+= nAgQtd
			nTotVal		+= nAgTotal
			nTotDolar	+= nAgDolar
			nPag		:= 1                           
			//cPaisAux := (cAliasTmp)->P06_PAIS 
		Else
			
			While (cAliasTmp)->(!eof()) .And. ((cAliasTmp)->P06_CODPP == cPPAux)
				
				If cPaisAux != (cAliasTmp)->P06_PAIS
					//Imprime a linha do relatorio
					ImpLinha(@nLinha,@nContPag, Alltrim(GetDescPa(cPaisAux)), "--------", "---", "--",; 
								nAgQtd, nCOld, nCNew, (nAgDolar / nAgQtd) , nAgDolar , (cAliasTmp)->P06_VLUNIT, nAgTotal )
							  //nAgQtd, (cAliasTmp)->P06_VLUNIT, nAgTotal, (nAgDolar / nAgQtd) , nAgDolar, nCOld, nCNew ) Removido Lucas Oliveira
					
					nTotQtd		+= nAgQtd
					nTotVal		+= nAgTotal
					nTotDolar	+= nAgDolar
					
					nAgQtd		:= 0
					nAgTotal  	:= 0
					nAgDolar	:= 0 
					nCOld		:= 0
					nCNew       := 0
								
					//pula linha do layout do relatorio
					nLinha += 60
					cPaisAux := (cAliasTmp)->P06_PAIS
				EndIf
				
				nAgQtd		+= (cAliasTmp)->P06_QUANT
				nAgTotal  	+= (cAliasTmp)->P06_TOTAL
				nAgDolar	+= (cAliasTmp)->P06_DLCONV
				nVlUnit		:= (cAliasTmp)->P06_VLUNIT
				nCOld		:= (cAliasTmp)->P06_COLD
				nCNew       := (cAliasTmp)->P06_CNEW
				(cAliasTmp)->(DbSkip())
			EndDo
			
			//Imprime a linha do relatorio
			ImpLinha(@nLinha, @nContPag,Alltrim(GetDescPa(cPaisAux)), "--------", "---", "--",;
						nAgQtd, nCOld, nCNew, (nAgDolar / nAgQtd) , nAgDolar , nVlUnit, nAgTotal )
			nTotQtd		+= nAgQtd
			nTotVal		+= nAgTotal
			nTotDolar	+= nAgDolar
			nPag		:= 1
		Endif
		
	Else
		
		//Imprime a linha do relatorio
		ImpLinha(@nLinha,@nContPag, Alltrim(GetDescPa((cAliasTmp)->P06_PAIS)), Alltrim((cAliasTmp)->A1_NOME), Alltrim((cAliasTmp)->A1_COD), (cAliasTmp)->A1_LOJA,;
		(cAliasTmp)->P06_QUANT, (cAliasTmp)->P06_COLD, (cAliasTmp)->P06_CNEW, ((cAliasTmp)->P06_DLCONV /(cAliasTmp)->P06_QUANT), (cAliasTmp)->P06_DLCONV,;
		(cAliasTmp)->P06_VLUNIT, (cAliasTmp)->P06_TOTAL)
		
		nTotQtd		+= (cAliasTmp)->P06_QUANT
		nTotVal		+= (cAliasTmp)->P06_TOTAL
		nTotDolar	+= (cAliasTmp)->P06_DLCONV
		nPag 		:= 1
	EndIf
	
	//pula linha do objeto treport para depois efetuar a quebra de pagina
	If nContPag > 21
		opReport:SkipLine(nContPag)
		nPag := 1
	EndIf                             

	//pula linha do layout do relatorio
	nLinha += 60
	
	//Conta linha para pular a pagina
	++nContPag
	
	If aParam[5] != '1'
		(cAliasTmp)->(DbSkip())
	EndIf
EndDo


//Imprime o total do item anterior
ImpLinTotal(nLinha, nTotQtd, nTotVal, nTotDolar )
nTotQtd		:= 0
nTotVal		:= 0
nTotDolar	:= 0
nPag		:= 1

RestArea(aArea)
Return



/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQbrPag	บAutor  ณElton C.            บ Data ณ  14/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณQuaebra pagina						                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function QbrPag(nContPag)

Local aArea 	:= GetArea()
Local nX		:= 0
Local nCont		:= 15
Local nTotLin	:= 22 -nContPag

opReport:EndPage()
For nX := 1 To nTotLin
	opReport:PrintText("",0100,0750)
	opReport:SkipLine((nCont-14)+nX)
Next

RestArea(aArea)
Return


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpLayOut บAutor  ณElton C.            บ Data ณ  14/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime o relatorio a partir do array.                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ImpLayOut(cNumPP, cCodDescP, cCodBarra, cPublisher, dDataPubl, dDataAceit, dDataEfet, nTotal,nTaxa, nTotalDolar, nQuantidade,;
				cPPPub, cContat, cCEmail, nPag)

Local aArea := GetArea()

Default	cNumPP 		:= ""
Default cCodDescP	:= ""
Default cCodBarra	:= ""
Default	cPublisher	:= ""
Default dDataPubl	:= CTOD('')
Default dDataAceit	:= CTOD('')
Default dDataEfet	:= CTOD('')
Default nTotal		:= 0
Default nTaxa		:= 0
Default nTotalDolar	:= 0
Default nQuantidade	:= 0
Default cPPPub		:= ""
Default cContat		:= ""
Default cCEmail		:= ""

oFont10		:= TFont():New("Tahoma",10,10,,.F.,,,,.T.,.F.)
oFont10n	:= TFont():New("Tahoma",10,10,,.T.,,,,.T.,.F.)
oFont11		:= TFont():New("Tahoma",11,11,,.F.,,,,.T.,.F.)
oFont11n	:= TFont():New("Tahoma",11,11,,.T.,,,,.T.,.F.)
oFont12		:= TFont():New("Tahoma",12,12,,.F.,,,,.T.,.F.)
oFont12n	:= TFont():New("Tahoma",12,12,,.T.,,,,.T.,.F.)
oFont13		:= TFont():New("Tahoma",13,13,,.F.,,,,.T.,.F.)
oFont14n	:= TFont():New("Tahoma",14,14,,.T.,,,,.T.,.F.)
oFont15		:= TFont():New("Tahoma",15,15,,.F.,,,,.T.,.F.)
oFont15n	:= TFont():New("Tahoma",15,15,,.T.,,,,.T.,.F.)
oFont16		:= TFont():New("Tahoma",16,16,,.F.,,,,.T.,.F.)
oFont16n	:= TFont():New("Tahoma",16,16,,.T.,,,,.T.,.F.)
oFont17		:= TFont():New("Tahoma",17,17,,.F.,,,,.T.,.F.)
oFont17n	:= TFont():New("Tahoma",17,17,,.T.,,,,.T.,.F.)

Private oFont10, oFont10n, oFont11, oFont11n, oFont12, oFont12n, oFont13, oFont14n, oFont15, oFont15n, oFont16, oFont16n, oPrint17, oPrint17n

//opReport:StartPage()

//Imprime o retangulo do do layout
/*opReport:Line(0140,0030,0140,2250)
opReport:Line(0140,0030,3200,0030)
opReport:Line(0140,2250,3200,2250)
opReport:Line(3200,0030,3200,2250)*/

opReport:Box(0040,0040,2250,3000) //Box add Lucas Oliveira
opReport:Box(0041,0041,2249,2999)//Box add Lucas Oliveira
opReport:Box(0042,0042,2248,2998)//Box add Lucas Oliveira

//Linha que separa o cabe็alho dos itens
/*opReport:Line(0680,0030,0680,2250)
opReport:Line(0690,0030,0690,2250)*/

opReport:Box(0050,0050,0680,2990)
opReport:Box(0690,0050,2240,2990)

//Dados do cabe็aho
ImpCabec(cNumPP, cCodDescP, cCodBarra, cPublisher, dDataPubl, dDataAceit, dDataEfet, nTotal,nTaxa, nTotalDolar, nQuantidade, cPPPub, cContat, cCEmail)

ImpLogoEmp(nPag)

//Imprime o cabe็alho das colunas
ImpCabecIt()

//Imprime assinatura
//ImpAss("Teste")


RestArea(aArea)
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpCabec 	บAutor  ณElton C.            บ Data ณ  14/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime o cabe็alho					                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ImpCabec(cNumPP, cCodDescP, cCodBarra, cPublisher, dDataPubl, dDataAceit, dDataEfet, nTotal,nTaxa, nTotalDolar, nQuantidade, cPPPub, cContat, cCEmail)

Local aArea := GetArea()

Default	cNumPP 		:= ""
Default cCodDescP	:= ""
Default cCodBarra	:= ""
Default	cPublisher	:= ""
Default dDataPubl	:= CTOD('')
Default dDataAceit	:= CTOD('')
Default dDataEfet	:= CTOD('')
Default nTotal		:= 0
Default nTaxa		:= 0
Default nTotalDolar	:= 0
Default nQuantidade	:= 0
Default cPPPub		:= ""
Default cContat		:= ""
Default cCEmail		:= ""

opReport:PrintText("",0100,0750)
opReport:Say(0200,0730,"PRICE PROTECTION - APPROVAL DOCUMENT - PUBLISHER",oFont17n)

opReport:Say(0340,0120,"Price Protection Number: "+cPPPub,oFont12) 
opReport:Say(0340,1420,"PP Ncgames: "+cNumPP,oFont12)     

opReport:Say(0400,0120,"Product: "+cCodDescP,oFont12)
opReport:Say(0400,1420,"Barcode: "+cCodBarra,oFont12)
opReport:Say(0400,2160,"Publisher: "+cPublisher,oFont12)  

opReport:Say(0460,0120,"Effective Date: "+dtoc(dDataPubl),oFont12)
opReport:Say(0460,1420,"Approval Date: "+dtoc(dDataAceit),oFont12)
opReport:Say(0460,2160,"Credit Application: "+dtoc(dDataEfet),oFont12)

opReport:Say(0520,0120,"Total amount(U$):"+Transform(nTotalDolar,"@E 999,999,999.99"),oFont12)
opReport:Say(0520,0800,"Exchange currency: "+Transform(nTaxa,"@E 999,999,999.9999"),oFont12)
opReport:Say(0520,1420,"Total amount(R$): "+Transform(nTotal,"@E 999,999,999.99"),oFont12)
opReport:Say(0520,2160,"Quantity: "+Transform(nQuantidade,"@E 999,999,999.99"),oFont12)
                                                                                                  
opReport:Say(0580,0120,"Contact: "+cContat,oFont12)
opReport:Say(0580,1420,"Email: "+cCEmail,oFont12)


RestArea(aArea)
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpCabecItบAutor  ณElton C.            บ Data ณ  14/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime o cabe็alho dos itens		                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ImpCabecIt()

Local aArea := GetArea()

//Linha do cabe็alho
opReport:Line(0820,0050,0820,2990)

//Linha de separa็ใo das colunas
//opReport:Line(0690,0260,0820,260)//COL1
opReport:Line(0690,0760,0820,0760)//Cliente
opReport:Line(0690,980,0820,980)//Loja
opReport:Line(0690,1120,0820,1120)//Quantidade
opReport:Line(0690,1300,0820,1300)//Custo
opReport:Line(0690,1540,0820,1540)//Custo
opReport:Line(0690,1752,0820,1752)//Repasse
opReport:Line(0750,1992,0820,1992)//total
opReport:Line(0690,2376,0820,2376)//Repasse
opReport:Line(0750,2616,0820,2616)//Total


//Linha utiliza para separa a descri็ใo de repasse
opReport:Line(0750,1752,0750,2990)


//Imprime a descri็ใo das colunas
//opReport:Say(0750,0045,"PAIS",oFont12)
opReport:Say(0720,0060,"Description",oFont12)
opReport:Say(0700,0780,"Retailer",oFont12)
opReport:Say(0750,0800,"Code",oFont12)
opReport:Say(0700,0990,"Retailer",oFont12)
opReport:Say(0750,1000,"Store",oFont12)
opReport:Say(0720,1130,"Quantity",oFont12)

opReport:Say(0700,1350,"Original",oFont12)
opReport:Say(0750,1370,"Cost",oFont12)
opReport:Say(0700,1570,"New",oFont12)
opReport:Say(0750,1570,"Cost",oFont12)

opReport:Say(0700,1880,"Markdown credit due U$",oFont12)
opReport:Say(0700,2480,"Markdown credit due R$",oFont12)

opReport:Say(0750,1790,"Unity",oFont12)
opReport:Say(0750,2030,"Total",oFont12)
opReport:Say(0750,2410,"Unity",oFont12)
opReport:Say(0750,2670,"Total",oFont12)

RestArea(aArea)
Return


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpLinha  บAutor  ณElton C.            บ Data ณ  14/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Efetua a impressใo da linha			                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ImpLinha(nLinha, nContPag, cPais, cNomCli, cCodigo, cLoja, nQuantidade, nCOld, nCNew, nValUnitDol, nTotalDolar, nValUnit, nTotal )

Local aArea := GetArea()

Local lQbrLinha		:= .F.

Default nLinha 		:= 0
Default cPais		:= ""
Default cNomCli		:= ""
Default cCodigo		:= ""
Default cLoja		:= ""
Default nQuantidade := 0
Default nValUnit	:= 0
Default nTotal		:= 0
Default nValUnitDol	:= 0
Default nTotalDolar	:= 0     
Default nCOld		:= 0 
Default nCNew		:= 0


/*//Imprime o pais
aDescAux 	:= {}
aDescAux := GetQbrDesc(cPais,10,2)
If Len(aDescAux ) > 1
	opReport:PrintText(aDescAux[1],0825+nLinha,0045)
	opReport:PrintText(aDescAux[2],0825+nLinha+60,0045)
	lQbrLinha := .T.
Else                                                            
	opReport:PrintText(cPais,0825+nLinha,0045)
EndIf */


//Imprime o cliente
aDescAux 	:= {}
aDescAux := GetQbrDesc(cNomCli,40,2)
If Len(aDescAux ) > 1
	opReport:PrintText(aDescAux[1],0825+nLinha,0060)
	opReport:PrintText(aDescAux[2],0825+nLinha+60,0060)
	lQbrLinha := .T.
Else                                                            
	opReport:PrintText(cNomCli,0825+nLinha,0060)
EndIf



//Imprime o codigo do cliente
aDescAux 	:= {}
aDescAux := GetQbrDesc(cCodigo,15,2)
If Len(aDescAux ) > 1
	opReport:PrintText(aDescAux[1],0825+nLinha,0780)
	opReport:PrintText(aDescAux[2],0825+nLinha+60,0780)
	lQbrLinha := .T.
Else                                                            
	opReport:PrintText(cCodigo,0825+nLinha,0780)
EndIf

opReport:PrintText(cLoja,0825+nLinha,1000)

opReport:PrintText(Transform(nQuantidade,"@E 999,999,999")	 ,0825+nLinha,	1230 -(	Len(Transform(nQuantidade,"@E 999,999,999.99")) * 12   )   )

opReport:PrintText(Transform(nCOld		,"@E 999,999.9999"),0825+nLinha,	1410 -(	Len(Transform(nCOld,"@E 999,999.9999")) * 12   ))
opReport:PrintText(Transform(nCNew 		,"@E 999,999.9999"),0825+nLinha,	1600 -(	Len(Transform(nCNew,"@E 999,999.9999")) * 12   ))

opReport:PrintText(Transform(nValUnitDol,"@E 999,999,999.9999"),0825+nLinha,1850 -(	Len(Transform(nValUnitDol,"@E 999,999,999.9999")) * 12   ))
opReport:PrintText(Transform(nTotalDolar,"@E 999,999,999.99"),0825+nLinha,	2240 -(	Len(Transform(nTotalDolar,"@E 999,999,999.99")) * 12   ))   

opReport:PrintText(Transform(nValUnit	,"@E 999,999,999.9999"),0825+nLinha,2470 -(	Len(Transform(nValUnit,"@E 999,999,999.9999")) * 12   ) )
opReport:PrintText(Transform(nTotal		,"@E 999,999,999.99"),0825+nLinha,	2860 -(	Len(Transform(nTotal,"@E 999,999,999.99")) * 12   )) 


//Pula linha para os outros itens em caso de quebra de linha
If lQbrLinha 
	nLinha += 60
	nContPag += 1
EndIF

//Linha de separa็ใo
opReport:Line(0880+nLinha,0050,0880+nLinha,2990)

//Colunas das linhas
//opReport:Line(0880+nLinha,260 ,0820,260)//COL1
opReport:Line(0880+nLinha,0760,0820,0760)//COL2
opReport:Line(0880+nLinha,0980,0820,0980)//COL3
opReport:Line(0880+nLinha,1120,0820,1120)//COL4
opReport:Line(0880+nLinha,1300,0820,1300)//COL3
opReport:Line(0880+nLinha,1540,0820,1540)//COL4
opReport:Line(0880+nLinha,1752,0820,1752)//COL5
opReport:Line(0880+nLinha,1992,0820,1992)//COL6
opReport:Line(0880+nLinha,2376,0820,2376)//COL7
opReport:Line(0880+nLinha,2616,0820,2616)//COL8
                                                
RestArea(aArea)
Return


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpLinha  บAutor  ณElton C.            บ Data ณ  14/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime a linha com os totais		                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ImpLinTotal(nLinha, nQuantidade, nTotalDolar, nTotal )

Local aArea := GetArea()

Default nLinha 		:= 0
Default nQuantidade := 0
Default nTotal		:= 0
Default nTotalDolar	:= 0  

//Imprime o conteudo da linha
opReport:PrintText("Totals",0825+nLinha,0060)

opReport:PrintText(Transform(nQuantidade	,"@E 999,999,999")	 ,0825+nLinha,	1230 -(	Len(Transform(nQuantidade,"@E 999,999,999.99")) * 12   )  )
opReport:PrintText(Transform(nTotalDolar	,"@E 999,999,999.99"),0825+nLinha,	2240 -(	Len(Transform(nTotalDolar,"@E 999,999,999.99")) * 12   ))
opReport:PrintText(Transform(nTotal			,"@E 999,999,999.99"),0825+nLinha,	2860 -(	Len(Transform(nTotal,"@E 999,999,999.99")) * 12   ))


//Linha de separa็ใo
opReport:Line(0880+nLinha,0050,0880+nLinha,2990)

//Colunas das de colunas
opReport:Line(0880+nLinha,1120,0820,1120)//COL4
opReport:Line(0880+nLinha,1300,0820,1300)//COL3
opReport:Line(0880+nLinha,1540,0820,1540)//COL4
opReport:Line(0880+nLinha,1752,0820,1752)//COL5
opReport:Line(0880+nLinha,1992,0820,1992)//COL6
opReport:Line(0880+nLinha,2376,0820,2376)//COL7
opReport:Line(0880+nLinha,2616,0820,2616)//COL8


RestArea(aArea)
Return




/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpAss	บAutor  ณElton C.            บ Data ณ  14/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime linha para assinatura		                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ImpAss(cNomPublis)

Local aArea := GetArea()

Default cNomPublis := ""

opReport:Line(3050,1700 ,3010,2310)
opReport:PrintText(cNomPublis,3050,1660)

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPergRel	บAutor  ณElton C.		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Perguntas a serem utilizadas no filtro do relatorio        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergRel(alParams)

Local alParamBox := {}
Local llRet      := .T.

AADD(alParamBox,{1,"Campanha Publisher:"					,Space(TAMSX3("P0C_PPPUB")[1])		,"@!"	,"","P0C","",70,.F.})
AADD(alParamBox,{1,"Price Protection de:"					,Space(TAMSX3("P05_CODPP")[1])		,"@!"	,"","P05","",70,.F.})
AADD(alParamBox,{1,"Price Protection at้:"					,Space(TAMSX3("P05_CODPP")[1])		,"@!"	,"","P05","",70,.F.})
aAdd(alParamBox,{2,"Quebra por paํs ?"			,"1"	, {"1=Sim","2=Nใo"}	, 40,".T."					,.F.})
aAdd(alParamBox,{2,"Aglutina valores ?"			,"1"	, {"1=Sim","2=Nใo"}	, 40,".T."					,.F.})



llRet := ParamBox(alParamBox, "Parโmetros", alParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .t., .t.)

Return llRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFun็ใo    ณGetDados	บAutor  ณElton C.            บ Data ณ  12/20/12  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Executa a query para sele็ใo dos dados do Price Protection บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC GAMES - COMERCIAL                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetDadPP(aParam)

Local cSql	:= ""
Local lOk	:= .T.

cSql	:= " SELECT "+CRLF
cSql	+= " 		  P05_CODPP "+CRLF
cSql	+= " 		  ,P05_XDTAPL "+CRLF
cSql	+= " 		  ,P05_DTACEI "+CRLF
cSql	+= " 		  ,P05_DLCONV  "+CRLF
cSql	+= " 		 ,B1_COD "+CRLF
cSql	+= " 		 ,B1_DESC "+CRLF
cSql	+= " 		 ,P05_CODBAR "+CRLF
cSql	+= " 		 ,P05_QUANT "+CRLF
//cSql	+= " 		 ,( P05_QUANT*P05_VALOR ) AS TOTAL "
cSql	+= " 		 ,P05_NCUSTO AS TOTAL "+CRLF
cSql	+= " 		 ,P05_TXDOLA "+CRLF
cSql	+= " 		 ,P05_DTEFET "+CRLF
cSql	+= " 		 ,P05_PUBLIS "+CRLF
cSql	+= " 		 ,P06_CODPP "+CRLF
cSql	+= " 		 ,P06_PAIS "+CRLF
cSql	+= " 		 ,P06_DPAIS "+CRLF
cSql	+= " 		 ,A1_COD "+CRLF
cSql	+= " 		 ,A1_LOJA "+CRLF
cSql	+= " 		 ,A1_NOME "+CRLF
cSql	+= " 		 ,P06_CUSTAT "+CRLF
cSql	+= " 		 ,P06_NCUSTO "+CRLF
cSql	+= " 		 ,SUM(P06_QUANT) AS P06_QUANT "+CRLF
cSql	+= " 		 ,SUM(P06_TOTAL) AS P06_TOTAL "+CRLF
cSql	+= " 		 ,SUM(P06_VLUNIT) AS P06_VLUNIT "+CRLF
cSql	+= " 		 ,SUM(P06_DLCONV) AS P06_DLCONV "+CRLF
cSql	+= " 		 ,P05_PPPUB "+CRLF
cSql	+= " 		 ,P05_CONTAT "+CRLF
cSql	+= " 		 ,P05_CEMAIL "+CRLF
cSql	+= " 		 ,P06_COLD "+CRLF
cSql	+= " 	 	 ,P06_CNEW "+CRLF
cSql	+= " FROM " + RetSqlName("P05")  + " P05 "+CRLF

cSql	+= " INNER JOIN " + RetSqlName("SB1") + " SB1 "+CRLF
cSql	+= " ON B1_FILIAL = '" + xFilial("SB1") + "' "+CRLF
cSql	+= " AND B1_COD = P05_CODPRO "+CRLF
cSql	+= " AND SB1.D_E_L_E_T_ = ' ' "+CRLF

cSql	+= " INNER JOIN " + RetSqlName("P06") + " P06 "+CRLF
cSql	+= " ON P06_FILIAL = '" + xFilial("P06") + "' "+CRLF
cSql	+= " AND P06_CODPP = P05_CODPP "+CRLF
cSql	+= " AND P06.D_E_L_E_T_ = ' ' "+CRLF

cSql	+= " INNER JOIN " + RetSqlName("SA1") + " SA1 "+CRLF
cSql	+= " ON A1_FILIAL = '" + xFilial("SA1") + "' "+CRLF
cSql	+= " AND A1_COD = P06_CLIENT "+CRLF
cSql	+= " AND A1_LOJA = P06_LOJA "+CRLF
cSql	+= " AND SA1.D_E_L_E_T_ = ' ' "+CRLF

cSql	+= " WHERE P05_FILIAL = '" + xFilial("P05") + "' "  +CRLF
cSql	+= " AND P05_PPPUB = '"+aParam[1]+"' "
cSql	+= " AND P05_CODPP BETWEEN '" + Padr(aParam[2],TamSx3("P05_CODPP")[1]) +  "' AND '" + Padr(aParam[3],TamSx3("P05_CODPP")[1]) + "' "+CRLF
cSql	+= " AND P05.D_E_L_E_T_ = ' ' "+CRLF
cSql	+= " GROUP BY "+CRLF
cSql	+= " 		P05_CODPP "+CRLF
cSql	+= " 		,P05_XDTAPL "+CRLF
cSql	+= " 		,P05_DTACEI "+CRLF
cSql	+= " 		,P05_DLCONV "+CRLF
cSql	+= " 		,B1_COD "+CRLF
cSql	+= " 		,B1_DESC "+CRLF
cSql	+= " 		,P05_CODBAR "+CRLF
cSql	+= " 		,P05_QUANT "+CRLF
cSql	+= " 		,P05_PUBLIS "+CRLF
cSql	+= " 		,P05_NCUSTO "+CRLF
//cSql	+= " 		,( P05_QUANT*P05_VALOR ) "
cSql	+= " 		,P05_TXDOLA "+CRLF
cSql	+= " 		,P05_DTEFET "+CRLF
cSql	+= " 		,P06_CODPP "+CRLF
cSql	+= " 		,P06_PAIS "+CRLF
cSql	+= " 		,P06_DPAIS "    +CRLF
cSql	+= " 		 ,A1_COD "+CRLF
cSql	+= " 		 ,A1_LOJA "+CRLF
cSql	+= " 		 ,A1_NOME "+CRLF
cSql	+= " 		,P06_CUSTAT "+CRLF
cSql	+= " 		,P06_NCUSTO "+CRLF
cSql	+= " 		,P05_PPPUB "+CRLF
cSql	+= " 		,P05_CONTAT "+CRLF
cSql	+= " 		,P05_CEMAIL "+CRLF
cSql	+= " 		,P06_COLD "+CRLF
cSql	+= " 		,P06_CNEW "+CRLF
cSql	+= " 		ORDER BY "+CRLF
cSql	+= " 		 P06_CODPP, P05_CODPP "+CRLF

//Aviso("Query",cSql, {"Ok"}, 3)

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cSql), cAliasTmp , .F., .T.)

TcSetField(cAliasTmp,"P05_QUANT"	,"N",TamSx3("P05_QUANT")[1]		,TamSx3("P05_QUANT")[2])
TcSetField(cAliasTmp,"P06_QUANT"	,"N",TamSx3("P06_QUANT")[1]		,TamSx3("P06_QUANT")[2])
TcSetField(cAliasTmp,"P06_TOTAL"	,"N",TamSx3("P06_TOTAL")[1]		,TamSx3("P06_TOTAL")[2])
TcSetField(cAliasTmp,"TOTAL"		,"N",TamSx3("P05_QUANT")[1]		,TamSx3("P05_QUANT")[2])
TcSetField(cAliasTmp,"P05_TXDOLA"	,"N",TamSx3("P05_TXDOLA")[1]	,TamSx3("P05_TXDOLA")[2])
TcSetField(cAliasTmp,"P05_DTEFET"	,"D",TamSx3("P05_DTEFET")[1]	,TamSx3("P05_DTEFET")[2])
TcSetField(cAliasTmp,"P05_DTACEI"	,"D",TamSx3("P05_DTEFET")[1]	,TamSx3("P05_DTEFET")[2])
TcSetField(cAliasTmp,"P05_XDTAPL"	,"D",TamSx3("P05_DTEFET")[1]	,TamSx3("P05_DTEFET")[2])
TcSetField(cAliasTmp,"P06_COLD"		,"N",TamSx3("P06_COLD")[1]		,TamSx3("P06_COLD")[2])
TcSetField(cAliasTmp,"P06_CNEW"		,"N",TamSx3("P06_CNEW")[1]		,TamSx3("P06_CNEW")[2])

(cAliasTmp)->(DbGoTop())

If (cAliasTmp)->(Eof()) .And. (cAliasTmp)->(Bof())
	lOk := .F.
	
	Aviso("NCGRL205-01"														;
			,"Nใo foi encontrado nenhum registro com os parโmetros escolhidos"	;
			,{"Ok"}																;
			,3																	;
			,"Nenhum registro encontrado")
EndIf

(cAliasTmp)->(DbGoTop())

Return(lOk)
 


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetVlCabecบAutor  ณElton C.            บ Data ณ  14/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna os valores do cabe็alho se houver quebra por pais   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function GetVlCabec(cCopPP, cCodPais)

Local aArea		:= GetArea()
Local cQuery 	:= ""
Local cArqP06   := GetNextAlias()
Local aRet		:= {}

Default cCopPP 		:= ""
Default cCodPais    := ""                  

cQuery += " SELECT SUM(P06_QUANT) AS QUANTIDADE, SUM(P06_TOTAL) AS TOTAL,SUM(P06_DLCONV) AS VALORDOLAR FROM "+RetSqlName("P06")
cQuery += " WHERE D_E_L_E_T_ = ' ' "
cQuery += " AND P06_FILIAL = '"+xFilial("P06")+"' "
cQuery += " AND P06_CODPP = '"+cCopPP+"' "
cQuery += " AND P06_PAIS = '"+cCodPais+"' "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqP06 , .F., .T.)

(cArqP06)->(DbGoTop())
If (cArqP06)->(!Eof())
	aAdd(aRet, (cArqP06)->QUANTIDADE)
	aAdd(aRet, (cArqP06)->TOTAL)	 
	aAdd(aRet, (cArqP06)->VALORDOLAR)	 
Else 
	aRet := {0,0,0}
EndIf 


(cArqP06)->(DbCloseArea())

RestArea(aArea)
Return aRet



/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetDescPa บAutor  ณElton C.            บ Data ณ  14/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a descri็ใo dos paises							  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function GetDescPa(cCodPais)

Local aArea := GetArea()
Local cRet	:= ""

Default cCodPais := ""
                    

If !Empty(cCodPais)
	DbSelectArea("SYA")
	DbSetOrder(1)
	If SYA->(DbSeek(xFilial("SYA") + cCodPais))
		cRet := SYA->YA_DESCR
	EndIf
EndIf

RestArea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetQbrDescบAutor  ณQuebra a descri็ใo  บFecha ณ  09/24/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para quebrar String                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetQbrDesc(cStr,nTam,nLin)
Local cTexto	:= ""
Local nPos		:= 0
Local nX		:= 0
Local aRet		:= {}
Local aPalavras	:= {}

Default cStr	:= ""
Default nTam	:= 0
Default nLin	:= 0

If Len(cStr) > nTam
	If !Empty(cStr)
		cTexto := Alltrim(cStr)
		nPos := AT(" ",cTexto)
		While nPos > 0
			Aadd(aPalavras,Substr(cTexto,1,nPos-1))
			cTexto := Substr(cTexto,nPos + 1)
			nPos := AT(" ",cTexto)
		Enddo
		Aadd(aPalavras,Alltrim(cTexto))
	Endif
	If nTam > 0
		nX := 1
		cTexto := ""
		While nX <= Len(aPalavras)
			If (Len(cTexto) + Len(aPalavras[nX])) <= nTam
				cTexto += aPalavras[nX]
				cTexto += " "
				nX++
			Else
				If !Empty(cTexto)
					Aadd(aRet,Alltrim(cTexto))
					cTexto := ""
				Else
					Aadd(aRet,aPalavras[nX])
					nX++
				Endif
			Endif
		Enddo
		If !Empty(cTexto)
			Aadd(aRet,cTexto)
		Endif
	Else
		aRet := AClone(aPalavras)
	Endif
	If nLin > 0                  
		If Len(aRet) < nLin
			For nX := 1 To (nLin - Len(aRet))
				Aadd(aRet," ")
			Next
		Else
			If Len(aRet) > nLin
				aRet := Asize(aRet,nLin)
			Endif
		Endif
	Endif
Else
	aRet := {""}
EndIf

Return(aRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ GetAlgDir ณ Autor ณ Elton C.				ณ Data ณ 16/02/12 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณAlinhamento a direita dos numeros 		 		          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetAlgDir(cNumAux,nTamLim)

Local nRet		:= 0

Default cNumAux := ""        
Default nTamLim	:= 0


nRet := nTamLim - (Len(cNumAux)*5)

Return nRet




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ ImpLogoEmp ณ Autor ณ Elton C.			ณ Data ณ 16/02/12 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณCabecalho principal com o logo da empresa 		          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpLogoEmp(nPagina)

//Local aEmpresa 			:= DadosEmp()//Dados da empresa posicionada
Local nFont14			:= 28 
Local nFont10 			:= 20
Local cCGCTxt 			:= ""
Local cStartPath		:= GetSrvProfString("Startpath","")
Local cNameFile			:= ""

Default nPagina			:= 0


cStartPath := AjuBarPath(cStartPath)
cNameFile  := cStartPath+"lgrl"+cEmpAnt+cFilAnt+".bmp"
If !File(cNameFile)
	cNameFile := cStartPath+"lgrl"+cEmpAnt+".bmp"
Endif

opReport:SayBitmap(175,140,cNameFile,216,78) // Tem que estar abaixo do RootPath


opReport:Say(205,2500,"Page: "+Alltrim(TRANSFORM(nPagina,'999999') ))//Numero da Pagina
opReport:Say(235,2500,"DT. REF.: "+Dtoc(Date()))//Data de Referencia
opReport:Say(265,2500,"Emission.: "+Dtoc(Date()))
opReport:Say(295,2500,"Time: "+Substring(Time(), 1,5 ) )

Return Nil
