#INCLUDE "TOPCONN.CH"
#INCLUDE "XMLXFUN.CH"
//
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX07  บAutor  ณMicrosiga           บ Data ณ  02/05/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCVTEX07()
Local aAreaAtu	   :=GetArea()
Local cPerg  		:= 'NCVTEX07'
Local cQryAlias 	:= GetNextAlias()
Local oReport

CriaSX1(cPerg)
Pergunte(cPerg, .F.)
oReport := ReportDef(cQryAlias, cPerg)
oReport:SetLandscape()
oReport:PrintDialog()

If Select(cQryAlias)>0
	(cQryAlias)->(DbCloseArea())
EndIf
RestArea(aAreaAtu)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX07  บAutor  ณMicrosiga           บ Data ณ  05/25/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef(cQryAlias,cPerg)
Local cTitle  := "Relat๓rio Analise de Integra็ใo B2C"
Local cHelp   := ""
Local oReport
Local oSection1
Local aOrdem    := {}

oReport := TReport():New('NCVTEX07',cTitle,cPerg,{|oReport| ReportPrint(oReport,cQryAlias,aOrdem)},cHelp)
oSection1 := TRSection():New(oReport,"Integra็ใo B2C",{"ZC5"},aOrdem)

TRCell():New(oSection1,"ZC5_DTVTEX" , "ZC5", "Data Vtex")
TRCell():New(oSection1,"ZC5_NOECOM" , "ZC5", "Loja")
TRCell():New(oSection1,"ZC5_PVVTEX" , "ZC5", "PV Vtex")
TRCell():New(oSection1,"ZC5_SEQUEN" , "ZC5", "Sequencia")
TRCell():New(oSection1,"ZC5_NUMPV"  , "ZC5", "Pedido Protheus")
TRCell():New(oSection1,"ZC5_PREVEN" , "ZC5", "Pre Venda?")
TRCell():New(oSection1,"ZC5_CLIENT" , "ZC5", "Cliente")
TRCell():New(oSection1,"ZC5_LOJA"   , "ZC5", "Loja")
TRCell():New(oSection1,"ZC5_NOME"    ,"ZC5","Nome Cliente","",50,/*lPixel*/,{|| AllTrim(Posicione("SA1",1,xFilial("SA1")+(cQryAlias)->ZC5_CLIENT+(cQryAlias)->ZC5_LOJA,"A1_NOME") )		})
TRCell():New(oSection1,"ZC5_STATUS"    ,"ZC5","Status PV","",50,/*lPixel*/,{|| U_VTEX07Status(cQryAlias)		})
//Status Vtex
TRCell():New(oSection1,"ZC5_TPPGTO" , "ZC5", "Tp Pagamento")
TRCell():New(oSection1,"ZC5_TOTAL"  , "ZC5", "Total Pedido")
TRCell():New(oSection1,"ZC5_QTDPAR" , "ZC5", "Qtd Parcelas")
TRCell():New(oSection1,"ZC5_VDESCO" , "ZC5", "Vlr.Desconto")
TRCell():New(oSection1,"ZC5_STATUS"    ,"ZC5","Monitor","",60,/*lPixel*/,{|| U_VTEX07Erro((cQryAlias)->ZC5_PVVTEX)		})
TRCell():New(oSection1,"ZC5_DTWMS" , "ZC5", "Dt.Env.WMS")
TRCell():New(oSection1,"ZC5_NOTA"  , "ZC5", "Nota Fiscal")
TRCell():New(oSection1,"ZC5_SERIE"  , "ZC5", "Serie")
TRCell():New(oSection1,"ZC5_EMISNF"  , "ZC5", "Emissao NF")
TRCell():New(oSection1,"ZC5_DTSAID"  , "ZC5", "Dt. Saida NF")
TRCell():New(oSection1,"ZC5_DTENTR"  , "ZC5", "Dt.EntregaNF")
TRCell():New(oSection1,"ZC5_RASTRE"  , "ZC5", "Cod.Rastreio")

Return(oReport)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX07  บAutor  ณMicrosiga           บ Data ณ  05/25/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint(oReport,cQryAlias,aOrdem)
Local oSecao1 := oReport:Section(1)
Local nOrdem  := oSecao1:GetOrder()
Local cWhere  :=""

//oReport:SetTitle(oReport:Title()+' (' + AllTrim(aOrdem[nOrdem]) + ')')

If mv_par07==1
	cWhere+="ZC5_PREVEN='S'"
ElseIf mv_par07==2
	cWhere+="ZC5_PREVEN<>'S'"
Else
	cWhere+="ZC5_PREVEN IN ('S','N',' ')"
EndIf

cWhere:="%"+cWhere+"%"

oSecao1:BeginQuery()

BeginSQL Alias cQryAlias
	
	SELECT *
	FROM %Table:ZC5% ZC5
	WHERE ZC5_FILIAL BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
	AND ZC5_LJECOM BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
	AND ZC5_DTVTEX BETWEEN %Exp:DTOS(MV_PAR05)% AND %Exp:DTOS(MV_PAR06)%
	AND %Exp:cWhere%
	AND ZC5.%notDel%
	Order By ZC5_DTVTEX,ZC5_PVVTEX
