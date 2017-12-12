#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

//#define MB_OK 0

 /*/{Protheus.doc} ncgpr141
    (long_description)
    @type  Function
    @author Flavio de Brito Borges
    @since 23/10/2017
    @version 1
    @param param, param_type, param_descr
    @return returno,return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
 User Function ncgpr141()
    Local cQuery
    Local bResult
    Local aLojas := {}
    Local aAux := {}
    Local aParams
    Local nTamLojas
    Local cMensagem
    Local cRet
    Local aCabeca := {}
    Local aDados := {}
    Local oFunc
   
    //RpcSetEnv("03","01")

    oFunc := FuncoesDiversas():New()

    //Seta o nome do documento
    oFunc:setNomeExcel("Lista de conferencias cegas")
    	
	//Seta o nome da planilha
	oFunc:setNomeTabela("Documentos")

    DbSelectArea("ZX5")
    DbSelectArea("SB1")
    ZX5->(DbSetOrder(1))
    SB1->(DbSetOrder(1))

    aAdd(aLojas,"Todas")
    nTamLojas := 0
    aAdd(aCabeca,{"LOJA",1,1})
    aAdd(aCabeca,{"NOTA FISCAL",1,1})
    aAdd(aCabeca,{"DATA DE EMISSÃO",1,1})
    aAdd(aCabeca,{"ESTADO",1,1})
    aAdd(aCabeca,{"CNPJ FORNECEDOR",1,1})
    aAdd(aCabeca,{"CODIGO DO PRODUTO",1,1})
    aAdd(aCabeca,{"DESCRIÇÃO DO PRODUTO",1,1})
    aAdd(aCabeca,{"QUANTIDADE",1,1})
   

    If ZX5->(DbSeek(xFilial("ZX5")+"00006"))
        Do While ZX5->(!EOF())
            If ZX5->ZX5_TABELA != "00006"
                ZX5->(DbGoBottom())
            Else
                aAux:= Separa(ZX5->ZX5_DESCRI,";")
                aAdd(aLojas,Alltrim(ZX5->ZX5_CHAVE)+"-"+aAux[Len(aAux)])
                    if nTamLojas < Len(Alltrim(ZX5->ZX5_CHAVE)+"-"+aAux[Len(aAux)])
                            nTamLojas := Len(Alltrim(ZX5->ZX5_CHAVE)+"-"+aAux[Len(aAux)])
                    Endif
            EndIf
            ZX5->(DbSkip())
        EndDo
    EndIF
    ZX5->(DbCLoseArea())

    If ncgpr141Pa(aLojas, nTamLojas)
        cQuery := "SELECT  CC.COD_LOJA_WM LOJA, CC.Numero_nota NOTA, CC.Data_nota DATA, "
        cQuery += 'CASE CC.ESTADO  '
        cQuery += "WHEN 0 THEN 'NOVO(PENDENTE)' "
        cQuery += "WHEN 1 THEN 'EM ANDAMENTO' "
        cQuery += "WHEN 2 THEN 'FINALIZADO' "
        cQuery += "End AS ESTADO, "
        cQuery += "CC.CNPJ_fornecedor CNPJ, "
        cQuery += "CCI.COD_PRODUTO_WM PROD, "
        cQuery += "CCI.QUANTIDADE_ORIGINAL QTD "
         cQuery += " FROM CONFERENCIA_CEGA CC "
        cQuery += "LEFT JOIN CONFERENCIA_CEGA_ITEM CCI "
        cQuery += "ON CC.COD_CONFERENCIA = CCI.COD_CONFERENCIA "
        cQuery += "WHERE "

        If MV_PAR04 != "Todas"
            cQuery += " CC.COD_LOJA_WM = "+ Strtokarr2( MV_PAR04,"-")[1] +" "
        Else
            cQuery += " CC.COD_LOJA_WM BETWEEN 0 AND 9999 "
        EndIf

        If cValToChar(MV_PAR01)!= "  /  /  "
            cQuery += "AND CC.DATA_NOTA BETWEEN '"+cValToChar(Year(MV_PAR01))+"-"+cValToChar(Month(MV_PAR01))+"-"+cValToChar(Day(MV_PAR01))+" 00:00:00' "+" AND '" +cValToChar(Year(MV_PAR02))+"-"+cValToChar(Month(MV_PAR02))+"-"+cValToChar(Day(MV_PAR02))+" 23:59:59' "
        Else 
            cQuery += "AND CC.DATA_NOTA <= '"+cValToChar(Year(MV_PAR02))+"-"+cValToChar(Month(MV_PAR02))+"-"+cValToChar(Day(MV_PAR02))+" 23:59:59' "
        EndIf
         
         If MV_PAR03 != "T-Todos"
            cQuery += "AND CC.ESTADO = " + Separa(MV_PAR03,"-")[1]+" "
         Else
            cQuery += "AND CC.ESTADO <= 2 "         
         EndIf

         If isEmpty(MV_PAR05)
                if !(SubStr(cValToChar(AllTrim(MV_PAR06)),1,1) $ "Z;z")
                        cQuery+= "AND CCI.COD_PRODUTO_WM <= "+cValToChar(AllTrim(MV_PAR06))+" "
                Else
                        cQuery+= "AND CCI.COD_PRODUTO_WM <= 9999999999 "
                EndIf
         Else
                if !(SubStr(cValToChar(AllTrim(MV_PAR06)),1,1) $ "Z;z")
                        cQuery+= "AND CCI.COD_PRODUTO_WM BETWEEN "+cValToChar(AllTrim(MV_PAR05))+ " AND "+ cValToChar(AllTrim(MV_PAR06))+" "
                Else
                        cQuery+= "AND CCI.COD_PRODUTO_WM >="+cValToChar(AllTrim(MV_PAR05))+" "                 
                EndIf
                
         EndIF

        cRet := U_NCIWMF02(cQuery,"1",@cMensagem)
        If Select(cRet)>0
            Do While (cRet)->(!Eof())
                    SB1->(DbGoTop())
                    If SB1->(DbSeek(xFilial("SB1")+cValToChar((cRet)->(prod))))
                     aAdd(aDados,{(cRet)->(LOJA),(cRet)->(NOTA),DtoC((cRet)->(DATA)),(cRet)->(ESTADO),(cRet)->(CNPJ),(cRet)->(PROD),SB1->B1_XDESC,(cRet)->(QTD)})
                    Else
                     aAdd(aDados,{(cRet)->(LOJA),(cRet)->(NOTA),DtoC((cRet)->(DATA)),(cRet)->(ESTADO),(cRet)->(CNPJ),(cRet)->(PROD)," ",(cRet)->(QTD)})
                    EndIF
                    (cRet)->(DbSkip())
            EndDo
            (cRet)->(DbCloseArea())
            SB1->(DbCLoseArea())
            If oFunc:criaExcelSimples(aCabeca,aDados)
            MsgInfo("Arquivo gerado com sucesso!")            
		    End If
        Else
            MsgInfo("Não foram encontrados resultados para a sua pesquisa!","Resultados não encontrados!")
        EndIF

    Endif

Return 

 /*/{Protheus.doc} CriaPergunte
    (long_description)
    @type  Function
    @author user
    @since date
    @version version
    @param param, param_type, param_descr
    @return returno,return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
 static Function ncgpr141Pa(aLojas, nTamLojas)

    Local aPergs	:= {}
    Local aOpcao:= {}
    Local aParam := {}
    Local lRet := .F.
    Local aParams

 	aAdd(aParam,{1,"Data Emissão Nota De"	,CtoD("//")	,"@D"	,"","","",70,.F.})//MV_PAR01
	aAdd(aParam,{1,"Data Emissão Nota Até"	,CtoD("//")	,"@D"	,"","","",70,.T.})//MV_PAR02
       
    aAdd(aOpcao,"0-NOVO(PENDENTE)")
    aAdd(aOpcao,"1-EM ANDAMENTO ")
    aAdd(aOpcao,"2-FINALIZADO")
    aAdd(aOpcao,"T-Todos")

    aAdd(aParam,{2,"Estado"			,"3"	, aOpcao	, 70,".T."					,.T.})//MV_PAR03
    aAdd(aParam,{2,"Loja"			,"1"	, aLojas	, nTamLojas,".T."					,.T.})//MV_PAR04
    
    aAdd(aParam,{1,"Produto De"			,Space(TAMSX3("B1_COD")[1]),"@!","","SB1","",70,.F.})//MV_PAR05
    aAdd(aParam,{1,"Produto Até"			,"ZZZZZZZZZZZZZZZ","@!","","SB1","",70,.T.})//MV_PAR06
    lRet:= ParamBox(aParam, "Consulta de conferência cega!", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/,.T.,.T.)
Return lRet