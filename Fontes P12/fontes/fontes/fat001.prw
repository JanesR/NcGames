#INCLUDE "PROTHEUS.CH"

/*/                
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Fat001    ³ Autor ³ Vitor Daniel          ³ Data ³ 13.10.09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rotina de Expedicao - Inclusao e/ou alteracao de Transporta-³±±
±±³          ³ra e Veiculo na Nota Fiscal de Saida                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Fat001()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Array contendo as Rotinas a executar do programa      ³
//³ ----------- Elementos contidos por dimensao ------------     ³
//³ 1. Nome a aparecer no cabecalho                              ³
//³ 2. Nome da Rotina associada                                  ³
//³ 3. Usado pela rotina                                         ³
//³ 4. Tipo de Transa‡"o a ser efetuada                          ³
//³    1 - Pesquisa e Posiciona em um Banco de Dados             ³
//³    2 - Simplesmente Mostra os Campos                         ³
//³    3 - Inclui registros no Bancos de Dados                   ³
//³    4 - Altera o registro corrente                            ³
//³    5 - Remove o registro corrente do Banco de Dados          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aRotina := {         { "Pesquisar","AxPesqui"  , 0 , 1},;                           //"Pesquisar"
                                                                                              { "Visualizar","AxVisual"  , 0 , 2},;             //"Visualizar"
                                                                                              { "Manutencao","u_AFATManut()" , 0 , 4} }       //"Manutencao"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o cabecalho da tela de atualizacoes                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cCadastro            := "Expedicao"         //"Expedicao"

dbSelectArea("SF2")
dbSetOrder(1)
MsSeek(xFilial("SF2"))
mBrowse(6,1,22,75,"SF2")

Return Nil

/*/                
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³AFATManut ³ Autor ³ Sergio S. Fuzinaka    ³ Data ³ 14.12.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Inclusao e/ou alteracao de Transportadora e Veiculo         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function AFATManut()

Local aArea                        := GetArea()
Local aTitles       := {}//"Nota Fiscal" //"Nota Fiscal"
Local nCntFor    := 0
Local nOpc                         := 0
Local nX        := 0
Local lVeiculo    := .T.//(SF2->(FieldPos("F2_VOLUME1"))>0 .And. SF2->(FieldPos("F2_PLIQUI"))>0 .And. SF2->(FieldPos("F2_PBRUTO"))>0)
Local cTransp     := ""
Local cVeicul1    := ""
Local cVeicul2    := ""
Local cVeicul3    := ""
Local cVeicul4    := ""
Local oDlg
Local oFolder
Local oList

Private aHeader                := {}
Private aCols       := {}

Private oTransp
Private oVeicul1
Private oVeicul2
Private oVeicul3
Private oVeicul4
    
AADD(aTitles,"Nota Fiscal")

