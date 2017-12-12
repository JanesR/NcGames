#INCLUDE 'PROTHEUS.CH' 
#INCLUDE "FIVEWIN.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDBINDDBF  บAutor ณDBMS - Alberto S. Kibinoบ Data ณ 26/09/12 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ T-REPORT Indicadores. Analisa vendas dos ultimos 3 meses.  บฑฑ                                   \
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Comercial                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function DBINDDBF()


Local clQry	:= "" 
Local cAlias := GetNextAlias()

Local nTotReg  := 0 
Local llFirst := .T.

Local bQuery		:= {|| Iif(Select(calias) > 0, (calias)->(dbCloseArea()), Nil), dbUseArea(.T.,"TOPCONN",TCGENQRY(,,clQry),calias,.F.,.T.) , dbSelectArea(calias), (calias)->(dbGoTop()), nTotReg := 0, (calias)->(dbEval({|| nTotReg++ })), (calias)->(dbGoTop())}

Local nlMes	:= 0 
Local aDbStru := {} 

DBMCRIASX1()

	//-- Interface de impressao
If !Pergunte("DBM_INDIC" ,.T.)  
	Return
EndIf

aTam:=TamSX3("A1_COD")
AADD(aDbStru,{"CODCLI"	 ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("A1_NREDUZ")
AADD(aDbStru,{"CLIENT" ,aTam[3],aTam[1],aTam[2]})   

aTam:=TamSX3("A3_GRPREP")	
AADD(aDbStru,{"GRPCANAL" ,aTam[3],aTam[1],aTam[2]}) 


aTam:=TamSX3("ACA_DESCRI")	
AADD(aDbStru,{"CANAL" ,aTam[3],aTam[1],aTam[2]}) 
				
aTam:=TamSX3("A3_COD")	
AADD(aDbStru,{"CODVEN" ,aTam[3],aTam[1],aTam[2]}) 

aTam:=TamSX3("A3_NOME")	
AADD(aDbStru,{"VENDED" ,aTam[3],aTam[1],aTam[2]}) 							

AADD(aDbStru,{"CARTEIRA","N",4,0})						
AADD(aDbStru,{"MES01" ,"N",4,0})
AADD(aDbStru,{"MES02" ,"N",4,0})
AADD(aDbStru,{"MES03" ,"N",4,0})
AADD(aDbStru,{"MES04" ,"N",4,0}) 
AADD(aDbStru,{"EROSAO" ,"N",3,0}) 
AADD(aDbStru,{"REATIV" ,"N",3,0}) 
AADD(aDbStru,{"NOVO" ,"N",3,0}) 
AADD(aDbStru,{"NAOCOMPR" ,"N",4,0})
AADD(aDbStru,{"EXPER" ,"C",1,0})


If Select("VIXLS") > 0
	VIXLS->(dbCloseArea())
EndIf

clTime := Time()
While ":" $ clTime
	clTime := Stuff(clTime,At(":",clTime),1,"")
End

CNOMEDBF := "NCVINCOM"

fErase("SYSTEM\VIXLS.cdx") 
If File("SYSTEM\" + CNOMEDBF + ".dbf")
	//fErase("XLSNC\" + CNOMEDBF +GetDBExtension())
	//COPY FILE ("XLSNC\" + CNOMEDBF + ".dbf") TO ("XLSNC\" + CNOMEDBF + SubStr(DtoS(Date()),5,4) + ".dbf")
	fErase("SYSTEM\" + CNOMEDBF +GetDBExtension())
EndIf 



DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")  

MakeDir("C:\relatorios")



DbUseArea(.T.,"DBFCDXADS", "SYSTEM\" + CNOMEDBF,"VIXLS",.T.,.F.)
Index On  CODVEN TAG IND1 to VIXLS


DbSelectArea("SA1")
DbSetOrder(1)

DbSelectArea("SA3")
DbSetOrder(1)

DbSelectArea("ACA")
DbSetOrder(1)

MyNewSX6( "DBM_DTUCA1", '20110101', 'C', "Data Ultima compra a ser considerado Relat๓rio indicadores", "Data Ultima compra a ser considerado Relat๓rio indicadores", "Data Ultima compra a ser considerado Relat๓rio indicadores")

//Firstday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01)-3,2) + "15" ))                                        

clQry := " SELECT A1_FILIAL, A1_COD," 
clQry += " SUM("
//Subquery para trazer quantidade de faturas de 3 meses anteriores a data base do parโmetro.
clQry += " COALESCE("
clQry += " (SELECT COUNT(F2_DOC)"
clQry += " FROM " + RetSqlName("SF2") + " S2"
clQry += " WHERE S2.F2_EMISSAO BETWEEN '" + DtoS(Firstday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01)-3,2) + "15" ))) + "' AND '" + DtoS(Lastday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01)-3,2) + "15" ))) + "' "
clQry += " AND S2.F2_CLIENTE = SA1.A1_COD"
clQry += " AND S2.F2_LOJA = SA1.A1_LOJA"
clQry += " AND S2.F2_FILIAL = '" + xFilial("SF2") + "'"
clQry += " AND S2.F2_TIPO = 'N'"
clQry += " AND S2.F2_DUPL <> '         '"
clQry += " AND S2.D_E_L_E_T_ = ' ')"
clQry += " ,0)) AS M1,"
//Subquery para trazer quantidade de faturas de 2 meses anteriores a data base do parโmetro.
clQry += " SUM("

