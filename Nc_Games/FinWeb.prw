#Include 'Protheus.ch'
#DEFINE CRLF Chr(13) + Chr(10)


user Function RelFinWM01()
Local aArea := GetArea()
Local aCabExcel := {}
Local aItems := {}
Local aParamBox	:= {}
Local aRet := {}

//#Data Emissão de
aAdd(aParamBox,{1,"Data de:"  ,Ctod(Space(8)),"@D","","","",70,.T.})
//#Data Emissão ate
aAdd(aParamBox,{1,"Data ate:"  ,Ctod(Space(8)),"@D","","","",70,.T.}) 
//Código Loja  DE 
aAdd(aParamBox,{1,"Loja de:"  ,space(4),"@!","","","",70,.F.}) 
//Código Loja  ATE
aAdd(aParamBox,{1,"Loja ate:"  ,space(4),"@!","","","",70,.F.})


If !ParamBox(aParamBox, "Parâmetros", aRet, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/,.T.,.T.)
		Return .T.
EndIf

aCabExcel := GetHeader()
aItems := GetACols(aRet[1],aRet[2],aRet[3],aRet[4])


MsgRun("Favor Aguardar, Exportando para EXCEL....", "Exportando os Registros para o Excel",{||DlgToExcel({{"GETDADOS","",aCabExcel,aItems}})})
RestArea(aArea)
Return

 Static Function GetHeader()
 Local aArea := GetArea()
 Local aHeader := {}

AADD(aHeader,{"Loja WM"       ,"C",TamSx3('E1_YLOJAWM')[1],0})
AADD(aHeader,{"Filial Orig"   ,"C",TamSx3('E1_FILORIG')[1],0})
AADD(aHeader,{"Nome Filial"   ,"C",TamSx3('ZX5_DESCRI')[1],0})
AADD(aHeader,{"Cod.Web Mang"  ,"C",TamSx3('E1_YCODWM')[1],0})
AADD(aHeader,{"Cupom WM"      ,"C",TamSx3('e1_ycupom')[1],0})
AADD(aHeader,{"Cod.OS Wm."    ,"C",TamSx3('e1_yoswm')[1],0})
AADD(aHeader,{"Desc.OS Wm."   ,"C",TamSx3('e1_ydoswm')[1],0})
AADD(aHeader,{"Cod.Finan.WM"  ,"C",TamSx3('e1_ycodfin')[1],0})
AADD(aHeader,{"Desc.Fin.WM"   ,"C",TamSx3('e1_ydesfi')[1],0})
AADD(aHeader,{"Prefixo"       ,"C",TamSx3('e1_prefixo')[1],0})
AADD(aHeader,{"No. Titulo"    ,"C",TamSx3('e1_num')[1] ,0})
AADD(aHeader,{"Parcela"       ,"C",TamSx3('e1_parcela')[1],0})
AADD(aHeader,{"Tipo"          ,"C",TamSx3('e1_tipo')[1],0})
AADD(aHeader,{"Cliente"       ,"C",TamSx3('e1_cliente')[1],0})
AADD(aHeader,{"Loja"          ,"C",TamSx3('e1_loja')[1],0})
AADD(aHeader,{"Nome Cliente"  ,"C",TamSx3('e1_nomcli')[1],0})
AADD(aHeader,{"DT Emissao"    ,"D",TamSx3('E1_EMISSAO')[1],0})
AADD(aHeader,{"Vencto real"   ,"D",TamSx3('e1_vencrea')[1],0})
AADD(aHeader,{"Vlr.Titulo"    ,"D",TamSx3('e1_valor')[1],0})
AADD(aHeader,{"Historico"     ,"C",TamSx3('e1_hist')[1],0})
AADD(aHeader,{" "              ,"C",01,0})


