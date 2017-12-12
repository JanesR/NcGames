#include "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR116  บAutor  ณLucas System        บ Data ณ  11/13/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGPR116()
Local aAreaAtu	   :=GetArea()
Local cPerg  		:= 'NCGPR116'
Local cWorkAlias 	:= GetNextAlias()
Local cWorkNome
Local oReport
Private cNomeTRB

CriaSx1(cPerg)
Pergunte(cPerg, .F.)

oReport := ReportDef(cPerg,@cWorkNome,cWorkAlias)
oReport:PrintDialog()

If Select(cWorkAlias)>0
	(cWorkAlias)->(E_EraseArq(cWorkNome))
EndIf

RestArea(aAreaAtu)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR116  บAutor  ณMicrosiga           บ Data ณ  11/13/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef(cPerg,cWorkNome,cWorkAlias)
Local cTitle  := "Relat๓rio Endere็o Entrega Site x Endere็o Entrega ERP"
Local cHelp   := ""
Local oReport
Local oSection1
Local aOrdem    := {"Codigo Site","Codigo ERP"}


oReport := TReport():New('NCGPR116',cTitle,cPerg,{|oReport| ReportPrint(oReport,aOrdem,@cWorkNome,cWorkAlias)},cHelp)
oReport:SetLandScape(.T.)


oSection1 := TRSection():New(oReport,"Endere็o Entrega",{cWorkAlias},aOrdem)

TRCell():New(oSection1,"Aprovado"	 ,cWorkAlias, "Aprovado"  )
TRCell():New(oSection1,"ORIGEM"	 	 ,cWorkAlias, "Origem"  )
TRCell():New(oSection1,"A1_ZCODCIA"	 ,cWorkAlias, "Codigo Site"  )
TRCell():New(oSection1,"A1_COD" 		 ,cWorkAlias , "Codigo")
TRCell():New(oSection1,"A1_LOJA" 	 ,cWorkAlias , "Loja"  )
TRCell():New(oSection1,"A1_NOME" 	 ,cWorkAlias , "Nome"  )

TRCell():New(oSection1,"A1_ENDENT" 	 ,cWorkAlias , "Endereco"  )
TRCell():New(oSection1,"A1_BAIRROE"  ,cWorkAlias , "Bairro"  )
TRCell():New(oSection1,"A1_CEPE" 	 ,cWorkAlias , "CEP"  )
TRCell():New(oSection1,"A1_MUNE" 	 ,cWorkAlias , "Municipio"  )
TRCell():New(oSection1,"A1_ESTE" 	 ,cWorkAlias , "Estado"  )

//TRCell():New(oSection1,"WK_ENDENT" 	 ,cWorkAlias , "Endereco Site"  )
//TRCell():New(oSection1,"WK_BAIRROE"  ,cWorkAlias , "Bairro Site"  )
//TRCell():New(oSection1,"WK_CEPE" 	 ,cWorkAlias , "CEP Site"  )
//TRCell():New(oSection1,"WK_MUNE" 	 ,cWorkAlias , "Municipio Site"  )
//TRCell():New(oSection1,"WK_ESTE" 	 ,cWorkAlias , "Estado Site"  )


Return(oReport)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR116  บAutor  ณMicrosiga           บ Data ณ  11/13/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint(oReport,aOrdem,cWorkNome,cWorkAlias)
Local oSecao1 		:= oReport:Section(1)
Local nOrdem  		:= oSecao1:GetOrder()
Local cOrderBy
Local cQryAlias  :=GetNextAlias()
Local bExec
Local bWhile
Local cChave
Local lPrintErp
Local lPrintLine
Local cTracado:=Replicate("-", 50)
Local cAprovados
Local nAt

Private oApiSite

oApiSite:= ApiCiaShop():New()
oApiSite:lSemAcento:=.T.
oApiSite:lUpperCase:=.T.

oApiSite:cUrl:="clusters/13/clustersitems"		
oApiSite:HttpGet()
cAprovados:=oApiSite:cResponse


