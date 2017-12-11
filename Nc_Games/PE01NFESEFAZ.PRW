#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PE01NFESEFAZºAutor  ³Rodrigo           º Data ³  18/02/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

USER FUNCTION PE01NFESEFAZ()

	Local aAreaAtu	:= GetArea()
	Local aAreaSZ6	:= SZ6->(GetArea())
	Local aAreaSA1	:= SA1->(GetArea())
	Local aAreaSF2	:= SF2->(GetArea())
	Local aAreaSF1	:= SF1->(GetArea())
	Local aAreaSB1	:= SB1->(GetArea())
	Local cAliasZX5	:= GetNextAlias()
	Local aProd		:= PARAMIXB[1]
	Local cMensCli	:= PARAMIXB[2]
	Local cMensFis	:= PARAMIXB[3]
	Local aDest		:= PARAMIXB[4]
	Local aNota   	:= PARAMIXB[5]
	Local aInfoItem	:= PARAMIXB[6]
	Local aDupl		:= PARAMIXB[7]
	Local aTransp	:= PARAMIXB[8]
	Local aEntrega	:= PARAMIXB[9]
	Local aRetirada	:= PARAMIXB[10]
	Local aVeiculo	:= PARAMIXB[11]
	Local aReboque	:= PARAMIXB[12]
	Local aNfVincRur:= PARAMIXB[13]
	Local aRefECF	:= PARAMIXB[14]
	Local aRetorno	:= {}
	Local cMsg		:= ""
	Local cMsgNReduz:= ""
	Local cYPed		:= ""
	Local cMsImp	:= ""
	Local nVAlimp6	:= 0
	Local nVAlimp5	:= 0
	Local nVAlDesp	:= 0

	Local lEcommerce:= .F.
	Local cEndereco	:= ""
	Local cBairro	:= ""
	Local cCEP		:= ""
	Local cMunicipio:= ""
	Local cEstado	:= ""
	Local cComplem	:= ""
	Local cCodMun	:= ""
	Local aDadEnt
	local cQry
	Private _wnDoc	:= ""
	Private _wnserie:= ""
	Private _w6dinum:= ""

	cMensCli += u_nfeMsg(aNota[4])

	If aNota[4] == "1"
		cClieFor	:= getadvfval("SF2","F2_CLIENTE",xFilial("SF2")+aNota[2]+aNota[1],1,"")
		cLoja		:= getadvfval("SF2","F2_LOJA",xFilial("SF2")+aNota[2]+aNota[1],1,"")
	Else
		cClieFor	:= getadvfval("SF1","F1_FORNECE",xFilial("SF1")+aNota[2]+aNota[1],1,"")
		cLoja		:= getadvfval("SF1","F1_LOJA",xFilial("SF1")+aNota[2]+aNota[1],1,"")
	EndIf


	If Len(aInfoItem)>0
		If Posicione("SC5",1,xFilial("SC5")+aInfoItem[1][1],"C5_XECOMER")=="C"
			lEcommerce:=.T.
			aDupl:={}
		EndIf
	EndIf
	//aNota[1] - SERIE
	//aNota[2] - DOC
	SA1->(DbSetOrder(1))
	SA1->(DbSeek(xFilial("SA1")+cClieFor+cLoja))

	SB1->(DbSetOrder(1))
	SZ6->(DbSetOrder(1))

	If aNota[4] == "1"

		For nx:=1 to len(aInfoItem)

			SB1->(DbSeek(xFilial("SB1")+aProd[nX][2]))

			SZ6->(DbSeek(xFilial("SZ6")+SB1->B1_GRTRIB+SA1->A1_EST))
			If !aNota[5] $ "DB" .and. Empty(cMsgNReduz)
				cMsgNReduz	:= "Nome Fantasia: "+ SA1->A1_NREDUZ +" "
				If !EMPTY(cMsgNReduz) .And. (FWCodEmp() != "03")
					cMensCli += cMsgNReduz
				EndIf
				cLiminar:= AllTrim(SA1->A1_LIMINAR)
				cNrLim	:= AllTrim(SA1->A1_NRLIMIN)
				cxTpCli	:= AllTrim(SA1->A1_TIPO)
				If cLiminar == "1" .AND. !EMPTY(cNrLim) .AND. cxTpCli == "R"
					cMensCli += "Liminar no.: "+AllTrim(cNrLim)+" - "
				EndIf
			EndIf

		Next nx

		//MENSAGEM ICMS ST
		IF !aNota[5] $ "DB"//IF !(cAliasSD2)->D2_TIPO $ "DB"

			cUFmsg	:= SA1->A1_EST
			cA1GRTRI:= SA1->A1_GRPTRIB
			cContri := SA1->A1_CONTRIB
			cMensST	:= ""

			For nX := 1 To Len(aProd)

				cMensST	:= ""
				cProdTri:= SB1->B1_GRTRIB
				cMensST	:= SZ6->Z6_MENSAGE

				If !Empty(cMensST) .And. !AllTrim(cMensST) $ cMensCli .AND. aProd[nX][23] $ "10/30"
					If Len(cMensCli) > 0 .And. SubStr(cMensCli, Len(cMensCli), 1) <> " "
						cMensCli += " "
					EndIf
					If alltrim(cA1GRTRI) == "SCS" .and. !("30 por cento de MVA – Anexo 3, art. 229, Paragrafo 4o.") $ cMensST
						cMensST := ALLTRIM(cMensST)+" - ST – 30 por cento de MVA – Anexo 3, art. 229, Paragrafo 4o."
					EndIf
				EndIf
				If !(Empty(cMensCli))
					cMensCli += ", "+AllTrim(cMensST)
				Else
					cMensCli:= AllTrim(cMensST)
				EndIf
			Next nX

		EndIf

		If lEcommerce .And. U_COM05EndEnt(aInfoItem[1][1],@cEndereco,@cBairro,@cCEP,@cMunicipio,@cEstado,@cComplem,.F.,@cCodMun)

			aDadEnt:=FisGetEnd(cEndereco,cEstado)
			adest[3]:=aDadEnt[1]
			If "/" $ aDadEnt[3]
				adest[4]:=IIF(aDadEnt[3]<>"",aDadEnt[3],"SN")
			Else
				adest[4]:=IIF(aDadEnt[2]<>0,aDadEnt[2],"SN")
			EndIf

			adest[05]:=IIf(cComplem=="",adest[05],cComplem)
			adest[06]:=IIf(cBairro=="",adest[06],cBairro)
			aDest[07]:=IIf(cCodMun=="",adest[07],cCodMun)
			aDest[08]:=IIf(cMunicipio=="",adest[08],cMunicipio)
			aDest[09]:=IIf(cEstado=="",adest[09],cEstado)
			aDest[10]:=IIf(cCEP=="",adest[10],cCEP)
		EndIf

		SF2->(DbSetOrder(1))
		If SF2->(MsSeek(xFilial("SF2")+aNota[2]+aNota[1]   )) .And. TransfMerc(SF2->F2_FILIAL,SF2->F2_DOC,SF2->F2_SERIE) .And. (!Empty(SF2->F2_YCODMOV) .or. SA1->A1_YCODWM != ' ')
			/*cMensCli+=" Codigo Movimento WM:"+SF2->F2_YCODMOV
			cMensCli+=" Loja WM:"				+SF2->F2_YLOJAWM
			cMensCli+=" Operacao WM:"			+SF2->F2_YTOPER

			If SF2->F2_YTOPER=="TLS"
			cMensCli+=" Loja Destino WM:"	+SF2->F2_YWMLJDE
			EndIf
			*/

			cQry := "  SELECT ZX5_CHAVE CHAVE,"  +CRLF
			cQry += "  SUBSTR(ZX5_DESCRI,7,LENGTH(TRIM(ZX5_DESCRI))-6) DESCRI  FROM  "+ RetSqlName("ZX5") +" "  +CRLF
			cQry += "  WHERE  zx5_tabela = '00006' AND D_e_l_e_t_ = ' ' AND ZX5_DESCRI like '"+ FWCodEmp() +";"+ SF2->F2_FILIAL +"%'"  +CRLF

			cQry := ChangeQuery(cQry)
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasZX5,,.f.,.T.)


			//if (SA1->A1_YCODWM != ' ') .AND. (SA1->A1_YEMPDES == FWCodEmp()) .And. !(SA1->A1_YFILDES == '01')
			if (SA1->A1_YCODWM != ' ') .And. !(SF2->F2_FILIAL == '30')

				cMensCli+="TRANSFERENCIA ENTRE LOJAS "
				if !empty(alltrim(SF2->F2_YCODMOV))
					cMensCli+="WM:"+SF2->F2_YCODMOV
				endIf
				cMensCli+=" - DA LOJA:"+ (cAliasZX5)->CHAVE + " " + (cAliasZX5)->DESCRI + CRLF + " P/ A LOJA:"+ SA1->A1_YCODWM + " " + SA1->A1_NREDUZ

				//cMensCli+= SA1->A1_YCODWM +" "+  GetDescLoja(SA1->A1_YCODWM)

			elseif (SF2->F2_YLOJAWM != ' ') .And. (SF2->F2_YTOPER=="TLS") .AND. (SA1->A1_YFILDES == '30') .And. (SA1->A1_YEMPDES == "03")
				cMensCli+="TRANSFERENCIA DA LOJA:"+(cAliasZX5)->CHAVE+ " " + GetDescLoja((cAliasZX5)->CHAVE)
				if alltrim(SF2->F2_YLOJAWM) == "3001"
					cMensCli+="P/ NC STORE WM " + SF2->F2_YCODMOV + " ARMAZEM 04 RMA."
				elseif alltrim(SF2->F2_YLOJAWM) == "3000"
					cMensCli+="P/  NC STORE WM " + SF2->F2_YCODMOV + " ARMAZEM 03 QUALIDADE."
				endif

			Elseif SF2->F2_YLOJAWM != ' ' .AND. (FWCodEmp() =="03") .AND. (SF2->F2_FILIAL == '30') //.And. SF2->F2_YTOPER=="TLS"
				DBSelectArea("ZX5")
				DBSetOrder(1)
				DbSeek(xFilial("ZX5")+"00006"+SF2->F2_YLOJAWM)

				cMensCli+= "TRANSFERENCIA NC STORE P/ LOJA:"+ SUBSTR(ZX5->ZX5_DESCRI,7, LEN(ALLTRIM(ZX5->ZX5_DESCRI)))
				dbCloseArea("ZX5")
			endif
			DbCloseArea(cAliasZX5)
		EndIf

		If IsInCallStack("U_NCGPR118")
			cMensCli+=" Gerado pelo Lote "+P07->P07_LOTE+"("+AllTrim(P07->P07_USLOTE)+")"
		EndIf
	Else

		//NC GAMES ********************** inicio
		If !aNota[5]$"IP" .and. SF1->F1_EST = "EX"	// No Caso de NFE de Importação os valores são re-calculados pela DI
			_wnBaseIcm	:=0
			_wnValIcm	:= 0
			_wnValIpi	:= 0
			_wnValor	:= 0
			_wnVlrPis	:= 0
			_wnVlrCof	:= 0
			_wnBasPis	:= 0
			_wdvalorr	:= 0
			_hawb    	:= SF1->F1_HAWB								// Numero DI
			_wndoc   	:= PadR(SF1->F1_DOC,TamSx3("WN_DOC")[1])	// Numero NFE
			_wnserie 	:= SF1->F1_SERIE 					 		// Serie NFE
			_valii    	:= SF1->F1_II								// Valor II

			ImpNFEIC() // Busca informações impostos DI

			xOUTRADESP  :=SF1->F1_DESPESA

			cMensEIC:= "Proc: "+_hawb+" - DI: "+Transform(_w6dinum,"@R 99/9999999-9")
			cMensEIC+= " .BASE:   R$ "+Transform(_wnbaspis,"@r 999,999.99")+" - "+"PIS: R$ "+Transform(_wnvlrpis,"@r 999,999.99")
			cMensEIC+= " - COFINS: R$ "+Transform(_wnvlrcof,"@r 999,999.99")+" - "+"TX:  R$ "+Transform(xOUTRADESP,"@r 999,999.99")
			cMensEIC+= " - II: R$ "+Transform(_valii,"@r 999,999.99")
			If !Empty(AllTrim(cMensCli)) .AND. !AllTrim(cMensEIC) $ cMensCli
				If Len(cMensCli) > 0 .And. SubStr(cMensCli, Len(cMensCli), 1) <> " "
					cMensCli += " "
				EndIf
				cMensCli+= cMensEIC
			ElseIf !AllTrim(cMensEIC) $ cMensCli
				cMensCli+= cMensEIC
			EndIf

		EndIf

		SF1->(DbSetOrder(1))

		If SF1->(MsSeek(xFilial("SF1")+aNota[2]+aNota[1]   )) .And. !Empty(SF1->F1_YCODMOV)

			cMensCli+=" Codigo Movimento WM:"+SF1->F1_YCODMOV
			cMensCli+=" Loja WM:"			+SF1->F1_YLOJAWM
			cMensCli+=" Operacao WM:"		+SF1->F1_YTOPER

			If SF1->F1_YTOPER=="TLE"
				cMensCli+=" Loja Origem WM"	+SF1->F1_YWMLJOR
			EndIf

			If SF1->F1_YTOPER=="TRD"
				GetCupom(SF1->F1_YMOVVEN,SF1->F1_YLOJAWM,aRefECF)
			EndIf

		EndIf

	EndIf



	//O retorno deve ser exatamente nesta ordem e passando o conteúdo completo dos arrays
	//pois no rdmake nfesefaz é atribuido o retorno completo para as respectivas variáveis
	//Ordem:
	//		aRetorno[1] -> aProd
	//		aRetorno[2] -> cMensCli
	//		aRetorno[3] -> cMensFis
	//		aRetorno[4] -> aDest
	//		aRetorno[5] -> aNota
	//		aRetorno[6] -> aInfoItem
	//		aRetorno[7] -> aDupl
	//		aRetorno[8] -> aTransp
	//		aRetorno[9] -> aEntrega
	//		aRetorno[10] -> aRetirada
	//		aRetorno[11] -> aVeiculo
	//		aRetorno[12] -> aReboque
	//		aRetorno[13] -> aNfVincRur
	//		aRetorno[14] -> aRefECF
	aadd(aRetorno,aProd)
	aadd(aRetorno,cMensCli)
	aadd(aRetorno,cMensFis)
	aadd(aRetorno,aDest)
	aadd(aRetorno,aNota)
	aadd(aRetorno,aInfoItem)
	aadd(aRetorno,aDupl)
	aadd(aRetorno,aTransp)
	aadd(aRetorno,aEntrega)
	aadd(aRetorno,aRetirada)
	aadd(aRetorno,aVeiculo)
	aadd(aRetorno,aReboque)
	aadd(aRetorno,aNfVincRur)
	aadd(aRetorno,aRefECF)


	RestArea(aAreaSB1)
	RestArea(aAreaSA1)
	RestArea(aAreaSZ6)
	RestArea(aAreaSF2)
	RestArea(aAreaSF1)
	RestArea(aAreaAtu)

