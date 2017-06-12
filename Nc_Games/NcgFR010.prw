#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³fc010Imp  ³ Autor ³Eduardo Riera          ³ Data ³04/01/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Funcao de Impressao ao dos Itens individuais da Posicao de  ³±±
±±³          ³Cliente.                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³Fc010Imp()          										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpN1		: Recno do Arquivo principal                      ³±±
±±³          ³ExpN2		: nBrowse                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINC010													  ³±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NcgFR010  ºAutor  ³Lucas Felipe        º Data ³  10/08/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NcgFR010()

Local aArea    := GetArea()
Local cTitulo  := cCadastro
Local cDesc1   := "Este programa ir  imprimir a Consulta de um Cliente," 
Local cDesc2   := "informando os dados acumulados do Cliente, os Pedidos"
Local cDesc3   := "em aberto, Titulos em Aberto e rela‡„o do Faturamento."
Local cString  := "SA1"
Local wnrel    := "FINC010"

Private Tamanho := "G"
Private Limite  := 220
Private cPerg   := "FIC010"
Private aReturn := { "Zebrado",1,"Administracao",1,2,1,"",1}
Private nLastKey:= 0
Private m_pag   := 1
Private lEnd    := .F.
Private nCasas 	:= GetMv("MV_CENT")

SA1->(MsUnlockAll())

If Pergunte(cPerg,.T.)
	wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,,.F.,Tamanho,,.F.)
	If ( nLastKey == 0 )
		SetDefault(aReturn,cString)
		If ( nLastKey == 0 )
			RptStatus({|lEnd| ImpDet(@lEnd,wnRel,cString,"FINC010",cTitulo)},cTitulo)
		EndIf
	EndIf
	dbSelectArea(cString)
	dbClearFilter()
	dbSetOrder(1)
	RestArea(aArea)
EndIf

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³ Eduardo Riera         ³ Data ³02.07.1998³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Controle de Fluxo do Relatorio.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpDet(lEnd,wnrel,cString,cNomeprog,cTitulo)

Local li      := 100 // Contador de Linhas
Local lImp    := .F. // Indica se algo foi impresso
Local cbCont  := 0   // Numero de Registros Processados
Local cbText  := ""  // Mensagem do Rodape
Local cHist	  := ""
Local cMoeda  := ""
Local aCol    := {}
Local aHeader := {}
Local nCntFor := 0 
Local nTamHis := 0	// Tamanho do campo historico a ser impresso
//
//                          1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//                01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Local cCabec1 := ""
Local cCabec2 := ""
Local aAlias  := {}
Local aParam  := {}
Local nMCusto := If(SA1->A1_MOEDALC > 0,SA1->A1_MOEDALC,Val(GetMv("MV_MCUSTO")))
Local cSalFin := ""
Local cLcFin  := ""
Local aGet    := {"","","",""}
Local lInverte
Local cObsMemo:= ""
	
SX3->(DbSetOrder(2))
cLcFin	:=	If(SX3->(DbSeek("A1_LCFIN")) ,X3Titulo(),"Limite Fin")
cSalFin  := If(SX3->(DbSeek("A1_SALFIN")),X3Titulo(),"Saldo Fin")

aadd(aParam,MV_PAR01)
aadd(aParam,MV_PAR02)
aadd(aParam,MV_PAR03)
aadd(aParam,MV_PAR04)
aadd(aParam,MV_PAR05)
aadd(aParam,MV_PAR06)
aadd(aParam,MV_PAR07)
aadd(aParam,MV_PAR08)
aadd(aParam,MV_PAR09)
aadd(aParam,MV_PAR10)
aadd(aParam,MV_PAR11)
aadd(aParam,MV_PAR12)
aadd(aParam,MV_PAR13)
aadd(aParam,MV_PAR14)
aadd(aParam,MV_PAR15)

cMoeda	:= AllTrim(STR(nMCusto))
cMoeda	:= SubStr(Getmv("MV_SIMB"+cMoeda)+Space(4),1,4)

dbSelectArea(cString)
SetRegua(LastRec())
dbSetOrder(1)

