#INCLUDE "RWMAKE.CH"
#INCLUDE "TopConn.ch"
//
//
//
User Function TRACKING()
Private Tamanho   := "M"
Private Limite    := 132
Private cDesc1    := PADC("Este Programa Ira Emitir o Relatorio Tracking...",74)
Private cDesc2    := PADC("",74)
Private cDesc3    := PADC("",74)
Private aReturn   := {"Zebrado",1,"Administracao",1,2,1,"",1} // Formulario,N.vias,Destinatario,Formato,Midia,Porta,Filtro,Ordem
Private nomeprog  := "TRACKING"
Private _cPerg    := "TRACKING  "
Private nLastKey  := 0
Private lContinua := .T.
Private _nLin     := 80
Private wnrel     := "TRACKING"

//+----------------------------------------------------------------------------+
//¦                         Variaveis do Cabecalho                             ¦
//+----------------------------------------------------------------------------+
//                             1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21       22
//                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Private cabec1    :="Documento/Ser  DtDispSep   HrDispSep  DtIniSep    HrIniSep   DtIniConf   HrIniConf  DtDispNf    HrDispNf   DtEtiNf     HrEtiNf
//                   XXXXXXXXX/XXX  DD/MM/AAAA  99:99:99   DD/MM/AAAA  99:99:99   DD/MM/AAAA  99:99:99   DD/MM/AAAA  99:99:99   DD/MM/AAAA  99:99:99
//                   
Private cabec2    := ""
Private cCancel   := "***** CANCELADO PELO OPERADOR *****"
Private m_pag     := 1     //Variavel que acumula numero da pagina

//+----------------------------------------------------------------------------+
//¦                         Variaveis do Rodape                                ¦
//+----------------------------------------------------------------------------+
Private cbCont := 0
Private cbTxt  := ""

//+----------------------------------------------------------------------------+
//¦ Verifica as Perguntas Selecionadas no SX1                                  ¦
//+----------------------------------------------------------------------------+
//ValidPerg()
//Pergunte(_cPerg,.T.)               // Pergunta no SX1

//+--------------------------------------------------------------+
//¦ Envia controle para a funcao SETPRINT                        ¦
//+--------------------------------------------------------------+
Private cString   :="SC5"
Private Titulo    :="Relatorio Tracking"

wnrel:=SetPrint(cString,nomeprog,,@Titulo,cDesc1,cDesc2,cDesc3,.T.,,.T.,Tamanho,,.T.)
If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

RptStatus({|| Impressao() })

Roda(CbCont,CbTxt,Tamanho)

dbcommitAll()
Set Device To Screen

If aReturn[5] == 1
	Set Printer To
	Ourspool(wnrel)
Endif

MS_FLUSH()
Return

Static Function Impressao()
Private _aArea := GetArea()

_cQuery01 := "SELECT * FROM VW_DOCUMENTOSAIDAPAINEL "

_cQuery01 := ChangeQuery(_cQuery01)

If Select("TRB1") > 0
    dbSelectArea("TRB1")
    dbCloseArea()
EndIf
TCQUERY _cQuery01 New Alias "TRB1"

dbSelectArea("TRB1")
dbGoTop()

Do While !Eof()
	If _nLin > 55
		Cabec(Titulo,cabec1,cabec2,nomeprog,tamanho,15)
	EndIf

	_nLin++
	@ _nLin, 000 Psay TRB1->DOCUMENTOSAIDA+"/"+TRB1->SERIEDOCUMENTO
//	@ _nLin, 015 Psay STOD(TRB1->DATADISPONIVELSEP)
//	@ _nLin, 027 Psay TRB1->TEMPODISPONIVELSEP             PICTURE "@R 99:99:99"
	@ _nLin, 015 Psay STOD(TRB1->DATADISPSEP)
	@ _nLin, 027 Psay TRB1->DATADISPONIVELSEP              PICTURE "@R 99:99:99"
//	@ _nLin, 038 Psay STOD(TRB1->DATASEPARACAO)
//	@ _nLin, 050 Psay TRB1->TEMPOSEPARACAO                 PICTURE "@R 99:99:99"
	@ _nLin, 038 Psay STOD(TRB1->DATASEP)
	@ _nLin, 050 Psay TRB1->DATASEPARACAO                  PICTURE "@R 99:99:99"
//	@ _nLin, 061 Psay STOD(TRB1->DATACONFERENCIA)
//	@ _nLin, 073 Psay TRB1->TEMPOCONFERENCIA               PICTURE "@R 99:99:99"
	@ _nLin, 061 Psay STOD(TRB1->DATACONF)
	@ _nLin, 073 Psay TRB1->DATACONFERENCIA                PICTURE "@R 99:99:99"
//	@ _nLin, 084 Psay DTOC(TRB1->DATADISPONIVELCONF)
//	@ _nLin, 096 Psay TRB1->TEMPODISPONIVELCONF            PICTURE "@R 99:99:99"
	@ _nLin, 084 Psay DTOC(TRB1->DATAFIM)
	@ _nLin, 096 Psay TRB1->DATACONFIRMACAO                PICTURE "@R 99:99:99"
	@ _nLin, 107 Psay DTOC(TRB1->DATACONFIRMACAO)
	@ _nLin, 119 Psay TRB1->TEMPOTOTAL                     PICTURE "@R 99:99:99"

	dbSkip()
EndDo
Return