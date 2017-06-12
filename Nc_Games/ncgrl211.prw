#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"
#Include "FIVEWIN.Ch"
#Include "TBICONN.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL211  ºAutor  ³Microsiga           º Data ³  02/19/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RL211JOB(aDados)

	Default aDados:={"01","03"}

	RpcSetEnv(aDados[1],aDados[2] )

	U_NCGRL211()

	RpcClearEnv()

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} NCGRL211

@author    Lucas Felipe
@version   1.xx
@since     22/02/2016
/*/
//------------------------------------------------------------------------------------------

User Function NCGRL211()

	Local cAliasSql	:= GetNextAlias()

	Local cCC, cBCC		:= ""
	Local aFiles		:= {}
	Local cHtml			:= ""
	Local clMensagem	:= ""
	Local cEmails 		:= Alltrim(U_MyNewSX6("NCG_000085","lfelipe@ncgames.com","C","Email workflow de faturamento do grupo",,,.F. )   )
	Local cEmpresa		:= ""
	Local cTextAux		:= ""

	Local cDescFat1,cHtmFat1	:= ""
	Local cDescFat2,cHtmFat2	:= ""
	Local cDescFat3,cHtmFat3	:= ""
	Local cDescFat4,cHtmFat4	:= ""
	Local cDescFat5,cHtmFat5	:= ""

	Local nTotalFat	:= 0
	Local nVlFat1		:= 0
	Local nVlFat2		:= 0
	Local nVlFat3		:= 0
	Local nVlFat4		:= 0
	Local nVlFat5		:= 0
	
	Local cData1, cData2

	Private alData		:= {DtoS(FirstDay(date())),DtoS(date())}
	Private _cUser		:= RetCodUsr(Substr(cUsuario,1,6))
	Private cUserEmail	:= UsrRetMail(AllTrim(_cUser))

	If Len(alData) > 1
		clDtde		:= alData[1]
		clDtAte 	:= alData[2]
	Else
		clDtde := FirstDay(date())
		clDtde := Date()
	endIf
	If EMpty(clDtDe)
		dldTLibDe 	:= FirstDay(Date())
		dlDtLibAte	:= Date()
	Else
		If Valtype(clDtDe) == "N"
			dldTLibDe 	:= StoD(AllTrim(Str(clDtDe)))
			dlDtLibAte	:= StoD(AllTrim(Str(clDtAte)))
		
		Else
			dldTLibDe 	:= StoD(clDtDe)
			dlDtLibAte	:= StoD(clDtAte)
		EndIf
	EndIf

	dldTLibDe	:= FirstDay(Date())
	dlDtLibAte	:= Date()
	dlDtDe		:= dldTLibDe
	dlDtate 	:= Date()

	DB_PAR01 := dlDtde - 15
	DB_PAR02 := dlDtAte
	DB_PAR03 := 1
	DB_PAR04 := "L"
	DB_PAR05 := dlDtlibde
	DB_PAR06 := dlDtLibAte


/*-------------------------------------------------------------//
//	TOTAL FATURADO													//
//-------------------------------------------------------------*/

	clQry := ""
	clQry += " SELECT "+CRLF
	//clQry += " 		B1_YCLASSE,"+CRLF
	clQry += "        ACA_GRPREP, "+CRLF
	clQry += "        ACA_DESCRI, "+CRLF
	clQry += " 	       SUM(D2_TOTAL+D2_VALIPI + D2_VALFRE + D2_SEGURO + D2_ICMSRET + D2_DESPESA) AS TOTAL "+CRLF
	clQry += " 	FROM " + RetSqlName("SF2") + " SF2 "+CRLF
	clQry += " 		LEFT OUTER JOIN " + RetSqlName("ACA") + "  ACA "+CRLF
	clQry += "		ON ACA.D_E_L_E_T_ = ' ' "+CRLF
	clQry += " 		AND ACA.ACA_GRPREP = SF2.F2_YCANAL "+CRLF
	clQry += " 		LEFT OUTER JOIN " + RetSqlName("SD2") + " SD2 "+CRLF
	clQry += "		ON SD2.D_E_L_E_T_ = ' ' "+CRLF
	clQry += " 		AND SD2.D2_FILIAL = SF2.F2_FILIAL "+CRLF
	clQry += " 		AND SD2.D2_DOC = SF2.F2_DOC "+CRLF
	clQry += " 		AND SD2.D2_SERIE = SF2.F2_SERIE "+CRLF
	clQry += " 		AND SD2.D2_CLIENTE = SF2.F2_CLIENTE "+CRLF
	clQry += " 			LEFT OUTER JOIN " + RetSqlName("SF4") + " SF4 "+CRLF
	clQry += "			ON SF4.D_E_L_E_T_ = ' ' "+CRLF
	clQry += " 			AND SF4.F4_FILIAL = SD2.D2_FILIAL "+CRLF
	clQry += " 			AND SF4.F4_CODIGO = SD2.D2_TES "+CRLF
	clQry += " 			AND SF4.F4_DUPLIC = 'S' "+CRLF
	clQry += " 			INNER JOIN " + RetSqlName("SC6") + " SC6 "+CRLF
	clQry += "			ON SC6.D_E_L_E_T_ = ' ' "+CRLF
	clQry += " 			AND SC6.C6_NUM = SD2.D2_PEDIDO "+CRLF
	clQry += " 			AND SC6.C6_PRODUTO = SD2.D2_COD "+CRLF
	clQry += " 			AND SC6.C6_TPOPER IN('01','19') "+CRLF
	clQry += " 			INNER JOIN " + RetSqlName("SB1") + " SB1 "+CRLF
	clQry += "			ON SB1.D_E_L_E_T_ = ' ' "+CRLF
	clQry += " 			AND SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
	clQry += " 			AND SB1.B1_COD = SD2.D2_COD "+CRLF
	clQry += " 	   		AND SB1.B1_TIPO = 'PA' " +CRLF
	clQry += " 	WHERE D2_FILIAL = '"+xFilial("SD2")+"' "+CRLF
	clQry += " 		AND F2_EMISSAO >= '"  + DTOS(DB_PAR05) + "'" +CRLF
	clQry += " 		AND F2_EMISSAO <= '" + DTOS(DB_PAR06) + "' " +CRLF
	clQry += " GROUP BY "
	//clQry += " 		B1_YCLASSE, "+CRLF
	clQry += " 		ACA_GRPREP, "+CRLF
	clQry += "			ACA_DESCRI	 "+CRLF
	clQry += " ORDER BY "
	//clQry += " 		B1_YCLASSE, "+CRLF
	clQry += " 		ACA_GRPREP, "+CRLF
	clQry += "			ACA_DESCRI	 "+CRLF

	clQry := ChangeQuery(clQry)

	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,clQry),cAliasSql, .T., .T.)

	DbSelectArea(cAliasSql)
	DbgoTop()
	nTotalFat	:= 0
	nVlFat1	:= 0
	nVlFat2	:= 0
	nVlFat3	:= 0
	nVlFat4	:= 0
	nVlFat5	:= 0
	
	cDescFat1	:= ""
	cDescFat2	:= ""
	cDescFat3	:= ""
	cDescFat4	:= ""
	cDescFat5	:= ""
	
	cHtmlFat1	:= ""
	cHtmlFat2	:= ""
	cHtmlFat3	:= ""
	cHtmlFat4	:= ""
	cHtmlFat5	:= ""

	Do While (cAliasSql)->(!EOF())
		nTotalFat	+= (cAliasSql)->TOTAL
		//cFatClasse	:= (cAliasSql)->B1_YCLASSE
		//cDesClasse	:= PadR(Capital((Posicione("SX5",1,xFilial("SX5")+"_Y"+cFatClasse,"X5_DESCRI"))),50)
		cCanDescri	:= PadR(Capital((cAliasSql)->(ACA_DESCRI)),50)
		
		//cTextAux	:= cDesClasse +" - "+ cCanDescri
		cTextAux	:= cCanDescri
		
	
		If  (cAliasSql)->ACA_GRPREP $ '000001|000012|000013|999999|000010'	//Faturamento Brasil(Sell In)
		
			cDescFat1	+= cTextAux + "R$ " + AllTrim(Transform((cAliasSql)->TOTAL,"@E 999,999,999.99")) + CRLF
			cHtmFat1	+= '<tr>'
			cHtmFat1	+= '	<td style="border-bottom: 1px solid #ddd;text-align: left;width: 80%;font-size: 16px;">'+ cTextAux +'</td>'
			cHtmFat1	+= '	<td style="border-bottom: 1px solid #ddd;text-align: right;width: 5%;font-size: 16px;">R$</td>'
			cHtmFat1	+= '	<td style="border-bottom: 1px solid #ddd;text-align: right;width: 15%;font-size: 16px;">'+ AllTrim(Transform((cAliasSql)->TOTAL,"@E 999,999,999.99")) +'</td>'
			cHtmFat1	+= '</tr>'
		
			nVlFat1	+= (cAliasSql)->TOTAL 	//total
		
		
		ElseIf  (cAliasSql)->ACA_GRPREP $ '990000|990001'		//Faturamento Ecommerce
		
			cDescFat2	+= cTextAux + "R$ " + AllTrim(Transform((cAliasSql)->TOTAL,"@E 999,999,999.99"))
			cHtmFat2	+= '<tr>'
			cHtmFat2	+= '	<td style="border-bottom: 1px solid #ddd;text-align: left;width: 80%;font-size: 16px;">'+ cTextAux +'</td>'
			cHtmFat2	+= '	<td style="border-bottom: 1px solid #ddd;text-align: right;width: 5%;font-size: 16px;">R$</td>'
			cHtmFat2	+= '	<td style="border-bottom: 1px solid #ddd;text-align: right;width: 15%;font-size: 16px;">'+ AllTrim(Transform((cAliasSql)->TOTAL,"@E 999,999,999.99")) +'</td>'
			cHtmFat2	+= '</tr>'
		
			nVlFat2		+= (cAliasSql)->TOTAL	//total
		
		ElseIf  (cAliasSql)->ACA_GRPREP $ '000011'			// Faturamento Latam
		
			cDescFat4	+= cTextAux + "R$ " + AllTrim(Transform((cAliasSql)->TOTAL,"@E 999,999,999.99"))
			cHtmFat4	+= '<tr>'
			cHtmFat4	+= '	<td style="border-bottom: 1px solid #ddd;text-align: left;width: 80%;font-size: 16px;">'+ cTextAux +'</td>'
			cHtmFat4	+= '	<td style="border-bottom: 1px solid #ddd;text-align: right;width: 5%;font-size: 16px;">R$</td>'
			cHtmFat4	+= '	<td style="border-bottom: 1px solid #ddd;text-align: right;width: 15%;font-size: 16px;">'+ AllTrim(Transform((cAliasSql)->TOTAL,"@E 999,999,999.99")) +'</td>'
			cHtmFat4	+= '</tr>'
		
			nVlFat4		+= (cAliasSql)->TOTAL	// total
		
		ElseIf  (cAliasSql)->ACA_GRPREP $ '000014|000015|000017' 	// Faturamento Varejo (Sell In)
		
			cDescFat5	+= cTextAux + "R$ " + AllTrim(Transform((cAliasSql)->TOTAL,"@E 999,999,999.99"))
			cHtmFat5	+= '<tr>'
			cHtmFat5	+= '	<td style="border-bottom: 1px solid #ddd;text-align: left;width: 80%;font-size: 16px;">'+ cTextAux +'</td>'
			cHtmFat5	+= '	<td style="border-bottom: 1px solid #ddd;text-align: right;width: 5%;font-size: 16px;">R$</td>'
			cHtmFat5	+= '	<td style="border-bottom: 1px solid #ddd;text-align: right;width: 15%;font-size: 16px;">'+ AllTrim(Transform((cAliasSql)->TOTAL,"@E 999,999,999.99")) +'</td>'
			cHtmFat5	+= '</tr>'
		
			nVlFat5		+= (cAliasSql)->TOTAL	//total
		EndIf
	
		(cAliasSql)->(dbSkip())
	
	EndDo 
	
	nTotalFat := nTotalFat - nVlFat5

	(cAliasSql)->(dbCloseArea())
	
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³	Faturamento Sell Out		 							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cAliasSql 	:= GetNextAlias()
	cData1		:= DtoS(DB_PAR05)
	cData2		:= DtoS(DB_PAR06)

	BeginSql Alias cAliasSql

		SELECT '40' EMPRESA,
		SUM(D2_TOTAL+D2_VALIPI + D2_VALFRE + D2_SEGURO + D2_ICMSRET + D2_DESPESA) AS TOTAL
		FROM SD2400 SD2
		WHERE SD2.%notDel%
		AND SD2.D2_EMISSAO BETWEEN  %Exp:cData1% AND  %Exp:cData2%
		AND SD2.D2_YCODMOV != ' '
		AND SD2.D2_YTOPER IN('VE','TRV')
		
		UNION ALL
		
		SELECT '03' EMPRESA,
		SUM(D2_TOTAL+D2_VALIPI + D2_VALFRE + D2_SEGURO + D2_ICMSRET + D2_DESPESA) AS TOTAL
		FROM SD2030 SD2
		WHERE SD2.%notDel%
		AND SD2.D2_EMISSAO BETWEEN %Exp:cData1% AND  %Exp:cData2%
		AND SD2.D2_YCODMOV != ' '
		AND SD2.D2_YTOPER IN('VE','TRV')
		ORDER BY EMPRESA

	EndSql

	Do While (cAliasSql)->(!EOF())

		//nTotalFat	+= (cAliasSql)->TOTAL //somar ao total do grupo
		cEmp		:= (cAliasSql)->EMPRESA
		cCanDescri	:= IIf(cEmp =="03","Uz Games","Proximo Games")

		
		cDescFat3	+= /*cEmp +" - "+*/ cCanDescri + "R$ " + AllTrim(Transform((cAliasSql)->TOTAL,"@E 999,999,999.99")) + CRLF
		cHtmFat3	+= '<tr>'
		cHtmFat3	+= '	<td style="border-bottom: 1px solid #ddd;text-align: left;width: 80%;font-size: 16px;">'/*+ cEmp +" - "*/+ cCanDescri +'</td>'
		cHtmFat3	+= '	<td style="border-bottom: 1px solid #ddd;text-align: right;width: 5%;font-size: 16px;">R$</td>'
		cHtmFat3	+= '	<td style="border-bottom: 1px solid #ddd;text-align: right;width: 15%;font-size: 16px;">'+ AllTrim(Transform((cAliasSql)->TOTAL,"@E 999,999,999.99")) +'</td>'
		cHtmFat3	+= '</tr>'
		
		nVlFat3	+= (cAliasSql)->TOTAL
			
		(cAliasSql)->(dbSkip())
	
	EndDo

	(cAliasSql)->(dbCloseArea())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³					Faturamento do Grupo na tela				     	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cEmpresa := IIf(xFilial("SC5")=="06","NC Espirito Santo",Alltrim(SM0->M0_FILIAL))

	clMensagem := "Workflow de visão comercial vendas da Filial "+ cEmpresa +" até o dia " + DtoC(Date()) +  CRLF
	clMensagem += "Informação gerada pelo protheus." + " " + Time() + CRLF  + CRLF

	clMensagem += "FATURAMENTO TOTAL GRUPO	R$"+Alltrim(Transform(nTotalFat,"@E 999,999,999.99")) + CRLF

	clMensagem += "FATURAMENTO BRASIL (SELL IN)	R$"+Alltrim(Transform(nVlFat1,"@E 999,999,999.99")) + CRLF
	clMensagem += cDescFat1

	clMensagem += "FATURAMENTO E-COMMERCE R$"+Alltrim(Transform(nVlFat2,"@E 999,999,999.99")) + CRLF
	clMensagem += cDescFat2

	clMensagem += "FATURAMENTO VAREJO (SELL IN) R$"+Alltrim(Transform(nVlFat5,"@E 999,999,999.99")) + CRLF
	clMensagem += cDescFat5
	clMensagem += "FATURAMENTO VAREJO (SELL OUT) R$"+Alltrim(Transform(nVlFat3,"@E 999,999,999.99")) + CRLF
	clMensagem += cDescFat3

	clMensagem += "FATURAMENTO LATAM R$"+Alltrim(Transform(nVlFat4,"@E 999,999,999.99")) + CRLF
	clMensagem += cDescFat4



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³							Html de Faturamento do Grupo 					       	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cHtml := ''
	cHtml += '  <!DOCTYPE html>'
	cHtml += '  <html>'
	cHtml += '  	<head>'
	cHtml += '        <meta http-equiv="Content-Type" content="text/html; charset="UTF-8" />'
	cHtml += '  		<title>Faturamento do Grupo</title>'
	cHtml += '  	</head>'
	cHtml += '  	<body style="font-size: 16px; margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF; color: #000000; font-family: Tahoma; text-shadow: 0px 0px #FFFFFF; border: #FFFFFF;" >'
	cHtml += '	  		<center>'
	cHtml += '		  		<div style="margin: 10px ; width: 900px; padding: 15px; border: #FFFFFF; font-size: 14px;">'

	cHtml += '		  			<table style="border-radius: 20px; background: #ececec;" width="95%">'
	cHtml += '		  				<tbody>'
	cHtml += '				  			<tr align="center" valign="middle">'
	cHtml += '				 	 			<td style=" width: 25%;"><img style="width: 214px; height: 60px;" src="https://www.ncgames.com.br//Assets/Uploads/emails//NCGames_horizontal_branco_rgb.png" alt="Logo Nc Games"></td>'
	cHtml += ' 			 				<td style="width: 75%;text-align: left;"><p style="text-align: center; font-size: 30px; color: #FF952B;">Faturamento do Grupo</p></td>'
	cHtml += ' 			 			</tr>'
	cHtml += ' 			 		</tbody>'
	cHtml += ' 			 	</table>'

	cHtml += ' 				<hr style="border:radius; border-top: 1px solid #dfdfdf;  width: 95%; margin: 30px auto">'

	cHtml += '  				<table style="font-family: Tahoma; border:none; width:95%;" align:center >'
	cHtml += ' 				 	<tbody>'
	cHtml += '  						<tr>'
	cHtml += '  							<th style="font-size: 14px; color: #000;text-align:left;">Atenção Prezados</th>'
	cHtml += '  						</tr>'
	cHtml += '  						<tr>'
	cHtml += '  							<td><p style="font-family:Tahoma; font-size:14px;">Workflow de faturamento total do grupo Nc Games at&eacute; o dia ' + DtoC(Date()) + ', informada e gerada pelo protheus.' + Time() +'</p></td>'
	cHtml += '  						</tr>'
	cHtml += '  					</tbody>
	cHtml += '  				</table>'
	
	cHtml += ' 				<br/>'

	cHtml += ' 	      		<table style="width: 95%;">'
	cHtml += ' 	      	   		<tr>'
	cHtml += ' 	      	      		<th style="border-bottom: 1px solid #ddd;text-align: left;width: 80%; font-size: 18px;">FATURAMENTO TOTAL GRUPO:</th>'
	cHtml += ' 	      	      		<th style="border-bottom: 1px solid #ddd;text-align: right;width: 5%; font-size: 18px;">R$</th>'
	cHtml += '   	    	      		<th style="border-bottom: 1px solid #ddd;text-align: right;width:	15%;font-size: 18px;">'+ Alltrim(Transform(nTotalFat,"@E 999,999,999.99")) +'</th>'
	cHtml += '   	    	   		</tr>'
	cHtml += '   	    		</table>'
	
	cHtml += ' 				<br/>'
	cHtml += ' 				<br/>'
	
	cHtml += ' 	        	<table style="width: 95%;">'
	cHtml += '    	       	<tr>'
	cHtml += '    	         		<th style="border-bottom: 1px solid #ddd;text-align: left;width: 80%;font-size: 18px;">FATURAMENTO BRASIL (SELL IN)</th>'
	cHtml += '    	         		<th style="border-bottom: 1px solid #ddd;text-align: right;width: 5%;font-size: 18px;">R$</th>'
	cHtml += '    	          		<th style="border-bottom: 1px solid #ddd;text-align: right;width: 15%;font-size: 18px;">'+ Alltrim(Transform(nVlFat1,"@E 999,999,999.99")) +'</th>'
	cHtml += '    	       	</tr>'
	cHtml += cHtmFat1
	cHtml += '   		      	</table>'
	
	cHtml += ' 				<br/>'
	cHtml += '					<br/>'
	
	cHtml += ' 	        	<table style="width: 95%;">'
	cHtml += '    	       	<tr>'
	cHtml += '    	         		<th style="border-bottom: 1px solid #ddd;text-align: left;width: 80%;font-size: 18px;">FATURAMENTO E-COMMERCE</th>'
	cHtml += '    	          		<th style="border-bottom: 1px solid #ddd;text-align: right;width: 5%;font-size: 18px;">R$</th>'
	cHtml += '    	          		<th style="border-bottom: 1px solid #ddd;text-align: right;width: 15%;font-size: 18px;">'+ Alltrim(Transform(nVlFat2,"@E 999,999,999.99")) +'</th>'
	cHtml += '    	       	</tr>'
	cHtml += cHtmFat2
	cHtml += '    	     	</table>'
	
	cHtml += ' 				<br/>'
	cHtml += ' 				<br/>'
	

	cHtml += ' 	        	<table style="width: 95%;">'
	cHtml += '    	       	<tr>'
	cHtml += '    	          		<th style="border-bottom: 1px solid #ddd;text-align: left;width: 80%;font-size: 18px;">FATURAMENTO LATAM</th>'
	cHtml += '    	          		<th style="border-bottom: 1px solid #ddd;text-align: right;width: 5%;font-size: 18px;">R$</th>'
	cHtml += '    	          		<th style="border-bottom: 1px solid #ddd;text-align: right;width: 15%;font-size: 18px;">'+ Alltrim(Transform(nVlFat4,"@E 999,999,999.99")) +'</th>'
	cHtml += '    	       	</tr>'
	cHtml += cHtmFat4
	cHtml += '    	     	</table>'
	
		
	cHtml += ' 				<br/>'
	cHtml += ' 				<br/>' 
	
	
	cHtml += '	         	<table style="width: 95%;">'
	cHtml += '    	       	<tr>'
	cHtml += '    	          		<th style="border-bottom: 1px solid #ddd;text-align: left;width: 80%;font-size: 18px;">FATURAMENTO VAREJO (SELL IN)</th>'
	cHtml += '    	          		<th style="border-bottom: 1px solid #ddd;text-align: right;width: 5%;font-size: 18px;">R$</th>'
	cHtml += '    	          		<th style="border-bottom: 1px solid #ddd;text-align: right;width: 15%;font-size: 18px;">'+ Alltrim(Transform(nVlFat5,"@E 999,999,999.99")) +'</th>'
	cHtml += '    	       	</tr>'
	cHtml += cHtmFat5
	cHtml += '    	     	</table>'
	
	cHtml += ' 				<br/>' 
	cHtml += ' 				<br/>'   
	
	
	cHtml += '		        <table style="width: 95%;">'
	cHtml += '    	       	<tr>'
	cHtml += '    	          		<th style="border-bottom: 1px solid #ddd;text-align: left;width: 80%;font-size: 18px;">FATURAMENTO VAREJO (SELL OUT)<div style="font-size:11px; color:red;">(Faturamento fechado D - 1)</div></th>'
	cHtml += '    	          		<th style="border-bottom: 1px solid #ddd;text-align: right;width: 5%;font-size: 18px;">R$</th>'
	cHtml += '    	          		<th style="border-bottom: 1px solid #ddd;text-align: right;width: 15%;font-size: 18px;">'+ Alltrim(Transform(nVlFat3,"@E 999,999,999.99")) +'</th>'
	cHtml += '    	       	</tr>'
	cHtml += cHtmFat3
	cHtml += '    	     	</table>'
	
	cHtml += '					<br/>'
	cHtml += ' 				<br/>'
	cHtml += ' 				<br/>'


	cHtml += '					<table bordercolorlight="#006600" bordercolordark="#006600" border="0" bordercolor="#006600" height="62" width="100%">'
	cHtml += '				 		<tbody>'
	cHtml += '							<tr>'
	cHtml += '								<td height="52" width="100%">'
	cHtml += '									<table style="font-family:"Roboto"; font-size:11px;" align="center" border="0" width="95%">'
	cHtml += '										<tbody>'
	cHtml += '											<tr>'
	cHtml += '												<td><p>Workflow informativo enviado por rotinas automaticas.</p></td>'
	cHtml += '											</tr>'
	cHtml += '										</tbody>'
	cHtml += '									</table>'
	cHtml += '								</td>'
	cHtml += '							</tr>'
	cHtml += '						</tbody>'
	cHtml += '					</table>'
	cHtml += '					<table width="100%">'
	cHtml += '						<tbody>'
	cHtml += '							<tr>'
	cHtml += '  							<td style="font-family:"Roboto"; font-size: 11px; color: #000;" align="center" height="30"> WORKFLOW PROTHEUS</td>'
	cHtml += '							</tr>'
	cHtml += '  					</tbody>'
	cHtml += '					</table>'
	cHtml += '				</div>'
	cHtml += '			</center>'
	cHtml += '		</body>'
	cHtml += '	</html>'

	IF !IsBlind()
		If  Aviso("Dados do processamento: ", clMensagem +" "+CRLF+CRLF,{"Sim","Não"},3,"Previa de Vendas") == 1
			clMensagem += "*** NÃO RESPONDER A ESSE E-MAIL, POIS TRATA-SE DE UMA MENSAGEM AUTOMÁTICA ***"
			U_ENVIAEMAIL(cUserEmail, cCC, cBCC, "Faturamento do grupo - Nc Games - " + DtoC(Date()) + " - " + time(), cHtml, aFiles)	
		EndIf
	ELSE
		U_ENVIAEMAIL(cEmails, cCC, cBCC, "Faturamento do grupo - Nc Games - " + DtoC(Date()) + " - " + time(), cHtml, aFiles)
	ENDIF


Return