Li := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,Tamanho)
@li,000 PSAY Replicate("*",220)
Li++
@li,001 PSAY RetTitle("A1_COD")+": "+SA1->A1_COD+" "+RetTitle("A1_NOME")+": "+SA1->A1_NOME+" "+RetTitle("A1_TEL")+": "+;
	Alltrim(SA1->A1_DDI+" "+SA1->A1_DDD+" "+SA1->A1_TEL)
Li++
@li,001 PSAY RetTitle("A1_CGC")+": "+SA1->A1_CGC
Li++
@Li,001 PSAY RetTitle("A1_PRICOM")+": "+DTOC(SA1->A1_PRICOM)
Li++
@Li,001 PSAY RetTitle("A1_ULTCOM")+": "+DTOC(SA1->A1_ULTCOM)
Li++
@Li,001 PSAY RetTitle("A1_MATR")+": "+TransForm(SA1->A1_MATR,PesqPict("SA1","A1_MATR"))
Li++
@Li,001 PSAY RetTitle("A1_METR")+": "+TransForm(SA1->A1_METR,PesqPict("SA1","A1_METR")) 
Li++
@Li,001 PSAY RetTitle("A1_CHQDEVO")+": "+TransForm(SA1->A1_CHQDEVO,PesqPict("SA1","A1_CHQDEVO",4))
Li++
@Li,001 PSAY RetTitle("A1_DTULCHQ")+": "+Dtoc(SA1->A1_DTULCHQ)
Li++
@Li,001 PSAY RetTitle("A1_TITPROT")+": "+TransForm(SA1->A1_TITPROT,PesqPict("SA1","A1_TITPROT",4))
Li++
@Li,001 PSAY RetTitle("A1_DTULTIT")+": "+DtoC(SA1->A1_DTULTIT)
Li++
@Li,001 PSAY RetTitle("A1_RISCO")+": "+SA1->A1_RISCO
Li++
@Li,001 PSAY RetTitle("A1_VENCLC")+": "+Dtoc(SA1->A1_VENCLC)
Li++
@Li,001 PSAY "Descrição"+Space(31-Len("Valor"))+"Valor"+;
Space(11-Len("Valor Em"))+"Valor Em"+cMoeda
Li++
@Li,001 PSAY RetTitle("A1_SALDUP")+": "+Space(20-Len(RetTitle("A1_SALDUP")))+TransForm(SA1->A1_SALDUP,PesqPict("SA1","A1_SALDUP",14,1))+;
SPACE(6)+TransForm(SA1->A1_SALDUPM,PesqPict("SA1","A1_SALDUPM",14,nMcusto))
Li++
@Li,001 PSAY RetTitle("A1_MCOMPRA")+": "+Space(20-Len(RetTitle("A1_MCOMPRA")))+TransForm(xMoeda(SA1->A1_MCOMPRA,nMcusto,1,dDataBase,MsDecimais(1)),;
PesqPict("SA1","A1_MCOMPRA",14,1))+SPACE(6)+TransForm(SA1->A1_MCOMPRA,PesqPict("SA1","A1_MCOMPRA",14,nMcusto))
Li++
@Li,001 PSAY RetTitle("A1_MSALDO")+": "+Space(20-Len(RetTitle("A1_MSALDO")))+TransForm(xMoeda(SA1->A1_MSALDO,nMcusto,1,dDataBase,MsDecimais(1)),;
PesqPict("SA1","A1_MCOMPRA",14,1))+SPACE(6)+TransForm(SA1->A1_MSALDO,PesqPict("SA1","A1_MCOMPRA",14,nMCusto))
Li++

@Li,001 PSAY cSalFin+": "+Space(20-Len(cSalFin))+;
TRansform(SA1->A1_SALFIN,PesqPict("SA1","A1_SALFIN",14,1))+SPACE(6)+;
TRansform(SA1->A1_SALFINM,PesqPict("SA1","A1_SALFINM",14,nMcusto))
Li++

@Li,001 PSAY cLcFin+": "+Space(20-Len(cLcFin))+;
TRansform(xMoeda(SA1->A1_LCFIN,nMcusto,1,dDatabase,MsDecimais(1)),PesqPict("SA1","A1_LCFIN",14,1))+;
SPACE(6)+TRansform(SA1->A1_LCFIN,PesqPict("SA1","A1_LCFIN",14,nMcusto))
Li++

