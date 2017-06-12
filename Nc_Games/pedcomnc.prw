#INCLUDE "Protheus.ch"
#INCLUDE "rwmake.ch"

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥PEDCOMNC  ∫Autor  ≥RAFAEL AUGUSTO-STCH ∫Data  ≥  14/02/11   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥ Impress„o do Pedido de Compra, com o layout especifico e   ∫±±
±±∫          ≥ com os dados necessarios.                                  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ AP10 NC GAMES - SUPERTECH CONSULTING LTDA.                 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫AlteraÁ„o ≥ANALISTA  ∫       ≥ Sidney Oliveira    ∫Data  ≥  18/05/12   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥ Inclusao da coluna codigo, Campo do Contato                ∫±±
±±∫          | Exclus„o dos imposto no total do pedido                    ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/

User Function PEDCOMNC

                                        
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Declaracao de Variaveis                                             ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

Local cDesc1         := "Este programa tem como objetivo imprimir o pedido de "
Local cDesc2         := "compras de acordo com os parametros informados "
Local cDesc3         := "pelo usuario."
Local cPict          := ""
Local titulo         := ""
Local nLin           := 081

Local Cabec1         := ""
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 80
Private tamanho      := "P"
Private nomeprog     := "PEDCOM" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "PEDCOM" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cPerg        := "PEDCOM"
Private _nLinha      := 100

Private cString      := "SC7"


VALIDPERG()
pergunte(cPerg,.T.)       

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Monta a interface padrao com o usuario...                           ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