clQry += " COALESCE("
clQry += " (SELECT COUNT(F2_DOC)"
clQry += " FROM " + RetSqlname("SF2") + " S2"
clQry += " WHERE S2.F2_EMISSAO BETWEEN '" + DtoS(Firstday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01)-2,2) + "15" ))) + "' AND '" + DtoS(Lastday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01)-2,2) + "15" ))) + "' "
clQry += " AND S2.F2_CLIENTE = SA1.A1_COD"
clQry += " AND S2.F2_LOJA = SA1.A1_LOJA"
clQry += " AND S2.F2_FILIAL = '" + xFilial("SF2") + "'"
clQry += " AND S2.F2_TIPO = 'N'"
clQry += " AND S2.F2_DUPL <> '         '"
clQry += " AND S2.D_E_L_E_T_ = ' ')"
clQry += " ,0)) AS M2,"
//Subquery para trazer quantidade de faturas do mes anterior a data base do parโmetro.
clQry += " SUM("
clQry += " COALESCE("
clQry += " (SELECT COUNT(F2_DOC)"
clQry += " FROM " + RetSqlname("SF2") + " S2"
clQry += " WHERE S2.F2_EMISSAO BETWEEN '" + DtoS(Firstday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01)-1,2) + "15" ))) + "' AND '" + DtoS(Lastday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01)-1,2) + "15" ))) + "' "
clQry += " AND S2.F2_CLIENTE = SA1.A1_COD"
clQry += " AND S2.F2_LOJA = SA1.A1_LOJA" 
clQry += " AND S2.F2_FILIAL = '" + xFilial("SF2") + "'"
clQry += " AND S2.F2_TIPO = 'N'"
clQry += " AND S2.F2_DUPL <> '         '"
clQry += " AND S2.D_E_L_E_T_ = ' ')"
clQry += " ,0)) AS M3,"
// faturas do mes atual
clQry += " SUM("
clQry += " COALESCE("
clQry += " (SELECT COUNT(F2_DOC)"
clQry += " FROM " + RetSqlname("SF2") + " S2"
clQry += " WHERE S2.F2_EMISSAO BETWEEN '" + DtoS(Firstday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01),2) + "15" ))) + "' AND '" + DtoS(Lastday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01),2) + "15" ))) + "' "
clQry += " AND S2.F2_CLIENTE = SA1.A1_COD"
clQry += " AND S2.F2_LOJA = SA1.A1_LOJA"
clQry += " AND S2.F2_FILIAL = '" + xFilial("SF2") + "'"
clQry += " AND S2.F2_TIPO = 'N'"
clQry += " AND S2.F2_DUPL <> '         '"
clQry += " AND S2.D_E_L_E_T_ = ' ')"
clQry += " ,0)) AS M4"


clQry += " FROM " + RetSqlName("SA1") + " SA1"

clQry += " WHERE SA1.D_E_L_E_T_ = ' '"
clQry += " AND A1_PRICOM <> '        '" 
clQry += " AND A1_ULTCOM >= '" + GetMv("DBM_DTUCA1") + "'"
clQry += " AND A1_YCANAL BETWEEN '" + MV_PAR02 + "' AND '" + MV_PAR03 + "'"
clQry += " GROUP BY A1_FILIAL, A1_COD"
clQry += " ORDER BY A1_FILIAL, A1_COD"   