If nOrdem==1
	bExec	 :={ || cChave:= (cWorkAlias)->A1_ZCODCIA }
	bWhile :={ || (cWorkAlias)->A1_ZCODCIA==cChave }
ElseIf nOrdem==2
	bExec	 :={ || cChave:=(cWorkAlias)->(A1_COD+A1_LOJA) }
	bWhile :={ || (cWorkAlias)->(A1_COD+A1_LOJA)==cChave }
EndIf


GeraWork(@cWorkNome,cWorkAlias,nOrdem)
oReport:SetTitle(oReport:Title()+' (' + AllTrim(aOrdem[nOrdem]) + ')')

BeginSQL Alias cQryAlias
	SELECT A1_ZCODCIA,A1_COD,A1_LOJA,A1_ENDENT,A1_BAIRROE,A1_CEPE,A1_MUNE,A1_ESTE,A1_NOME
	FROM %Table:SA1% SA1
	WHERE A1_FILIAL = %xfilial:SA1%
	AND A1_COD BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
	AND A1_LOJA BETWEEN %Exp:MV_PAR05% AND %Exp:MV_PAR06%
	AND A1_ZCODCIA BETWEEN %Exp:Str(MV_PAR01,0)% AND %Exp:Str(MV_PAR02,0)%
	And SA1.A1_ZCODCIA<>0
	AND SA1.%notDel%
EndSQL




Do While (cQryAlias)->(!Eof())
	
	nAt:=At('"ID": '+AllTrim(Str((cQryAlias)->A1_ZCODCIA))+',',cAprovados)
	If mv_par08==1 .And. (nAt)==0
		(cQryAlias)->(DbSkip());Loop		
	EndIf

	(cWorkAlias)->(DbAppend())	
	(cWorkAlias)->A1_ZCODCIA	:=AllTrim(Str((cQryAlias)->A1_ZCODCIA))
	(cWorkAlias)->A1_COD			:=(cQryAlias)->A1_COD
	(cWorkAlias)->A1_LOJA		:=(cQryAlias)->A1_LOJA
	(cWorkAlias)->A1_ENDENT		:=(cQryAlias)->A1_ENDENT
	(cWorkAlias)->A1_BAIRROE	:=(cQryAlias)->A1_BAIRROE
	(cWorkAlias)->A1_CEPE		:=(cQryAlias)->A1_CEPE
	(cWorkAlias)->A1_MUNE		:=(cQryAlias)->A1_MUNE
	(cWorkAlias)->A1_ESTE		:=(cQryAlias)->A1_ESTE
	(cWorkAlias)->A1_NOME		:=(cQryAlias)->A1_NOME
	(cWorkAlias)->ORIGEM			:="ERP"
	(cWorkAlias)->APROVADO			:=Iif(nAt==0,"Nao","Sim")
	
	(cQryAlias)->(DbSkip())
EndDo
(cQryAlias)->(DbCloseArea())
PR116Site(cWorkAlias,nOrdem)

(cWorkAlias)->(DbGoTop())
oSecao1:Init()
Do While (cWorkAlias)->(!Eof())
	
	lPrintErp:=.T.
	lPrintLine:=.F.
	Eval(bExec)
	Do While (cWorkAlias)->(!Eof())	.And. Eval(bWhile)
		
		If AllTrim((cWorkAlias)->ORIGEM)=="ERP"
			(cWorkAlias)->(DbSkip());Loop
		EndIf
		
		If mv_par07==1 .And.  Empty( (cWorkAlias)->DIVERGE )
			(cWorkAlias)->(DbSkip());Loop
		EndIf
		
		If lPrintErp
			PrintERP(oSecao1,cWorkAlias,cChave)
			lPrintErp:=.F.
		EndIf
		
		oSecao1:PrintLine()
		lPrintLine:=.T.
		(cWorkAlias)->(DbSkip())
	EndDo
	
	If lPrintLine
		oReport:PrintText(cTracado)
	EndIf
	
	
