/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML0B  บAutor  ณMicrosiga           บ Data ณ  06/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCIWML0B
//Processa({|| WML0B_B1() })
WML0BNCM()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML0B  บAutor  ณMicrosiga           บ Data ณ  06/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function WML0BNCM()
Local aEmpresas:={"40","03"}
Local aFiliais
Local nInd
Local nContar
Local aDadosAux






For nYnd:=1 To Len(aEmpresas)

	aFiliais:=FWAllFilial(,,aEmpresas[nYnd])
	For nInd:=1 To Len(aFiliais)
		aConexoes:=GetUserInfoArray();		nContar:=0
		AEVAL( aConexoes, {|a| IIf( (a[6]==GetEnvServer() .And. AllTrim(Upper(a[5]))=="U_WMLBGRBNCM" ),nContar++, )   }  )
		aDadosAux:={aEmpresas[nYnd],aFiliais[nInd]}
		StartJob( "U_WMLBGRBNCM",GetEnvServer(),  nContar>14 , aDadosAux)
		//U_WMLBGRBNCM( aDadosAux)
	Next
Next


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML0B  บAutor  ณMicrosiga           บ Data ณ  06/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WMLBGRBNCM(aDados)
Local nPosCpo
Local nLenCodBZ
Local cFilSBZ
Local cFilSB1
Local aDadSBZ
Local cProduto
Local cMensagem
Local cModo 
Local cAliasSBZ


RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
nLenCodBZ:=AvSx3("BZ_COD",3)
cFilSB1	:=xFilial("SB1")
DbUseArea( .T.,"DBFCDXADS" , "\webmanager\NCM.dbf", "Work", .T. )
      
cAliasSBZ:=GetNextAlias()       
If SM0->M0_ESTCOB=="SP"
	EmpOpenFile(cAliasSBZ,"SBZ",1,.T.,"03",@cModo)
	cFilSBZ:="02"
ElseIf SM0->M0_ESTCOB=="PR"	
	EmpOpenFile(cAliasSBZ,"SBZ",1,.T.,"40",@cModo)
	cFilSBZ:="02"
EndIf


If (nPosCpo:=Work->(FieldPos(AllTrim(SM0->M0_ESTCOB))))==0
	Return
EndIf

SBZ->(DbSetOrder(1))//BZ_FILIAL+BZ_COD
Work->(DbGoTop())

Do While Work->(!Eof())
	
	cProduto:=Padr( AllTrim(Work->(FieldGet(nPosCpo))) ,nLenCodBZ)
	
	If Empty(cProduto) .Or. !SB1->(MsSeek(cFilSB1+cProduto)	)  .Or. !(cAliasSBZ)->(MsSeek(cFilSBZ+cProduto))
		Work->(DbSkip());Loop
	EndIf
	
	aDadSBZ:={}
	For nInd:=1 To (cAliasSBZ)->(FCount())
		AADD(aDadSBZ,(cAliasSBZ)->(FieldGet(nInd)) )
	Next
	
	BeginSQL Alias "SB5NEW"
		SELECT SB5.B5_COD
		FROM  %table:SB5% SB5
		WHERE B5_FILIAL = %xfilial:SB5%
		AND SB5.B5_YNCMWM=%Exp:AllTrim(Work->NCM)%
		AND SB5.%notDel%
		ORDER BY SB5.B5_COD
	EndSQL
	
	Do While SB5NEW->(!Eof())
		
		cMensagem:="Empresa:"+cEmpAnt+" Filial:"+cFilAnt+" Produto Modelo:"+cProduto+" NCM WM "+AllTrim(Work->NCM)+" Produto:"+SB5NEW->B5_COD
		PtInternal(1,cMensagem)
		IncProc(cMensagem)
		
		RecLock("SBZ", !SBZ->( MsSeek(xFilial("SBZ")+SB5NEW->B5_COD) ) )
		For nInd:=1 To Len(aDadSBZ)
			SBZ->(FieldPut(nInd,aDadSBZ[nInd]) )
		Next
		SBZ->BZ_COD		:=SB5NEW->B5_COD
		SBZ->BZ_FILIAL	:=xFilial("SBZ")
		SBZ->(MsUnLock())
		SB5NEW->(DbSkip())
	EndDo
	
	SB5NEW->(DbCloseArea())
	Work->(DbSkip())
EndDo

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML0B  บAutor  ณMicrosiga           บ Data ณ  06/29/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML0B_B1()
Local aEmpresas:={"03","40"}
Local aFiliais
Local nInd
Local nContar
Local aDadosAux

RpcClearEnv()
RpcSettype(3)
RpcSetEnv("03","01")  
   
//aArqAux:=Directory ("\WebManager\SB1WM*.csv",,Nil,.F.)