/*wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)


//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Processamento. RPTSTATUS monta janela com a regua de processamento. ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/       

LayOUT()

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫FunáÑo    ≥RUNREPORT ∫ Autor ≥ AP6 IDE            ∫ Data ≥  14/02/11   ∫±±
±±ÃÕÕÕÕÕ'ÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫DescriáÑo ≥ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ∫±±
±±∫          ≥ monta a janela com a regua de processamento.               ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ Programa principal                                         ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/

Static Function layout
	
Public nOrdem
Public oFont07    := TFont():New("Arial",07,09,,.F.,,,,.T.,.F.) //Local oFont07    := TFont():New("Arial",07,10,,.F.,,,,.T.,.F.)
Public oFont07c   := TFont():New("Courier New",07,09,,.F.,,,,.T.,.F.)
Public oFont08n   := TFont():New("Arial",08,09,,.F.,,,,.T.,.F.) //Local oFont07    := TFont():New("Arial",07,10,,.F.,,,,.T.,.F.)
Public oFont09    := TFont():New("Arial",09,11,,.T.,,,,.T.,.F.) //Local oFont09    := TFont():New("Arial",09,09,,.F.,,,,.T.,.F.)
Public oFont09n   := TFont():New("Arial",09,12,,.T.,,,,.T.,.F.) //Local oFont09    := TFont():New("Arial",09,09,,.F.,,,,.T.,.F.)
Public oFont10    := TFont():New("Arial",10,12,,.F.,,,,.T.,.F.) //Local oFont10    := TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
Public oFont10n   := TFont():New("Arial",10,12,,.T.,,,,.T.,.F.) //Local oFont10n   := TFont():New("Arial",10,10,,.T.,,,,.T.,.F.)
Public oFont11    := TFont():New("Arial",11,13,,.F.,,,,.T.,.F.) //Local oFont11    := TFont():New("Arial",11,11,,.F.,,,,.T.,.F.)
Public oFont11n   := TFont():New("Arial",11,13,,.T.,,,,.T.,.F.) //Local oFont11n   := TFont():New("Arial",11,11,,.T.,,,,.T.,.F.)
Public oFont12    := TFont():New("Arial",12,14,,.F.,,,,.T.,.F.) //Local oFont12    := TFont():New("Arial",12,12,,.F.,,,,.T.,.F.)
Public oFont12n   := TFont():New("Arial",12,14,,.T.,,,,.T.,.F.) //Local oFont12n   := TFont():New("Arial",12,12,,.T.,,,,.T.,.F.)
Public oFont13    := TFont():New("Arial",13,15,,.F.,,,,.T.,.F.) //Local oFont13    := TFont():New("Arial",13,13,,.F.,,,,.T.,.F.)
Public oFont13n   := TFont():New("Arial",13,15,,.T.,,,,.T.,.F.) //Local oFont13n   := TFont():New("Arial",13,13,,.T.,,,,.T.,.F.)
Public oFont14    := TFont():New("Arial",14,16,,.F.,,,,.T.,.F.) //Local oFont14    := TFont():New("Arial",14,14,,.F.,,,,.T.,.F.)
Public oFont14n   := TFont():New("Arial",14,16,,.T.,,,,.T.,.F.) //Local oFont14n   := TFont():New("Arial",14,14,,.T.,,,,.T.,.F.)
Public oFont15    := TFont():New("Arial",15,17,,.F.,,,,.T.,.F.) //Local oFont15    := TFont():New("Arial",15,15,,.F.,,,,.T.,.F.)
Public oFont16    := TFont():New("Arial",16,18,,.F.,,,,.T.,.F.) //Local oFont16    := TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
Public oFont16n   := TFont():New("Arial",16,18,,.T.,,,,.T.,.F.) //Local oFont16n   := TFont():New("Arial",16,16,,.T.,,,,.T.,.F.)
Public oFont18    := TFont():New("Arial",18,20,,.F.,,,,.T.,.F.) //Local oFont18    := TFont():New("Arial",18,18,,.F.,,,,.T.,.F.)
Public oFont18n   := TFont():New("Arial",18,20,,.T.,,,,.T.,.F.) //Local oFont18n   := TFont():New("Arial",18,18,,.T.,,,,.T.,.F.)
Public oFont21n   := TFont():New("Arial",21,23,,.T.,,,,.T.,.F.) //Local oFont21n   := TFont():New("Arial",21,21,,.T.,,,,.T.,.F.)
Public oFontBAR   := TFont():New("3 of 9 Barcode",30,30,,.F.,,,,.T.,.F.) //Local oFontBAR   := TFont():New("3 of 9 Barcode",30,30,,.F.,,,,.T.,.F.)
Public oFontNum   := TFont():New("Courier New",07,09,,.F.,,,,.T.,.F.) //Local oFontNum   := TFont():New("Courier New",12,12,,.F.,,,,.T.,.F.)
Public oFontNumN  := TFont():New("Courier New",12,14,,.T.,,,,.T.,.F.) //Local oFontNumN  := TFont():New("Courier New",12,12,,.T.,,,,.T.,.F.)
Public oPrint      

Public _nMARGEM    := 0 
Public _nItens     := 001
Public Itens       := 001 
Public _nSomaItens := 00 
Public _nSomaBruto := 00
Public _nSomaICMS  := 00
Public _nSomaIPI   := 00
Public _nSomaFrete := 00
Public _nSomaTotal := 00
Public _nCONT      := 00
Public _nNro       := 00
Public lRod        := .T.
Public Pagina      := 001
Public segpag      := .F.
Public aArea 	   := GetArea()
Public _nPag       := 1
Public _aAcabou    := .F.

cBmp := "\SYSTEM\NC_LOGO.BMP"

dbSelectArea("SC7")
dbSetOrder(1)    
dbSeek(xFilial() + MV_PAR01,.T.)                                                                                
                                    	
cCliente   := SC7->C7_FORNECE
cLojaCli   := SC7->C7_LOJA

While! EOF() .and. SC7->C7_NUM == MV_PAR01

Itens := Itens + 1

dbSkip()
EndDo                    

IF Itens < 29
	cPagina := 2
ElseIF Itens > 29
	cPagina := 3
ElseIF Itens > 58
	cPagina := 4
ElseIF Itens > 87
	cPagina := 5
EndIF

oPrint:= TMSPrinter():New("Pedido de Compra")
oPrint:StartPage()  

IF _nLinha > 80
	U_Cabec()
EndIF 

U_QUADRO()
U_Itens()
U_fim()         

IF _aAcabou == .T.
    oPrint:EndPage()
    Pagina := Pagina + 1
    _nLinha     := 999    // vai forÁar entrar na situaÁ„o l· de cima para abrir nova p·gina
	U_Regra()   
ENDIF

oPrint:Preview()

Return

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ A rotina ira imprimir sempre o cabeÁalho do pedido de compra,	    ≥
//≥ composto pelo logo, dados da empresa e numero de paginas.		    ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

User Function Cabec

dbSelectArea("SC7")
dbSetOrder(1)    
dbSeek(xFilial() + MV_PAR01,.T.)                                                                                
                                          
cCliente   := SC7->C7_FORNECE
cLojaCli   := SC7->C7_LOJA

dbSelectArea("SA2")
dbSetOrder(1)    
dbSeek(xFilial() + cCliente + cLojaCLi,.T.)                                                                                

_nLINHA := 0100

oPrint:SayBitmap(0010,0030,cBMP    ,0450,0250)
oPrint:Say(_nLINHA,0700,SM0->M0_NOMECOM,oFont11n)
oPrint:Say(_nLINHA,1950,"PAGINA",oFont08n)
oPrint:Say(_nLINHA,2100,transform((Pagina),"@E 999"),oFont08n)
oPrint:Say(_nLINHA,2150,"/",oFont08n)
oPrint:Say(_nLINHA,2200,transform((cPagina),"@E 999"),oFont08n)
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0700,"CNPJ: ",oFont07)
//oPrint:Say(_nLINHA,0850,SM0->M0_CGC,oFont07)
oPrint:Say(_nLINHA,0850,Trans(SM0->M0_CGC,"@R 99.999.999/9999-99"),oFont07)//substr(SM0->M0_CGC,1,2)+"."+substr(SM0->M0_CGC,3,3)+"."+substr(SM0->M0_CGC,5,3)+"/"+substr(SM0->M0_CGC,8,4)+"-"+substr(SM0->M0_CGC,13,2),oFont07)

oPrint:Say(_nLINHA,1200,"Inscricao Estadual: ",oFont07)
oPrint:Say(_nLINHA,1550,SM0->M0_INSC,oFont07)
_nLinha := _nLinha + 050
oPrint:Say(_nLINHA,0700,SM0->M0_ENDENT,oFont07)
_nLinha := _nLinha + 050
oPrint:Say(_nLINHA,0700,"CEP: ",oFont07)
oPrint:Say(_nLINHA,0800,SM0->M0_CIDENT,oFont07)
oPrint:Say(_nLINHA,1030,"-",oFont07)
oPrint:Say(_nLINHA,1050,SM0->M0_ESTENT,oFont07)
oPrint:Say(_nLINHA,1150,"-",oFont07)
oPrint:Say(_nLINHA,1400,"Brasil",oFont07)
_nLinha := _nLinha + 050
oPrint:Say(_nLINHA,0700,"Fone: ",oFont07)
oPrint:Say(_nLINHA,0800,SM0->M0_TEL,oFont07)
_nLinha := _nLinha + 050                 
oPrint:Say(_nLINHA,0700,"Internet: www.ncgames.com.br",oFont07)
_nLinha := _nLinha + 100                                                                                        
oPrint:Say(_nLINHA,0850,"PEDIDO DE COMPRA",oFont12n)                                                                                                                
_nLinha := _nLinha + 070                                                                                        
oPrint:Box(_nLINHA,0030,1250,2200)
oPrint:Box(_nLinha,0030,1250,1100)
_nLinha := _nLinha + 010
oPrint:Say(_nLINHA,0060,"DADOS DO FORNECEDOR",oFont11n)
oPrint:Say(_nLINHA,1150,"INFORMACOES GERAIS",oFont11n)
_nLinha := _nLinha + 060
oPrint:Line(_nLinha,0030,_nLinha,2200)
_nLinha := _nLinha + 030
oPrint:Say(_nLINHA,0060,SA2->A2_NOME,oFont10n)
oPrint:Say(_nLINHA,1150,"No. do Pedido ",oFont09)
oPrint:Say(_nLINHA,1500,MV_PAR01,oFont07)
_nLinha := _nLinha + 050                  
oPrint:Say(_nLINHA,0060,SA2->A2_END,oFont07)
oPrint:Say(_nLINHA,1150,"Data",oFont09)                  
oPrint:Say(_nLINHA,1500,DTOC(SC7->C7_EMISSAO),oFont07)
_nLinha := _nLinha + 050                  
oPrint:Say(_nLINHA,0060,SA2->A2_CEP,oFont07)
oPrint:Say(_nLINHA,0250,"-",oFont07)
oPrint:Say(_nLINHA,0300,SA2->A2_MUN,oFont07)
oPrint:Say(_nLINHA,0550,"-",oFont07)
oPrint:Say(_nLINHA,0600,SA2->A2_BAIRRO,oFont07)
oPrint:Say(_nLINHA,1150,"No. Fornecedor",oFont09)
oPrint:Say(_nLINHA,1500,SA2->A2_COD,oFont07)
_nLinha := _nLinha + 050                  
oPrint:Say(_nLINHA,0060,"Fone/Fax: ",oFont07)
oPrint:Say(_nLINHA,0250,SA2->A2_TEL,oFont07)
oPrint:Say(_nLINHA,0500,"/",oFont07)
oPrint:Say(_nLINHA,0550,SA2->A2_FAX,oFont07)
oPrint:Say(_nLINHA,1150,"Moeda ",oFont09)

IF SC7->C7_MOEDA == 1
	oPrint:Say(_nLINHA,1500,"Real",oFont07)
ElseIF SC7->C7_MOEDA == 2
	oPrint:Say(_nLINHA,1500,"Dolar",oFont07)
ENDIF

_nLinha := _nLinha + 050
oPrint:Say(_nLINHA,0060,"E-mail: ",oFont07)
oPrint:Say(_nLINHA,0250,SA2->A2_EMAIL,oFont07)
oPrint:Say(_nLINHA,1150,"Cond Pagamento ",oFont09)
oPrint:Say(_nLINHA,1500,SC7->C7_COND,oFont07)     
oPrint:Say(_nLINHA,1600,"-",oFont07)  

dbSelectArea("SE4")
dbSetorder(1)
dbSeek(xFilial() + SC7->C7_COND,.T.)

oPrint:Say(_nLINHA,1700,SE4->E4_DESCRI,oFont07)     
_nLinha := _nLinha + 050
//Dados do contato
oPrint:Say(_nLINHA,0060,"Contato ",oFont07)      
oPrint:Say(_nLINHA,0250,SC7->C7_CONTATO,oFont07) 
oPrint:Say(_nLINHA,1150,"Comprador ",oFont09)     

dbSelectArea("SY1")
dbSetOrder(3)
dbSeek(xFilial() + SC7->C7_USER,.T.)

oPrint:Say(_nLINHA,1500,SY1->Y1_NOME,oFont07)     

_nLinha := _nLinha + 050                              
oPrint:Say(_nLINHA,0060,"CNPJ: ",oFont07)     

IF !Empty(SA2->A2_CGC)
//	oPrint:Say(_nLINHA,0250,transform(SA2->A2_CGC,"@E 99.999.999/9999-99"),oFont07)     
//	oPrint:Say(_nLINHA,0250,substr(SA2->A2_CGC,1,2)+"."+substr(SA2->A2_CGC,3,3)+"."+substr(SA2->A2_CGC,7,3)+"/"+substr(SA2->A2_CGC,9,4)+"-"+substr(SA2->A2_CGC,13,2),oFont07)    
	oPrint:Say(_nLINHA,0250,substr(SA2->A2_CGC,1,2)+"."+substr(SA2->A2_CGC,3,3)+"."+substr(SA2->A2_CGC,6,3)+"/"+substr(SA2->A2_CGC,9,4)+"-"+substr(SA2->A2_CGC,13,2),oFont07)     
ENDIF

_nLinha := _nLinha + 050                  

//Dados do Contato    
/*
oPrint:Say(_nLINHA,0060,"Contato ",oFont09)
oPrint:Say(_nLINHA,0510,SC7->C7_CONTATO,oFont07) 
_nLinha := _nLinha + 050     
                        */