EndDo
oSecao1:Finish()

oReport:EndPage()
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR116  บAutor  ณMicrosiga           บ Data ณ  12/04/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function PrintERP(oSecao1,cWorkAlias,cChave)
Local aAreaWork:=(cWorkAlias)->(GetArea())
If (cWorkAlias)->(DbSeek(cChave+"ERP"))
	oSecao1:PrintLine()
EndIf
RestArea(aAreaWork)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR116  บAutor  ณMicrosiga           บ Data ณ  11/13/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static function CriaSX1(cPerg)
PutSx1(cPerg,"01","Cod CiaShop De                ","Cod CiaShop De                ","Cod CiaShop De                ","MV_CH1","N",4,0,0,"G","                                                            ","      ","   "," ","MV_PAR01","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"02","Cod CiaShop Ate               ","Cod CiaShop Ate               ","Cod CiaShop Ate               ","MV_CH2","N",4,0,0,"G","                                                            ","      ","   "," ","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"03","Cod Cliente De                ","Cod Cliente De                ","Cod Cliente De                ","MV_CH3","C",6,0,0,"G","                                                            ","      ","   "," ","MV_PAR03","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"04","Cod Cliente Ate               ","Cod Cliente Ate               ","Cod Cliente Ate               ","MV_CH4","C",6,0,0,"G","                                                            ","      ","   "," ","MV_PAR04","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"05","Loja De                       ","Loja De                       ","Loja De                       ","MV_CH5","C",2,0,0,"G","                                                            ","      ","   "," ","MV_PAR05","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"06","Loja Ate                      ","Loja Ate                      ","Loja Ate                      ","MV_CH6","C",2,0,0,"G","                                                            ","      ","   "," ","MV_PAR06","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"07","Somente com Divergencia?      ","Somente com Divergencia?      ","Somente com Divergencia?      ","MV_CH7","N",1,0,1,"C","                                                            ","      ","   "," ","MV_PAR07","Sim            ","Si             ","Yes            ","                                                            ","Nao            ","No             ","No             ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"08","Somente com Aprovados?      	  ","Somente com Aprovados?      ","Somente com Aprovados?         ","MV_CH8","N",1,0,1,"C","                                                            ","      ","   "," ","MV_PAR08","Sim            ","Si             ","Yes            ","                                                            ","Todos          ","Todos          ","Todos             ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR116  บAutor  ณMicrosiga           บ Data ณ  12/04/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GeraWork(cNomeWork,cWorkAlias,nOrdem)
Local aStruWork:={}
Local cChave	:=""

If nOrdem == 1 //-- Codigo Site
	cChave := "A1_ZCODCIA+ORIGEM"
ElseIf nOrdem == 2 //-- Codigo Protheus
	cChave := "A1_COD+A1_LOJA+ORIGEM"
EndIf


AADD(aStruWork,{"APROVADO"		,"C",3,0	})
AADD(aStruWork,{"DIVERGE"		,"C",1,0	})
AADD(aStruWork,{"ORIGEM"		,"C",4,0	})
AADD(aStruWork,{"A1_ZCODCIA"	,"C",AvSx3("A1_ZCODCIA",3)	,AvSx3("A1_ZCODCIA",4)	})
AADD(aStruWork,{"A1_COD"		,"C",AvSx3("A1_COD",3)		,AvSx3("A1_COD",4)		})
AADD(aStruWork,{"A1_LOJA"		,"C",AvSx3("A1_LOJA",3)		,AvSx3("A1_LOJA",4)		})
AADD(aStruWork,{"A1_NOME"		,"C",AvSx3("A1_NOME",3)		,AvSx3("A1_NOME",4)		})
AADD(aStruWork,{"A1_ENDENT"	,"C",AvSx3("A1_ENDENT",3)	,AvSx3("A1_ENDENT",4)	})
AADD(aStruWork,{"A1_BAIRROE"	,"C",AvSx3("A1_BAIRROE",3)	,AvSx3("A1_BAIRROE",4)	})
AADD(aStruWork,{"A1_CEPE"		,"C",AvSx3("A1_CEPE",3)		,AvSx3("A1_CEPE",4)		})
AADD(aStruWork,{"A1_MUNE"		,"C",AvSx3("A1_MUNE",3)		,AvSx3("A1_MUNE",4)		})
AADD(aStruWork,{"A1_ESTE"		,"C",AvSx3("A1_ESTE",3)		,AvSx3("A1_ESTE",4)		})


//AADD(aStruWork,{"WK_ENDENT"	,"C",AvSx3("A1_ENDENT",3)	,AvSx3("A1_ENDENT",4)	})
//AADD(aStruWork,{"WK_BAIRROE"	,"C",AvSx3("A1_BAIRROE",3)	,AvSx3("A1_BAIRROE",4)	})
//AADD(aStruWork,{"WK_CEPE"		,"C",AvSx3("A1_CEPE",3)		,AvSx3("A1_CEPE",4)		})
//AADD(aStruWork,{"WK_MUNE"		,"C",AvSx3("A1_MUNE",3)		,AvSx3("A1_MUNE",4)		})
//AADD(aStruWork,{"WK_ESTE"		,"C",AvSx3("A1_ESTE",3)		,AvSx3("A1_ESTE",4)		})

cNomeWork:=CriaTrab(aStruWork,.T.)
DbUseArea(.T.,,(cNomeWork),cWorkAlias,.F.,.F.)
IndRegua(cWorkAlias,cWorkAlias,cChave,,,)


cNomeTRB:=CriaTrab(aStruWork,.T.)
DbUseArea(.T.,,(cNomeTRB),"TRB_SITE",.F.,.F.)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR116  บAutor  ณMicrosiga           บ Data ณ  12/04/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR116Site(cWorkAlias,nOrdem)
Local cEndAux
Local nAt
Local nInd
Local aEndAux
Local aDados
Local aCols 	:={}
Local aHeader	:={}
Local lAddaHeader:=.T.
Local aPosEnd	  :={12,13,09}
Local bExec
Local bWhile
Local cChave
Local cChaveEnd




If nOrdem==1
	bExec	 :={ || cChave:=(cWorkAlias)->A1_ZCODCIA }
	bWhile :={ || (cWorkAlias)->A1_ZCODCIA==cChave }
ElseIf nOrdem==2
	bExec	 :={ || cChave:=(cWorkAlias)->(A1_COD+A1_LOJA) }
	bWhile :={ || (cWorkAlias)->(A1_COD+A1_LOJA)==cChave }
EndIf



(cWorkAlias)->(DbGoTop())
Do While (cWorkAlias)->(!Eof())
	
	M->A1_ZCODCIA	:=(cWorkAlias)->A1_ZCODCIA
	M->A1_COD		:=(cWorkAlias)->A1_COD
	M->A1_LOJA		:=(cWorkAlias)->A1_LOJA
	M->A1_NOME		:=(cWorkAlias)->A1_NOME
	
	M->A1_ENDENT	:=(cWorkAlias)->A1_ENDENT
	M->A1_BAIRROE	:=(cWorkAlias)->A1_BAIRROE
	M->A1_CEPE		:=(cWorkAlias)->A1_CEPE
	M->A1_MUNE		:=(cWorkAlias)->A1_MUNE
	M->A1_ESTE		:=(cWorkAlias)->A1_ESTE
	                  
	cChaveEnd:=M->(StrTran(A1_ENDENT,Space(1),"")+AllTrim(A1_BAIRROE)+AllTrim(A1_CEPE)+AllTrim(A1_MUNE)+AllTrim(A1_ESTE))
	
	Eval(bExec)
	Do While (cWorkAlias)->(!Eof()) .And. Eval(bWhile)
     

		oApiSite:cUrl:="customers/"+AllTrim((cWorkAlias)->A1_ZCODCIA)
		oApiSite:HttpGet()  
		
		If (nAt:=At( '"SHIPPINGADDRESSES"',oApiSite:cResponse))==0
			(cWorkAlias)->(DbDelete())
			(cWorkAlias)->(DbSkip());Loop
		EndIf
		
		cEndAux:= SubStr(oApiSite:cResponse,nAt)
		nAt:= At( '[',cEndAux)
		cEndAux:= SubStr(cEndAux,nAt+1)
		
		
		aEndAux:=Separa(cEndAux,Chr(13)+Chr(10))
		
		aCols 	:={}
		
		For nInd:=1 To Len(aEndAux)
			
			aEndAux[nInd]:=AllTrim(aEndAux[nInd])
			
			If Empty(aEndAux[nInd]) .Or. aEndAux[nInd]$"}*]"
				Loop
			EndIf
			
			If aEndAux[nInd]=="{"
				AADD(aCols,{})
				aAuxEndCob:=aCols[Len(aCols)]
				Loop
			EndIf
			
			aDados:=Separa(StrTran(aEndAux[nInd],'"',''),":")
			
			If Len(aDados)==1
				AADD(aDados,"")			
			EndIf
			
			If lAddaHeader
				AADD(aHeader,AllTrim(aDados[1]))
				
				If aDados[1]=="STREET"
					aPosEnd[1]:=Len(aHeader)
				EndIf
				
				If aDados[1]=="STREETNUMBER"
					aPosEnd[2]:=Len(aHeader)
				EndIf
				If aDados[1]=="STREETCOMPLEMENT"
					aPosEnd[3]:=Len(aHeader)
				EndIf
				
				
			EndIf
			
			AADD(aAuxEndCob,AllTrim(StrTran(aDados[2],',','')))
		Next
		lAddaHeader:=.F.
		
		For nInd:=1 To Len(aCols)
			
			TRB_SITE->(DbAppend())
			TRB_SITE->A1_ZCODCIA	:=M->A1_ZCODCIA
			TRB_SITE->A1_COD		:=M->A1_COD
			TRB_SITE->A1_LOJA		:=M->A1_LOJA
			TRB_SITE->A1_NOME		:=aCols[nInd][Ascan( aHeader,"RECIPIENTNAME")]
			
			TRB_SITE->ORIGEM		:="Site"
			TRB_SITE->A1_ENDENT 	:=aCols[nInd][ aPosEnd[1] ]+","+aCols[nInd][aPosEnd[2]]+""+aCols[nInd][aPosEnd[3]]
			TRB_SITE->A1_BAIRROE	:=aCols[nInd][Ascan( aHeader,"DISTRICT")]
			TRB_SITE->A1_CEPE		:=aCols[nInd][Ascan( aHeader,"ZIPCODE")]
			TRB_SITE->A1_MUNE		:=aCols[nInd][Ascan( aHeader,"CITY")]
			TRB_SITE->A1_ESTE    :=aCols[nInd][Ascan( aHeader,"STATE")]
			
			If cChaveEnd<>TRB_SITE->(StrTran(A1_ENDENT,Space(1),"")+AllTrim(A1_BAIRROE)+AllTrim(A1_CEPE)+AllTrim(A1_MUNE)+AllTrim(A1_ESTE))
				TRB_SITE->DIVERGE:="S"
			EndIf
			
		Next
		
		(cWorkAlias)->(DbSkip())
	EndDo
EndDo

TRB_SITE->(DbGoTop())
TRB_SITE->( DbEval({|| (cWorkAlias)->(DbAppend()) ,AvReplace("TRB_SITE",cWorkAlias)},{||.T.},{||.T.})   )

TRB_SITE->(E_EraseArq(cNomeTRB))
DbSelectArea(cWorkAlias)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR116  บAutor  ณMicrosiga           บ Data ณ  03/12/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
//User Function xTeste

//oApiSite:= ApiCiaShop():New()
///api/v1/customers/18611