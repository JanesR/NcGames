#Include "Protheus.ch"

User Function DBNV2CSV(cliniseq) 
	Local cPerg := "DBIMPCS2"
	
	Private nOpc := 0
	
	Private cCadastro := "Ler arquivo csv"
	Private aSay := {}
	Private aButton := {}
	Private ciniseq	:= cliniseq  
	
	dbPergunta()
	If !Pergunte(cperg,.T.,"Parametros") 
		Return(.F.)
	EndIf
	//Pergunte(cperg,.T.) 
	AADD( aSay, "Leitura em um arquivo CSV" )
	AADD( aButton, { 1,.T.,{|| nOpc := 1,FechaBatch()}})
	AADD( aButton, { 2,.T.,{|| FechaBatch() }} )  
	
	FormBatch( cCadastro, aSay, aButton )
	
	If nOpc == 1
		Processa( {|| Import() }, "Processando..." )
	Endif 
	
Return


//+-------------------------------------------
//| Função - Import()
//+-------------------------------------------

Static Function Import()  

Local cBuffer := ""
Local cFileOpen := ""
Local cTitulo1 := "Selecione o arquivo"
Local cExtens := "Arquivo CSV | *.csv"
Local cMainPath := "C:\" 
Local llPrimer := .T.
Local clSeque	:= "000001"
Local alFore	:= {}
Local alSemana	:= {} //{0.2,0.15,0.25,0.4}


Local nRet := 0
Local nli := 0
Local nlj := 0
Local nlk := 0 

Local alGrpcli := {} 
Local cSqlUpd := ""
Local clDGrupo := ""

  
clSeque := StrZero(Val(MV_PAR13),6)

alSemana := { MV_PAR08/100,MV_PAR09/100,MV_PAR10/100,MV_PAR11/100}
clSeque := StrZero(MV_PAR03,3) + clSeque







cTitulo1 := "Selecione o arquivo de grupo de clientes"
cFileOpen := cGetFile(cExtens,cTitulo1,,cMainPath,.T.)
If !File(cFileOpen)
	MsgAlert("Arquivo csv: "+cFileOpen+" não localizado",cCadastro)
	Return
Endif
FT_FUSE(cFileOpen) //ABRIR
FT_FGOTOP() //PONTO NO TOPO
ProcRegua(FT_FLASTREC()) //QTOS REGISTROS LER 



Do While !FT_FEOF() //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
	IncProc()
	// Capturar dados
	If !llPrimer
		cBuffer := FT_FREADLN() //LENDO LINH
	 
		clcodgrp	:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clregiao	:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clDgrpcli	:= substr(cBuffer,1,At(";",cBuffer)-1) 
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		If "," $ cBuffer
			nlpercgrp	:= Val(Stuff(cBuffer, At(",",cBuffer), 1, "."))
		Else
			nlpercgrp	:= Val(substr(cBuffer,1,At(";",cBuffer)-1) )
		EndIf
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
		clCanal		:= substr(cBuffer,1,At(";",cBuffer)-1) 
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
		cldCanal	:= cBuffer
		
		If nlPercgrp <> 0
			AADD(algrpcli,{clcodgrp,clregiao,clDgrpcli,nlpercgrp,clCanal,cldCanal})
		EndIf
		
		
		
		FT_FSKIP() //próximo registro no arquivo txt
	Else 
		FT_FSKIP()
		llPrimer := .F.
	EndIf
	
EndDo

FT_FUSE() //fecha o arquivo txt




DbSelectArea("SCT")
DbSetOrder(1)

//---------*-*-*-*-*-*-*-*-*-*-*-*-*-*
cTitulo1 := "Selecione o arquivo de Forecast"
cFileOpen := cGetFile(cExtens,cTitulo1,,cMainPath,.T.)
If !File(cFileOpen)
	MsgAlert("Arquivo csv: "+cFileOpen+" não localizado",cCadastro)
	Return
Endif
FT_FUSE(cFileOpen) //ABRIR
FT_FGOTOP() //PONTO NO TOPO
ProcRegua(FT_FLASTREC()) //QTOS REGISTROS LER  