oPrint:Say(_nLINHA,0060,"Insc Estadual: ",oFont07)     
oPrint:Say(_nLINHA,0350,SA2->A2_INSCR,oFont07)     
_nLinha := _nLinha + 050                  
oPrint:Line(_nLinha,0030,_nLinha,1100)
_nLinha := _nLinha + 010
oPrint:Say(_nLINHA,0060,"LOCAL DE ENTREGA",oFont11n)
_nLinha := _nLinha + 060              
oPrint:Line(_nLinha,0030,_nLinha,1100)
_nLinha := _nLinha + 020                  
oPrint:Say(_nLINHA,0060,SM0->M0_NOMECOM,oFont07)     
_nLinha := _nLinha + 040                  
oPrint:Say(_nLINHA,0060,SM0->M0_ENDENT,oFont07)     
_nLinha := _nLinha + 040                  
oPrint:Say(_nLINHA,0060,"CEP: ",oFont07)     
oPrint:Say(_nLINHA,0200,SM0->M0_CEPENT,oFont07)     
oPrint:Say(_nLINHA,0450,"-",oFont07)     
oPrint:Say(_nLINHA,0500,SM0->M0_CIDENT,oFont07)     
oPrint:Say(_nLINHA,0650,"-",oFont07)     
oPrint:Say(_nLINHA,0700,SM0->M0_ESTENT,oFont07)     