If lVeiculo

                RegToMemory("SF2",.F.)
                
                cTransp                := Posicione("SA4",1,xFilial("SA4")+SF2->F2_TRANSP,"A4_NOME")
                cVeicul1:= SF2->F2_VOLUME1  //F2_VOLUME1
                cVeicul2:= SF2->F2_PLIQUI        //F2_PLIQUI
                cVeicul3:= SF2->F2_PBRUTO     //F2_PBRUTO
				cVeicul4:= SF2->F2_ESPECI1 
                //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                //³ Montagem do aHeader                                  ³
                //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                dbSelectArea("SX3")
                dbSetOrder(1)
                If dbSeek("SF2")
                               While ( !Eof() .And. (SX3->X3_ARQUIVO == "SF2") )
                                               If ( X3USO(SX3->X3_USADO) .And. ;
                                                               AllTrim(SX3->X3_CAMPO) $ "F2_DOC|F2_SERIE|F2_CLIENTE|F2_LOJA|F2_EMISSAO" .And. ;
                                                               cNivel >= SX3->X3_NIVEL )
                                                               
                                                               Aadd(aHeader,{ TRIM(X3Titulo()),;
                                                                              SX3->X3_CAMPO,;
                                                                              SX3->X3_PICTURE,;
                                                                              SX3->X3_TAMANHO,;
                                                                              SX3->X3_DECIMAL,;
                                                                              SX3->X3_VALID,;
                                                                              SX3->X3_USADO,;
                                                                              SX3->X3_TIPO,;
                                                                              SX3->X3_ARQUIVO,;
                                                                              SX3->X3_CONTEXT } )
                                               EndIf
                                               dbSelectArea("SX3")
                                               dbSkip()
                               EndDo
                EndIf                     
                
                //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                //³ Montagem do aCols                                    ³
                //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                dbSelectArea("SF2")
                AADD(aCols,Array(Len(aHeader)))
                For nCntFor:=1 To Len(aHeader)
                               If ( aHeader[nCntFor,10] <>  "V" )
                                               aCols[Len(aCols)][nCntFor] := FieldGet(FieldPos(aHeader[nCntFor,2]))
                               Else                                       
                                               aCols[Len(aCols)][nCntFor] := CriaVar(aHeader[nCntFor,2])
                               EndIf
                Next nCntFor
                
                //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                //³Monta a tela de exibicao dos dados           ³
                //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                DEFINE MSDIALOG oDlg TITLE "Manutencao de Transportadoras, Volume e Peso" FROM 09,00 TO 32.2,80 //"Manutencao de Transportadoras e Veiculos"
                
                oFolder                := TFolder():New(001,001,aTitles,{"HEADER"},oDlg,,,, .T., .F.,315,161)
                oList      := TWBrowse():New( 5, 1, 310, 42,,{aHeader[1,1],aHeader[2,1],aHeader[3,1],aHeader[4,1],aHeader[5,1]},{30,90,50,30,50},oFolder:aDialogs[1],,,,,,,,,,,,.F.,,.T.,,.F.,,, ) //"Numero"###"Serie"###"Cliente"###"Loja"###"DT Emissao"
                oList:SetArray(aCols)
                oList:bLine          := {|| {aCols[oList:nAt][1],aCols[oList:nAt][2],aCols[oList:nAt][3],aCols[oList:nAt][4],aCols[oList:nAt][5]}}
                oList:lAutoEdit  := .F.
                
                @ 051,005 SAY RetTitle("F2_TRANSP")    SIZE 40,10 PIXEL OF oFolder:aDialogs[1]
                @ 066,005 SAY RetTitle("F2_VOLUME1")   SIZE 40,10 PIXEL OF oFolder:aDialogs[1]
                @ 081,005 SAY RetTitle("F2_PLIQUI")    SIZE 40,10 PIXEL OF oFolder:aDialogs[1]               
                @ 095,005 SAY RetTitle("F2_PBRUTO")    SIZE 40,10 PIXEL OF oFolder:aDialogs[1]                               
                @ 110,005 SAY RetTitle("F2_ESPECI1")   SIZE 40,10 PIXEL OF oFolder:aDialogs[1]    
                
                @ 051,050 MSGET M->F2_TRANSP     PICTURE PesqPict("SF2","F2_TRANSP")   F3 CpoRetF3("F2_TRANSP")            SIZE 50,07 PIXEL OF oFolder:aDialogs[1] VALID IIf(Vazio(),(cTransp:="",.T.),.F.) .Or. (ExistCpo("SA4").And.AFATDisp(@cTransp))
                @ 066,050 MSGET M->F2_VOLUME1    PICTURE PesqPict("SF2","F2_VOLUME1")  SIZE 50,07 PIXEL OF oFolder:aDialogs[1]// VALID IIf(Vazio(),(cVeicul1:="",.T.),.F.) .Or. (AFATDisp(@cVeicul1))
                @ 081,050 MSGET M->F2_PLIQUI     PICTURE PesqPict("SF2","F2_PLIQUI")   SIZE 50,07 PIXEL OF oFolder:aDialogs[1]// VALID IIf(Vazio(),(cVeicul2:="",.T.),.F.) .Or. (AFATDisp(@cVeicul2))          
                @ 095,050 MSGET M->F2_PBRUTO     PICTURE PesqPict("SF2","F2_PBRUTO")   SIZE 50,07 PIXEL OF oFolder:aDialogs[1]// VALID IIf(Vazio(),(cVeicul3:="",.T.),.F.) .Or. (AFATDisp(@cVeicul3))          
                @ 110,050 MSGET M->F2_ESPECI1    PICTURE PesqPict("SF2","F2_ESPECI1")  SIZE 50,07 PIXEL OF oFolder:aDialogs[1]// VALID IIf(Vazio(),(cVeicul3:="",.T.),.F.) .Or. (AFATDisp(@cVeicul3))          
                
                @ 051,105 MSGET oTransp         VAR cTransp      PICTURE PesqPict("SF2","F2_TRANSP")    WHEN .F. SIZE 150,07 PIXEL OF oFolder:aDialogs[1]
                @ 066,105 MSGET oVeicul1        VAR cVeicul1     PICTURE PesqPict("SF2","F2_VOLUME1")   WHEN .F. SIZE 150,07 PIXEL OF oFolder:aDialogs[1]
                @ 081,105 MSGET oVeicul2        VAR cVeicul2     PICTURE PesqPict("SF2","F2_PLIQUI")    WHEN .F. SIZE 150,07 PIXEL OF oFolder:aDialogs[1]     
                @ 095,105 MSGET oVeicul3        VAR cVeicul3     PICTURE PesqPict("SF2","F2_PBRUTO")    WHEN .F. SIZE 150,07 PIXEL OF oFolder:aDialogs[1]                      
                @ 110,105 MSGET oVeicul4        VAR cVeicul4     PICTURE PesqPict("SF2","F2_ESPECI1")   WHEN .F. SIZE 150,07 PIXEL OF oFolder:aDialogs[1]                                      
               
                @ 110,005 TO 111,310 PIXEL OF oFolder:aDialogs[1]
                @ 126,225 BUTTON "Confirmar"      SIZE 040,13 FONT oFolder:aDialogs[1]:oFont ACTION (nOpc:=1,oDlg:End()) OF oFolder:aDialogs[1] PIXEL     //"Confirmar"
                @ 126,270 BUTTON "Cancelar"       SIZE 040,13 FONT oFolder:aDialogs[1]:oFont ACTION oDlg:End()                                            OF oFolder:aDialogs[1] PIXEL     //"Cancelar"
                
                ACTIVATE MSDIALOG oDlg CENTERED
                
                If nOpc == 1
                                RecLock("SF2",.F.)
                               SF2->F2_TRANSP	:= M->F2_TRANSP
                               SF2->F2_VOLUME1	:= M->F2_VOLUME1
                               SF2->F2_PLIQUI	:= M->F2_PLIQUI                            
                               SF2->F2_PBRUTO	:= M->F2_PBRUTO
                               SF2->F2_ESPECI1	:= M->F2_ESPECI1
                               MsUnlock()
                Endif
Else
                MsgAlert("Teste")
Endif

RestArea(aArea)

Return Nil

/*/                
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³AFATDisp  ³ Autor ³ Sergio S. Fuzinaka    ³ Data ³ 14.12.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Display do Campo                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AFATDisp(cCampo)

Local aArea        := GetArea()
Local cCpo          := ReadVar()

Do Case
                Case cCpo == "M->F2_TRANSP"
                               cCampo := Posicione("SA4",1,xFilial("SA4")+M->F2_TRANSP,"A4_NOME")
                               oTransp:Refresh()
                Case cCpo == "M->F2_VOLUME1"
                               cCampo               := M->F2_VOLUME1
                               oVeicul1:Refresh()         
                Case cCpo == "M->F2_PLIQUI"
                               cCampo               := M->F2_PLIQUI
                               oVeicul2:Refresh()         
                Case cCpo == "M->F2_ESPECI1"
                               cCampo               := M->F2_ESPECI1
                               oVeicul4:Refresh()         
                Otherwise
                               cCampo               := M->F2_PBRUTO
                               oVeicul3:Refresh()         
EndCase

RestArea(aArea)

Return(.T.)
