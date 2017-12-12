#INCLUDE "protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±³Função    ³ GP670CPO   ³ Autor ³Marcelo SServices    ³ Data ³ 25/08/11 ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±³Descrição ³ Ponto de Entrada para Gravação Campos Contas a Pagar       ³±±
±±³            E2_HIST E2_CCD dos Títulos da Fopag                        ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Específico para NC GAMES GPEM670 (Integ. Títulos)          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GP670CPO()

Local cMesAnoRef := SuperGetMv("MV_FOLMES",,"")
Local cFil  := ""
Local cMat  := ""
Local cNome := ""

If RC1->RC1_TIPO $("FER*RES*PEN") .And. !EMPTY(RC1->RC1_MAT)
    // Pesquisa no Cadastro de Funcionários
	dbSelectArea("SRA")
	dbSetOrder(1)
	dbSeek(xFilial("SRA")+RC1->RC1_MAT)
    cFil  := xFilial("SRA")
    cMat  := SRA->RA_MAT
    cNome := SRA->RA_NOME                   
    ///////////////////////////////////////////                   

    RecLock("SE2",.F.)        
	SE2->E2_HIST   := RC1->RC1_TIPO+SPACE(01)+SUBSTR(cMesAnoRef,5,2)+"/"+SUBSTR(cMesAnoRef,3,2)+SPACE(01)+cFil+"-"+cMat+"-"+cNome
    MsUnLock()
Else
	RecLock("SE2",.F.)       
	SE2->E2_HIST  := RC1->RC1_TIPO+"-"+RC1->RC1_DESCRI+SPACE(01)+SUBSTR(cMesAnoRef,5,2)+"/"+SUBSTR(cMesAnoRef,3,2)
	MsUnLock()
Endif                     

Return