If MV_PAR02 == 4

	/*
	DbSelectArea("SCT")
	DbSetOrder(1)
	
	If SCT->(dbSeek(xFilial("SCT") + MV_PAR01)) 
	
		While !SCT->(EOF()) .And. SCT->CT_DOC == MV_PAR01 
			If RecLock("SCT",.F.) 
				SCT->CT_DOC := SUBSTR(MV_PAR01,1,8) + "P"
				SCT->(MsUnLock())
			EndIf
			SCT->(dbGoTop())
			SCT->(dbSeek(xFilial("SCT") + MV_PAR01)) 
		End
	EndIf
	
	*/
	If MSGYESNO("Atualiza documento W atual para P?","Atualiza?") 
		cSqlUpd := " UPDATE " + RetSqlName("SCT") 
		cSqlUpd += " SET CT_DOC = 'FORE" + PADL(mv_par12,4, "0") + "P' ," 
		cSqlUpd += " CT_XTIPO = '4'"
		cSqlUpd += " WHERE CT_DOC = 'FORE" + PADL(mv_par12,4, "0") + "W'" 
		cSqlUpd += " AND D_E_L_E_T_ = ' '"
		cSqlupd += " AND CT_FILIAL = '" + xfilial("SCT") + "'"
		
	
		nRet := TCSQLExec(cSqlUpd) 
		
		If nRet <> 0 
			Alert(TCSqlError()) 
			Return
		EndIf
	EndIf
EndIf
DbSelectArea("SX5")
DbSetOrder(1)