For nYnd:=1 To Len(aEmpresas)
	//For nXnd:=1 To Len(aArqAux)      
		//aDadosAux:={aEmpresas[nYnd],"01","\WebManager\"+aArqAux[nXnd,1] }
		aDadosAux:={aEmpresas[nYnd],"01","\WebManager\SB1WM.csv" }
		//StartJob( "U_WMLBGRVB1",GetEnvServer(), .F., aDadosAux)
		U_WMLBGRVB1( aDadosAux)
	//Next	                         
	
Next


Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML0B  บAutor  ณMicrosiga           บ Data ณ  06/29/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function WMLBGRVB1(aDados)
Local cTotLinha
Local cMensagem
Local nCont:=0
Local aHeadSB1:={}
Local aHeadSB5:={}
Local aProduto:={}
Local lCabec:=.T.
Local	nContColB1
Local	nContColB5
Local bCampo

RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
SX3->(DbSetOrder(2))
nContColB1:=SB1->(FCount())
nContColB5:=SB5->(FCount())
bCampo := {|x| Field(x) }
cArquivo:=aDados[3]

        
If !File(cArquivo)
	Return
EndIf	
FT_FUSE(cArquivo)
FT_FGOTOP() //PONTO NO TOPO

cTotLinha:=AllTrim(Str(FT_FLASTREC()))

FT_FGOTOP()

Do While !FT_FEOF()
	

	cBuffer := FT_FREADLN() //LENDO LINHA
	aDados:=Separa(cBuffer,";")
	
	If lCabec
		For nInd:=1 TO Len(aDados)
			If SX3->(DbSeek(aDados[nInd]))
				If Left( aDados[nInd],2)=="B1"
					AADD(aHeadSB1,{nInd,AllTrim(aDados[nInd]),AvSx3(aDados[nInd],2),AvSx3(aDados[nInd],3),AvSx3(aDados[nInd],4)  }  )
				ElseIf Left(aDados[nInd],2)=="B5"
					AADD(aHeadSB5,{nInd,AllTrim(aDados[nInd]),AvSx3(aDados[nInd],2),AvSx3(aDados[nInd],3),AvSx3(aDados[nInd],4)  }  )
				Endif
			EndIf
		Next
		nPosB1_COD:=Ascan(aHeadSB1,{|a| a[2]=="B1_COD" }  )
		lCabec:=.F.
		FT_FSKIP();	Loop
	EndIf
	
	
	
	If Empty(aDados)
		FT_FSKIP();Loop
	EndIf
	
	If Ascan(aProduto,aDados[nPosB1_COD])>0
		FT_FSKIP();Loop
	EndIf
	
	cMensagem:="Empresa:"+cEmpAnt+" Filial:"+cFilAnt+" Linha:"+StrZero(++nCont,5)+" de "+cTotLinha+"- Produto:"+aDados[1]
	PtInternal(1,cMensagem)                                                                                              
	TcInternal(1,cMensagem)                                                                                              
	
	
	AADD(aProduto,aDados[nPosB1_COD])
	aDados[1]:=padr(aDados[1],15)
	
	If SB1->(MsSeek(xFilial("SB1")+PadR(aDados[1], TamSx3("B1_COD")[1])  ))
		nOpcao:=4
		RegToMemory("SB1",.F.)
	Else
		nOpcao:=3
		RegToMemory("SB1",.T.)
	Endif
	
	For nInd:=1 To Len(aHeadSB1)
		xDados:=aDados[aHeadSB1[nInd,1]]
		If aHeadSB1[nInd,3]=="N"
			xDados:=Val(xDados)
		ElseIf aHeadSB1[nInd,3]=="D"
			xDados:=CTOD(xDados)
		ElseIf aHeadSB1[nInd,3]=="C"
			xDados:=Upper(xDados)
		EndIf
		bValue:=&("{|xValor| M->"+aHeadSB1[nInd,2]+":=xValor}")
		Eval(bValue,xDados)
	Next
	M->B1_COD:=aDados[1]
	M->B1_FILIAL:=xFilial("SB1")              
	M->B1_MSBLQL:=""
	
	If AllTrim(M->B1_XUSADO)=="1"
		M->B1_XUSADO:="S"
	ElseIf AllTrim(M->B1_XUSADO)=="0"		
		M->B1_XUSADO:="N"	
	EndIf	
	
	
	
	
	If SB5->(MsSeek(xFilial("SB5")+ PADR(aDados[1], TAMSX3("B5_COD")[1]) ))
		nOpcaoSB5:=4
		RegToMemory("SB5",.F.)
	Else
		nOpcaoSB5:=3
		RegToMemory("SB5",.T.)
	Endif
	
	For nInd:=1 To Len(aHeadSB5)
		xDados:=aDados[aHeadSB5[nInd,1]]
		If aHeadSB5[nInd,3]=="N"
			xDados:=Val(xDados)
		ElseIf aHeadSB5[nInd,3]=="D"
			xDados:=CTOD(xDados)
		ElseIf aHeadSB5[nInd,3]=="C"
			xDados:=Upper(xDados)
		EndIf
		//SB5->(FieldPut(FieldPos(aHeadSB5[nInd,2]),xDados) )
		bValue:=&("{|xValor| M->"+aHeadSB5[nInd,2]+":=xValor}")
		Eval(bValue,xDados)
	Next
	M->B5_COD:=aDados[1]
	M->B5_FILIAL:=xFilial("SB5")
	M->B5_YNCMWM:=StrTran(M->B1_POSIPI,".","")
	
	If Upper(AllTrim(M->B5_YNCMWM))=="INDEFINIDO" .Or. Upper(AllTrim(M->B5_YNCMWM))=="-" .Or. Empty(M->B5_YNCMWM)
		M->B1_POSIPI:="XXXXXXXX"
		M->B5_YNCMWM:="INDEFINIDO"
	Else
		M->B1_POSIPI:=Left(M->B5_YNCMWM,8)
	EndIf
	
	Begin Transaction
	If !AL_GRAVA(nOpcao,nOpcaoSB5,nContColB1,nContColB5)
		DisarmTransaction()
	EndIf
	
	End Transaction
	
	FT_FSKIP()
	
