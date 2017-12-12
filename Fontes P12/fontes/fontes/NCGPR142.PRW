#INCLUDE "PROTHEUS.CH"

#Define AV_YESNO {"Continuar","Parar"}
#Define AV_OK {"OK"}

 /*/{Protheus.doc} NCGPR142
    (long_description)
    @type  Function
    @author Flavio de Brito Borges
    @since 26/10/2017
    @version 1.0
    @param param, param_type, param_descr
    @return returno,return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function NCGPR142()

Local cRet
Local aAux
Local cMensagem

Local cQuery
Local cAlias
Local cAliasAtu 
Local cCodRef
Local cLojaWM


cAliasAtu := GetArea()
cCodRef:=SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO)

DbSelectArea("ZX5")
ZX5->(DbSetOrder(1))

    
    If ZX5->(DbSeek(xFilial("ZX5")+"00006"))
        Do While ZX5->(!EOF())
            If ZX5->ZX5_TABELA != "00006"
                ZX5->(DbGoBottom())
            Else
                aAux:= Separa(ZX5->ZX5_DESCRI,";")
                if aAux[1] == cEmpAnt .And. aAux[2]==cFilAnt
                        cLojaWM := AllTrim(cValToChar(ZX5_CHAVE))
                        ZX5->(DbGoBottom())
                EndIf
                  
            EndIf
            ZX5->(DbSkip())
        EndDo
    EndIF
    ZX5->(DbCLoseArea()) 
  
        if Aviso("Cuidado!!!","Tem certeza que deseja continuar? Esse processo é inrreversivel! Documento selecionado: "+SF1->F1_DOC+" Da loja: "+cLojaWM,AV_YESNO,2) == 1
       
        cQuery := "SELECT count(ESTADO) QTDES FROM Conferencia_cega "
        cQuery+=" Where Cod_referencia= '"+cCodRef+"'"
        cQuery+=" And Cod_loja_WM = "+cLojaWM+" "
         cQuery+=" And ESTADO <= 1 "

            cAlias := U_NCIWMF02(cQuery,"1",@cMensagem)

                If SELECT(cAlias) >0
                        If (cAlias)->(QTDES) > 1
                            Aviso("Atenção!","Ocorreu um problema, foram encontrados mais de um resultado para a NF informada!",AV_OK,2)
                        Else
                            If (cAlias)->(QTDES) = 1
                                cQuery := "UPDATE Conferencia_cega SET ESTADO = 5 "
                                 cQuery+=" Where Cod_referencia='"+cCodRef+"'"
                                 cQuery+=" And Cod_loja_WM = '"+cLojaWM+"' "
                                    
                                    cRet := U_NCIWMF02(cQuery,"2",@cMensagem)

                                    If isEmpty(cMensagem)
                                        Aviso("Conferência cega encerrada com sucesso!",AV_OK,2)
                                    Else
                                         Aviso("Atenção!","Ops ocorreu o seguinte erro: " + cMensagem,AV_OK,2)
                                    EndIf
                            Else
                                    Aviso("Atenção!","Desculpe mas não foram encontradas conferências referentes aos dados informados, verifique se o documento não se encontra finalizado ou encerrado!", AV_OK,2)
                            EndIf
                        EndIf
                Else
                    Aviso("Atenção!","Desculpe mas não foram encontradas conferências referentes aos dados informados!",AV_OK,2)
                EndIf
        EndIf

Return 