llPrimer := .T.
Do While !FT_FEOF() //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
	IncProc()
	// Capturar dados  
	
	//CODNC	Quant.7	Prcvend7	Faturamento7	Mrg Contrib.7	Quant.8	Prcvend8	Faturamento8	Mrg Contrib.8	Quant.9	Prcvend9	Faturamento9	Mrg Contrib.9	Quant.10	Prcvend10	Faturamento10	Mrg Contrib.10	Quant.11	Prcvend11	Faturamento11	Mrg Contrib.11	Quant.12	Prcvend12	Faturamento12	Mrg Contrib.12
	//AADD(algrpcli,{clcodgrp,clregiao,clDgrpcli,nlpercgrp,clgrpcli,cldgrpcl})
	If !llPrimer
		cBuffer := FT_FREADLN() //LENDO LINH 
		
		//Substitui virgula por ponto para conversao para numérico
		
		While "," $ cBuffer
			 cBuffer := Stuff(cBuffer, At(",",cBuffer), 1, ".")
		End

		
		alFore := {}
		If MV_PAR14 == 1
			clproduto	:= substr(cBuffer,1,At(";",cBuffer)-1)
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
			nlQtdJul	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlPrcJul	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlFatJul	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlMrgJul	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			If "01" >= MV_PAR04 .And. "01" <= MV_PAR05 
				AADD(alFore,{"1","01",nlQtdJul,nlPrcJul,nlFatJul,nlMrgJul})
			EndIf          
			
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
			nlQtdAgo	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlPrcAgo	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlFatAgo	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlMrgAgo	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			If "02" >= MV_PAR04 .And. "02" <= MV_PAR05 
		   		AADD(alFore,{"1","02",nlQtdAgo,nlPrcAgo,nlFatAgo,nlMrgAgo})
		 	EndIf
			
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
			nlQtdSet	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlPrcSet	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlFatSet	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlMrgSet	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			If "03" >= MV_PAR04 .And.  "03" <= MV_PAR05 
				AADD(alFore,{"1","03",nlQtdSet,nlPrcSet,nlFatSet,nlMrgSet})
			EndIf
			
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
			nlQtdOut	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlPrcOut	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlFatOut	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlMrgOut	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			If "04" >= MV_PAR04 .And.  "04" <= MV_PAR05 
				AADD(alFore,{"2","04",nlQtdOut,nlPrcOut,nlFatOut,nlMrgOut})
			EndIf
			
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
			nlQtdNov	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlPrcNov	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlFatNov	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlMrgNov	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			If "05" >= MV_PAR04 .And.  "05" <= MV_PAR05
				AADD(alFore,{"2","05",nlQtdNov, nlPrcNov,nlFatNov,nlMrgNov})
			EndIf
			
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
			nlQtdDez	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlPrcDez	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlFatDez	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlMrgDez	:= Val(cBuffer)
			If "06" >= MV_PAR04 .And.  "06" <= MV_PAR05 
				AADD(alFore,{"2","06",nlQtdDez,nlPrcDez,nlFatDez,nlMrgDez})
			EndIf
		
		Else
			
			clproduto	:= substr(cBuffer,1,At(";",cBuffer)-1)
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
			nlQtdJul	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlPrcJul	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlFatJul	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlMrgJul	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			If "07" >= MV_PAR04 .And. "01" <= MV_PAR05 
				AADD(alFore,{"3","01",nlQtdJul,nlPrcJul,nlFatJul,nlMrgJul})
			EndIf          
			
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
			nlQtdAgo	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlPrcAgo	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlFatAgo	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlMrgAgo	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			If "08" >= MV_PAR04 .And. "02" <= MV_PAR05 
		   		AADD(alFore,{"3","02",nlQtdAgo,nlPrcAgo,nlFatAgo,nlMrgAgo})
		 	EndIf
			
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
			nlQtdSet	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlPrcSet	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlFatSet	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlMrgSet	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			If "09" >= MV_PAR04 .And.  "03" <= MV_PAR05 
				AADD(alFore,{"3","03",nlQtdSet,nlPrcSet,nlFatSet,nlMrgSet})
			EndIf
			
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
			nlQtdOut	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlPrcOut	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlFatOut	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlMrgOut	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			If "10" >= MV_PAR04 .And.  "04" <= MV_PAR05 
				AADD(alFore,{"4","04",nlQtdOut,nlPrcOut,nlFatOut,nlMrgOut})
			EndIf
			
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
			nlQtdNov	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlPrcNov	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlFatNov	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlMrgNov	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			If "11" >= MV_PAR04 .And.  "05" <= MV_PAR05
				AADD(alFore,{"4","05",nlQtdNov, nlPrcNov,nlFatNov,nlMrgNov})
			EndIf
			
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
			nlQtdDez	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlPrcDez	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlFatDez	:= Val(substr(cBuffer,1,At(";",cBuffer)-1))
			cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
			nlMrgDez	:= Val(cBuffer)
			If "12" >= MV_PAR04 .And.  "06" <= MV_PAR05 
				AADD(alFore,{"4","06",nlQtdDez,nlPrcDez,nlFatDez,nlMrgDez})
			EndIf
		EndIf
		
			
	    
		//cldoc := "FR2012002"  
		//clDoc := "BUDG2012" 
		For nli:=1 to Len(alFore)
			For nlj:=1 to Len(alGrpcli)
				For nlk:=1 to Len(alSemana)
					If !(Round(((alFore[nli,3] * algrpcli[nlj,4]) * alsemana[nlk]),2) == 0 .and. Round(((alFore[nli,5] * algrpcli[nlj,4]) * alsemana[nlk]),2) == 0 .and. Round(((alFore[nli,6] * algrpcli[nlj,4]) * alsemana[nlk]),2) == 0)
						clDGrupo := ""
						If SX5->(dbSeek(xFilial("SX5") + "ZS" + AllTrim(algrpcli[nlj,1])))
							clDGrupo := AllTrim(SX5->X5_DESCRI)
						EndIf
						If RecLock("SCT",.T.)
							//CODNC	Quant.7	Prcvend7	Faturamento7	Mrg Contrib.7	Quant.8	Prcvend8	Faturamento8	Mrg Contrib.8	Quant.9	Prcvend9	Faturamento9	Mrg Contrib.9	Quant.10	Prcvend10	Faturamento10	Mrg Contrib.10	Quant.11	Prcvend11	Faturamento11	Mrg Contrib.11	Quant.12	Prcvend12	Faturamento12	Mrg Contrib.12
	   						//AADD(algrpcli,{clcodgrp,clregiao,clDgrpcli,nlpercgrp,clgrpcli,cldgrpcl}) 
						    //AADD(alFore,{"4","12",nlQtdDez,nlPrcDez,nlFatDez,nlMrgDez})                   
							SCT->CT_FILIAL	:= xFilial("SCT")
							SCT->CT_SEQUEN	:= clSeque 
							If MV_PAR02 == 4
								SCT->CT_XTIPO	:= "5"
							Else
								SCT->CT_XTIPO	:= Alltrim(Str(MV_PAR02)) 
							EndIf
							If Len(AllTrim(clProduto)) <= 11
								SCT->CT_PRODUTO := STRZERO(VAL(clproduto),11)
							Else
								SCT->CT_PRODUTO := clproduto
							EndIf
							SCT->CT_DOC	:= MV_PAR01
							SCT->CT_REGIAO := algrpcli[nlj,2]
							SCT->CT_XQUARTE := alFore[nli,1]
							SCT->CT_XMES := alFore[nli,2]
							SCT->CT_XSEMANA := AllTrim(Str(nlk))
							SCT->CT_XCANAL	:= 	PADL(AllTrim(algrpcli[nlj,5]),6,"0")
							SCT->CT_XDCANAL := AllTrim(algrpcli[nlj,6])
	
							SCT->CT_XGRPCLI	:= AllTrim(algrpcli[nlj,1])
							SCT->CT_XDGRPCL	:= clDGrupo
						
							SCT->CT_QUANT	:= Round(((alFore[nli,3] * algrpcli[nlj,4]) * alsemana[nlk]),2)
						
							SCT->CT_XPRCUNI := Round(alFore[nli,4],2) 
						
							SCT->CT_XFATUR	:= Round(((alFore[nli,5] * algrpcli[nlj,4]) * alsemana[nlk]),2)
						
							SCT->CT_XCONMAR	:= Round(((alFore[nli,6] * algrpcli[nlj,4]) * alsemana[nlk]),2)
									
							SCT->CT_XDTINI	:= MV_PAR06
							SCT->CT_XDTFIM	:= MV_PAR07
							SCT->CT_XVERSAO := MV_PAR03
							SCT->CT_XANO	:= MV_PAR12
					
							SCT->(MsUnLock()) 
					
							clSeque := Soma1(clSeque)
						ELSE
							CONOUT("DBIMPCSV - RecLock")
							
						EndIf
					EndIf
	
				Next nlk
			Next nlj
		Next nli
		
		FT_FSKIP() //próximo registro no arquivo txt
	Else 
		FT_FSKIP()
		llPrimer := .F.
	EndIf
