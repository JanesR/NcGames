#Include "Protheus.Ch"
#DEFINE CRLF Chr(13)+Chr(10)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZRFat02 	     บAutor  ณAlfredo A. MagalhaesบData  ณ14/05/12	  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio de carteira de cliente x vendedor					  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ Nenhum					   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ																  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function KZRFat02()

Local nlPos			:= 0
Private apData		:= {}
Private apHeader	:= {"Codigo cliente",;
"Loja Cliente",;
"Razใo Social",;
"Nome Fantasia",;
"Cidade",;
"UF",;
"Regiใo",;
"Setor",;
"Vendedor",;
"Nome Vendedor",;
"Ativo",;
"Canal"	}


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica as perguntas selecionadas                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
AjustaSx1("NFATCA")

If Pergunte("NFATCA",.T.)
	If Empty(Mv_Par07)
		ShowHelpDlg("EMBRANCO",{"O caminho para cria็ใo do arquivo excel nใo foi preenchido."},5,{"O caminho ้ necessario para a cria็ใo do arquivo."},5)
	Else
		apData := KZGetData()
		
		//Campos para os valores por mes
		For nx:= 1 to Len(apData)
			aadd(apHeader,"Vlr. Fat s/Dev Mes " + apData[nx][3])
			aadd(apHeader,"Qtd. Fat s/Dev Mes " + apData[nx][3])
			aadd(apHeader,"Vlr. Fat c/Dev Mes " + apData[nx][3])
			aadd(apHeader,"Qtd. Fat c/Dev Mes " + apData[nx][3])
		Next nx
		If Mv_Par04 == 1
			nlPos := aScan(apHeader,"Loja Cliente")
			aDel(apHeader,nlPos)
			aSize(apHeader,Len(apHeader)-1)
			nlPos := aScan(apHeader,"UF")
			aDel(apHeader,nlPos)
			aSize(apHeader,Len(apHeader)-1)
			nlPos := aScan(apHeader,"Regiใo")
			aDel(apHeader,nlPos)
			aSize(apHeader,Len(apHeader)-1)
		EndIf
		
		Processa( { || KZGeraRel() }, 'Gerando Excel...' )
		
	EndIf
	
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZGeraRel	     บAutor  ณAlfredo A. MagalhaesบData  ณ14/05/12	  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFun็ใo para gerar o relatorio em excel						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ Nenhum					   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ																  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KZGeraRel()

Local aCampos	:= {}
Local nx		:= 0
Local nlPos		:= 0
Local nl2Pos	:= 0
Local clWhrCli	:= ""
Local clWhrD2	:= ""
Local clWhrF2	:= ""
Local clWhere	:= ""
Local clAtivo	:= Iif(Mv_Par01 == 1,"Ativo","Inativo")
Local alLocal	:= {}
Local aCampos	:= {}
Local aArea		:= getArea()
Local clSearch	:= ""
Local alInfo	:= {}


//Pega a descri็ใo do combo box do campo A1_X_LOCZ
SX3->(dbSetOrder(2))
SX3->(DbSeek("A1_X_LOCZ"))
alLocal := Separa(SX3->X3_CBOX,";")
For nx:= 1 to Len(alLocal)
	alLocal[nx] := {SubsTr(alLocal[nx],1,At("=",alLocal[nx])-1),SubsTr(alLocal[nx],At("=",alLocal[nx])+1,Len(alLocal[nx]))}
Next nx
RestArea(aArea)

aTam:=TamSX3("A1_COD")
AADD(aCampos,{ "TB_CODCLI" 	,"C",aTam[1],aTam[2] } )

If Mv_Par04 == 2
	aTam:=TamSX3("A1_LOJA")
	AADD(aCampos,{ "TB_LJCLI"  	,"C",aTam[1],aTam[2] } )
	//AADD(aCampos,{ "TB_EST"    	,"C",aTam[1],aTam[2] } )
	//AADD(aCampos,{ "TB_REG"    	,"C",12,0 } )
EndIf