dbSelectArea("SC7")
dbSetOrder(1)
dbSeek(xFilial() + MV_PAR01 + "0001",.T.)
	
_nCONT := 000
_nNro  := 000

WHILE! EOF() .AND. SC7->C7_NUM == MV_PAR01 
	_nCONT += 065
	_nNro  += 065    
	DBSKIP()
ENDDO

Return  

User Function Quadro

_nLINHA := 1180
                    
//IF _nCONT > 1985
	_nCONT := 1735//1885
//EndIF

_nLINHA := _nLINHA + 150                  

oPrint:Box(_nLINHA,0030,_nCONT + 100 +_nLINHA,2200) //Quadro Geral
oPrint:Box(_nLINHA,0030,_nCONT + 100 +_nLINHA,0180) //Quadro Item
oPrint:Box(_nLINHA,0030,_nCONT + 100 +_nLINHA,0475) //Quadro Codigo Produto
oPrint:Box(_nLINHA,0030,_nCONT + 100 +_nLINHA,1180) //Quadro Descricao
oPrint:Box(_nLINHA,0030,_nCONT + 100 +_nLINHA,1450) //Quadro Quantidade
oPrint:Box(_nLINHA,0030,_nCONT + 100 +_nLINHA,1550) //Quadro Unidade
oPrint:Box(_nLINHA,0030,_nCONT + 100 +_nLINHA,1850) //Quadro Preco Unitario
oPrint:Box(_nLinha,0030,_nLinha + 0050,2200)        //Quadro Descricao Itens