EndDo
		
FT_FUSE() //fecha o arquivo txt
MsgInfo("Processo finalizada")
Return Nil		
		
 

Static Function dbpergunta()
Local aHelpP11 := {} 
//Local aHelpE11 := {}
//Local aHelpS11 := {}


PutSx1("DBIMPCS2","01","Documento ?" ,"","","mv_ch1","C",9,0,,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)


//Aadd( aHelpP11, "Tipo de documento ?" ) 
PutSx1("DBIMPCS2","02","Tipo documento ?" ,"","","mv_ch2","C",1,0,2,"C","","","","","mv_par02","Meta","Meta","Meta","","Forecast","Forecast","Forecast","Budget","Budget","Budget","CW","CW","CW","","","")//,aHelpP11,aHelpE11,aHelpS11)
//aHelpP11	:= {}

//Aadd( aHelpP11, "Inicio da sequencia ?" ) 
PutSx1("DBIMPCS2","03","Versao ?" ,"","","mv_ch3","N",3,0,,"G","","","","","mv_par03","","","","","","","","","","","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)
//aHelpP11	:= {} 

//Aadd( aHelpP11, "Mes de processamento do semestre ex julho = 01 ?" )
PutSx1("DBIMPCS2","04","Processar mes de ?" ,"","","mv_ch4","C",2,0,,"G","","","","","mv_par04","","","","","","","","","","","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)
//aHelpP11	:= {}   

//Aadd( aHelpP11, "Mes de processamento do semestre ex julho = 01 ?" )
PutSx1("DBIMPCS2","05","Processar mes até ?" ,"","","mv_ch5","C",2,0,,"G","","","","","mv_par05","","","","","","","","","","","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)
//aHelpP11	:= {}

//Aadd( aHelpP11, "Data inicio semestre ?" )
PutSx1("DBIMPCS2","06","Data de início do semestre ?" ,"","","mv_ch6","D",8,0,,"G","","","","","mv_par06","","","","","","","","","","","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)
//aHelpP11	:= {}

//Aadd( aHelpP11, "Data Fim semestre ?" )
PutSx1("DBIMPCS2","07","Data final do semestre ?" ,"","","mv_ch7","D",8,0,,"G","","","","","mv_par07","","","","","","","","","","","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)
//aHelpP11	:= {} 
//{0.2,0.15,0.25,0.4}
Aadd( aHelpP11, "Percentual da primeira semana?" )
PutSx1("DBIMPCS2","08","Percentual da primeira semana ?" ,"","","mv_ch8","N",2,0,,"G","","","","","mv_par08","","","","","","","","","","","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {} 

//Aadd( aHelpP11, "Percentual da segunda semana ?" )
PutSx1("DBIMPCS2","09","Percentual da segunda semana ?" ,"","","mv_ch9","N",2,0,,"G","","","","","mv_par09","","","","","","","","","","","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)
//aHelpP11	:= {} 

//Aadd( aHelpP11, "Percentual da terceira semana ?" )
PutSx1("DBIMPCS2","10","Percentual da terceira semana?" ,"","","mv_cha","N",2,0,,"G","","","","","mv_par10","","","","","","","","","","","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)
//aHelpP11	:= {} 

//Aadd( aHelpP11, "Percentual da quarta semana ?" )
PutSx1("DBIMPCS2","11","Percentual da quarta semana ?" ,"","","mv_chb","N",2,0,,"G","","","","","mv_par11","","","","","","","","","","","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)dbmsystem
//aHelpP11	:= {} 

PutSx1("DBIMPCS2","12","Ano ?" ,"","","mv_chc","C",4,0,,"G","","","","","mv_par12","","","","","","","","","","","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)dbmsystem

//Aadd( aHelpP11, "Tipo de documento ?" ) 
PutSx1("DBIMPCS2","13","Sequencia ?" ,"","","mv_chd","C",6,0,,"G","","","","","mv_par13","","","" ,"","","","","","","","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)

PutSx1("DBIMPCS2","14","Semestre ?" ,"","","mv_ch2","N",1,0,2,"C","","","","","mv_par14","Primeiro","Primeiro","Primeiro","","Segundo","Segundo","Segundo","","","","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)


Return		