EndDo


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML0B  บAutor  ณMicrosiga           บ Data ณ  06/29/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function AL_GRAVA(nOpcao,nOpcaoSB5,nContColB1,nContColB5)
Local nX
Local cCampo,bCampo := {|x| Field(x) }
Local aproduto:={}
Local aComplemento:={}
Local nOrde
Private lMsHelpAuto := .t.
Private lMsErroAuto := .f.

SB1->(RecLock("SB1", (nOpcao==3)  ))
For nX:= 1 to nContColB1
	cCampo := SB1->(FieldName(nX))
	SB1->(FieldPut(nX,M->&(cCampo)) )
Next                   
SB1->B1_DTEXEC := MsDate()
SB1->(MsUnLock())      


                        
SB5->(RecLock("SB5",(nOpcaoSB5==3)))
For nX:= 1 to nContColB5
	cCampo := SB5->(FieldName(nX))
	SB5->(FieldPut(nX,M->&(cCampo)) )
Next
SB5->(MsUnLock())


/*
lMsErroAuto := .F.
aProduto:={}
SX3->(DBSetOrder(2))
For nX:= 1 to nContColB1
cCampo := SB1->(FieldName(nX))
SX3->(DbSeek(cCampo))
If X3USO(SX3->X3_USADO)
aadd(aProduto,{SB1->(FieldName(nX)),M->&(cCampo),nil})
EndIf
Next
MSExecAuto({|x,y| Mata010(x,y)},aProduto,nOpcao)
If lMsErroAuto
Return .F.
EndIf

SX3->(DBSetOrder(2))
aComplemento:={}
For nX:= 1 to nContColB5
cCampo := SB5->(EVAL(bCampo,nX))

SX3->(DbSeek(cCampo))
If X3USO(SX3->X3_USADO)
aadd(aComplemento,{SB5->(FieldName(nX)),M->&(cCampo),nil})
EndIf
Next

MSExecAuto({|x,y| Mata180(x,y)},aComplemento,nOpcaoSB5)
If lMsErroAuto
Return .F.
EndIf
*/
Return .T.



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML0B  บAutor  ณMicrosiga           บ Data ณ  06/29/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML0B_A7()
Local aEmpresas:={"03"}
Local aFiliais
Local nInd
Local nContar
Local aDadosAux
Local cCodCli:="000000"
Local cLojaCli:="01"
Local nCont:=0

RpcSetEnv("03","01")
nLen1:=AvSx3("A7_CODCLI" ,3)
nLen2:=AvSx3("A7_PRODUTO",3)



FT_FUSE("\WebManager\SA7WM.csv")
FT_FGOTOP() //PONTO NO TOPO
cTotLinha:=AllTrim(Str(FT_FLASTREC()))
FT_FGOTOP()

Do While !FT_FEOF()
	cMensagem:="Linha:"+StrZero(++nCont,5)+" de "+cTotLinha
	PtInternal(1,cMensagem)
	IncProc(cMensagem)
	
	cBuffer := FT_FREADLN() //LENDO LINHA
	aDados:=Separa(cBuffer,";")
	aDados[1]:=Padr(aDados[1],nLen1)
	aDados[2]:=Padr(aDados[2],nLen2)
	aDados[3]:=Upper(aDados[3])
	U_NCGRAVASA7(cCodCli,cLojaCli,aDados[1],aDados[3],aDados[2])
	FT_FSKIP()
EndDo

Return