oPrint:Say(_nLINHA,0040,"Item",oFont09n)     
oPrint:Say(_nLINHA,0210,"Codigo",oFont09n)     
oPrint:Say(_nLINHA,0490,"DescriÁ„o",oFont09n) 
oPrint:Say(_nLINHA,1200,"Quantidade",oFont09n)     
oPrint:Say(_nLINHA,1480,"UN",oFont09n)     
oPrint:Say(_nLINHA,1570,"Preco Bruto",oFont09n)     
oPrint:Say(_nLINHA,1860,"Montante Bruto",oFont09n)     

_nLinha := _nLinha + 070                  
                                                                            
Return

User Function Itens 

dbSelectArea("SC7")
dbSetOrder(1)
dbSeek(xFilial() + MV_PAR01 + "0001",.T.)

WHILE! EOF() .AND. SC7->C7_NUM == MV_PAR01        

oPrint:Say(_nLINHA,0040,SC7->C7_ITEM,oFont07c)     
oPrint:Say(_nLINHA,0210,SC7->C7_PRODUTO,oFont07c)   
oPrint:Say(_nLINHA,0490,SC7->C7_DESCRI,oFont07c)  
oPrint:Say(_nLINHA,1200,transform((SC7->C7_QUANT),"@E 9,999,999.99"),oFont07c)     
oPrint:Say(_nLINHA,1480,SC7->C7_UM,oFont07c)                                  
oPrint:Say(_nLINHA,1580,transform((SC7->C7_PRECO),"@E 9,999,999.99"),oFont07c)//oFont07)     
oPrint:Say(_nLINHA,1880,transform((SC7->C7_TOTAL),"@E 9,999,999.99"),oFont07c)//oFont07)     

//_nSomaBruto += SC7->C7_TOTAL + SC7->C7_VALICM
//_nSomaICMS  += SC7->C7_VALICM
//_nSomaIPI   += SC7->C7_VALIPI
//_nSomaFrete += SC7->C7_FRETE
_nSomaBruto += SC7->C7_TOTAL                 
//_nSomaTotal := _nSomaBruto + _nSomaIPI + _nSomaFrete
_nSomaTotal := _nSomaBruto

_nLinha := _nLinha + 050                  

_nSomaItens := _nSomaItens + _nItens