@Li,001 PSAY RetTitle("A1_LC")+": "+Space(20-Len(RetTitle("A1_LC")))+TransForm(xMoeda(SA1->A1_LC,nMcusto,1,dDataBase,MsDecimais(nMCusto)),PesqPict("SA1","A1_LC",14,nMCusto))+SPACE(6)+;
TransForm(SA1->A1_LC,PesqPict("SA1","A1_LC",14,1))
Li++                                              

@Li,001 PSAY RetTitle("A1_PRF_OBS")
Li++ 
@Li,001 PSAY MSMM(SA1->A1_PRF_OBS,1000,,AllTrim(cObsMemo),1,,,"SA1","A1_PRF_OBS")
 
Li+=3
@Li,001 PSAY PadC("TITULOS EM ABERTO",Limite) //"TITULOS EM ABERTO"
Li++
aHeader := Fc010Brow(1,@aAlias,aParam,.F.,aGet,.T.)
IncRegua(1)
cCabec1 := ""
aCol    := {}
dbSelectArea(aAlias[Len(aAlias)][1])
dbGotop()
aadd(aCol,1)

aHeader := FC010COLIMP(aHeader)

For nCntFor := 1 To Len(aHeader)
	If nModulo != 49    //Gestao Educacional
		If !(Alltrim(aHeader[nCntFor][2]) $ "E1_SDACRES#E1_SDDECRE#E1_HIST") .and. !(Alltrim(aHeader[nCntFor][2])== "E1_SALDO2")				
			cCabec1 += PadR(aHeader[nCntFor][1],Max(Len(TransForm(FieldGet(FieldPos(aHeader[nCntFor][2])),Trim(aHeader[nCntFor][3]))),Len(AllTrim(aHeader[nCntFor][1]))))+Space(2)
		
		ElseIf Alltrim(aHeader[nCntFor][2]) $ "E1_HIST"  //Limita Historico
			cHist	:= PadR(aHeader[nCntFor][1],12)+Space(2)
			cCabec1 += cHist
			nTamHis := Len(cHist) - 1
		Endif
	Else
		If !(Alltrim(aHeader[nCntFor][2]) $ "E1_SDACRES#E1_SDDECRE#E1_HIST") .and. !(Alltrim(aHeader[nCntFor][2])== "E1_SALDO2")
			cCabec1 += PadR(aHeader[nCntFor][1],Max(Len(TransForm(FieldGet(FieldPos(aHeader[nCntFor][2])),Trim(aHeader[nCntFor][3]))),Len(AllTrim(aHeader[nCntFor][1]))))+Space(2)
		Endif
	EndIf		
	
	aadd(aCol,Len(cCabec1)+2)
	
Next nCntFor
@ Li,001 PSAY cCabec1
Li++
While ( !Eof() )
	lImp := .T.
	If lEnd
		@ Prow()+1,001 PSAY "CANCELADO PELO OPERADOR" //"CANCELADO PELO OPERADOR"
		Exit
	EndIf
	If ( Li > 56 )
		li := cabec(cTitulo,cCabec1,cCabec2,cNomeprog,Tamanho)
		li++
	Endif
	For nCntFor := 1 To Len(aHeader)
		If nModulo != 49    //Gestao Educacional
			If !(Alltrim(aHeader[nCntFor][2]) $ "E1_SDACRES#E1_SDDECRE") .and. !(Alltrim(aHeader[nCntFor][2])== "E1_SALDO2")
				lInverte	:= E1_TIPO $ MVRECANT+","+MV_CRNEG .And. Alltrim(aHeader[nCntFor][2]) $ "E1_VLCRUZ#E1_SALDO"
				If (Alltrim(aHeader[nCntFor][2]) <> "E1_HIST")
					@ Li,aCol[nCntFor]-If(lInverte,1,0) PSAY If(lInverte,"(","")+TransForm(FieldGet(FieldPos(aHeader[nCntFor][2])),Trim(aHeader[nCntFor][3])) + If(lInverte,")","")
				Else
					@ Li,aCol[nCntFor] PSAY SubStr(TransForm(FieldGet(FieldPos(aHeader[nCntFor][2])),Trim(aHeader[nCntFor][3])),1,nTamHis)
				EndIf
			Endif		
		Else
			If !(Alltrim(aHeader[nCntFor][2]) $ "E1_SDACRES#E1_SDDECRE#E1_HIST") .and. !(Alltrim(aHeader[nCntFor][2])== "E1_SALDO2")
				lInverte	:= E1_TIPO $ MVRECANT+","+MV_CRNEG .And. Alltrim(aHeader[nCntFor][2]) $ "E1_VLCRUZ#E1_SALDO"
				@ Li,aCol[nCntFor]-If(lInverte,1,0) PSAY If(lInverte,"(","")+TransForm(FieldGet(FieldPos(aHeader[nCntFor][2])),Trim(aHeader[nCntFor][3])) + If(lInverte,")","")
			Endif		
		EndIf
	Next nCntFor
	Li++
	dbSkip()
	cbCont++