aTam:=TamSX3("A1_NOME")
AADD(aCampos,{ "TB_NOME"   	,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A1_NREDUZ")
AADD(aCampos,{ "TB_NREDUZ"   	,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A1_MUN")
AADD(aCampos,{ "TB_MUN"    	,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A1_EST")

If Mv_Par04 == 2
	aTam:=TamSX3("A1_LOJA")
	//AADD(aCampos,{ "TB_LJCLI"  	,"C",aTam[1],aTam[2] } )
	AADD(aCampos,{ "TB_EST"    	,"C",aTam[1],aTam[2] } )
	AADD(aCampos,{ "TB_REG"    	,"C",12,0 } )
EndIf

AADD(aCampos,{ "TB_SET"    	,"C",10,0 } )
aTam:=TamSX3("A3_COD")
AADD(aCampos,{ "TB_CODVEND"    	,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A3_NREDUZ")
AADD(aCampos,{ "TB_NOMEVND"    	,"C",aTam[1],aTam[2] } )
AADD(aCampos,{ "TB_ATIVO"    	,"C",7,0 } )
aTam:=TamSX3("ACA_DESCRI")
AADD(aCampos,{ "TB_CANAL"    	,"C",aTam[1],aTam[2] } )

For nx:= 1 to Len(apData)
	aTam:=TamSX3("D2_TOTAL")
	AADD(aCampos,{ "VLFT"+ALLTRIM(STR(NX))    	,"N",aTam[1],aTam[2] }   )
	aTam:=TamSX3("D2_QUANT")
	AADD(aCampos,{ "QTDFT"+ALLTRIM(STR(NX))   	,"N",aTam[1],aTam[2] }   )
	aTam:=TamSX3("D1_TOTAL")
	AADD(aCampos,{ "VLDV"+ALLTRIM(STR(NX))    	,"N",aTam[1],aTam[2] }   )
	aTam:=TamSX3("D1_QUANT")
	AADD(aCampos,{ "QTDDV"+ALLTRIM(STR(NX))    ,"N",aTam[1],aTam[2] }   )
Next nx

aTam:=TamSX3("F2_YCANAL")
AADD(aCampos,{ "TB_YCANAL"    	,"C",aTam[1],aTam[2] } )

cNomArq 	:= CriaTrab(aCampos,.T.)
dbUseArea( .T.,, cNomArq,"TRB", .T. , .F. )

cNomArq1 := Subs(cNomArq,1,7)+"A"
If Mv_Par04 == 1
	IndRegua("TRB",cNomArq1,"TB_CODCLI+TB_CODVEND+TB_YCANAL",,,"Selecionando Registros...")		//"Selecionando Registros..."
Else
	IndRegua("TRB",cNomArq1,"TB_CODCLI+TB_LJCLI+TB_CODVEND+TB_YCANAL",,,"Selecionando Registros...")		//"Selecionando Registros..."
EndIf
//cNomArq2 := Subs(cNomArq,1,7)+"B"
//IndRegua("TRB",cNomArq2,"TB_CODCLI+TB_LJCLI+TB_CODVEND",,,"Selecionando Registros...")		//"Selecionando Registros..."

dbClearIndex()
dbSetIndex(cNomArq1+OrdBagExt())
//dbSetIndex(cNomArq2+OrdBagExt())


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Transforma parametros Range em expressao SQL                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MakeSqlExpr("NFATCA")
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Filtragem do relat๓rio                                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
#IFDEF TOP
	
	cAliasSD2	:=	GetNextAlias()
	cAliasAux	:= 	GetNextAlias()
	cAliasRest	:= 	GetNextAlias()
	If Mv_Par01 == 1
		clWhrCli := "% AND A1_VEND <> 'VN0000'%"
	ElseIf Mv_Par01 == 2
		clWhrCli := "% AND A1_VEND = 'VN0000'%"
	Else
		clWhrCli := "%%"
	EndIf
	
	clWhrD2 := "% NOT ("+IsRemito(2,"D2_TIPODOC")+")%"
	clWhrF2 := "% F2_VEND1 <> ''%"
	
	clWhrF4	:= "% F4_DUPLIC = 'S' AND F4_ESTOQUE = 'S' %"
	
	BeginSql Alias cAliasSD2
		SELECT	A1_COD,
		A1_LOJA,
		SUM(D2_TOTAL) AS TOTFAT,
		SUM(D2_QUANT) AS QTDFAT,
		SUM(D2_VALICM) AS TOTICM,
		SUM(D2_ICMSRET) AS VLICM,
		SUM(D2_VALFRE) AS VALFRE,
		SUM(D2_SEGURO) AS SEGURO,
		SUM(D2_DESPESA) AS DESPESA,
		SUM(D2_VALIPI) AS TOTIPI,
		MES,ANO,
		F2_VEND1,
		F2_YCANAL,
		F4_DUPLIC,
		F4_ESTOQUE
		FROM(
		SELECT	F2_DOC,
		F2_SERIE,
		F2_CLIENTE,
		F2_LOJA,
		F2_VEND1,
		F2_YCANAL
		FROM %Table:SF2%
		WHERE	F2_FILIAL = %xFilial:SF2%
		AND %notdel%
		AND %exp:clWhrF2%
		)SF2
		INNER JOIN
		(
		SELECT	D2_DOC,
		D2_SERIE,
		D2_TOTAL,
		D2_QUANT,
		D2_VALICM,
		D2_ICMSRET,
		D2_VALFRE,
		D2_SEGURO,
		D2_DESPESA,
		D2_VALIPI,
		SubStr(D2_EMISSAO,5,2) AS MES,
		SubStr(D2_EMISSAO,1,4) AS ANO,
		F4_DUPLIC, F4_ESTOQUE
		FROM  %Table:SD2% SD2,%Table:SF4% SF4
		WHERE	D2_FILIAL = %xFilial:SD2%
		AND F4_FILIAL = %xFilial:SF4%
		AND SF4.%notdel%
		AND SD2.%notdel%
		AND D2_TES = F4_CODIGO
		//					AND %exp:clWhrF4%
		AND D2_EMISSAO BETWEEN %exp:mv_par02% AND %exp:mv_par03%
		AND %exp:clWhrD2%
		)SD2
		ON SF2.F2_DOC = SD2.D2_DOC AND SF2.F2_SERIE = SD2.D2_SERIE
		INNER JOIN
		(
		SELECT 	A1_COD,
		A1_LOJA,
		A1_NOME,
		A1_NREDUZ
		FROM %Table:SA1%
		WHERE	A1_FILIAL = %xFilial:SA1%
		AND %notdel%
		%exp:clWhrCli%
		)SA1
		ON SA1.A1_COD = SF2.F2_CLIENTE AND SF2.F2_LOJA = SA1.A1_LOJA
		GROUP BY ANO,MES,A1_COD, A1_LOJA, F2_VEND1, F2_YCANAL, F4_DUPLIC, F4_ESTOQUE
		ORDER BY A1_COD, F2_VEND1
	EndSql
	
	While (cAliasSD2)->(!Eof())
		
		cGrpVend := (cAliasSD2)->F2_YCANAL //getadvfval("SA3","A3_GRPREP",xFilial("SA3")+(cAliasSD2)->F2_VEND1,1,"")
		If !(cGrpVend >= mv_par05 .and. cGrpVend <= mv_par06)
			(cAliasSD2)->(dbSkip())
			loop
		EndIf
		
		If Mv_Par04 == 1
			clChave	:= (cAliasSD2)->A1_COD
		Else
			clChave	:= (cAliasSD2)->A1_COD+(cAliasSD2)->A1_LOJA
		EndIf
		clSetor		:= getadvfval("SA1","A1_X_LOCZ",xFilial("SA1")+clChave,1,"")
		If !Empty(clSetor )
			nl2Pos := aScan(alLocal,{|x| x[1] == clSetor })
			If nl2Pos > 0
				clSetor		:= alLocal[nl2Pos][2]
			EndIf
		EndIf
		clNomeCli	:= getadvfval("SA1","A1_NOME",xFilial("SA1")+clChave,1,"")
		clNomeR		:= getadvfval("SA1","A1_NREDUZ",xFilial("SA1")+clChave,1,"")
		clEst		:= getadvfval("SA1","A1_EST",xFilial("SA1")+clChave,1,"")
		clMun		:= getadvfval("SA1","A1_MUN",xFilial("SA1")+clChave,1,"")
		clRegiao	:= IIf(clEst $ "AM/RR/AP/PA/TO/RO/AC","Norte",Iif(clEst $ "MA/PI/CE/RN/PE/PB/SE/AL/BA","Nordeste",Iif(clEst $ "MT/MS/GO","Centro-Oeste",Iif(clEst $ "SP/RJ/ES/MG","Sudeste",Iif(clEst $ "PR/RS/SC","Sul","")))))
		clVend		:= (cAliasSD2)->F2_VEND1
		clNomVnd	:= getadvfval("SA3","A3_NREDUZ",xFilial("SA3")+clVend,1,"")
		clCanal		:= getadvfval("ACA","ACA_DESCRI",xFilial("ACA")+cGrpVend,1,"")
		If alltrim(clVend) == "VN0000"
			clAtivo := "Inativo"
		Else
			clAtivo := "Ativo"
		EndIf
		
		clSearch := AllTrim(STRZERO(Val((cAliasSD2)->MES),2))+"/"+ SubsTr(AllTrim(STR(Val((cAliasSD2)->ANO))),3,2)
		nlPos	:= aScan(apData,{|x| x[3] == clSearch })
		TRB->(dbSetOrder(1))
		If !TRB->(dbSeek(clChave+clVend+(cAliasSD2)->F2_YCANAL))
			If ((cAliasSD2)->F4_ESTOQUE == "S" .AND. (cAliasSD2)->F4_DUPLIC == "S") .or. ((cAliasSD2)->VLICM+(cAliasSD2)->VALFRE+(cAliasSD2)->SEGURO+(cAliasSD2)->DESPESA) > 0
				
				RecLock("TRB",.T.)
				//		RecLock("TRB",TRB->(!dbSeek(clChave+clVend+(cAliasSD2)->F2_YCANAL)))
				
				Replace TRB->TB_CODCLI 	with (cAliasSD2)->A1_COD
				If mv_par04 == 2
					Replace TRB->TB_LJCLI 	with (cAliasSD2)->A1_LOJA
					Replace TRB->TB_EST 		with clEst
					Replace TRB->TB_REG 		with clRegiao
				EndIf
				Replace TRB->TB_NOME 	with clNomeCli
				Replace TRB->TB_NREDUZ 	with clNomeR
				Replace TRB->TB_MUN 		with clMun
				Replace TRB->TB_SET 		with clSetor
				Replace TRB->TB_CODVEND 	with clVend
				Replace TRB->TB_NOMEVND 	with clNomVnd
				Replace TRB->TB_ATIVO 	with clAtivo
				Replace TRB->TB_CANAL 	with clCanal
				Replace TRB->TB_YCANAL	with cGrpVend
				
			EndIf
		Else
			RecLock("TRB",.F.)
		EndIf
		If (cAliasSD2)->F4_ESTOQUE == "S" .AND. (cAliasSD2)->F4_DUPLIC == "S"
			Replace TRB->&("VLFT"+Alltrim(Str(nlPos)))		with ( TRB->&("VLFT"+Alltrim(Str(nlPos))) + ((cAliasSD2)->TOTFAT+(cAliasSD2)->TOTIPI+(cAliasSD2)->VLICM+(cAliasSD2)->VALFRE+(cAliasSD2)->SEGURO+(cAliasSD2)->DESPESA) )
			Replace TRB->&("QTDFT"+Alltrim(Str(nlPos)))	with ( TRB->&("QTDFT"+Alltrim(Str(nlPos))) + (cAliasSD2)->QTDFAT )
			Replace TRB->&("VLDV"+Alltrim(Str(nlPos)))		with ( TRB->&("VLDV"+Alltrim(Str(nlPos)) ) + ((cAliasSD2)->TOTFAT+(cAliasSD2)->TOTIPI+(cAliasSD2)->VLICM+(cAliasSD2)->VALFRE+(cAliasSD2)->SEGURO+(cAliasSD2)->DESPESA))// MESMO VALOR DO TOTAL FATURADOS, POIS SERม DESCONTADO NA PROXIMA ROTINA
			Replace TRB->&("QTDDV"+Alltrim(Str(nlPos)))	with ( TRB->&("QTDDV"+Alltrim(Str(nlPos))) + (cAliasSD2)->QTDFAT )
		Else
			Replace TRB->&("VLFT"+Alltrim(Str(nlPos)))		with ( TRB->&("VLFT"+Alltrim(Str(nlPos))) + ((cAliasSD2)->VLICM+(cAliasSD2)->VALFRE+(cAliasSD2)->SEGURO+(cAliasSD2)->DESPESA) )
			//			Replace TRB->&("QTDFT"+Alltrim(Str(nlPos)))	with ( TRB->&("QTDFT"+Alltrim(Str(nlPos))) + (cAliasSD2)->QTDFAT )
			Replace TRB->&("VLDV"+Alltrim(Str(nlPos)))		with ( TRB->&("VLDV"+Alltrim(Str(nlPos)) ) + ((cAliasSD2)->VLICM+(cAliasSD2)->VALFRE+(cAliasSD2)->SEGURO+(cAliasSD2)->DESPESA))// MESMO VALOR DO TOTAL FATURADOS, POIS SERม DESCONTADO NA PROXIMA ROTINA
			//			Replace TRB->&("QTDDV"+Alltrim(Str(nlPos)))	with ( TRB->&("QTDDV"+Alltrim(Str(nlPos))) + (cAliasSD2)->QTDFAT )
		EndIf
		If ((cAliasSD2)->F4_ESTOQUE == "S" .AND. (cAliasSD2)->F4_DUPLIC == "S") .or. ((cAliasSD2)->VLICM+(cAliasSD2)->VALFRE+(cAliasSD2)->SEGURO+(cAliasSD2)->DESPESA) > 0
			TRB->(msUnlock())
		EndIf
		(cAliasSD2)->(dbSkip())
	EndDo
	
	//inclusใo dos clientes que nใo tiveram venda no perํodo mas tiveram devolu็๕es
	BeginSql Alias cAliasRest
		SELECT F2_CLIENTE CLIENTE, F2_LOJA LOJA, F2_YCANAL YCANAL, F2_VEND1 VEND1
		FROM %Table:SD1% SD1, %Table:SF4% SF4, %Table:SF2% SF2, %Table:SF1% SF1
		WHERE D1_FILIAL  = %xFilial:SD1%
		AND D1_DTDIGIT between %exp:mv_par02% AND %exp:mv_par03%
		AND D1_TIPO = 'D'
		AND F4_FILIAL  = %xFilial:SF4%
		AND F4_CODIGO  = D1_TES
		AND F2_FILIAL  = %xFilial:SF2%
		AND F2_DOC     = D1_NFORI
		AND F2_SERIE   = D1_SERIORI
		AND F2_LOJA    = D1_LOJA
		AND F1_FILIAL  = %xFilial:SF1%
		AND F1_DOC     = D1_DOC
		AND F1_SERIE   = D1_SERIE
		AND F1_FORNECE = D1_FORNECE
		AND F1_LOJA    = D1_LOJA
		AND SD1.%notdel%
		AND SF4.%notdel%
		AND SF2.%notdel%
		AND SF1.%notdel%
		AND %exp:clWhrF4%
		AND F2_CLIENTE||F2_LOJA||F2_YCANAL||F2_VEND1 NOT IN(
		SELECT  F2_CLIENTE||F2_LOJA||F2_YCANAL||F2_VEND1 CHAVE
		FROM %Table:SD2% SD2, %Table:SF4% SF4, %Table:SF2% SF2
		WHERE D2_FILIAL  = %xFilial:SD2%
		AND D2_EMISSAO BETWEEN %exp:mv_par02% AND %exp:mv_par03%
		AND D2_TIPO NOT IN ('D', 'B')
		AND F2_FILIAL  = %xFilial:SF2%
		AND D2_DOC     = F2_DOC
		AND D2_SERIE   = F2_SERIE
		AND D2_CLIENTE = F2_CLIENTE
		AND D2_LOJA    = F2_LOJA
		AND F4_FILIAL  = %xFilial:SF4%
		AND F4_CODIGO  = D2_TES
		AND SD2.%notdel%
		AND SF2.%notdel%
		AND SF4.%notdel%
		AND %exp:clWhrF4%
		GROUP BY F2_CLIENTE||F2_LOJA||F2_YCANAL||F2_VEND1)
		GROUP BY F2_CLIENTE, F2_LOJA, F2_YCANAL, F2_VEND1
		ORDER BY F2_CLIENTE, F2_LOJA, F2_YCANAL, F2_VEND1
	EndSql
	
	
	While (cAliasRest)->(!Eof())
		
		cGrpVend := (cAliasRest)->YCANAL //getadvfval("SA3","A3_GRPREP",xFilial("SA3")+(cAliasSD2)->F2_VEND1,1,"")
		If !(cGrpVend >= mv_par05 .and. cGrpVend <= mv_par06)
			(cAliasRest)->(dbSkip())
			loop
		EndIf
		
		If Mv_Par04 == 1
			clChave	:= (cAliasRest)->CLIENTE
		Else
			clChave	:= (cAliasRest)->CLIENTE+(cAliasRest)->LOJA
		EndIf
		clSetor		:= getadvfval("SA1","A1_X_LOCZ",xFilial("SA1")+clChave,1,"")
		If !Empty(clSetor )
			nl2Pos := aScan(alLocal,{|x| x[1] == clSetor })
			If nl2Pos > 0
				clSetor		:= alLocal[nl2Pos][2]
			EndIf
		EndIf
		clNomeCli	:= getadvfval("SA1","A1_NOME",xFilial("SA1")+clChave,1,"")
		clNomeR		:= getadvfval("SA1","A1_NREDUZ",xFilial("SA1")+clChave,1,"")
		clEst		:= getadvfval("SA1","A1_EST",xFilial("SA1")+clChave,1,"")
		clMun		:= getadvfval("SA1","A1_MUN",xFilial("SA1")+clChave,1,"")
		clRegiao	:= IIf(clEst $ "AM/RR/AP/PA/TO/RO/AC","Norte",Iif(clEst $ "MA/PI/CE/RN/PE/PB/SE/AL/BA","Nordeste",Iif(clEst $ "MT/MS/GO","Centro-Oeste",Iif(clEst $ "SP/RJ/ES/MG","Sudeste",Iif(clEst $ "PR/RS/SC","Sul","")))))
		clVend		:= (cAliasRest)->VEND1
		clNomVnd	:= getadvfval("SA3","A3_NREDUZ",xFilial("SA3")+clVend,1,"")
		clCanal		:= getadvfval("ACA","ACA_DESCRI",xFilial("ACA")+cGrpVend,1,"")
		If alltrim(clVend) == "VN0000"
			clAtivo := "Inativo"
		Else
			clAtivo := "Ativo"
		EndIf
		
		TRB->(dbSetOrder(1))
		RecLock("TRB",TRB->(!dbSeek(clChave+clVend+(cAliasRest)->YCANAL)))
		
		Replace TRB->TB_CODCLI 	with (cAliasRest)->CLIENTE
		If mv_par04 == 2
			Replace TRB->TB_LJCLI 	with (cAliasRest)->LOJA
			Replace TRB->TB_EST 		with clEst
			Replace TRB->TB_REG 		with clRegiao
		EndIf
		Replace TRB->TB_NOME 	with clNomeCli
		Replace TRB->TB_NREDUZ 	with clNomeR
		Replace TRB->TB_MUN 		with clMun
		Replace TRB->TB_SET 		with clSetor
		Replace TRB->TB_CODVEND 	with clVend
		Replace TRB->TB_NOMEVND 	with clNomVnd
		Replace TRB->TB_ATIVO 	with clAtivo
		Replace TRB->TB_CANAL 	with clCanal
		Replace TRB->TB_YCANAL	with cGrpVend
		
		TRB->(msUnlock())
		(cAliasRest)->(dbSkip())
	EndDo
	
	//processa as devolu็๕es
	TRB->(dbGoTop())
	While TRB->(!EOF())


		clWhere := "% F2_VEND1 = '" +TRB->TB_CODVEND + "'"
		clWhere += "  AND F2_CLIENTE = '" + TRB->TB_CODCLI + "' AND F2_YCANAL = '"+ TRB->TB_YCANAL +"' "
		If Mv_Par04 == 2
			clWhere += " AND F2_LOJA = '" + TRB->TB_LJCLI + "'"
		EndIf
		clWhere += "%"
		
		clWhrF4	:= "% F4_DUPLIC = 'S' AND F4_ESTOQUE = 'S' %"
		
		BeginSql Alias cAliasAux
			SELECT	SUM(D1_TOTAL-D1_VALDESC) AS TOTAL,
			SUM(D1_QUANT) AS QTD,
			SUM(D1_ICMSRET) AS TOTICM ,
			SUM(D1_VALIPI) AS TOTIPI,
			ANO,
			MES,
			F2_YCANAL AS YCANAL,
			F4_ESTOQUE,
			F4_DUPLIC
			FROM(
			SELECT	D1_TOTAL,
			D1_QUANT,
			D1_ICMSRET,
			D1_VALIPI,
			D1_NFORI,
			D1_SERIORI,
			D1_VALDESC,
			D1_VALICM,
			SubStr(D1_DTDIGIT,5,2) AS MES,
			SubStr(D1_DTDIGIT,1,4) AS ANO,
			F4_ESTOQUE,
			F4_DUPLIC
			FROM %Table:SD1% SD1,%Table:SF4% SF4
			WHERE	D1_FILIAL = %xFilial:SD1%
			AND F4_FILIAL = %xFilial:SF4%
			AND SD1.%notdel%
			AND SF4.%notdel%
			AND D1_TIPO = 'D'
			AND D1_TES = F4_CODIGO
//			AND %EXP:clWhrF4%
			AND D1_DTDIGIT BETWEEN %exp:Mv_par02% AND %exp:Mv_par03%
			)SD1
			INNER JOIN
			(
			SELECT F2_DOC,
			F2_SERIE,
			F2_VEND1,
			F2_YCANAL
			FROM %Table:SF2%
			WHERE	F2_FILIAL = %xFilial:SF2%
			AND %notdel%
			AND %exp:clWhere%
			)SF2 ON SD1.D1_NFORI = SF2.F2_DOC AND SD1.D1_SERIORI = SF2.F2_SERIE
			GROUP BY ANO, MES, F2_YCANAL, F4_ESTOQUE, F4_DUPLIC
			ORDER BY ANO, MES, F2_YCANAL
		EndSql
		While (cAliasAux)->(!Eof())
			clSearch := AllTrim(STRZERO(Val((cAliasAux)->MES),2))+"/"+ SubsTr(AllTrim(STR(Val((cAliasAux)->ANO))),3,2)
			nlPos	:= aScan(apData,{|x| x[3] == clSearch })   
			If (cAliasAux)->F4_ESTOQUE == "S" .AND. (cAliasAux)->F4_DUPLIC == "S"
				RecLock("TRB",.F.)
				Replace TRB->&("VLDV"+Alltrim(Str(nlPos))) With (TRB->&("VLDV"+Alltrim(Str(nlPos))) - ( ( (cAliasAux)->TOTAL + ((cAliasAux)->TOTICM ) + (cAliasAux)->TOTIPI )))
				Replace TRB->&("QTDDV"+Alltrim(Str(nlPos))) With (TRB->&("QTDDV"+Alltrim(Str(nlPos))) - (cAliasAux)->QTD)
				TRB->(msUnlock())
			Elseif (cAliasAux)->TOTICM > 0
				RecLock("TRB",.F.)
				Replace TRB->&("VLDV"+Alltrim(Str(nlPos))) With (TRB->&("VLDV"+Alltrim(Str(nlPos))) - ( ( ((cAliasAux)->TOTICM ) )))
				//			Replace TRB->&("QTDDV"+Alltrim(Str(nlPos))) With (TRB->&("QTDFT"+Alltrim(Str(nlPos))) - (cAliasAux)->QTD)
				TRB->(msUnlock())
			EndIf
			(cAliasAux)->(dbSkip())
		EndDo
		(cAliasAux)->(dbCloseArea())
		TRB->(dbSkip())
	EndDo
#ELSE
	
#ENDIF
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Impressao do Relatorio                                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

dbSelectArea("TRB")
TRB->(dbSetOrder(1))
TRB->(dbGoTop())


While TRB->(!eof())
	
	AAdd(alInfo,{})
	For nx:= 1 to Len(aCampos)
		AADD(alInfo[Len(alInfo)],&("TRB->"+aCampos[nx][1]))
	Next nx
	
	TRB->(dbSkip())
EndDo
TRB->(dbCloseArea())


fErase(cNomArq+GetDBExtension())
fErase(cNomArq1+OrdBagExt())

KzCriaArq(alInfo)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKzCriaArq	     บAutor  ณAlfredo A. MagalhaesบData  ณ17/05/12	  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFun็ใo para incluir as informa็๕es no arquivo excel.			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณaInfo - array com as informa็๕es a serem incluidas no relatorio บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNenhum														  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KzCriaArq(aInfo)

Local nx		:= 0
Local ny		:= 0
Local clNomarq	:= "Rel_Carteira_de_Clientes_X_Vendedor_"+dtos(dDataBase) + "_" + StrTran(Time(),":","")
Local cFile		:= ""
Local cTexto	:= ""
Local cCaminho	:= ""
Local nlhandle	:= 0
Local cTitulo	:= "Relat๓rio de Carteira de Cliente x Vendedor"
Local cConteudo	:= ""

cCaminho	:= AllTrim(Mv_Par07)
If !ExistDir(cCaminho)
	If MakeDir(Trim(cCaminho))<>0
		Aviso("Nใo foi possivel criar o diretorio selecionado.")
		Return
	EndIf
EndIf
If RAT("\",cCaminho) <> Len(cCaminho)
	cCaminho += "\"
EndIf

cFile := cCaminho + clNomarq + ".xls"
nlHandle := FCreate(cFile,0)
If nlHandle < 0
	Alert("Nใo foi possivel criar o arquivo no diretorio!")
	Return
EndIf

cTexto := '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
cTexto += '<html xmlns="http://www.w3.org/1999/xhtml">'
cTexto += '<head>'
cTexto += '<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />'
cTexto += '<title>'+ cTitulo +'</title>'
cTexto += '</head>'
cTexto += '<body>'
cTexto += '<table style="border: 1px solid #000; border-collapse:collapse; width:99%; font:10px Verdana;">'
cTexto += '	<caption style="padding:0 0 5px 0;">'+cTitulo+'</caption>'
cTexto += '	<thead style="background:#006; color:#FFF; font-weight:bold">'
cTexto += '	  <tr>'
For nx:=1  To Len(apHeader)
	cTexto += '	    <th scope="col" style="border: 1px solid #000;">'+apHeader[nx]+'</th>'
Next nx
cTexto += '	  </tr>'
cTexto += '	</thead>'
cTexto += '	<tbody style="background:#FFFFFF;">'

fWrite(nlHandle,cTexto,Len(cTexto))
cTexto := ""

ProcRegua(len(aInfo))
For nx:= 1 to Len(aInfo)
	IncProc()
	cTexto += '	  <tr>'
	For ny:= 1 to len(apHeader)
		
		If Valtype(aInfo[nx][ny]) == 'D'
			cConteudo := DTOC(aInfo[nx][ny])
		ElseIf Valtype(aInfo[nx][ny]) == 'N'
			cConteudo := Transform(aInfo[nx][ny],'@E 999,999,999.99')
		Else
			cConteudo := "&nbsp;" + aInfo[nx][ny]
		EndIf
		
		cTexto += '	    <td style="border: 1px solid #000;">'+cConteudo+'</td>'
	Next ny
	cTexto += '	  </tr>'
	fWrite(nlHandle,cTexto,Len(cTexto))
	cTexto := ""
Next nx
cTexto += '	</tbody>'
cTexto += '</table>'
cTexto += '</body>'
cTexto += '</html>'

fWrite(nlHandle,cTexto,Len(cTexto))
cTexto := ""
fClose(nlHandle)
MsgInfo("Arquivo gerado com sucesso no diretorio: " + AllTrim(Mv_Par07),"Concluido.")
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKzGetData	     บAutor  ณAlfredo A. MagalhaesบData  ณ14/05/12	  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFun็ใo auxiliar para gerar o relatorio em excel				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ Nenhum					   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณalDatas - array com o range de datas selecionado pelo usuaio	  บฑฑ
ฑฑบ			 ณ	alData[n][1] - Data inicial do mes							  บฑฑ
ฑฑบ			 ณ	alData[n][2] - Data final do mes							  บฑฑ
ฑฑบ			 ณ	alData[n][3] - Numero do mes / ano selecionado				  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KzGetData()
Local dlDataini	:= Stod("")
Local dlDataFim	:= Stod("")
Local alDatas	:= {}

dlDataini := Mv_Par02
While(dlDataFim < MV_PAR03)
	dlDataFim := LastDay(dlDataIni)
	If dlDataini < dlDataFim
		If dlDataFim < Mv_Par03
			aadd(alDatas,{dlDataini,dlDataFim,SubStr(DtoC(dlDataini),4,5)})
			dlDataIni := dlDataFim+1
		ElseIf dlDataFim > Mv_Par03
			dlDataFim := Mv_Par03
			aadd(alDatas,{dlDataini,dlDataFim,SubStr(DtoC(dlDataini),4,5)})
		Else
			aadd(alDatas,{dlDataini,dlDataFim,SubStr(DtoC(dlDataini),4,5)})
		EndIf
	Else
		aadd(alDatas,{dlDataini,dlDataFim,SubStr(DtoC(dlDataini),4,5)})
		dlDataIni := dlDataFim+1
	EndIf
EndDo

Return alDatas
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณAjustaSx1	     บAutor  ณAlfredo A. MagalhaesบData  ณ09/05/12	  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณCria as perguntas do relatorio no dicionario de dados			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ Nenhum					   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ																  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AjustaSx1(cPerg)

Local aArea := GetArea()
Local aHelpPor	:= {}
Local aHelpEng	:= {}
Local aHelpSpa	:= {}

//Cliente Ativo
aHelpPor := {}
Aadd( aHelpPor, "Informar se os clientes a serem buscados" )
Aadd( aHelpPor, "estarao ativos ou nใo." )
PutSx1(cPerg,"01","Cliente Ativo ?" ,"","","mv_ch1","N",1,0,1,"C","","","","","mv_par01","Sim","Si","Yes","","Nใo","No","No","Todos","Todos","Todos","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

aHelpPor := {}
//Data Inicial
Aadd( aHelpPor, 'Informe a data inicial para ')
Aadd( aHelpPor, 'processamento do relatorio')
PutSx1(cPerg,"02","Data Inicial ","Data Inicial ","Data Inicial ","mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

//Data Final
aHelpPor := {}
Aadd( aHelpPor, 'Informe a data final para ')
Aadd( aHelpPor, 'processamento do relatorio')
PutSx1(cPerg,"03","Data Final ","Data Final ","Data Final ","mv_ch3","D",08,0,0,"G","(Mv_Par03 >= Mv_Par02)","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

//Aglutinar dados por loja
aHelpPor := {}
Aadd( aHelpPor, "Deseja aglutinar os dados " )
Aadd( aHelpPor, "por rede de lojas ?" )
PutSx1(cPerg,"04","Aglutina por rede de lojas ?" ,"","","mv_ch4","N",1,0,1,"C","","","","","mv_par04","Sim","Si","Yes","","Nใo","No","No","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

//Grupo de representantes inicial
aHelpPor := {}
Aadd( aHelpPor, 'Informe o grupo de representantes')
Aadd( aHelpPor, 'inicial de busca')
PutSx1(cPerg,"05","Grp. Representante de ","Grp. Representante de ","Grp. Representante de ","mv_ch5","C",6,0,0,"G","","ACA","","","mv_par05","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

//Grupo de representantes inicial
aHelpPor := {}
Aadd( aHelpPor, 'Informe o grupo de representantes')
Aadd( aHelpPor, 'final de busca')
PutSx1(cPerg,"06","Grp. Representante ate","Grp. Representante ate ","Grp. Representante ate ","mv_ch6","C",6,0,0,"G","","ACA","","","mv_par06","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

//Diretorio
aHelpPor := {}
Aadd( aHelpPor, 'Informe o diretorio para ')
Aadd( aHelpPor, 'gravacao do arquivo')
PutSx1(cPerg,"07","Diretorio ","Diretorio ","Diretorio ","mv_ch7","C",50,0,0,"G","","DRC","","","mv_par07","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

Return