IF _nSomaItens > 29
    oPrint:EndPage()
    Pagina      := Pagina + 1
    _nLinha     := 999    // vai forÁar entrar na situaÁ„o l· de cima para abrir nova p·gina
    _nPag       := 003
	_nSomaItens := 000    
ENDIF

IF _nPag > 1   
	aArea := getarea()
	U_Cabec()
	U_QUADRO()
	RestArea(aArea)          
	_nPag := 1
ENDIF

dbSkip()                                              
ENDDO
                    
Return

User Function fim

//_nLinha := 2900 

_nLinha := 3200
oPrint:Box(_nLINHA,0030,3270,2200) //Quadro Geral
     /*
oPrint:Say(_nLINHA,0900,"Valor Mercadoria --------------------------------",oFont07c)     
oPrint:Say(_nLINHA,1880,transform((_nSomaBruto),"@E 9,999,999.99"),oFont07c)     
	_nLinha := _nLinha + 050                  
oPrint:Say(_nLINHA,0900,"Valor ICMS --------------------------------------",oFont07c) 
oPrint:Say(_nLINHA,1880,transform((_nSomaICMS),"@E 9,999,999.99"),oFont07c)     
	_nLinha := _nLinha + 050                      
oPrint:Say(_nLINHA,0900,"Valor IPI ---------------------------------------",oFont07c)  
oPrint:Say(_nLINHA,1880,transform((_nSomaIPI),"@E 9,999,999.99"),oFont07c)     
	_nLinha := _nLinha + 050                     
oPrint:Say(_nLINHA,0900,"Adicional Frete ---------------------------------",oFont07c)     
oPrint:Say(_nLINHA,1880,transform((_nSomaFrete),"@E 9,999,999.99"),oFont07c)     
	_nLinha := _nLinha + 050                  
	*/
oPrint:Say(_nLINHA + 10,0900,"Total Pedido ------------------------------------",oFont10n)
oPrint:Say(_nLINHA + 10,1880,transform((_nSomaTotal),"@E 9,999,999.99"),oFont10n)     

_aAcabou := .T.
   
Return

User Function Regra
                                     
_nCONT  := 1985
_nLinha := 0100     

oPrint:StartPage()  
                                              
oPrint:SayBitmap(0030,0030,cBMP,0250,0150)