RestArea(aArea)
Return aHeader

 Static Function GetAcols(DataIni, DataFin, LojaIni, LojaFim)
 Local aArea := GetArea()
 Local aItens := {}
 Local DtIni := ""
 Local DtFin := ""
 Local LjIni := ""
 Local LjFim := ""
 Local cQuery := ""
 Local cAlias01 := GetNextAlias()

DtIni := DataIni
DtFin := DataFin
LjIni := LojaIni
LjFim := LojaFim

cQuery := "select " + CRLF
cQuery += "E1_YLOJAWM as LojaWM, " + CRLF
cQuery += "E1_FILORIG as FilOrig, " + CRLF
cQuery += "trim(substr(zX5.ZX5_DESCRI,7)) AS NomeFilial, " + CRLF
cQuery += "E1_YCODWM CodWebMang, " + CRLF
cQuery += "e1_ycupom as CupomWM, " + CRLF
cQuery += "e1_yoswm as CodOSWm, " + CRLF
cQuery += "e1_ydoswm as DescOSWm, " + CRLF
cQuery += "e1_ycodfin as CodFinanWM, " + CRLF
cQuery += "e1_ydesfi as DescFinWM, " + CRLF
cQuery += "e1_prefixo as Prefixo, " + CRLF
cQuery += "e1_num as NoTitulo, " + CRLF
cQuery += "e1_parcela as Parcela, " + CRLF
cQuery += "e1_tipo as Tipo, " + CRLF
cQuery += "e1_cliente as Cliente, " + CRLF
cQuery += "e1_loja as Loja, " + CRLF
cQuery += "e1_nomcli as NomeCli, " + CRLF
cQuery += "e1_emissao as Emissao, " + CRLF
cQuery += "e1_vencrea as Vencreal, " + CRLF
cQuery += "e1_valor as VlrTitulo, " + CRLF
cQuery += "e1_hist as Historico " + CRLF

cQuery += "from "+RetSqlName("SE1")+" se1 " + CRLF
cQuery += "left join "+RetSqlName("ZX5")+" zX5  " + CRLF
cQuery += "ON se1.E1_YLOJAWM = zX5.ZX5_CHAVE " + CRLF
cQuery += "AND zX5.ZX5_TABELA = '00006' " + CRLF
cQuery += "where E1_YCODWM != ' ' " + CRLF
cQuery += "and se1.e1_emissao BETWEEN '"+DtoS(DtIni)+"' and '"+DtoS(DtFin)+"' " + CRLF
cQuery += "and se1.E1_YLOJAWM BETWEEN '"+LjIni+"' and '"+LjFim+"' " + CRLF
cQuery += "and se1.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "and ZX5.D_E_L_E_T_ = ' ' " + CRLF

cQuery := ChangeQuery(cQuery)
MsgRun("Favor Aguardar, Efetuando consulta....", "Executando busca dos dados...",{||DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAlias01  ,.F.,.T.) })

while (cAlias01)->(!EOF())
    
    aadd(aItens,{(cAlias01)->LojaWm,;
                (cAlias01)->FilOrig,;
                (cAlias01)->NomeFilial,;
                (cAlias01)->CodWebMang,;
                (cAlias01)->CupomWM,;
                (cAlias01)->CodOSWm,;
                (cAlias01)->DescOSWm,;
                (cAlias01)->CodFinanWM,;
                (cAlias01)->DescFinWM,;
                (cAlias01)->Prefixo,;
                (cAlias01)->NoTitulo,;
                (cAlias01)->Parcela,;
                (cAlias01)->Tipo,;
                (cAlias01)->Cliente,;
                (cAlias01)->Loja,;
                (cAlias01)->NomeCli,;
                StoD((cAlias01)->Emissao),;
                StoD((cAlias01)->Vencreal),;
                (cAlias01)->VlrTitulo,;
                (cAlias01)->Historico,;
                " " })

    (cAlias01)->(DbSkip())

EndDo

(cAlias01)->(DbCloseArea())
RestArea(aArea)
Return aItens