EndDo
Li++
@Li,001 PSAY "Total : " + RIGHT(aGet[1],5)  //"Total : "
@Li,077 PSAY aGet[2]
@Li,130 PSAY aGet[3]

Li+=3
If ( Li > 55 )
	li := cabec(cTitulo,"","",cNomeprog,Tamanho)
	li++
Endif

@Li,001 PSAY PadC("TITULOS RECEBIDOS",Limite) //"TITULOS RECEBIDOS"
Li++
aHeader := Fc010Brow(2,@aAlias,aParam,.F.,aGet,.T.)
cCabec1 := ""
aCol    := {}
IncRegua(2)

dbSelectArea(aAlias[Len(aAlias)][1])
dbGotop()
aadd(aCol,1)
aHeader := FC010COLIMP(aHeader)

For nCntFor := 1 To Len(aHeader)
	If !Alltrim(aHeader[nCntFor][2]) $ "E5_VLJUROS#E5_VLMULTA#E5_VLCORRE#E5_VLDESCO#E5_HISTOR"
		cCabec1 += PadR(aHeader[nCntFor][1],Max(Len(TransForm(FieldGet(FieldPos(aHeader[nCntFor][2])),Trim(aHeader[nCntFor][3]))),Len(AllTrim(aHeader[nCntFor][1]))))+Space(1)	
		aadd(aCol,Len(cCabec1)+1)
	ElseIf Alltrim(aHeader[nCntFor][2]) $ "E5_HISTOR"		//Limita Historico a 35 posicoes
		cCabec1 += PadR(aHeader[nCntFor][1],12)+Space(2)
		aadd(aCol,Len(cCabec1)+1)
	Else
		aadd(aCol,aCol[Len(aCol)])		// Deixar aCol do mesmo tamanho de aHeader para que na impressao nao
						  						// ocorram problemas.
	Endif	
Next nCntFor
@ Li,001 PSAY cCabec1
Li++
While ( !Eof() )
	lImp := .T.
	If lEnd
		@ Prow()+1,001 PSAY "CANCELADO PELO OPERADOR" //"CANCELADO PELO OPERADOR"
		Exit
	EndIf
	If ( Li > 56 )
		li := cabec(cTitulo,cCabec1,cCabec2,cNomeprog,Tamanho)
		li++
	Endif
	For nCntFor := 1 To Len(aHeader)
		If !Alltrim(aHeader[nCntFor][2]) $ "E5_VLJUROS#E5_VLMULTA#E5_VLCORRE#E5_VLDESCO#E5_HISTOR"
			@ Li,aCol[nCntFor] PSAY TransForm(FieldGet(FieldPos(aHeader[nCntFor][2])),Trim(aHeader[nCntFor][3]))
		ElseIf Alltrim(aHeader[nCntFor][2]) $ "E5_HISTOR"		//Limita Historico a 35 posicoes
			@ Li,aCol[nCntFor] PSAY Substr(FieldGet(FieldPos(aHeader[nCntFor][2])),1,12)+Space(2)
		Endif	
	Next nCntFor
	Li++
	dbSkip()
	cbCont++
EndDo
Li++
@Li,001 PSAY "Total : " + RIGHT(aGet[1],5)   //"Total : "
@Li,054 PSAY aGet[3]

Li+=3
If ( Li > 55 )
	li := cabec(cTitulo,"","",cNomeprog,Tamanho)
	li++
Endif