clQry := ChangeQuery(clQry)
    
  	    		
LJMsgRun("Consultando Clientes...","Aguarde...",bQuery)
	//Eval(bQuery) 
	
DbSelectArea("ACA")
DbSetOrder(1)

	 
	
Do While (cAlias)->(!Eof()) 
	If SA1->(DbSeek(xFilial("SA1") + (cAlias)->A1_COD))
		If ACA->(DbSeek(xFilial("ACA") + SA1->A1_YCANAL)) 
			If SA3->(dbSeek(xFilial("SA3") + SA1->A1_VEND))
		    	If ("VIXLS")->(RecLock("VIXLS", .T.))
			
					("VIXLS")->CODCLI	:= (cAlias)->A1_COD
					("VIXLS")->CLIENT	:= SA1->A1_NREDUZ
					("VIXLS")->GRPCANAL	:= SA1->A1_YCANAL
					("VIXLS")->CANAL	:= ACA->ACA_DESCRI
					("VIXLS")->CODVEN	:= SA1->A1_VEND
					("VIXLS")->VENDED	:= SA3->A3_NOME
					("VIXLS")->CARTEIRA	:= 1  
					("VIXLS")->MES01	:= (cAlias)->M1
					("VIXLS")->MES02	:= (cAlias)->M2
					("VIXLS")->MES03	:= (cAlias)->M3
					("VIXLS")->MES04	:= (cAlias)->M4
					("VIXLS")->EXPER	:= " "
				
					
					If (cAlias)->M1 = 0 .and. (cAlias)->M2 = 0 .and. (cAlias)->M3 = 0 
						If Month(SA1->A1_PRICOM) == Month(MV_PAR01) .And. Year(SA1->A1_PRICOM) == Year(MV_PAR01)
							("VIXLS")->NOVO := 1 //cliente novo
							//("VIXLS")->REATIV := 1 //Reativado
						Else 
							If (cAlias)->M4 > 0
								("VIXLS")->NAOCOMPR := 0  
								
							Else
								("VIXLS")->NAOCOMPR := 1  
								("VIXLS")->EROSAO := 1
							EndIf
						
							If (cAlias)->M4 > 0
								("VIXLS")->REATIV := 1 //Reativado
							Else
								("VIXLS")->REATIV := 0 
							EndIf
						EndIf
					Else
						("VIXLS")->EROSAO := 0  
						If (cAlias)->M4 > 0
							("VIXLS")->NAOCOMPR := 0 
						Else
							("VIXLS")->NAOCOMPR := 1 
						EndIf
					EndIf
					("VIXLS")->(MsUnLock())
				EndIf
			EndIf
		EndIf
	EndIf
	(cAlias)->(dbSkip())
End 


dbSelectArea("VIXLS")
dbCloseArea()