EndSQL

oSecao1:EndQuery()
oReport:SetMeter(0)
oSecao1:Print()
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX07  บAutor  ณMicrosiga           บ Data ณ  05/25/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaSX1(cPerg)
PutSx1(cPerg,"01","Filial de ?                   ","Filial de ?                   ","Filial de ?                   ","MV_CH1","C",2,0,0,"G","                                                            ","SM0   ","   "," ","MV_PAR01","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"02","Filial ate ?                  ","Filial ate ?                  ","Filial ate ?                  ","MV_CH2","C",2,0,0,"G","                                                            ","SM0   ","   "," ","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"03","Loja de ?                     ","Loja de ?                     ","Loja de ?                     ","MV_CH3","C",2,0,0,"G","                                                            ","SA1ECO","   "," ","MV_PAR03","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"04","Loja ate ?                    ","Loja ate ?                    ","Loja ate ?                    ","MV_CH4","C",2,0,0,"G","                                                            ","SA1ECO","   "," ","MV_PAR04","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"05","Data Vtex de ?                ","Data Vtex de ?                ","Data Vtex de ?                ","MV_CH5","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR05","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"06","Data Vtex ate ?               ","Data Vtex ate ?               ","Data Vtex ate ?               ","MV_CH6","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR06","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"07","Pre Venda?                    ","Pre Venda?                    ","Pre Venda?                    ","MV_CH7","N",1,0,1,"C","                                                            ","      ","   "," ","MV_PAR07","Sim            ","Sim            ","Sim            ","                                                            ","Nao            ","Nao            ","Nao            ","Todas          ","Todas          ","Todas          ","               ","               ","               ","               ","               ","          ","","","","")
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX07  บAutor  ณMicrosiga           บ Data ณ  05/25/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VTEX07Status(cQryAlias)
Local cStatus:=""

If AllTrim((cQryAlias)->ZC5_FLAG) == 'X'
	cStatus:="Pedidos Antes Data Corte"
ElseIf AllTrim((cQryAlias)->ZC5_FLAG) == '4'
	cStatus:="Erro no cadastro de cliente"
ElseIf AllTrim((cQryAlias)->ZC5_FLAG) == '5'
	cStatus:="Produto nใo encontrado no ERP"
ElseIf AllTrim((cQryAlias)->ZC5_STATUS) == '4'
	cStatus:="Pedido Recebido"
ElseIf AllTrim((cQryAlias)->ZC5_STATUS) == '5'
	cStatus:="Pedido em Analise"
ElseIf AllTrim((cQryAlias)->ZC5_STATUS) == '10'
	cStatus:="Credito Aprovado"
ElseIf AllTrim((cQryAlias)->ZC5_STATUS) == '16'
	cStatus:="Expedi็ใo"
ElseIf AllTrim( (cQryAlias)->ZC5_STATUS) == '15'
	cStatus:="Nota Fiscal Emitida"
ElseIf AllTrim((cQryAlias)->ZC5_STATUS) == '30'
	cStatus:="Pedido Enviado"
ElseIf AllTrim((cQryAlias)->ZC5_STATUS) == '90'
	cStatus:="Pedido Cancelado"
ElseIf AllTrim((cQryAlias)->ZC5_STATUS) == '96'
	cStatus:="Pedido Cancelado por Credito"
ElseIf AllTrim((cQryAlias)->ZC5_STATUS) == '91'
	cStatus:="Pedido Devolvido"
ElseIf AllTrim((cQryAlias)->ZC5_STATUS) == '92'
	cStatus:="Aguard.Reimporta็ใo\Cancelamento"
ElseIf AllTrim((cQryAlias)->ZC5_STATUS) == '93'
	cStatus:="Estornado"
EndIf

Return cStatus


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX07  บAutor  ณMicrosiga           บ Data ณ  05/25/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VTEX07Erro(cPvVtex)
Local cQuery
Local cAliasTmp := GetNextAlias()
Local cErro:=""

cQuery := "SELECT utl_raw.cast_to_varchar2(DBMS_LOB.SUBSTR(ZC7_OBS,2000,1)) ZC7_OBS "
cQuery += " FROM "+RetSqlName("ZC7")+" ZC7 "
cQuery += " WHERE D_E_L_E_T_ = ' ' "
cQuery += " AND ZC7_FILIAL = '"+xFilial("ZC7")+"' "
cQuery += " AND ZC7_PVVTEX = '"+cPvVtex+"' "
cQuery += " ORDER BY R_E_C_N_O_ DESC "

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)
Do While (cAliasTmp)->(!Eof())
	cErro+=(cAliasTmp)->ZC7_OBS
	(cAliasTmp)->(DbSkip())
	Exit
EndDo	

cErro:=Padr(cErro,60)

Return cErro
