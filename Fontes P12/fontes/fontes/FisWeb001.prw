#Include 'Protheus.ch'
#DEFINE CRLF Chr(13) + Chr(10)


user Function RelFisWM01()
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
aAdd(aParamBox,{1,"Serie de:"  ,space(3),"@!","","","",40,.F.}) 
//Código Loja  ATE
aAdd(aParamBox,{1,"Serie ate:"  ,space(3),"@!","","","",40,.F.})


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

AADD(aHeader,{"Filial"          ,"C",TamSx3('FT_FILIAL')[1] ,0})
AADD(aHeader,{"Numero da NF"    ,"C",TamSx3('FT_NFISCAL')[1],0})
AADD(aHeader,{"Serie da NF"     ,"C",TamSx3('FT_SERIE')[1]  ,0})
AADD(aHeader,{"Cliente"         ,"C",TamSx3('FT_CLIEFOR')[1],0})
AADD(aHeader,{"Loja"            ,"C",TamSx3('FT_LOJA')[1]   ,0})
AADD(aHeader,{"Produto"         ,"C",TamSx3('FT_PRODUTO')[1],0})
AADD(aHeader,{"Unidade"         ,"C",TamSx3('D2_UM')[1]     ,0})
AADD(aHeader,{"Quantidade"      ,"C",TamSx3('FT_QUANT')[1]  ,0})
AADD(aHeader,{"Vlr.Unitario"    ,"C",TamSx3('FT_VALCONT')[1],0})
AADD(aHeader,{"vlr unit total"  ,"C",TamSx3('FT_VALCONT')[1],0})
AADD(aHeader,{"Emissao"         ,"D",TamSx3('D2_EMISSAO')[1],0})
AADD(aHeader,{"Cod.Mov WM"      ,"C",TamSx3('D2_YCODMOV')[1],0})
AADD(aHeader,{"Loja WM"         ,"C",TamSx3('D2_YLOJAWM')[1],0})
AADD(aHeader,{"Oper.WM"         ,"C",TamSx3('D2_YTOPER')[1] ,0})
AADD(aHeader,{" "               ,"C",01                     ,0})


RestArea(aArea)
Return aHeader

 Static Function GetAcols(DataIni, DataFin, SerieIni, Seriefim)
 Local aArea := GetArea()
 Local aItens := {}
 Local DtIni := ""
 Local DtFin := ""
 Local Serini := ""
 Local Serfim := ""
 Local cQuery := ""
 Local cAlias01 := GetNextAlias()

DtIni := DataIni
DtFin := DataFin
Serini := SerieIni
Serfim := Seriefim

cQuery := "select " + CRLF
cQuery += "ft_filial Filial," + CRLF
cQuery += "ft_nfiscal Nota," + CRLF
cQuery += "ft_serie Serie," + CRLF
cQuery += "ft_cliefor Cliente," + CRLF
cQuery += "ft_loja Loja," + CRLF
cQuery += "ft_produto Produtos," + CRLF
cQuery += "sd2.D2_UM UM," + CRLF
cQuery += "sd2.D2_QUANT Qtd," + CRLF
cQuery += "sd2.D2_PRCVEN Valor," + CRLF
cQuery += "SD2.D2_QUANT * sd2.D2_PRCVEN Total," + CRLF
cQuery += "d2_emissao Emissao," + CRLF
cQuery += "sd2.D2_YCODMOV Mov," + CRLF
cQuery += "sd2.D2_YLOJAWM LojaWM," + CRLF
cQuery += "sd2.D2_YTOPER operacao" + CRLF
cQuery += "from "+RetSqlName("SD2")+" sd2 left join "+RetSqlName("SFT")+" sft" + CRLF
cQuery += "on sd2.d2_filial = sft.ft_filial" + CRLF
cQuery += "and sd2.D2_DOC = sft.ft_nfiscal" + CRLF
cQuery += "and sd2.d2_serie = sft.ft_serie" + CRLF
cQuery += "and sd2.D2_CLIENTE = sft.FT_CLIEFOR" + CRLF
cQuery += "and sd2.d2_loja = sft.ft_loja" + CRLF
cQuery += "and sd2.d2_cod = sft.ft_produto" + CRLF
cQuery += "where sd2.d2_emissao BETWEEN '"+DtoS(DtIni)+"' and '"+DtoS(DtFin)+"' " + CRLF
cQuery += "and sd2.D2_SERIE BETWEEN '"+Serini+"' and '"+Serfim+"' " + CRLF
cQuery += "and sd2.D_E_L_E_T_ = ' '" + CRLF
cQuery += "and sft.D_E_L_E_T_ = ' '" + CRLF
cQuery += "and sd2.D2_YCODMOV != ' '" + CRLF
cQuery += "order by ft_filial, sft.FT_PRODUTO" + CRLF
cQuery := ChangeQuery(cQuery)
MsgRun("Favor Aguardar, Efetuando consulta....", "Executando busca dos dados...",{||DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAlias01  ,.F.,.T.) })

while (cAlias01)->(!EOF())
    
    aadd(aItens,{(cAlias01)->Filial,;
                (cAlias01)->Nota,;
                (cAlias01)->Serie,;
                (cAlias01)->Cliente,;
                (cAlias01)->Loja,;
                (cAlias01)->Produtos,;
                (cAlias01)->UM,;
                (cAlias01)->Qtd,;
                (cAlias01)->Valor,;
                (cAlias01)->Total,;
                StoD((cAlias01)->Emissao),;
                (cAlias01)->Mov,;
                (cAlias01)->LojaWm,;
                (cAlias01)->operacao,;
                " " })

    (cAlias01)->(DbSkip())

EndDo

(cAlias01)->(DbCloseArea())
RestArea(aArea)
Return aItens