@Li,001 PSAY PadC("PEDIDOS",Limite) //"PEDIDOS"
Li++
aHeader := Fc010Brow(3,@aAlias,aParam,.F.,aGet,.T.)
cCabec1 := ""
aCol    := {}
IncRegua(3)

dbSelectArea(aAlias[Len(aAlias)][1])
dbGotop()
aadd(aCol,1)
For nCntFor := 1 To Len(aHeader)
	cCabec1 += PadR(aHeader[nCntFor][1],Max(Len(TransForm(FieldGet(FieldPos(aHeader[nCntFor][2])),Trim(aHeader[nCntFor][3]))),Len(AllTrim(aHeader[nCntFor][1]))))+Space(1)	
	aadd(aCol,Len(cCabec1)+1)
Next nCntFor
@ Li,001 PSAY cCabec1
Li++
While ( !Eof() )
	lImp := .T.
	If lEnd
		@ Prow()+1,001 PSAY "CANCELADO PELO OPERADOR"
		Exit
	EndIf
	If ( Li > 56 )
		li := cabec(cTitulo,cCabec1,cCabec2,cNomeprog,Tamanho)
		li++
	Endif
	For nCntFor := 1 To Len(aHeader)
		@ Li,aCol[nCntFor] PSAY TransForm(FieldGet(FieldPos(aHeader[nCntFor][2])),Trim(aHeader[nCntFor][3]))
	Next nCntFor
	Li++
	dbSkip()
	cbCont++
EndDo
Li+=2

@Li,001 PSAY "Total : " + RIGHT(aGet[1],5)
@Li,019 PSAY Transform(Val(StrTran(aGet[2],".","")),"@E 999,999,999.99")
@Li,034 PSAY Transform(Val(StrTran(aGet[3],".","")),"@E 999,999,999.99")
@Li,049 PSAY Transform(Val(StrTran(aGet[4],".","")),"@E 999,999,999.99")

Li+=3

If ( Li > 55 )
	li := cabec(cTitulo,"","",cNomeprog,Tamanho)
	li++
Endif

@Li,001 PSAY PadC("FATURAMENTO",Limite)
Li++
aHeader := Fc010Brow(4,@aAlias,aParam,.F.,aGet,.T.)
cCabec1 := ""
aCol    := {}
IncRegua(4)

dbSelectArea(aAlias[Len(aAlias)][1])
dbGotop()
aadd(aCol,1)
For nCntFor := 1 To Len(aHeader)
	cCabec1 += PadR(aHeader[nCntFor][1],Max(Len(TransForm(FieldGet(FieldPos(aHeader[nCntFor][2])),Trim(aHeader[nCntFor][3]))),Len(AllTrim(aHeader[nCntFor][1]))))+Space(1)	
	aadd(aCol,Len(cCabec1)+1)
Next nCntFor
@ Li,001 PSAY cCabec1
Li++
While ( !Eof() )
	lImp := .T.
	If lEnd
		@ Prow()+1,001 PSAY "CANCELADO PELO OPERADOR"
		Exit
	EndIf
	If ( Li > 56 )
		li := cabec(cTitulo,cCabec1,cCabec2,cNomeprog,Tamanho)
		li++
	Endif
	For nCntFor := 1 To Len(aHeader)
		@ Li,aCol[nCntFor] PSAY TransForm(FieldGet(FieldPos(aHeader[nCntFor][2])),Trim(aHeader[nCntFor][3]))
	Next nCntFor
	Li++
	dbSkip()
	cbCont++
EndDo
Li++
@Li,001 PSAY "Total : " + RIGHT(aGet[1],5)   //"Total : "
@Li,045 PSAY aGet[2]
Li++