oPrint:Say(_nLINHA,0450,"PROCEDIMENTO DE RECEBIMENTO DE COMPRAS",oFont12n)
oPrint:Say(_nLINHA,1950,"PAGINA",oFont08n)
oPrint:Say(_nLINHA,2100,transform((Pagina),"@E 999"),oFont08n)
oPrint:Say(_nLINHA,2150,"/",oFont08n)
oPrint:Say(_nLINHA,2200,transform((cPagina),"@E 999"),oFont08n)
_nLinha := _nLinha + 100
oPrint:Box(_nLINHA,0030,3150,2200)
_nLinha := _nLinha + 050
oPrint:Say(_nLINHA,0040,"1.  Todas as informacoes colocadas neste pedido dever„o ser praticadas na emiss„o da nota fiscal de faturamento, a nota   " ,oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"    dever· ser um espelho deste pedido de compra;  " ,oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"2.  Qualquer alteraÁ„o comercial deverao ser acordada com o Sr (a) usuario atraves do telefone (11) 4095-3052 ou  ",oFont08n)
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070 
oPrint:Say(_nLINHA,0040,"    via email: lreis@ncgames.com.br   ;" ,oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"3.  Todas as cobranÁas dever„o ser direcionadas para o endereÁo:   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"		  NC GAMES & ARCADES C.I.E.L.F.M. LTDA   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"		  AVENIDA ARUAN√, 280/352 CONDOMÕNIO WLC GALP√O 3 E 4 - TAMBOR… - BARUERI - SP - CEP 06460-010   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"		  TELEFONE: (11) 4095-3100   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"4.  A NC Games reserva-se ao direito de realizar pagamentos somente nos dias 05, 10, 15, 20 e 28 de cada mÍs, caso sejam   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"    emitidas faturas com vencimento diferente destes,o pagamento ser· realizado na data prÛxima sem que ocorram juros ou  ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"    multas. N„o aceitamos cobranÁa de nenhum encargo n„o mencionado neste pedido;   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"5.  Dever· ser mencionado na nota fiscal de faturamento o n˙mero do pedido de compra impreterivelmente. O departamento    " ,oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"    de recebimento das unidades estao proibidos de receber nota fiscal sem este dado;   " ,oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"6.  Toda Mercadoria e nota fiscal dever· ser entregue na NC Games e ter data de emiss„o atÈ no m·ximo  dia  26 de cada    ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"    mÍs, caso contr·rio somente receberemos a partir do primeiro dia ˙til do mÍs seguinte:   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"	  a.	Mercadoria entregue na NC Games no dia 26 - A nota devera ter data de emiss„o no dia 26;   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"	  b.	Mercadoria entregue na NC Games no dia 01 - A nota devera ter data de emiss„o no dia 1∫ (N„o iremos receber   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"           mercadoria com data do ˙ltimo dia do mÍs anterior - 30 ou 31);   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"	  c.	Dias 27, 28, 29, 30 e 31 n„o poderemos receber mercadorias e suas respectivas notas fiscais;   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"	  d.    N„o podemos receber nota fiscal antecipada. Exemplo a nota fiscal com data do dia  26 e mercadoria entregue   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"           no dia 27 ou 28;   ",oFont08n)
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"	  e.	O procedimento acima v·lido para recebimento de todo tipo de compra de mercadoria ou prestaÁ„o de serviÁos;     ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"	  f.	As notas fiscais eletrÙnicas de serviÁos e arquivos XML de DANFEs devem ser encaminhadas ao e-mail abaixo :   ",oFont08n) 
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"           fiscal@ncgames.com.br;   ",oFont08n)
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"	  g.	Todas as notas fiscais dever„o ser recebidas na NC Games  com no mÌnimo oito dias ˙teis   ",oFont08n)      
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"           de antecedÍncia da data de vencimento;   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"	  h.	Impostos: Destacar 18% ICMS ou valor equivalente ao estado/municÌpio de origem;   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"	  i.	As gr·ficas que fazem materiais promocionais como:   cubo, poster, stoper, displays, flyers, etc..., tambÈm   ",oFont08n)
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"           dever„o emitir nota fiscal de venda destacando os impostos e n˙mero de servico de impressos personalizados;   ",oFont08n)
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"7.	 PreÁos e condiÁıes fixados neste pedido n„o sofrer„o reajuste. N„o ser· aceito qualquer documento que comprove tal   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"    alteraÁ„o de preco apÛs emiss„o do pedido;   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"8.	 Dados para faturamento de compra de mercadoria e prestaÁ„o de serviÁos:   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"    a.	Para entrega no Galp„o 3:   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"		  	NC Games & Arcades C.I.E.L.F.M. Ltda.   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"		  	AVENIDA ARUAN√, 280/352 CONDOMÕNIO WLC GALP√O 3 - TAMBOR… - BARUERI - SP   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070     
oPrint:Say(_nLINHA,0040,"		  	CEP 02465-100 - CNPJ 01.455.929/0001-78 - IE 206.145.944.116   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"    b.	Para entrega no Galp„o 4:   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"		  	NC Games & Arcades C.I.E.L.F.M. Ltda.   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070
oPrint:Say(_nLINHA,0040,"		  	AVENIDA ARUAN√, 280/352 CONDOMÕNIO WLC GALP√O 4 - TAMBOR… - BARUERI - SP   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
_nLinha := _nLinha + 070                     
oPrint:Say(_nLINHA,0040,"		  	CEP 06460-200 - CNPJ 01.455.929/0003-30 - IE 206.280.266.110   ",oFont08n)     
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22

Return

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥Programa  ≥VALIDPERG ≥ Autor ≥ RAIMUNDO PEREIRA      ≥ Data ≥ 01/08/02 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥          ≥ Verifica as perguntas inclu°ndo-as caso nÑo existam        ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso       ≥ Especifico para Clientes Microsiga                         ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/

Static Function ValidPerg()
_aAreaVP := GetArea()

DBSelectArea("SX1")
DBSetOrder(1)

cPerg  := PADR(cPerg,10)
aRegs  :={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AADD(aRegs,{cPerg,"01","Numero do Pedido ?","","","mv_ch1","C",6,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SC7"})

For i:=1 to Len(aRegs)
	If !DBSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to Len(aRegs[i])
			FieldPut(j,aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next

RestArea(_aAreaVP)
Return