Return aRetorno




/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ImpNFEIC ³ Autor ³ SEIKOO                ³ Data ³08/07/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Funcao criada para retornar impostos informados na DI       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ImpNFEIC                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Exclusivo NC Games                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpNFEIC()

	Local oldarea

	oldarea := Alias()
	Store 0 to _wnbaseicm,_wnvalicm,_wnvalipi,_wnvalor,_wnvlrpis,_wnvlrcof,_wnbaspis,_wniival,_wdvalorr

	DbSelectArea("SWN")
	DbSetOrder(1)
	Dbseek(xFilial("SWN")+_wnDoc+_wnSerie)

	If !Eof()
		While SWN->WN_DOC == _wnDoc .and. SWN->WN_SERIE == _wnSerie
			_wnvalor   := _wnvalor   + (SWN->WN_CIF+SWN->WN_IIVAL)
			_wnvlrpis  := _wnvlrpis  + SWN->WN_VLRPIS
			_wnvlrcof  := _wnvlrcof  + SWN->WN_VLRCOF
			_wnbaspis  := _wnbaspis  + SWN->WN_BASPIS
			_wniival   := _wniival   + SWN->WN_IIVAL
			_wninvoice := SWN->WN_INVOICE
			DbSkip()
		Enddo
	Endif

	DbSelectArea("SW6")
	DbSetOrder(1)
	Dbseek(xFilial("SW6")+_hawb)
	If !eof()
		_w6NomAlf 	:= Posicione("SJA",1,xFilial("SJA")+SW6->W6_REC_ALF,"JA_DESCR")
		_w6dinum  	:= SW6->W6_DI_NUM
		_w6dtregd  	:= SW6->W6_DTREG_D
		_w6dest    	:= SW6->W6_DEST
		_w6trans   	:= SW6->W6_TRANS
		_w6RefDes  	:= SW6->W6_REF_DES /// Referencia do Despachante
		_w6house   	:= SW6->W6_HOUSE   /// Numero do BL
		_w6nfent  	:= SW6->W6_NF_ENT
		_w6dtnf  	:= SW6->W6_DT_NF
		_w6PesoL	:= SW6->W6_PESOL
		_w6PesoB	:= SW6->W6_PESO_BR

	Endif

	DbSelectArea("SWD")
	DbSetOrder(1)
	Dbseek(xFilial("SWD")+_hawb+"420")
	If !eof()
		If SF1->F1_TIPO == "N"
			_wdvalorr := SWD->WD_VALOR_R
		Endif
	Endif

	DbSelectArea(OldArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PE01NFESEFAZºAutor  ³Microsiga           º Data ³  06/25/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetDescLoja(cCodLoja)
	Local aAreaAtu:=GetArea()
	Local cAliasZX5:=GetNextAlias()
	Local cModo:=""
	Local cNome
	Local aEmpFil
	Local cCNPJAux
	Local cCodTab:="00005"

	EmpOpenFile(cAliasZX5,"ZX5",1,.T.,"01",@cModo)

	cNome:=""
	If !Empty(cCodLoja) .And. (cAliasZX5)->(MsSeek(xFilial("ZX5")+cCodTab+cCodLoja ))

		aEmpFil:=U_NCGEFORI(AllTrim((cAliasZX5)->ZX5_DESCRI))//Retorna a Empresa e Filial de origem

		If Len(aEmpFil)>=5
			cNome:=AllTrim(aEmpFil[5])
		EndIf
	EndIf
	(cAliasZX5)->(DbCloseArea())

	RestArea(aAreaAtu)
Return cNome


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PE01NFESEFAZºAutor  ³Microsiga         º Data ³  07/01/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetCupom(cCodMov,cCodLoja,aRefECF)
	Local aAreaAtu	:=GetArea()
	Local cQuery

	cQuery    := " SELECT * FROM "+u_NCGetBWM("INTEGRACAO_MOVIMENTO_FISCAL_CUPOM")
	cQuery    += " WHERE COD_LOJA="+AllTrim(cCodLoja)
	cQuery    += " AND COD_MOVIMENTO='"+cCodMov+"'"

	cQryAlias := U_NCIWMF02(cQuery)

	//Executa a query na base de dados do WEB MANAGER
	//Verifica se a conexão foi estabelecida com sucesso
	If Select(cQryAlias)>0
		(cQryAlias)->(aadd( aRefECF,{ AllTrim(Str(NUMERO_NOTA)),"CF",NUMERO_TERMINAL } ))
	EndIf

	(cQryAlias)->(DbCloseArea())
	RestArea(aAreaAtu)
Return


Static Function TransfMerc(cFilNF,cNota, cSerie)
	Local aArea := GetArea()
	Local lRet := .F.
	Local cAliasCT := GetNextAlias()
	Local cQry := ""


	DBSelectArea("SD2")
	SD2->(DbSetOrder(3))
	if DbSeek(cFilNF+cNota+cSerie)
		cQry := "SELECT * FROM "+ RetSqlName("ZX5") +" WHERE ZX5_TABELA = '00010' AND ZX5_CHAVE = '" +SD2->D2_CF +"'"
		cQry := ChangeQuery(cQry)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasCT,,.f.,.T.)


		while (cAliasCT)->(!EOF())
			if alltrim((cAliasCT)->ZX5_CHAVE) == alltrim(sd2->d2_cf)
				lRet:= .T.
			end if
			(cAliasCT)->(DbSkip())
		endDO
		(cAliasCT)->(DbCloseArea())
	endif
	DbCLoseArea("SD2")
	RestArea(aArea)
return lRet