If cPaisLoc	<> "BRA"
	Li++
	@Li,001 PSAY PadC("Cartera de Cheques",Limite) //"Cartera de Cheques"
	Li++
	
	aHeader := Fc010Brow(5,@aAlias,aParam,.F.,aGet,.T.)
	
	IncRegua(5)
	
	cCabec1 := ""
	aCol    := {}
	
	dbSelectArea(aAlias[Len(aAlias)][1])
	dbGotop()
	
	aadd(aCol,1)
	
	For nCntFor := 1 To Len(aHeader)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se e um campo numero, para alinhar a direita                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		If aHeader[nCntFor,8] == "N"
			cCabec1 += PadL(aHeader[nCntFor,1],Max(Len(TransForm(FieldGet(FieldPos(aHeader[nCntFor,2])),Trim(aHeader[nCntFor,3]))),Len(AllTrim(aHeader[nCntFor,1]))))+Space(1)
		Else
			cCabec1 += PadR(aHeader[nCntFor,1],Max(Len(TransForm(FieldGet(FieldPos(aHeader[nCntFor,2])),Trim(aHeader[nCntFor,3]))),Len(AllTrim(aHeader[nCntFor,1]))))+Space(1)
		EndIf
				
		aadd(aCol,Len(cCabec1)+1)
	Next nCntFor
	
	@ Li,001 PSAY alltrim(cCabec1)
	
	Li++
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis que controlam os totalizadores           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	aVals	:=	{0,0,0,0,0,0}	
	nPosEst	:=	Ascan(aHeader,{|x| Trim(x[2]) == "XX_ESTADO"})
	nPosVal	:=	Ascan(aHeader,{|x| Trim(x[2]) == "E1_VLCRUZ"})
	dbSelectArea(aAlias[Len(aAlias)][1])
	dbGotop()
	
	While ( !Eof() )
		lImp := .T.
		
		If lEnd
			@ Prow()+1,001 PSAY "CANCELADO PELO OPERADOR" //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
		
		If ( Li > 56 )
			li := cabec(cTitulo,cCabec1,cCabec2,cNomeprog,Tamanho)
			li++
		Endif
	
	
		For nCntFor := 1 To Len(aHeader)
			@ Li,aCol[nCntFor] PSAY TransForm(FieldGet(FieldPos(aHeader[nCntFor][2])),Trim(aHeader[nCntFor][3]))
	 	Next

		Li++
		cbCont++
		Do Case
			CASE FieldGet(FieldPos(aHeader[nPosEst,2]))	==	"PEND" //"PEND"
			 	aVals[1]	+=	FieldGet(FieldPos(aHeader[nPosVal,2]))
			 	aVals[4]++
			CASE FieldGet(FieldPos(aHeader[nPosEst,2]))	==	If(cPaisLoc$"URU|BOL|ARG","NEGO","NEGO") //"NEGO"
			 	aVals[2]	+=	FieldGet(FieldPos(aHeader[nPosVal,2]))
			 	aVals[5]++
			CASE FieldGet(FieldPos(aHeader[nPosEst,2]))	==	"COBR" //"COBR"
			 	aVals[3]	+=	FieldGet(FieldPos(aHeader[nPosVal,2]))
			 	aVals[6]++
		EndCase				 	

		dbSkip()
	 EndDo
	
	Li++
	
	@Li,000  PSAY "Totales --> " //"Totales --> "
	@Li,020 	PSAY "Pendientes"+ " : " + Transform(aVals[1],Tm(aVals[1],16,MsDecimais(1))) + " (" + Alltrim(STR(aVals[4])) + ")" //"Pendientes"
	If cPaisLoc$"URU|BOL"
		@Li,060	PSAY "Negociados"+ " : " + Transform(aVals[2],Tm(aVals[2],16,MsDecimais(1)))	+ " (" + Alltrim(STR(aVals[5])) + ")" //"Negociados"
	Else
	@Li,060	PSAY "Negociados"+ " : " + Transform(aVals[2],Tm(aVals[2],16,MsDecimais(1)))	+ " (" + Alltrim(STR(aVals[5])) + ")" //"Negociados"
	Endif
	@Li,100 	PSAY "Cobrados"+ " : " + Transform(aVals[3],Tm(aVals[3],16,MsDecimais(1)))	+ " (" + Alltrim(STR(aVals[6])) + ")" //"Cobrados"
	
	Li++
Endif
If ( lImp )
	Roda(cbCont,cbText,Tamanho)
EndIf
If Trim(GetMV("MV_VEICULO")) == "S"
   FG_SALOSV(SA1->A1_COD,SA1->A1_LOJA,," ","I")
EndIf   

aEval(aAlias,{|x| (x[1])->(dbCloseArea()),Ferase(x[2]+GetDBExtension()),Ferase(x[2]+OrdBagExt())})
dbSelectArea("SA1")
Set Device To Screen
Set Printer To


If ( aReturn[5] = 1 )
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()
Return(.T.)