//COPY FILE ("SYSTEM\" + CNOMEDBF + ".dbf") TO ("XLSNC\" + CNOMEDBF + ".dbf") 
CPYS2T("\SYSTEM\" + CNOMEDBF + ".dbf","C:\relatorios",.T.)
fErase("SYSTEM\" + CNOMEDBF +GetDBExtension()) 
fErase("SYSTEM\" + CNOMEDBF +OrdBagExt())

MSGALERT("Termino do processo." ,"Finalizado")


Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDBMCRIASX1 บAutor ณ DBMS- Alberto     บ Data ณ  27/02/2012  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Static Function para criacao de perguntas                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function DBMCRIASX1()

PutSx1("DBM_INDIC","01","Data Base"	   		,"Da Base"			,"Da Base"  		,"mv_ch1","D",08,0,1,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_INDIC","02","Canal de"			,"Canal de"	   		 ,"Canal de"	    ,"mv_ch2","C",06,0,1,"G","","ACA","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_INDIC","03","Canal Ate"	    	,"Canal Ate"	   	,"Canal Ate"	    ,"mv_ch3","C",06,0,1,"G","","ACA","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})


Return  

     

             

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMyNewSX6  บAutor  ณAlmir Bandina       บ Data ณ  10/02/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescri็ใo ณAtualiza o arquivo de parโmetros.                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGAMES - TECNOLOGIA DA INFORMAวรO                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametro ณExpC1 = Nome do Parโmetro                                   บฑฑ
ฑฑบ          ณExpX1 = Conte๚do do Parโmetro           	                  บฑฑ
ฑฑบ          ณExpC2 = Tipo do Parโmetro                                   บฑฑ
ฑฑบ          ณExpC3 = Descri็ใo em portugues                              บฑฑ
ฑฑบ          ณExpC4 = Descri็ใo em espanhol                               บฑฑ
ฑฑบ          ณExpC5 = Descri็ใo em ingles                                 บฑฑ
ฑฑบ          ณExpL1 = Grava o conte๚do se existir o parโmetro             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function MyNewSX6( cMvPar, xValor, cTipo, cDescP, cDescS, cDescE, lAlter , lFilial)

Local aAreaAtu	:= GetArea()
Local lRecLock	:= .F.
Local xlReturn

Default lAlter 	:= .F.
Default lFilial	:= .F.

If ( ValType( xValor ) == "D" )
	If " $ xValor
		xValor := Dtoc( xValor, "ddmmyy" )
	Else
		xValor	:= Dtos( xValor )
	Endif
ElseIf ( ValType( xValor ) == "N" )
	xValor	:= AllTrim( Str( xValor ) )
ElseIf ( ValType( xValor ) == "L" )
	xValor	:= If ( xValor , ".T.", ".F." )
EndIf

DbSelectArea('SX6')
DbSetOrder(1)

If lFilial
	lRecLock := !MsSeek( cFilAnt + Padr( cMvPar, Len( X6_VAR ) ) )
Else
	lRecLock := !MsSeek( Space( Len( X6_FIL ) ) + Padr( cMvPar, Len( X6_VAR ) ) )
EndIf

If lRecLock
	
	RecLock( "SX6", lRecLock )
	
	If lFilial
		FieldPut( FieldPos( "X6_FIL" ), cFilAnt )	
	EndIf
		
	FieldPut( FieldPos( "X6_VAR" ), cMvPar )
	
	FieldPut( FieldPos( "X6_TIPO" ), cTipo )
	
	FieldPut( FieldPos( "X6_PROPRI" ), "U" )
	
	If !Empty( cDescP )
		FieldPut( FieldPos( "X6_DESCRIC" ), SubStr( cDescP, 1, Len( X6_DESCRIC ) ) )
		FieldPut( FieldPos( "X6_DESC1" ), SubStr( cDescP, Len( X6_DESC1 ) + 1, Len( X6_DESC1 ) ) )
		FieldPut( FieldPos( "X6_DESC2" ), SubStr( cDescP, ( Len( X6_DESC2 ) * 2 ) + 1, Len( X6_DESC2 ) ) )
	EndIf
	
	If !Empty( cDescS )
		FieldPut( FieldPos( "X6_DSCSPA" ), cDescS )
		FieldPut( FieldPos( "X6_DSCSPA1" ), SubStr( cDescS, Len( X6_DSCSPA1 ) + 1, Len( X6_DSCSPA1 ) ) )
		FieldPut( FieldPos( "X6_DSCSPA2" ), SubStr( cDescS, ( Len( X6_DSCSPA2 ) * 2 ) + 1, Len( X6_DSCSPA2 ) ) )
	EndIf
	
	If !Empty( cDescE )
		FieldPut( FieldPos( "X6_DSCENG" ), cDescE )
		FieldPut( FieldPos( "X6_DSCENG1" ), SubStr( cDescE, Len( X6_DSCENG1 ) + 1, Len( X6_DSCENG1 ) ) )
		FieldPut( FieldPos( "X6_DSCENG2" ), SubStr( cDescE, ( Len( X6_DSCENG2 ) * 2 ) + 1, Len( X6_DSCENG2 ) ) )
	EndIf
	
	If lRecLock .Or. lAlter
		FieldPut( FieldPos( "X6_CONTEUD" ), xValor )
		FieldPut( FieldPos( "X6_CONTSPA" ), xValor )
		FieldPut( FieldPos( "X6_CONTENG" ), xValor )
	EndIf
	
	MsUnlock()
	
EndIf

xlReturn := GetNewPar(cMvPar)

RestArea( aAreaAtu )


Return(xlReturn)	
	
