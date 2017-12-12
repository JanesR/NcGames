#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch" 

//Posi็ใo do array referente o arquivo original
#DEFINE LINHAARQ 	1//Linha do arquivo original
#DEFINE STATUSBX 	2//Status Baixado / Nใo Baixado
#DEFINE IDMOIP		3//Id Moip
#DEFINE PVCIASHOP	4//Id Proprio (PV Ciashop)
#DEFINE FORMPAGTO	5//Forma de pagamento
#DEFINE RAZAOPROD	6//Razao - Descri็ใo Produto
#DEFINE NOMECOMP	7//Nome comprador
#DEFINE EMAILCOMP	8//Email comprador
#DEFINE ENDERCOMP	9//Endereco comprador
#DEFINE CPFCOMP		10//CPF Comprador
#DEFINE DTINICIAL	11//Data inicial
#DEFINE DTAUTORIZ	12//Data de autoriza็ใo
#DEFINE DTCONCLUS	13//Data de conclusใo
#DEFINE DTULTATU	14//Data da ultima atualiza็ใo
#DEFINE STATUSMOIP	15//Status da transa็ใo no moip
#DEFINE SUBSTATUSM	16//Substatus da transa็ใo
#DEFINE VALORMOIP	17//Valor Total Moip
#DEFINE TXMOIP		18//Taxa totcal Moip
#DEFINE VALORFIXOM	19//Valor Fixo Moip
#DEFINE PERCMOIP	20//Procentagem Moip
#DEFINE VALORLQMOI	21//Valor Liquido Moip
#DEFINE QTDPARCELA	22//Quantidade de parcelas
#DEFINE OBSERVACAO	23//Observa็ใo 

#DEFINE PREFIXO 	24 //Prefixo
#DEFINE TITULO 		25 //Titulo
#DEFINE TIPO 		26 //Tipo


//Posi็ใo do array referente os dados complementares 
#DEFINE NPREFIXOT	2 //Prefixo do titulo
#DEFINE NTITULO		3 //Tiutlo
#DEFINE NPARCELA	4 //Parcela	
#DEFINE NTIPO 		5 //Tipo
#DEFINE NNATUREZA	6 //Natureza
#DEFINE NVALORTIT	7 //Valor do titulo
#DEFINE NTAXAMOIP	8 //Taxa do moip
#DEFINE NVALORFIXO	9 //Valor fixo do moip
#DEFINE NPERCENT	10 // Percentual
#DEFINE NVALORABT	11 //Valor Abatimento
#DEFINE NVALORBAIXA	12 //Valor baixa
#DEFINE NDIFPROTMOI 13//Diferen็a entre o Moip e o Protheus
#DEFINE NCODCLIENTE	14 //Codigo do Cliente
#DEFINE NLOJA		15 //Loja
#DEFINE NNOMEREDUZ	16 //Nome do cliente
#DEFINE NPEDIDOCIA	17 //Pedido CIASHOP
#DEFINE NPVPROTHEUS	18 //Pedido no Protheus 
#DEFINE NNOTAFISCAL	19 //Nota Fiscal
#DEFINE NSERIE		20 //Serie
#DEFINE NIDMOIP		21 //ID Mopi
#DEFINE NPOSARQORI	22 //Posi็ใo do arquivo original
#DEFINE NSTATUSBX	23 //Status
#DEFINE NOBSERVACAO 24 //Observa็ใo

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCBXTMP		  บAutor  ณMicrosiga      บ Data ณ  18/11/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Baixa dos titulo do moip 								  บฑฑ
ฑฑบ          ณ 											  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCBXTMP()
Local oBrowse                
Local cFiltro		:= " PZH_ESTORN != 'S' "

Private cCadastro 	:= "Titulos baixados MOIP"

DbSelectArea('PZH')
DbSetOrder(1)
oBrowse := FWmBrowse():New()
oBrowse:SetAlias( 'PZH' )
oBrowse:SetDescription( "Titulos baixados MOIP" )
oBrowse:SetFilterDefault(cFiltro)
oBrowse:Activate()

Return NIL
                                              
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณMenuDef   ณ Autor ณ Microsiga             ณ Data ณ00/00/0000ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Utilizacao de menu Funcional                               ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณArray com opcoes da rotina.                                 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณParametros do array a Rotina:                               ณฑฑ
ฑฑณ          ณ1. Nome a aparecer no cabecalho                             ณฑฑ
ฑฑณ          ณ2. Nome da Rotina associada                                 ณฑฑ
ฑฑณ          ณ3. Reservado                                                ณฑฑ
ฑฑณ          ณ4. Tipo de Transao a ser efetuada:                        ณฑฑ
ฑฑณ          ณ		1 - Pesquisa e Posiciona em um Banco de Dados         ณฑฑ
ฑฑณ          ณ    2 - Simplesmente Mostra os Campos                       ณฑฑ
ฑฑณ          ณ    3 - Inclui registros no Bancos de Dados                 ณฑฑ
ฑฑณ          ณ    4 - Altera o registro corrente                          ณฑฑ
ฑฑณ          ณ    5 - Remove o registro corrente do Banco de Dados        ณฑฑ
ฑฑณ          ณ5. Nivel de acesso                                          ณฑฑ
ฑฑณ          ณ6. Habilita Menu Funcional                                  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ   DATA   ณ Programador   ณJeferson                                    ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ          ณ               ณ                                            ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function MenuDef()

Local aExcBx	:= {}                                                

Private aRotina := { }

AAdd(aExcBx, {"Cancela Baixa"				, "u_NCCANBXM"	, 0, 5} )
AAdd(aExcBx, {"Excluir Baixa"				, "u_NCEXCBXM"	, 0, 6} )
AAdd(aExcBx, {"Canc.Baixa Lote"				, "u_NCCANBXL"	, 0, 5} )
AAdd(aExcBx, {"Exc.Baixa Lote" 				, "u_NCEXCBXL"	, 0, 6} )

AAdd(aRotina, {"Visualizar"					, "AxVisual"	, 0, 2})
AAdd(aRotina, {"Import.Bx.CiaShop"			, "U_NCIMBXEC", 0, 3})
AAdd(aRotina, {"Import.Bx.Vend.Vista"		, "U_NCIMBXVA", 0, 3})
//AAdd(aRotina, {"Import.Bx.MarketPlace"		, "U_NCBXTMPV", 0, 3})
AAdd(aRotina, {"Vis.Arq.Import"				, "U_NCARQBXM", 0, 8})
AAdd(aRotina, {"Exc.\Cancel. Baixa"			, aExcBx	  , 0, 5})

Return(aRotina)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIMBXEC		  บAutor  ณMicrosiga      บ Data ณ  18/12/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina de importa็ใo de arquivo .CSV para baixa dos 		  บฑฑ
ฑฑบ          ณ titulos do E-commerce, processados pelo MOIP		 		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCIMBXEC()

Local aArea := GetArea()

ImpBxMoip(.T.)

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIMBXVA		  บAutor  ณMicrosiga      บ Data ณ  18/12/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina de importa็ใo de arquivo .CSV para baixa dos 		  บฑฑ
ฑฑบ          ณ titulos de venda a vista, processados pelo MOIP			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCIMBXVA()

Local aArea := GetArea()

ImpBxMoip(.F.)

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณImpBxMoip	บAutor  ณElton C.		     บ Data ณ  18/10/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para informar o locar do arquivo a ser    บฑฑ
ฑฑบ          ณ importado e chamar a rotina para leitura do mesmo.         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpBxMoip(lBxEcom)

Local aArea := GetArea()
Local aParam	:= {}         

Default lBxEcom := .T.

//Perguntas da importa็ใo
If U_NCPBXMP(aParam)
    
	//Valida็ใo dos parametros
	If U_NCVPBXMP(aParam)     
		
		//Processamento da rotina de importa็ใo
		Processa({|| ProcLrArq(aParam[1], lBxEcom,aParam[2], aParam[3], aParam[4]) })			
	EndIf

EndIf

RestArea(aArea)
Return
                                                                

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPergFile	บAutor  ณElton C.		     บ Data ณ  18/10/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Pergunta com o endere็o do arquivo						  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCPBXMP(aParam)

Local aArea 		:= GetArea()
Local aParamBox		:= {} 
Local lRet			:= .F.

Default aParam :={}		

AADD( aParamBox ,{6,"Arquivo:","","","File(&(ReadVar()))","",80,.T.,"Arquivos .CSV |*.CSV","",GETF_LOCALHARD+GETF_NETWORKDRIVE})
AADD( aParamBox ,{1,"Banco:"		,Space(TAMSX3("A6_COD")[1])		,"@!"	,"ExistCpo('SA6')","SA6","",70,.T.})
AADD( aParamBox ,{1,"Agencia:"		,Space(TAMSX3("A6_AGENCIA")[1])	,"@!"	,"","","",70,.T.})
AADD( aParamBox ,{1,"Conta:"		,Space(TAMSX3("A6_CONTA")[1])	,"@!"	,"","","",70,.T.})

//Monta a pergunta
lRet := ParamBox(aParamBox ,"Endere็o de arquivo",@aParam,,,.T.,50,50,,,.T.,.T.)

RestArea(aArea)
Return lRet
                                                                           
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณNCVPBXMPบAutor  ณElton C.		     บ Data ณ  18/10/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida็ใo das perguntas da importa็ใo					  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCVPBXMP(aParam)
Local aArea 	:=	GetArea()
Local lRet		:= .T.         
Local cMsgAux   := ""

Default aParam := {}

//Verifica se o parametro com o endere็o do arquivo foi preenchido
If Empty(aParam[1])
	lRet		:= .F.
	cMsgAux   	+= "Endere็o do arquivo nใo preenchido"+CRLF
ElseIf !File(aParam[1])//Verifica se o arquivo foi encontrado no caminho especificado
	lRet		:= .F.                                 
	cMsgAux   	+= "Arquivo nใo encontrado em: "+aParam[1]+CRLF
EndIf


//Verifica se o banco foi preenchido
If Empty(aParam[2])
	lRet		:= .F.                                 
	cMsgAux   	+= "C๓digo do banco nใo preenchido "+CRLF
EndIf

//Verifica se a agencia foi preenchido
If Empty(aParam[3])
	lRet		:= .F.                                 
	cMsgAux   	+= "C๓digo da ag๊ncia nใo preenchida "+CRLF
EndIf

//Verifica se a conta foi preenchida
If Empty(aParam[4])
	lRet		:= .F.                                 
	cMsgAux   	+= "Conta bancแria nใo preenchida "+CRLF
EndIf


//Verifica se os dados bancแrios existem na base de dados (tabela SA6)
If lRet
	DbSelectArea("SA6")
	DbSetOrder(1)
	If !SA6->(MsSeek(xFilial("SA6") + Padr(aParam[2],TAMSX3("A6_COD")[1]) + Padr(aParam[3],TAMSX3("A6_AGENCIA")[1]) +  Padr(aParam[4],TAMSX3("A6_CONTA")[1]) ))
		lRet		:= .F.                                 
		cMsgAux   	+= "Dados bancแrios nใo encontrados. Banco: "+aParam[2]+" Agencia: "+aParam[3]+" Conta: "+aParam[4]+" "+CRLF
	EndIf
EndIf	

If !lRet
	Aviso("Valida็ใo de parโmetros","Segue os erros encontrados no preenchimento dos parโmetros: "+cMsgAux+CRLF,{"Ok"},3)	
EndIf

RestArea(aArea)
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณProcLrArq	บAutor  ณElton C.		     บ Data ณ  18/10/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Processamento da leitura do arquivo 						  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ProcLrArq(cArqImport, lBxEcom,cBco, cAgencia, cContaBc)

Local aArquivo 		:= {}
Local cLinha   		:= "" 
Local alLinha  		:= {}
Local nX			:= 0
Local nlCont		:= 1
Local aItensBx		:= {}//Itens da baixa
Local lLogParc		:= .T.
Local aArqAux		:= {}
Local aBxTit		:= {}

Default cArqImport 	:= ""                    
Default lBxEcom		:= .T.
Default cBco		:= ""
Default cAgencia	:= "" 
Default cContaBc	:= ""

If !File(cArqImport)
	Aviso("Aten็ใo", "O arquivo informado nใo foi localizado.",{"Ok"},2)
EndIf     

FT_FUse(cArqImport)
FT_FGoTop()
ProcRegua(FT_FLastRec())
FT_FGoTop()

While !FT_FEof() 
	IncProc("Efetuando a leitura do arquivo...")
    
    //Pula a primeira linha do arquivo (Cabe็alho)
    If nlCont == 1
    	nlCont++
    	FT_FSkip()
       loop
    EndIf
    
    //Inicia as variaveis com vazio
	cLinha 	:= ""
	alLinha := {}
	
	cLinha   	:= FT_FReadLn() //Le alinha    
	alLinha		:= Separa(cLinha,";") //Quebra a linha em colunas de acordo com o delimitador ';'
	
	//Verifica se o arquivo esta com a quantidade de colunas correta
	If Len(alLinha) >= 20
	
		//Adiciona a linha ao arquivo
		aAdd(aArquivo,alLinha ) 
	Else
		Aviso("Formado invแlido","Formato do arquivo invแlido, verifique o layout correto",{"Ok"},2)
		Exit
		Return
	EndIf
	
	FT_FSkip()
EndDo 

If Len(aArquivo) > 0
	
	ProcRegua(Len(aArquivo))
	
	//Preenchimento do arquivo auxiliar.
	//Obs. Esse array tem o objetivo de manter os dados do arquivo original e os dados complementares da base de dados. 
	//Al้m disso, o mesmo guarda o informa็๕es como titulos baixados, nใo baixados e erros ocorridos no processo.
	For nX := 1 To Len(aArquivo)        
		IncProc("Criando arquivo complementar...")
		
		If lBxEcom
			Aadd(aArqAux,{nX,;//Linha do arquivo original 
						"NAO BAIXADO",;//Status Baixado / Nใo Baixado
						aArquivo[nX][1],;//Id Moip
						Iif(lBxEcom , Val(aArquivo[nX][2]), aArquivo[nX][2]),;//Id Proprio (PV Ciashop \Protheus)
						aArquivo[nX][3],;//Forma de pagamento
						aArquivo[nX][4],;//Razao - Descri็ใo Produto
						aArquivo[nX][5],;//Nome comprador
						aArquivo[nX][6],;//Email comprador
						aArquivo[nX][7],;//Endereco comprador
						aArquivo[nX][8],;//CPF Comprador
						aArquivo[nX][9],;//Data inicial
						aArquivo[nX][10],;//Data de autoriza็ใo
						aArquivo[nX][11],;//Data de conclusใo
						aArquivo[nX][12],;//Data da ultima atualiza็ใo
						aArquivo[nX][13],;//Status da transa็ใo no moip
						aArquivo[nX][14],;//Substatus da transa็ใo
						GetVlFmt(aArquivo[nX][15]),;//Valor Total Moip
						GetVlFmt(aArquivo[nX][16]),;//Taxa total Moip
						GetVlFmt(aArquivo[nX][17]),;//Valor Fixo Moip
						GetVlFmt(aArquivo[nX][18]),;//Percentual Moip
						GetVlFmt(aArquivo[nX][19]),;//Valor Liquido Moip
						GetVlFmt(aArquivo[nX][20]),;//Quantidade de parcelas
						"";//Observa็๕es
						})
		Else
			Aadd(aArqAux,{nX,;//Linha do arquivo original 
						"NAO BAIXADO",;//Status Baixado / Nใo Baixado
						aArquivo[nX][1],;//Id Moip
						Iif(lBxEcom , Val(aArquivo[nX][2]), aArquivo[nX][2]),;//Id Proprio (PV Ciashop \Protheus)
						aArquivo[nX][3],;//Forma de pagamento
						aArquivo[nX][4],;//Razao - Descri็ใo Produto
						aArquivo[nX][5],;//Nome comprador
						aArquivo[nX][6],;//Email comprador
						aArquivo[nX][7],;//Endereco comprador
						aArquivo[nX][8],;//CPF Comprador
						aArquivo[nX][9],;//Data inicial
						aArquivo[nX][10],;//Data de autoriza็ใo
						aArquivo[nX][11],;//Data de conclusใo
						aArquivo[nX][12],;//Data da ultima atualiza็ใo
						aArquivo[nX][13],;//Status da transa็ใo no moip
						aArquivo[nX][14],;//Substatus da transa็ใo
						GetVlFmt(aArquivo[nX][15]),;//Valor Total Moip
						GetVlFmt(aArquivo[nX][16]),;//Taxa total Moip
						GetVlFmt(aArquivo[nX][17]),;//Valor Fixo Moip
						GetVlFmt(aArquivo[nX][18]),;//Percentual Moip
						GetVlFmt(aArquivo[nX][19]),;//Valor Liquido Moip
						GetVlFmt(aArquivo[nX][20]),;//Quantidade de parcelas
						"",;//Observa็๕es
						aArquivo[nX][21],;
						aArquivo[nX][22],;
						aArquivo[nX][23];
						})		
		EndIf
	Next
	
	
	//Efetua a valida็ใo inicial do arquivo	
	For nX := 1 To Len(aArqAux)
		IncProc("Importando arquivo...")
		
		//Valida็ใo basica dos dados do arquivo		
		If VldImpIt(@aArqAux, nX, lBxEcom)
			
			Aadd(aItensBx, aArqAux[nX])		
		EndIf
	Next
	
	
	//Verifica se existe itens a srem abaixados	
	If Len(aItensBx) > 0
		
		//Chama a rotina para visualiza็ใo e baixa dos titulos selecionados
		aBxTit := ViewTitBx(aItensBx, cArqImport, lBxEcom, cBco, cAgencia, cContaBc)

	Else
		Aviso("Aten็ใo", "Nenhum item importado, deseja visualizar o log de processamento ? ", {"Ok"}, 2)
		lLogParc := .F.//Nใo imprime o log parcial
		
	EndIf
	
	If lLogParc	.And. aBxTit[1] == 2
		If Aviso("Aten็ใo", "Deseja visualizar o log de processamento ? ", {"Sim","Nใo"}, 2) == 1
	
			//Chama a rotina para imprimir o log de importa็ใo
			//CtRConOut(aErro)
	   		GerLogProc(aBxTit[2], lBxEcom)
		EndIf
    EndIf
EndIf

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGerLogProc	บAutor  ณElton C.	     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera log de erro											  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GerLogProc(aArqProc, lBxEcom)

Local aArea 	:= GetArea()
Local nX		:= 0
Local apExcel	:= {}  
Local cNameArq	:= "LogBxMoip_"+ DtoS(Date())+STRTRAN(Time(), ":", "")+".xls"

Default aArqProc := {}

//Cabe็alho
WrTXMLArq(1, @apExcel, Len(aArqProc)+1)//+1 para considerar o cabe็alho

For nX := 1 To Len(aArqProc)
    
 	WrTXMLArq(2,;//Op็ใo para preenchimento do conteudo
 				@apExcel,;//Array com os dados da planilha do Excel
 				Len(aArqProc),;				//Qtd.de linhas 
 				Alltrim(Str(aArqProc[nX][NPOSARQORI])),;	//Linha do arquivo
 				aArqProc[nX][NSTATUSBX],; 	//Status
 				aArqProc[nX][NIDMOIP],;		//Id moip
 				Alltrim(Str(aArqProc[nX][NPEDIDOCIA])),; 	//PV CIASHOP
 				aArqProc[nX][NPREFIXOT],;  	//Prefixo
 				aArqProc[nX][NTITULO],; 	//Titulo
 				aArqProc[nX][NPARCELA],; 	//Parcela
 				aArqProc[nX][NTIPO],; 		//Tipo
 				aArqProc[nX][NNATUREZA],; 	//Natureza
 				aArqProc[nX][NCODCLIENTE],; //Codigo do Cliente
 				aArqProc[nX][NLOJA],;		//Loja
				aArqProc[nX][NNOMEREDUZ],;	//Nome do cliente
				Alltrim(Str(aArqProc[nX][NVALORTIT])),; 	//Valor do titulo
				Alltrim(Str(aArqProc[nX][NTAXAMOIP])),; 	//Taxa do MOIP
				Alltrim(Str(aArqProc[nX][NVALORFIXO])),; 	//Valor Fixo
				Alltrim(Str(aArqProc[nX][NPERCENT])),; 	//Percentual
				Alltrim(Str(aArqProc[nX][NVALORBAIXA])),; //Valor da baixa
				aArqProc[nX][NPVPROTHEUS],;  //Pedido no Protheus
				aArqProc[nX][NNOTAFISCAL],; //Nota Fiscal
				aArqProc[nX][NSERIE],; 		//Serie
				aArqProc[nX][NOBSERVACAO])	//Observa็ใo

Next

WrTXMLArq(3, @apExcel, Len(aArqProc))//Rodap้

//Chama a rotina para gerar a planilha do Excel
GeraExcel(apExcel, cNameArq)

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณViewTitBx	บAutor  ณElton C.		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela para visualiza็ใo dos titulos a serem baixados		  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ViewTitBx(aDadosArq, cPathArq, lBxEcom, cBco, cAgencia, cContaBc)

Local aArea			:= GetArea()
Local aTitBx		:= {}
Local cArqTmp		:= GetNextAlias()
Local cQuery		:= ""
Local nX			:= 1
Local oDlg
Local oLst                        
Local oOk			:= LoadBitMap( GetResources(), "LBTIK" )
Local oNo			:= LoadBitMap( GetResources(), "LBNO" )
Local nSel			:= 0
Local nLin			:= If( cVersao == "P10", 15, 05 )
Local nVlTotMoip 	:= 0
Local nTxTotal  	:= 0
Local nVlFix   	 	:= 0
Local nPerc     	:= 0
Local nVlLiq    	:= 0
Local nQtdParc  	:= 0
Local nPosArqOri	:= 0//Posi็ใo do arquivo original
Local cNameArqDes	:= ""
Local nSaldoAux		:= 0
Local cMsgAuto		:= ""
Local nRet			:= 0
Local aBxTit 		:= {,{}}
Local aBxTitAux		:= {}  
Local aOpcPesq		:= {"1-Prefixo+Titulo+Parcela+Tipo","2-Pedido Protheus","3-Id Moip"}
Local cTpPesq		:= ""
Local cPesq 		:= Space(100)
Local nTotSel		:= 0
Local oButPesq
Local oTGetPesq    
Local oButImpRel
Local oButBxTit	
Local oButSair	
Local oTGetTot
Local oTSayTot
Local aCab			:= {" ", "Prefixo", "Titulo", "Parcela", "Tipo","Natureza",;
							 "Vl.Titulo", "Tx.Total Moip", "Valor Fixo Moip",;
							 "Porcentagem", "Vl.Abatim.","Vl.Baixa", "Dif.Proth. Vs Moip","Cod.Cliente",;
							 "Loja", "Nome", "PV CIASHOP", "PV Protheus", "Nota Fiscal",  "Serie","Id Moip","PosArq"}

Default aDadosArq	:= {} //Dados do arquivo original
Default cPathArq 	:= ""
Default lBxEcom		:= .T.
Default cBco		:= "" 
Default cAgencia	:= "" 
Default cContaBc	:= ""

For nX := 1 To Len(aDadosArq)   
		
	nPosArqOri	:= aDadosArq[nX][NPOSARQORI]
	
	//Verifica se o status do MOIP esta concluido. Caso contrแrio, o titulo serแ desconsiderado na baixa
	If ! (SubStr(Alltrim(upper(aDadosArq[nX][STATUSMOIP])), 1,6) $ "CONCLU|AUTORI")
		loop
	EndIf
	
	nVlTotMoip 	:= 0
	nTxTotal   	:= 0
	nVlFix    	:= 0
	nPerc     	:= 0
	nVlLiq    	:= 0
	nQtdParc  	:= 0

	nVlTotMoip 	:= aDadosArq[nX][VALORMOIP]//Valor total moip
	nTxTotal  	:= aDadosArq[nX][TXMOIP]//Valor total taxa
	nVlFix    	:= aDadosArq[nX][VALORFIXOM]//Valor fixo
	nPerc     	:= aDadosArq[nX][PERCMOIP]//Percentual
	nVlLiq    	:= aDadosArq[nX][VALORLQMOI]//valor liquido
	nQtdParc  	:= aDadosArq[nX][QTDPARCELA]//Qtd.Parcelas
	
	If nQtdParc == 0
		nVlBaixa	:= nVlTotMoip - nTxTotal - nVlFix
	Else
		nVlBaixa	:= (nVlTotMoip / nQtdParc) - nTxTotal - nVlFix
	EndIf
	
	
	If lBxEcom         
	
		//Preenche os titulos a serem baixados referente o E-commerce
		GetBxEco(Alltrim(Str(aDadosArq[nX][PVCIASHOP])),;//Cod.PV CIA
				 @aTitBx,;//Var.que receberแ os dados dos titulos
				 nVlTotMoip,;//Valor total moip
				 nTxTotal,;//Taxa total
				 nVlFix,;//Valor Fixo
				 nPerc,;//percentual
				 nVlLiq,;//valor liquido a ser baixado
				 nQtdParc,;//nQtd.Parc
				 nVlBaixa,;//Valor da Baixa
				 aDadosArq[nX][LINHAARQ],;//Linha do arquivo original
				 aDadosArq[nX][IDMOIP];//Id Moip
				 )
				 
	Else         
		                                                             
		//Preenche os titulos a serem baixados referente a venda a vista
		GetBxVA(@aTitBx,;//Var.que receberแ os dados dos titulos
				 nVlTotMoip,;//Valor total moip
				 nTxTotal,; //Taxa total
				 nVlFix,;//Valor fixo
				 nPerc,;//percentual
				 nVlLiq,;//valor liquido a ser baixado
				 nQtdParc,;//Valor da Baixa
				 nVlBaixa,;//Valor da Baixa
				 aDadosArq[nX][LINHAARQ],;//Linha do arquivo original
				 aDadosArq[nX][IDMOIP],;//Id Moip
				 Alltrim(aDadosArq[nX][PREFIXO] ),;//Prefixo
				 Alltrim(aDadosArq[nX][TITULO]  ),;//Titulo
				 Alltrim(aDadosArq[nX][TIPO] );//Tipo
				 )
	EndIf
	

Next

//Verifica se existe titulos a serem baixados
If Len(aTitBx) > 0                           

	DEFINE MSDIALOG oDlg TITLE "Bx.Tํtulos do MOIP" FROM  000,000 TO 500,800 PIXEL
        
		oLst := TWBrowse():New( nLin+020, 005, 390, 210-nLin,,aCab,, oDlg,,,,,,,,,,,,.F.,,.T.,,.F.,,, )
		oLst:aColSizes := { 010, 050, 060, 060, 060, 060 }
		oLst:SetArray( aTitBx )
	
	
		oLst:bLine:={ || {	If( aTitBx[oLst:nAT,1], oOk, oNo ),;//Mark
								aTitBx[oLst:nAT,2],;//Prefixo
								aTitBx[oLst:nAT,3],;//Titulo
								aTitBx[oLst:nAT,4],;//Parcela
								aTitBx[oLst:nAT,5],;//Tipo
								aTitBx[oLst:nAT,6],;//Vl.Titulo
								aTitBx[oLst:nAT,7],;//Vl.Tot.Moip
								aTitBx[oLst:nAT,8],;//Taxa Total
								aTitBx[oLst:nAT,9],;//Valor Fixo
								aTitBx[oLst:nAT,10],;//Porcentagem
								aTitBx[oLst:nAT,11],;//Vl.Liq.Moip
								aTitBx[oLst:nAT,12],;//Qtd. Parcela
								aTitBx[oLst:nAT,13],;//Vl.Baixa
								aTitBx[oLst:nAT,14],;//Cod.Cliente
								aTitBx[oLst:nAT,15],;//Loja
								aTitBx[oLst:nAT,16],;//Nome
								aTitBx[oLst:nAT,17],;//PV CIASHOP
								aTitBx[oLst:nAT,18],;//PV Protheus
								aTitBx[oLst:nAT,19],;//Nota Fiscal
								aTitBx[oLst:nAT,20],;//Serie
								aTitBx[oLst:nAT,21];//Posi็ใo do arquivo original
								} } 
        
        nTotSel 	:= GetTotSel(oLst)//Total de registros encontrados
        oTSayTot	:= TSay():New(012,295,{|| "Total Selecionado: "},oDlg,,,,,,.t.) //"Nome"
		oTGetTot	:= TGet():New(010,345,{|u| if(PCount() > 0, nTotSel := u, nTotSel) },oDlg,50,009, "@E 999,999,999,999.99",,0,,,.F.,,.T.,,.F.,{||.F.},.F.,.F.,,.F./*lReadOnly*/,.F.,,,,,, )
        
		
		oLst:bLDblClick := {|| aTitBx[oLst:nAt,1] := !aTitBx[oLst:nAt,1],;
								 Iif(aTitBx[oLst:nAt,1], nTotSel += aTitBx[oLst:nAt,NVALORTIT], nTotSel -= aTitBx[oLst:nAt,NVALORTIT]),;
								 oTGetTot:Refresh(),;
								 oLst:Refresh();  
							}
		oLst:Refresh()
                                                                                    
		oTSayPesq	:= TSay():New(012,05,{|| "Titulo: "},oDlg,,,,,,.t.) //"Nome"
		oTGetPesq	:= TGet():New(010,023,{|u| if(PCount() > 0, cPesq := u, cPesq) },oDlg,80,009, "",,0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F./*lReadOnly*/,.F.,,,,,, )			
		
		
		oButPesq	:= TButton():New(010,105, "Pesquisar",oDlg,{ || PesqTit(@oLst, Alltrim(cPesq)) }, 40,10,,,.F.,.T.,.F.,,.F.,,,.F. )        

	
		oButImpRel	:= TButton():New(235, 295, "Rel.Analise",oDlg,{ ||;
																	LJMsgRun("Aguarde o processamento...","Aguarde...", {|| u_NCBXTMP2(aTitBx, lBxEcom)});
																	 }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )
																	 	
		oButBxTit		:= TButton():New(235, 330, "Bx.Titulo"	,oDlg,{ || nRet := 2, oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )		
		oButSair		:= TButton():New(235, 365, "Sair"		,oDlg,{ || nRet := 3, oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )	
	
	ACTIVATE MSDIALOG oDlg CENTERED 
EndIf

//Chama a rotina para efetuar a baixa do titulo
If nRet == 2
	If Aviso("Aten็ใo", "Deseja realmente efetuar a baixa dos tํtulos ?",{"Sim","Nใo"},2) == 1
		aBxTitAux 	:= BxTitulo(aTitBx,cPathArq, lBxEcom, cBco, cAgencia, cContaBc)
		aBxTit		:= {nRet,aBxTitAux} 	
	Else
		nRet := 0
	EndIf
Else
	aBxTit := {nRet,{}}
EndIf

RestArea(aArea)
Return aBxTit


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGetTotSel	บAutor  ณElton C.		     บ Data ณ  05/01/2015 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna o valor total selecionado						  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetTotSel(oLst)

Local aArea := GetArea()
Local nX	:= 0
Local nRet	:= 0

Default oLst	:= Nil 

For nX := 1 To Len(oLst:aArray)
	nRet += oLst:aArray[nX][NVALORTIT]	
Next


RestArea(aArea)
Return nRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPesqTit	บAutor  ณElton C.		     บ Data ณ  05/01/2015 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Pesquisa titulos											  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PesqTit(oLst, cPesq)

Local aArea		:= GetArea()
Local cChaveAux	:= ""
Local nX			:= 0
Local lAchou		:= .F.	

Default oLst 	:= Nil           
Default cPesq   := ""


//Verifica abaixo 
For nX := oLst:nAt To Len(oLst:aArray)

   	cChaveAux := oLst:aArray[nX][NPREFIXOT]+oLst:aArray[nX][NTITULO]+oLst:aArray[nX][NPARCELA]+oLst:aArray[nX][NTIPO]
	
	If Alltrim(cPesq) $ Alltrim(cChaveAux)
		oLst:nAt 	:= nX
		lAchou		:= .T.
		Exit
	EndIf
Next

//Se nใo encontrou na pesquisa acima (Pesquisar abaixo), entใo verifica todo o array
If !lAchou
	For nX := 1 To Len(oLst:aArray)

		cChaveAux := oLst:aArray[nX][2]+oLst:aArray[nX][3]+oLst:aArray[nX][4]+oLst:aArray[nX][5]
		
		If Alltrim(cPesq) $ Alltrim(cChaveAux)
			oLst:nAt 	:= nX
			lAchou		:= .T.
			Exit
		EndIf
	Next
EndIf

     
If !lAchou
	Aviso("Aten็ใo", "Nenhum registro encontrado para a pesquisa: "+Alltrim(cPesq),{"Ok"},2)
EndIf	                                                        


RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณBxTitulo	บAutor  ณElton C.		     บ Data ณ  05/01/2015 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna utilizada para baxar os titulos					  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function BxTitulo(aTitBx, cPathArq, lBxEcom,cBco, cAgencia, cContaBc)

Local aArea 		:= GetArea()
Local cNameArqDes	:= ""
Local cMsgAuto		:= ""
Local nX			:= 0

Default aTitBx		:= {} 
Default cPathArq	:= ""                     
Default lBxEcom		:= .T.
Default cBco		:= "" 
Default cAgencia	:= "" 
Default cContaBc	:= ""

//Numero do processo de importa็ใo
cNumLote 	:= GetSXENum("PZH","PZH_SEQARQ")
ConfirmSX8()

cNameArqDes	:= cNumLote+"_"+ DtoS(Date())+STRTRAN(Time(), ":", "")+".csv"

ProcRegua(Len(aTitBx))

For nX := 1 To Len(aTitBx)
	
	IncProc("Processando a baixa do titulo: "+aTitBx[nX, NTITULO])
	
	//Desconsidera os nao marcados
	If !( aTitBx[nX, 01] )
		
		//Preenche o status do arquivo
		aTitBx[nX][NSTATUSBX] 	:= "NAO BAIXADO"
		aTitBx[nX][NOBSERVACAO] 	:= "Item desmarcado na tela de visualiza็ใo dos tํtulos"
		Loop
	EndIf
	
	//Variaveis auxiliares
	cMsgAuto	:= ""
	
		//Chama a rotina de baixa dos titulos
		cMsgAuto += BxTitMoip(aTitBx[nX][NPREFIXOT],;//Prefixo
								aTitBx[nX][NTITULO],;//Numero Titulo
								aTitBx[nX][NPARCELA],;//Parcela
								aTitBx[nX][NTIPO],;//Tipo
								aTitBx[nX][NIDMOIP],;//Id Moip
								aTitBx[nX][NVALORBAIXA],;//Valor da baixa
								aTitBx[nX][NVALORABT],;//Valor de Desconto								
								cBco,;//Banco
								cAgencia,;//Agencia
								cContaBc)//Conta bancaria
		
		If Empty(cMsgAuto)
			aTitBx[nX][NSTATUSBX] 	:= "BAIXADO"
			aTitBx[nX][NOBSERVACAO] 	:= "Titulo baixado com sucesso"
		Else
			aTitBx[nX][NSTATUSBX] 	:= "NAO BAIXADO"
			aTitBx[nX][NOBSERVACAO] 	:= "Erro ao baixar titulo: "+CRLF+Alltrim(cMsgAuto)+CRLF
		EndIf
	
	
	
	If Empty(cMsgAuto)
		
		//Chama a rotina para grava็ใo dos titulos na tabela intermediaria
		GrvBxTPzh(aTitBx[nX][NPREFIXOT],;	//Prefixo
					aTitBx[nX][NTITULO],;	//Titulo
					aTitBx[nX][NPARCELA],;	//Parcela
					aTitBx[nX][NTIPO],;		//Tipo
					aTitBx[nX][NNATUREZA],;	//Natureza
					aTitBx[nX][NVALORTIT],; //Valor Titulo
					,; 						//Valor Total Bruto MOIP
					aTitBx[nX][NTAXAMOIP],; //Taxa do Moip
					aTitBx[nX][NVALORFIXO],;//Valor Fixo Moip
					aTitBx[nX][NPERCENT],;	//Percentual Moip
					,;						//Valor Liquido Moip
					GetInfTit(aTitBx[nX][NPREFIXOT],aTitBx[nX][NTITULO],aTitBx[nX][NPARCELA],aTitBx[nX][NTIPO],"E1_SALDO"),;//Saldo restante atual
					aTitBx[nX][NVALORBAIXA],;//Valor da baixa
					Iif(lBxEcom ,aTitBx[nX][NPEDIDOCIA], 0),;//Pedido CIASHOP
					aTitBx[nX][NPVPROTHEUS],;	//Pedido Protheus
					aTitBx[nX][NNOTAFISCAL],;	//Nota fiscal
					aTitBx[nX][NSERIE],;		//Serie
					aTitBx[nX][NCODCLIENTE],;	//Codigo do cliente
					aTitBx[nX][NLOJA],;			//Loja
					aTitBx[nX][NNOMEREDUZ],; 	//Nome do cliente
					aTitBx[nX][NIDMOIP],; 		//Id MOIP
					"1",;						// E-COMMERCE ou Venda a Vista
					dDataBase,;					//Dt.Baixa
					Time(),;					//Hora
					cUserName,;					//Usuario
					"",; 						//Observa็ใo
					,;							//Forma de Pagto moip
					,;							//Qtd.Parcela moip
					,; 							//Nome comprador Moip
					,;							//CPF MOIP
					,; 							//Email comprador moip
					cNumLote,; 					//Numero do lote de processamento
					cNameArqDes,; 				//Nome do arquivo
					GetComputerName(),;			//Nome da maquina do usuario que esta efetuando a baixa
					aTitBx[nX][NDIFPROTMOI]) 	//Valor de diferen็a entre o moip e protheus
					
	EndIf
Next

If !Empty(cNameArqDes)

	//Gravar o arquivo da baixa
	CopArqMSrv(cPathArq, cNumLote, cNameArqDes)
EndIf

RestArea(aArea)
Return aTitBx

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGetBxEco	บAutor  ณElton C.		     บ Data ณ  05/01/2015 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna os titulos a serem baixados referentes os titulos  บฑฑ
ฑฑบ          ณ do E-commerce                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetBxEco(cNumPVCIA, aTitBx, nVlTotMoip, nTxTotal, nVlFixo, nPerc, nVlLiq, nQtdParc, nVlBaixa, nPosArq, cIdMoip)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmp		:= GetNextAlias()
Local nValorAbt		:= 0
Local nVlMSaldo		:= 0
Local nQtdParcAux	:= 0
Local nTxTotalAux	:= 0
Local nVlFixoAux	:= 0
Local nPercAux		:= 0
Local nDifPrtMoip	:= 0
Local nSaldoAux		:= 0


Default cNumPVCIA	:= ""
Default aTitBx		:= {}                                                                
Default nVlTotMoip	:= 0 
Default nTxTotal	:= 0 
Default nPerc		:= 0 
Default nVlLiq		:= 0 
Default nQtdParc	:= 0                            
Default nVlFixo		:= 0
Default nVlBaixa	:= 0
Default nPosArq		:= 0
Default cIdMoip		:= ""

cQuery	:= " SELECT DISTINCT ZC5_NUM, ZC5_NUMPV, "+CRLF
cQuery	+= "        F2_DOC, F2_SERIE, "+CRLF
cQuery	+= "         A1_COD, A1_LOJA, A1_NREDUZ, "+CRLF
cQuery	+= "         E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_NATUREZ, E1_VALOR, E1_SALDO  "+CRLF
cQuery	+= "         FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SD2")+" SD2 "+CRLF
cQuery	+= " ON SD2.D2_FILIAL = '"+xFilial("SD2")+"' "+CRLF
cQuery	+= " AND SD2.D2_PEDIDO = ZC5.ZC5_NUMPV "+CRLF
cQuery	+= " AND SD2.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SF2")+" SF2 "+CRLF
cQuery	+= " ON SF2.F2_FILIAL = SD2.D2_FILIAL "+CRLF
cQuery	+= " AND SF2.F2_DOC = SD2.D2_DOC "+CRLF
cQuery	+= " AND SF2.F2_SERIE = SD2.D2_SERIE "+CRLF
cQuery	+= " AND SF2.F2_CLIENTE = SD2.D2_CLIENTE "+CRLF
cQuery	+= " AND SF2.F2_LOJA = SD2.D2_LOJA "+CRLF
cQuery	+= " AND SF2.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery	+= " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery	+= " AND SA1.A1_COD = SD2.D2_CLIENTE "+CRLF
cQuery	+= " AND SA1.A1_LOJA = SD2.D2_LOJA "+CRLF
cQuery	+= " AND SA1.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SE1")+" SE1 "+CRLF
cQuery	+= " ON SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery	+= " AND SE1.E1_PREFIXO = SF2.F2_PREFIXO "+CRLF
cQuery	+= " AND SE1.E1_NUM = SF2.F2_DUPL "+CRLF
cQuery	+= " AND SE1.E1_CLIENTE = SF2.F2_CLIENTE "+CRLF
cQuery	+= " AND SE1.E1_LOJA = SF2.F2_LOJA "+CRLF
cQuery	+= " AND SE1.E1_SALDO != 0 "+CRLF
cQuery	+= " AND NOT EXISTS(SELECT * FROM "+RetSqlName("PZH")+" PZH "+CRLF
cQuery	+= "                 WHERE PZH.PZH_FILIAL = '"+xFilial("PZH")+"' "+CRLF
cQuery	+= "                 AND PZH.PZH_PREFIX = SE1.E1_PREFIXO "+CRLF
cQuery	+= "                 AND PZH.PZH_NUM = SE1.E1_NUM "+CRLF
cQuery	+= "                 AND PZH.PZH_PARCEL = SE1.E1_PARCELA "+CRLF
cQuery	+= "                 AND PZH.PZH_TIPO = SE1.E1_TIPO "+CRLF
cQuery	+= "                 AND PZH.PZH_SALDO = 0 "+CRLF
cQuery	+= " 				 AND PZH.PZH_ESTORN != 'S'"+CRLF
cQuery	+= "                 AND PZH.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= "                ) "+CRLF            

cQuery	+= "  AND SE1.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " WHERE ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
cQuery	+= " AND ZC5.ZC5_NUM = "+cNumPVCIA+" "+CRLF
cQuery	+= " AND ZC5.ZC5_NOTA != ' ' "+CRLF
cQuery	+= " AND ZC5.ZC5_NOTA != 'XXXXXXXXX' "+CRLF
cQuery	+= " AND ZC5.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " ORDER BY ZC5_NUM, ZC5_NUMPV, E1_PREFIXO, E1_NUM, E1_PARCELA "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( { || nQtdParcAux++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )

If nQtdParcAux > 0
	
	//Valor total MOIP
	nVlMSaldo	:= nVlTotMoip
	
	//Valor da taxa por parcela
	nTxTotalAux	:= round(nTxTotal / nQtdParcAux, TAMSX3("E1_VALOR")[2])
	
	//Valor fixo por parcela
	nVlFixoAux	:= 0//round(nVlFixo  / nQtdParcAux, TAMSX3("E1_VALOR")[2])
	
	//Valor de abatimento por parcela
	nValorAbt := nVlFixoAux + nTxTotalAux
EndIf


While (cArqTmp)->(!Eof())
	
	nDifPrtMoip := 0
	nVlBaixa	:= 0
		
	//Verifica se existe saldo a ser utilizado para baixar o titulo
	If nVlMSaldo > 0
		
		//Consome o saldo do moip
		nVlMSaldo	-= (cArqTmp)->E1_VALOR            
		
		//Preenchimento do valor da baixa (Valor Titulo - Valor Abatimento)
		nVlBaixa	:= (cArqTmp)->E1_VALOR - nValorAbt
		
		
		//Verifica se o saldo foi consumido completamente
		If nVlMSaldo < 0 .And. nVlMSaldo >= -0.30         
		    
			//Preenchimento da diferen็a entre o moip e o Protheus
			nDifPrtMoip := nVlMSaldo//Retira o sinal de negativo do numero
						
		ElseIf nVlMSaldo < 0 .And. nVlMSaldo < -0.30//Verifica se o valor da diferen็a ultrapassa o limite permitido
			loop
		EndIf


		//Verifica se o valor da baixa + abatimento ้ maior que o valor do titulo
		If (nVlBaixa + nValorAbt) > (cArqTmp)->E1_VALOR 
			nDifPrtMoip := 	(cArqTmp)->E1_VALOR - (nVlBaixa + nValorAbt)
			nValorAbt	+= nDifPrtMoip //Retira a diferen็a do abatimento

		ElseIf ((nVlBaixa + nValorAbt) < (cArqTmp)->E1_VALOR) .And. ((cArqTmp)->E1_VALOR - (nVlBaixa + nValorAbt)) < 0.30
		
			nDifPrtMoip := 	((nVlBaixa + nValorAbt) - (cArqTmp)->E1_VALOR)
			nVlBaixa	+= nDifPrtMoip //Inclui o valor da diferen็a
		EndIf

		
		//Adiciona o registro no array de processamento
		aAdd(aTitBx, {.T.,; //Registro selecionado
						(cArqTmp)->E1_PREFIXO,;//Prefixo
						(cArqTmp)->E1_NUM,;//Numero do titulo
						(cArqTmp)->E1_PARCELA,;//Parcela
						(cArqTmp)->E1_TIPO,;//Tipo
						(cArqTmp)->E1_NATUREZ,;//Natureza
						(cArqTmp)->E1_VALOR,;//Valor do titulo
						nTxTotalAux,;//Taxa Total
						nVlFixoAux,;//ValorFixo
						nPercAux,;//Porcentagem
						nValorAbt,;//Valor de Abatimento
						nVlBaixa,;//Vl.a ser baixado
						nDifPrtMoip,;//Diferen็a entre 
						(cArqTmp)->A1_COD,;//Codigo do cliente
						(cArqTmp)->A1_LOJA,;//Loja
						(cArqTmp)->A1_NREDUZ,;//Nome reduzido
						(cArqTmp)->ZC5_NUM,;//Numero do pedido CIASHOP
						(cArqTmp)->ZC5_NUMPV,;//Numero do pedido protheus
						(cArqTmp)->F2_DOC,;//Nota fiscal de saida
						(cArqTmp)->F2_SERIE,;//Serie
						cIdMoip,;//Id Moip
						nPosArq,;//Posi็ใo do arquivo original
						"",;//Status
						"";//Observa็ใo
						} )
						
		
	EndIf
	
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGetBxVA	บAutor  ณElton C.		     บ Data ณ  05/01/2015 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna os titulos a serem baixados referentes a			  บฑฑ
ฑฑบ          ณ venda a vista                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetBxVA(aTitBx, nVlTotMoip, nTxTotal, nVlFixo, nPerc, nVlLiq, nQtdParc, nVlBaixa, nPosArq, cIdMoip, cPrefixo, cTitulo, cTipo)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmp		:= GetNextAlias()
Local nValorAbt		:= 0
Local nVlMSaldo		:= 0
Local nQtdParcAux	:= 0
Local nTxTotalAux	:= 0
Local nVlFixoAux	:= 0
Local nPercAux		:= 0
Local nDifPrtMoip	:= 0
Local nSaldoAux		:= 0


Default aTitBx		:= {}                                                                
Default nVlTotMoip	:= 0 
Default nTxTotal	:= 0 
Default nPerc		:= 0 
Default nVlLiq		:= 0 
Default nQtdParc	:= 0                            
Default nVlFixo		:= 0
Default nVlBaixa	:= 0
Default nPosArq		:= 0
Default cIdMoip		:= ""
Default cPrefixo	:= "" 
Default cTitulo		:= "" 
Default cTipo		:= ""


cQuery	:= " SELECT DISTINCT F2_DOC, F2_SERIE, D2_PEDIDO, "+CRLF
cQuery	+= "         A1_COD, A1_LOJA, A1_NREDUZ, "+CRLF
cQuery	+= "         E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_NATUREZ, E1_VALOR, E1_SALDO  "	+CRLF
cQuery	+= "         FROM "+RetSqlName("SE1")+" SE1 "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SF2")+" SF2 "+CRLF
cQuery	+= " ON SF2.F2_FILIAL = '"+xFilial("SF2")+"' "+CRLF
cQuery	+= " AND SF2.F2_PREFIXO = SE1.E1_PREFIXO "+CRLF
cQuery	+= " AND SF2.F2_DUPL = SE1.E1_NUM "+CRLF
cQuery	+= " AND SF2.F2_CLIENTE = SE1.E1_CLIENTE "+CRLF
cQuery	+= " AND SF2.F2_LOJA = SE1.E1_LOJA "+CRLF
cQuery	+= " AND SF2.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SD2")+" SD2  "+CRLF
cQuery	+= " ON SD2.D2_FILIAL = SF2.F2_FILIAL  "+CRLF
cQuery	+= " AND SD2.D2_DOC = SF2.F2_DOC "+CRLF
cQuery	+= " AND SD2.D2_SERIE = SF2.F2_SERIE "+CRLF
cQuery	+= " AND SD2.D2_CLIENTE = SF2.F2_CLIENTE "+CRLF
cQuery	+= " AND SD2.D2_LOJA = SF2.F2_LOJA "+CRLF
cQuery	+= " AND SD2.D_E_L_E_T_ = ' '  "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SA1")+" SA1  "+CRLF
cQuery	+= " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"'  "+CRLF
cQuery	+= " AND SA1.A1_COD = SD2.D2_CLIENTE  "+CRLF
cQuery	+= " AND SA1.A1_LOJA = SD2.D2_LOJA  "+CRLF
cQuery	+= "  AND SA1.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"'  "+CRLF
cQuery	+= " AND SE1.E1_PREFIXO =  '"+cPrefixo+"' "+CRLF
cQuery	+= " AND SE1.E1_NUM =  '"+cTitulo+"' "+CRLF
cQuery	+= " AND SE1.E1_TIPO = '"+cTipo+"' "+CRLF
cQuery	+= " AND SE1.E1_SALDO != 0  "+CRLF
cQuery	+= " AND NOT EXISTS(SELECT * FROM "+RetSqlName("PZH")+" PZH  "+CRLF
cQuery	+= "                 WHERE PZH.PZH_FILIAL = '"+xFilial("PZH")+"'  "+CRLF
cQuery	+= "                 AND PZH.PZH_PREFIX = SE1.E1_PREFIXO "+CRLF
cQuery	+= "                 AND PZH.PZH_NUM = SE1.E1_NUM "+CRLF
cQuery	+= "                 AND PZH.PZH_PARCEL = SE1.E1_PARCELA  "+CRLF
cQuery	+= "                 AND PZH.PZH_TIPO = SE1.E1_TIPO "+CRLF
cQuery	+= "                 AND PZH.PZH_SALDO = 0  "+CRLF
cQuery	+= " 				 AND PZH.PZH_ESTORN != 'S' "+CRLF
cQuery	+= "                 AND PZH.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= "                )  "+CRLF

cQuery	+= " AND SE1.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " ORDER BY E1_PREFIXO, E1_NUM, E1_PARCELA  "+CRLF


dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( { || nQtdParcAux++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )

If nQtdParcAux > 0
	
	//Valor total MOIP
	nVlMSaldo	:= nVlTotMoip
	
	//Valor da taxa por parcela
	nTxTotalAux	:= round(nTxTotal / nQtdParcAux, TAMSX3("E1_VALOR")[2])
	
	//Valor fixo por parcela
	nVlFixoAux	:= 0//round(nVlFixo  / nQtdParcAux, TAMSX3("E1_VALOR")[2])
	
	//Valor de abatimento por parcela
	nValorAbt := nVlFixoAux + nTxTotalAux
EndIf


While (cArqTmp)->(!Eof())
	
	nDifPrtMoip := 0
	nVlBaixa	:= 0
		
	//Verifica se existe saldo a ser utilizado para baixar o titulo
	If nVlMSaldo > 0
		
		//Consome o saldo do moip
		nVlMSaldo	-= (cArqTmp)->E1_VALOR            
		
		//Preenchimento do valor da baixa (Valor Titulo - Valor Abatimento)
		nVlBaixa	:= (cArqTmp)->E1_VALOR - nValorAbt
		
		
		//Verifica se o saldo foi consumido completamente
		If nVlMSaldo < 0 .And. nVlMSaldo >= -0.30         
		    
			//Preenchimento da diferen็a entre o moip e o Protheus
			nDifPrtMoip := nVlMSaldo//Retira o sinal de negativo do numero
						
		ElseIf nVlMSaldo < 0 .And. nVlMSaldo < -0.30//Verifica se o valor da diferen็a ultrapassa o limite permitido
			loop
		EndIf


		//Verifica se o valor da baixa + abatimento ้ maior que o valor do titulo
		If (nVlBaixa + nValorAbt) > (cArqTmp)->E1_VALOR 
			nDifPrtMoip := 	(cArqTmp)->E1_VALOR - (nVlBaixa + nValorAbt)
			nValorAbt	+= nDifPrtMoip //Retira a diferen็a do abatimento

		ElseIf ((nVlBaixa + nValorAbt) < (cArqTmp)->E1_VALOR) .And. ((cArqTmp)->E1_VALOR - (nVlBaixa + nValorAbt)) < 0.30
		
			nDifPrtMoip := 	((nVlBaixa + nValorAbt) - (cArqTmp)->E1_VALOR)
			nVlBaixa	+= nDifPrtMoip //Inclui o valor da diferen็a
		EndIf

		
		//Adiciona o registro no array de processamento
		aAdd(aTitBx, {.T.,; //Registro selecionado
						(cArqTmp)->E1_PREFIXO,;//Prefixo
						(cArqTmp)->E1_NUM,;//Numero do titulo
						(cArqTmp)->E1_PARCELA,;//Parcela
						(cArqTmp)->E1_TIPO,;//Tipo
						(cArqTmp)->E1_NATUREZ,;//Natureza
						(cArqTmp)->E1_VALOR,;//Valor do titulo
						nTxTotalAux,;//Taxa Total
						nVlFixoAux,;//ValorFixo
						nPercAux,;//Porcentagem
						nValorAbt,;//Valor de Abatimento
						nVlBaixa,;//Vl.a ser baixado
						nDifPrtMoip,;//Diferen็a entre 
						(cArqTmp)->A1_COD,;//Codigo do cliente
						(cArqTmp)->A1_LOJA,;//Loja
						(cArqTmp)->A1_NREDUZ,;//Nome reduzido
						0,;//Numero do pedido CIASHOP
						(cArqTmp)->D2_PEDIDO,;//Numero do pedido protheus
						(cArqTmp)->F2_DOC,;//Nota fiscal de saida
						(cArqTmp)->F2_SERIE,;//Serie
						cIdMoip,;//Id Moip
						nPosArq,;//Posi็ใo do arquivo original
						"",;//Status
						"";//Observa็ใo
						} )
						
		
	EndIf
	
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณVldImpIt	บAutor  ณElton C.		     บ Data ณ  17/02/2012 	บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida็ใo dos itens a serem importados					  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldImpIt(aArqImp, nLin, lBxEcom)

Local aArea 	:= GetArea()
Local lRet		:= .T.

Default aArqImp	:= {} 
Default nLin	:= 0                   
Default lBxEcom := .T.

//Verifica se o ID do MOIP estแ preenchido
If Empty(aArqImp[nLin][IDMOIP])
	aArqImp[nLin][OBSERVACAO] := "Id Moip nao preenchido"
	lRet 	:= .F.
EndIf

If lBxEcom
	//Verifica se o ID do Proprio estแ preenchido
	If Empty(aArqImp[nLin][PVCIASHOP])
		aArqImp[nLin][OBSERVACAO] := "Id Proprio nao preenchido"
		lRet 	:= .F.
	
	ElseIf !VldPVCia( Alltrim(Str(aArqImp[nLin][PVCIASHOP])) ) //Verifica se o pedido existe
		aArqImp[nLin][OBSERVACAO] := "Pedido CIASHOP nao encontrado na base de dados"
		lRet 	:= .F.
	EndIf  
Else

	//Verifica se o prefixo do titulo foi preenchido
	If Empty(aArqImp[nLin][PREFIXO])
		aArqImp[nLin][OBSERVACAO] := "Prefixo nao preenchido"
		lRet 	:= .F.
	EndIf

	//Verifica se o numero do titulo foi preenchido
	If Empty(aArqImp[nLin][TITULO])
		aArqImp[nLin][OBSERVACAO] := "Titulo nao preenchido"
		lRet 	:= .F.
	EndIf

	//Verifica se o tipo do titulo foi preenchido
	If Empty(aArqImp[nLin][TIPO])
		aArqImp[nLin][OBSERVACAO] := "Tipo nao preenchido"
		lRet 	:= .F.
	EndIf
	
	//Verifica se o titulo existe     
	If lRet
	    DbSelectArea("SE1") 
		DbSetOrder(1)
        If !SE1->(MsSeek(xFilial("SE1") + PADR(aArqImp[nLin][PREFIXO],TAMSX3("E1_PREFIXO")[1]) + PADR(aArqImp[nLin][TITULO],TAMSX3("E1_NUM")[1]) ))
			aArqImp[nLin][OBSERVACAO] := "Titulo nao encontrado"
			lRet 	:= .F.			        
		EndIf        
	
	EndIf
	

EndIf

//Verifica se o Valor Bruto do moip foi preenchido
If aArqImp[nLin][VALORMOIP] <= 0	
	aArqImp[nLin][OBSERVACAO] := "Valor total nใo preenchido ou igual a 0"
	lRet 	:= .F.

Endif

RestArea(aArea)
Return lRet
           
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณVldPVCia	บAutor  ณElton C.		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida็ใo do PV CIASHOP									  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldPVCia(cCodCia)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local lRet	:= .F.

Default cCodCia := ""


cQuery    := " SELECT * FROM "+RetSqlName("ZC5")
cQuery    += " WHERE ZC5_FILIAL = '"+xFilial("ZC5")+"' "
cQuery    += " AND ZC5_NUM = "+cCodCia+" "
cQuery    += " AND D_E_L_E_T_ = ' ' "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

If (cArqTmp)->(!Eof())
	lRet := .T.
Else
	lRet := .F.	
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWrTXMLArq  บAutor  ณMicrosiga         บ Data ณ  01/30/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna os dados do XML a ser gravado no relat๓rio do Excelบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                  	      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/            
Static Function WrTXMLArq(nOpc, apExcel, nQtdReg, cLinArq, cStatus, cIdMoip, cPvCia, cPrefixo, cNumTit, cParcela, cTipo, cNaturez, cCodCli, cLoja,;
							cNomeCli, cVlTit, cTxMoip, cVlFixo, cPerc, cVlBaixa, cPvProth, cNF, cSerie, cObs)
								

Default nOpc 		:= 1
Default apExcel 	:= {}                  
Default nQtdReg		:= 1    

Default cLinArq	 :=""
Default cStatus	 :=""
Default cIdMoip	 :=""
Default cPvCia	 :=""
Default cPrefixo :=""
Default cNumTit	 :=""
Default cParcela :=""
Default cTipo	 :=""
Default cNaturez :=""
Default cCodCli	 :=""
Default cLoja	 :=""
Default cNomeCli :=""
Default cVlTit	 :=""
Default cTxMoip	 :=""
Default cVlFixo	 :=""
Default cPerc	 :=""
Default cVlBaixa :=""
Default cPvProth :=""
Default cNF		 :=""
Default cSerie	 :=""
Default cObs	 :=""


If nOpc == 1//Cabe็alho

	Aadd(apExcel, '<?xml version="1.0"?>'+CRLF)
	Aadd(apExcel, '<?mso-application progid="Excel.Sheet"?>'+CRLF)
	Aadd(apExcel, '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF)
	Aadd(apExcel, ' xmlns:o="urn:schemas-microsoft-com:office:office"'+CRLF)
	Aadd(apExcel, ' xmlns:x="urn:schemas-microsoft-com:office:excel"'+CRLF)
	Aadd(apExcel, ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF)
	Aadd(apExcel, ' xmlns:html="http://www.w3.org/TR/REC-html40">'+CRLF)
	Aadd(apExcel, ' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+CRLF)
	Aadd(apExcel, '  <Author>NC GAMES</Author>'+CRLF)
	Aadd(apExcel, '  <LastAuthor>Elton da Cunha Santana</LastAuthor>'+CRLF)
	Aadd(apExcel, '  <Created>2015-01-08T18:49:10Z</Created>'+CRLF)
	Aadd(apExcel, '  <LastSaved>2015-01-23T16:53:02Z</LastSaved>'+CRLF)
	Aadd(apExcel, '  <Version>12.00</Version>'+CRLF)
	Aadd(apExcel, ' </DocumentProperties>'+CRLF)
	Aadd(apExcel, ' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF)
	Aadd(apExcel, '  <WindowHeight>8010</WindowHeight>'+CRLF)
	Aadd(apExcel, '  <WindowWidth>20115</WindowWidth>'+CRLF)
	Aadd(apExcel, '  <WindowTopX>240</WindowTopX>'+CRLF)
	Aadd(apExcel, '  <WindowTopY>30</WindowTopY>'+CRLF)
	Aadd(apExcel, '  <ProtectStructure>False</ProtectStructure>'+CRLF)
	Aadd(apExcel, '  <ProtectWindows>False</ProtectWindows>'+CRLF)
	Aadd(apExcel, ' </ExcelWorkbook>'+CRLF)
	Aadd(apExcel, ' <Styles>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="Default" ss:Name="Normal">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Vertical="Bottom"/>'+CRLF)
	Aadd(apExcel, '   <Borders/>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   <Interior/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat/>'+CRLF)
	Aadd(apExcel, '   <Protection/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s49" ss:Name="Separador de milhares">'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="_-* #,##0.00_-;\-* #,##0.00_-;_-* &quot;-&quot;??_-;_-@_-"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s58">'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s59">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Vertical="Bottom"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s60">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#538ED5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s61">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Vertical="Bottom"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#538ED5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s62">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Vertical="Bottom"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#538ED5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s63">'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s64" ss:Parent="s49">'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s65">'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, ' </Styles>'+CRLF)
	Aadd(apExcel, ' <Worksheet ss:Name="Log">'+CRLF)
	Aadd(apExcel, '  <Table ss:ExpandedColumnCount="21" ss:ExpandedRowCount="'+Alltrim(Str(nQtdReg))+'" x:FullColumns="1"'+CRLF)
	Aadd(apExcel, '   x:FullRows="1" ss:DefaultColumnWidth="77.25" ss:DefaultRowHeight="15">'+CRLF)
	Aadd(apExcel, '   <Column ss:Width="87"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:AutoFitWidth="0" ss:Width="119.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:AutoFitWidth="0" ss:Width="105.75"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:AutoFitWidth="0" ss:Width="92.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s58" ss:AutoFitWidth="0" ss:Span="6"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:Index="12" ss:StyleID="s58" ss:AutoFitWidth="0" ss:Width="233.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:Index="18" ss:StyleID="s58" ss:Width="83.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s58" ss:AutoFitWidth="0" ss:Width="74.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s58" ss:Width="29.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s58" ss:AutoFitWidth="0" ss:Width="309.75"/>'+CRLF)
	Aadd(apExcel, '   <Row ss:AutoFitHeight="0" ss:StyleID="s59">'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s60"><Data ss:Type="String">Linha Arq.Origem</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s61"><Data ss:Type="String">Status</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s61"><Data ss:Type="String">Id Moip</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s61"><Data ss:Type="String">Id Proprio</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s62"><Data ss:Type="String">Prefixo</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s62"><Data ss:Type="String">Titulo</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s62"><Data ss:Type="String">Parcela</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s62"><Data ss:Type="String">Tipo</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s62"><Data ss:Type="String">Natureza</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s62"><Data ss:Type="String">Cod.Cliente</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s62"><Data ss:Type="String">Loja</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s62"><Data ss:Type="String">Nome</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s61"><Data ss:Type="String">Valor Titulo</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s61"><Data ss:Type="String">Taxa Total</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s61"><Data ss:Type="String">Valor Fixo </Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s61"><Data ss:Type="String">Porcentagem</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s61"><Data ss:Type="String">Valor da Baixa</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s62"><Data ss:Type="String">Pedido Protheus</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s62"><Data ss:Type="String">Nota fiscal</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s62"><Data ss:Type="String">Serie</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s62"><Data ss:Type="String">Observaรงรฃo</Data></Cell>'+CRLF)
	Aadd(apExcel, '   </Row>	'+CRLF)
	
ElseIf nOpc == 2//Conteudo
	
	Aadd(apExcel, '	<Row ss:AutoFitHeight="0">'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s63"><Data ss:Type="Number">'+cLinArq+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s63"><Data ss:Type="String">'+cStatus+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s63"><Data ss:Type="Number">'+cIdMoip+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s63"><Data ss:Type="Number">'+cPvCia+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s65"><Data ss:Type="String">'+cPrefixo+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s65"><Data ss:Type="String">'+cNumTit+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s65"><Data ss:Type="String">'+cParcela+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s65"><Data ss:Type="String">'+cTipo+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s65"><Data ss:Type="String">'+cNaturez+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s65"><Data ss:Type="String">'+cCodCli+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s65"><Data ss:Type="String">'+cLoja+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s65"><Data ss:Type="String">'+cNomeCli+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s64"><Data ss:Type="Number">'+cVlTit+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s64"><Data ss:Type="Number">'+cTxMoip+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s64"><Data ss:Type="Number">'+cVlFixo+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s63"><Data ss:Type="Number">'+cPerc+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s64"><Data ss:Type="Number">'+cVlBaixa+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s65"><Data ss:Type="String">'+cPvProth+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s65"><Data ss:Type="String">'+cNF+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s65"><Data ss:Type="String">'+cSerie+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s65"><Data ss:Type="String">'+cObs+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '   </Row>'+CRLF)

ElseIf nOpc == 3//Rodap้
	
	Aadd(apExcel, '  </Table>'+CRLF)
	Aadd(apExcel, '  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF)
	Aadd(apExcel, '   <PageSetup>'+CRLF)
	Aadd(apExcel, '    <Header x:Margin="0.31496062000000002"/>'+CRLF)
	Aadd(apExcel, '    <Footer x:Margin="0.31496062000000002"/>'+CRLF)
	Aadd(apExcel, '    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+CRLF)
	Aadd(apExcel, '     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+CRLF)
	Aadd(apExcel, '   </PageSetup>'+CRLF)
	Aadd(apExcel, '   <Unsynced/>'+CRLF)
	Aadd(apExcel, '   <Print>'+CRLF)
	Aadd(apExcel, '    <ValidPrinterInfo/>'+CRLF)
	Aadd(apExcel, '    <PaperSizeIndex>9</PaperSizeIndex>'+CRLF)
	Aadd(apExcel, '    <HorizontalResolution>600</HorizontalResolution>'+CRLF)
	Aadd(apExcel, '    <VerticalResolution>600</VerticalResolution>'+CRLF)
	Aadd(apExcel, '   </Print>'+CRLF)
	Aadd(apExcel, '   <Selected/>'+CRLF)
	Aadd(apExcel, '   <Panes>'+CRLF)
	Aadd(apExcel, '    <Pane>'+CRLF)
	Aadd(apExcel, '     <Number>3</Number>'+CRLF)
	Aadd(apExcel, '     <ActiveRow>13</ActiveRow>'+CRLF)
	Aadd(apExcel, '     <ActiveCol>4</ActiveCol>'+CRLF)
	Aadd(apExcel, '    </Pane>'+CRLF)
	Aadd(apExcel, '   </Panes>'+CRLF)
	Aadd(apExcel, '   <ProtectObjects>False</ProtectObjects>'+CRLF)
	Aadd(apExcel, '   <ProtectScenarios>False</ProtectScenarios>'+CRLF)
	Aadd(apExcel, '  </WorksheetOptions>'+CRLF)
	Aadd(apExcel, ' </Worksheet>'+CRLF)
	Aadd(apExcel, '</Workbook>'+CRLF)
	
EndIf

Return 




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGeraExcel บAutor  ณElton C.		     บ Data ณ  11/07/2011 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que cria e escreve o arquivo excel.                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GeraExcel(aPlanilha, cNameArq)
	
Local nlHandle
Local clLocal 	:= ""
Local olExcelApp
Local aPerg		:= {}
Local lRet		:= .T.

Default aPlanilha	:= {}               
Default cNameArq	:= ""

aPerg	:= PergFileEx()//Pergunta com o endere็o do arquivo

If Len(aPerg[2] ) > 0
	If !aPerg[1]
		Return
	EndIf
Else
	return
EndIf
clDir := Alltrim(aPerg[2][1])
clLocal := clDir + cNameArq

nlHandle  := FCREATE(clLocal)

If nlHandle == -1
	Aviso("Aten็ใo","Nใo foi possํvel criar o arquivo em: " + CRLF + clLocal,{"Ok"},2)
Else
	AEVAL(aPlanilha, {|x| FWRITE(nlHandle, x)} )
	FCLOSE(nlHandle)
	
	If File(clLocal)
		
		If Aviso("OPENARQ","Deseja abrir o arquivo gerado no Excel ?",{"Sim","Nใo"},2) == 1
			olExcelApp	:= MsExcel():New()
			olExcelApp:WorkBooks:Open(clLocal)
			olExcelApp:SetVisible(.T.)
			olExcelApp:Destroy()
		EndIf
	Else
		Aviso("Aten็ใo","Erro ao criar o arquivo em: " +CRLF+ clLocal,{"Ok"},2)
	Endif
endif

Return lRet     

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPergFile	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPergunta com o endere็o do arquivo				          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergFileEx()

Local aArea 		:= GetArea()
Local alRetPath  	:= {}
Local aParamBox	:= {} 
Local lRet			:= .F.
Local alRet			:= {}		

aAdd( aParamBox ,{6,"Endere็o para gravar o arquivo do Excel","","","ExistDir(&(ReadVar()))","",080,.T.,"","",GETF_LOCALHARD+GETF_NETWORKDRIVE + GETF_RETDIRECTORY})

//Monta a pergunta
lRet := ParamBox(aParamBox ,"Endere็o de arquivo",@alRetPath,,,.T.,50,50,				,			,.T.			,.T.)

alRet := {lRet, alRetPath}

RestArea(aArea)
Return alRet  



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGetVlFmt	บAutor  ณElton C.		     บ Data ณ  05/01/2015 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna o valor formatado 								  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetVlFmt(cVlPlanil)

Local nRet		:= 0 
Local cVlAux    := ""

Default cVlPlanil := ""                         

cVlAux	:= Strtran( cVlPlanil, "R$", "" )
cVlAux	:= Strtran( cVlAux, ".", "" )
cVlAux	:= Strtran( cVlAux , ",", "." )

If !Empty(cVlAux)
	nRet := Val(cVlAux)
Else
	nRet := 0
EndIf     

Return nRet
                        


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGrvBxTPzh	บAutor  ณElton C.		     บ Data ณ  05/01/2015 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Grava a baixa do titulo na tabela PZH					  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvBxTPzh(cPrefixo, cNumTitulo, cParcela, cTipo, cNatureza, nValOrig, nValBrtMoip, nTxMoip, nVlFixoMoip,;
							nPercMoip, nVlLiqMoip, nSaldo, nVlBaixa,nPvCiaShop, cPVProtheus, cNotaFiscal, cSerie, cCodCli, cLoja,;
							cNomeCli, cIdMoip, cTpMop, dDtBaixa, cHora, cUser, cObs, cFormPagM, nQtdParcM, cNomeCompM, cCpfComM,;
							cEmailCM, cSeqArq, cNomeArq, cMaqUser, nVlDif)

Local aArea := GetArea()

Default cPrefixo	:= "" 
Default cNumTitulo	:= "" 
Default cParcela	:= "" 
Default cTipo		:= "" 
Default cNatureza	:= "" 
Default nValOrig	:= 0 
Default nValBrtMoip	:= 0 
Default nTxMoip		:= 0 
Default nVlFixoMoip	:= 0
Default nPercMoip	:= 0 
Default nVlLiqMoip	:= 0 
Default nSaldo		:= 0 
Default nPvCiaShop	:= 0
Default cPVProtheus	:= "" 
Default cNotaFiscal	:= "" 
Default cSerie		:= "" 
Default cCodCli		:= "" 
Default cLoja		:= ""
Default cNomeCli	:= "" 
Default cIdMoip		:= "" 
Default cTpMop		:= "" 
Default dDtBaixa	:= "" 
Default cHora		:= "" 
Default cUser		:= "" 
Default cObs		:= "" 
Default cFormPagM	:= "" 
Default nQtdParcM	:= 0 
Default cNomeCompM	:= "" 
Default cCpfComM	:= ""
Default cEmailCM	:= "" 
Default cSeqArq		:= "" 
Default cNomeArq	:= "" 
Default cMaqUser	:= ""
Default nVlBaixa	:= 0 
Default nVlDif		:= 0

DbSelectArea("PZH")
DbSetOrder(1)
Reclock("PZH",.T.)

PZH->PZH_FILIAL := xFilial("PZH")
PZH->PZH_PREFIX	:= cPrefixo
PZH->PZH_NUM    := cNumTitulo
PZH->PZH_PARCEL := cParcela
PZH->PZH_TIPO   := cTipo
PZH->PZH_NATURE := cNatureza
PZH->PZH_VLORIG := nValOrig
PZH->PZH_VLBRTM := nValBrtMoip
PZH->PZH_TXMOIP := nTxMoip
PZH->PZH_VLFIXM := nVlFixoMoip
PZH->PZH_PERCM  := nPercMoip
PZH->PZH_VLLIQM := nVlLiqMoip
PZH->PZH_SALDO  := nSaldo
PZH->PZH_PVCIA  := nPvCiaShop
PZH->PZH_PVPROT := cPVProtheus
PZH->PZH_NF     := cNotaFiscal
PZH->PZH_SERIE  := cSerie
PZH->PZH_CLIENT := cCodCli
PZH->PZH_LOJA   := cLoja
PZH->PZH_NOME   := cNomeCli
PZH->PZH_IDMOIP := cIdMoip
PZH->PZH_TPMOV 	:= cTpMop
PZH->PZH_DTBAIX := dDtBaixa
PZH->PZH_HORA   := cHora
PZH->PZH_USER   := cUser
PZH->PZH_OBS    := cObs
PZH->PZH_FORMPG := cFormPagM
PZH->PZH_QTDPAR := nQtdParcM
PZH->PZH_NCOMP  := cNomeCompM
PZH->PZH_CPFCOM := cCpfComM
PZH->PZH_EMAILC := cEmailCM
PZH->PZH_SEQARQ := cSeqArq
PZH->PZH_ARQUIV := cNomeArq
PZH->PZH_NMQUSE := cMaqUser  
PZH->PZH_VLBAIX	:= nVlBaixa
PZH->PZH_DIFABT	:= nVlDif 

PZH->(MsUnLock())

RestArea(aArea)
Return                      


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณBxTitMoip	  บ Autor ณ Elton C.		 บ Data ณ  04/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณRotina utilizada para preencher o array com os dados do	  บฑฑ
ฑฑบ          ณ titulo e enviar para rotina automatica	  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function BxTitMoip(cPrefixo, cNumTit, cParcela, cTipo, cIdMoip, nValor, nDescont, cBco, cAgencia, cContaBc)

Local aArea 	:= GetArea()
Local aTitulo   := {}
Local cRet		:= ""

Default cPrefixo	:= "" 
Default cNumTit		:= "" 
Default cParcela	:= "" 
Default cTipo		:= "" 
Default cIdMoip		:= "" 
Default nValor		:= 0 
Default nDescont	:= 0
Default cBco		:= "" 
Default cAgencia	:= "" 
Default cContaBc	:= ""



AADD(aTitulo,	{"E1_PREFIXO"		,cPrefixo 			,Nil } )
AADD(aTitulo,	{"E1_NUM"		 	,cNumTit    		,Nil } )
AADD(aTitulo,	{"E1_PARCELA"	 	,cParcela    		,Nil } )
AADD(aTitulo,	{"E1_TIPO"	    	,cTipo      		,Nil } )
AADD(aTitulo,	{"AUTMOTBX"	    	,"NOR"            	,Nil } )
AADD(aTitulo,	{"AUTBANCO"			,PADR(Alltrim(cBco)		, TAMSX3("E8_BANCO")[1]) 		,Nil } )
AADD(aTitulo,	{"AUTAGENCIA"		,PADR(Alltrim(cAgencia)	, TAMSX3("E8_AGENCIA")[1])	,Nil } )
AADD(aTitulo,	{"AUTCONTA"			,PADR(Alltrim(cContaBc)	, TAMSX3("E8_CONTA")[1])	,Nil } )
AADD(aTitulo,	{"AUTDTBAIXA"	 	,MsDate()        	,Nil } )
AADD(aTitulo,	{"AUTHIST"	    	,"BX.MOIP ID:"+cIdMoip,Nil })
//AADD(aTitulo,	{"AUTJUROS"			,0 					,Nil } )
//AADD(aTitulo,	{"AUTMULTA"			,0 					,Nil } )
//AADD(aTitulo,	{"AUTCM1"			,0					,Nil } )
//AADD(aTitulo,	{"AUTPRORATA"		,0 					,Nil } )
AADD(aTitulo,	{"AUTDESCONT"       ,nDescont			,Nil } )
AADD(aTitulo,	{"AUTVALREC"	 	,nValor			   	,Nil } )

//Chama a rotina para efetuar a baixa do titulo 
cRet := RunBxTitM(aTitulo, 3 )

RestArea(aArea)
Return cRet



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณRunBxTitM	  บ Autor ณ Elton C.		 บ Data ณ  04/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณRotina automatica para baixar os titulos do processados 	  บฑฑ
ฑฑบ          ณpelo moip			  						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                                 
Static Function RunBxTitM(aTitulo, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aTitulo := {} 
Default nOpc	:= 3//Baixa

Begin Transaction
If (Len(aTitulo) > 0)
	
	//Chama a rotina automatica para gravar os dados da nota de entrada
	MSExecAuto({|x,y| FINA070(x,y)},aTitulo,nOpc)
	
	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Os dados informados estใo incorretos. Verifique o preenchimento do mesmo."
EndIf

End Transaction

RestArea(aArea)
Return cRet
                                                                    



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณCopArqMSrv  บ Autor ณ Elton C.		 บ Data ณ  04/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณRotina utilizada para copiar o arquivo de importa็ใo para	  บฑฑ
ฑฑบ          ณServidor			  						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function CopArqMSrv(cPathArqOri, cLote, cNameArqDes)
Local aArea 		:= GetArea()
Local cDirBx		:= "\BxTitMoip\"
Local lRet			:= .F.

Default cPathArqOri	:= "" 
Default cLote		:= "" 
Default cNameArqDes	:= ""

If VerifDir(cDirBx) 
	//Copia o arquivo para o servidor
	lRet := __CopyFile(cPathArqOri, cDirBx+cNameArqDes)
Else          
	Aviso("Aten็ใo","Nใo foi possํvel criar o diret๓rio "+cDirBx+" no servidor",{"Ok"}, 2)
	lRet := .F.
EndIf

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVerifDir  บAutor  ณElton C.		     บ Data ณ  24/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se existe diretorio, se nใo existir cria o mesmo	  บฑฑ
ฑฑบ          ณde acordo com o caminho informado           				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VerifDir(cDir) 

Local aArea 	:= GetArea()
Local lRet		:= .T.

Default cDir 	:= ""

If !EXISTDIR(cDir)
	If MakeDir( cDir ) < 0
		lRet := .F.
		Conout("Erro na cria็ใo do diretorio")
		
		Return lRet
	Else
		lRet := .T.
	EndIf
EndIf

RestArea(aArea)
Return lRet   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetInfTit  บAutor  ณElton C.		     บ Data ณ  24/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a informa็ใo do campo passado por paramento,		  บฑฑ
ฑฑบ          ณ  referente o titulo 				          				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetInfTit(cPrefixo, cNumTit, cParcela, cTipo, cCampo)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local xRet

Default cPrefixo	:= "" 
Default cNumTit		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""                                
Default cCampo		:= ""

cQuery    := " SELECT * FROM "+RetSqlName("SE1")+" SE1 "+CRLF
cQuery    += " WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery    += " AND SE1.E1_PREFIXO = '"+cPrefixo+"' "+CRLF
cQuery    += " AND SE1.E1_NUM = '"+cNumTit+"' "+CRLF
cQuery    += " AND SE1.E1_PARCELA = '"+cParcela+"' "+CRLF
cQuery    += " AND SE1.E1_TIPO = '"+cTipo+"' "+CRLF
cQuery    += " AND D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

If (cArqTmp)->(!Eof())
	xRet := (cArqTmp)->&(cCampo)
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return xRet                         


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCARQBXM  บAutor  ณElton C.		     บ Data ณ  24/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVisualiza็ใo do arquivo de baixa do e-commerce			  บฑฑ
ฑฑบ          ณ					 				          				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCARQBXM()

Local aArea 		:= GetArea()
Local cPathTemp 	:= GETTEMPPATH()
Local cDirBx		:= "\BxTitMoip\"
Local cNameArq		:= Alltrim(PZH->PZH_ARQUIV)+"_"+ DtoS(Date())+STRTRAN(Time(), ":", "")+".csv"
Local oExcelApp

//Copia o arquivo do servidor para temporario do usuแrio
If __CopyFile(cDirBx+Alltrim(PZH->PZH_ARQUIV),cPathTemp+cNameArq)
	
	If Aviso("OPENARQ","Deseja abrir o arquivo importado ?",{"Sim","Nใo"},2) == 1
		oExcelApp	:= MsExcel():New()
		oExcelApp:WorkBooks:Open(cPathTemp+cNameArq)
		oExcelApp:SetVisible(.T.)
		oExcelApp:Destroy()
	EndIf                                      
Else
	Aviso("Erro ao abrir arquivo","Arquivo nใo encontrado no servidor: "+Alltrim(cDirBx+PZH->PZH_ARQUIV),{"Ok"},2)	
EndIf

RestArea(aArea)
Return                                       

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCCANBXL บAutor  ณElton C.		     บ Data ณ  24/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCancelamento da baixa por lote							  บฑฑ
ฑฑบ          ณ					 				          				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCCANBXL()

Local aArea 	:= GetArea()
Local cMsgAuto  := ""

Processa({||  cMsgAuto := CancBxLote() })

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCEXCBXL บAutor  ณElton C.		     บ Data ณ  24/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExclusใo da baixa por lote								  บฑฑ
ฑฑบ          ณ					 				          				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCEXCBXL()

Local aArea 	:= GetArea()
Local cMsgAuto  := ""

Processa({||  cMsgAuto  := ExcBxLote() })

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCCANBXM  บAutor  ณElton C.		     บ Data ณ  24/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCancelamento da baixa do item selecionado					  บฑฑ
ฑฑบ          ณ					 				          				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCCANBXM()

Local aArea 	:= GetArea()
Local cMsgAuto  := ""

If Aviso("Aten็ใo","Deseja efetuar o cancelamento da baixa ?",{"Sim","Nใo"}) == 1

	//Chama a rotina para efetuar o cancelamento da baixa do titulo
	LJMsgRun("Aguarde o processamento...","Aguarde...", {|| cMsgAuto := CancBxTit(PZH->PZH_PREFIX,;//Prefixo
																				 PZH->PZH_NUM,;//Titulo
																				 PZH->PZH_PARCEL,;//Parcela
																				 PZH->PZH_TIPO,; //Tipo
																				 PZH->PZH_NATURE,; //Natureza
																				 PZH->PZH_CLIENT,; //Cliente
																				 PZH->PZH_LOJA,; //Loja
																				 PZH->PZH_NOME,; //Nome
																				 PZH->PZH_IDMOIP);//Moip
															})
	//Atualiza a flag de estorno
	If Empty(cMsgAuto)
		Reclock("PZH",.F.)
		PZH->PZH_ESTORN := "S"
		PZH->(MsUnLock())                                             
		Aviso("สxito","Cancelamento da baixa efetuado com sucesso.",{"Ok"},2)
	EndIf
	
EndIf
RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCEXCBXM บAutor  ณElton C.		     บ Data ณ  24/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExclusใo da baixa do item selecionado						  บฑฑ
ฑฑบ          ณ					 				          				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCEXCBXM()

Local aArea 	:= GetArea()
Local cMsgAuto  := ""

If Aviso("Aten็ใo","Deseja efetuar a exclusใo da baixa ?",{"Sim","Nใo"}) == 1

	//Chama a rotina para efetuar o cancelamento da baixa do titulo
	LJMsgRun("Aguarde o processamento...","Aguarde...", {|| cMsgAuto := ExcBxTit(PZH->PZH_PREFIX,;//Prefixo
																				 PZH->PZH_NUM,;//Titulo
																				 PZH->PZH_PARCEL,;//Parcela
																				 PZH->PZH_TIPO,; //Tipo
																				 PZH->PZH_NATURE,; //Natureza
																				 PZH->PZH_CLIENT,; //Cliente
																				 PZH->PZH_LOJA,; //Loja
																				 PZH->PZH_NOME,; //Nome
																				 PZH->PZH_IDMOIP);//Moip
															})
	//Atualiza a flag de estorno
	If Empty(cMsgAuto)
		Reclock("PZH",.F.)
		PZH->PZH_ESTORN := "S"
		PZH->(MsUnLock())
		
		Aviso("สxito","Exclusใo da baixa efetuado com sucesso.",{"Ok"},2)
	EndIf

	
EndIf
RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCancBxTit  บAutor  ณElton C.		     บ Data ณ  24/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCancelamento da baixa 									  บฑฑ
ฑฑบ          ณ					 				          				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CancBxTit(cPrefixo, cNumTit, cParcela, cTipo, cNaturez, cCodCli, cLoja, cNome, cIdMoip)

Local aArea := GetArea()
Local aTitulo   := {}
Local cMsgAuto	:= ""

Default cPrefixo	:= "" 
Default cNumTit		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""                                     
Default cNaturez	:= "" 
Default cCodCli		:= "" 
Default cLoja		:= "" 
Default cNome		:= "" 
Default cIdMoip		:= ""

AADD(aTitulo,	{"E1_PREFIXO"		,cPrefixo 			,Nil } )
AADD(aTitulo,	{"E1_NUM"		 	,cNumTit    		,Nil } )
AADD(aTitulo,	{"E1_PARCELA"	 	,cParcela    		,Nil } )
AADD(aTitulo,	{"E1_TIPO"	    	,cTipo      		,Nil } )

//Chama a rotina para cancelar a baixa do titulo 
cMsgAuto := RunBxTitM(aTitulo, 5 )


If !Empty(cMsgAuto)
	Aviso("Aten็ใo","Nใo foi possํvel cancelar a baixo do titulo: "+cNumTit+CRLF+CRLF+cMsgAuto, {"Ok"},3)			
Endif

RestArea(aArea)
Return cMsgAuto


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExcBxTit  บAutor  ณElton C.		     บ Data ณ  24/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExclusใo da baixa		 									  บฑฑ
ฑฑบ          ณ					 				          				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ExcBxTit(cPrefixo, cNumTit, cParcela, cTipo, cNaturez, cCodCli, cLoja, cNome, cIdMoip)

Local aArea := GetArea()
Local aTitulo   := {}
Local cMsgAuto	:= ""

Default cPrefixo	:= "" 
Default cNumTit		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""                                     
Default cNaturez	:= "" 
Default cCodCli		:= "" 
Default cLoja		:= "" 
Default cNome		:= "" 
Default cIdMoip		:= ""

AADD(aTitulo,	{"E1_PREFIXO"		,cPrefixo 			,Nil } )
AADD(aTitulo,	{"E1_NUM"		 	,cNumTit    		,Nil } )
AADD(aTitulo,	{"E1_PARCELA"	 	,cParcela    		,Nil } )
AADD(aTitulo,	{"E1_TIPO"	    	,cTipo      		,Nil } )

//Chama a rotina para excluir a baixa do titulo 
cMsgAuto := RunBxTitM(aTitulo, 6 )


If !Empty(cMsgAuto)
	Aviso("Aten็ใo","Nใo foi possํvel cancelar a baixo do titulo: "+cNumTit+CRLF+CRLF+cMsgAuto, {"Ok"},3)			
Endif

RestArea(aArea)
Return cMsgAuto            


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCancBxLote บAutor  ณElton C.		     บ Data ณ  24/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCancelamento da baixa por lote							  บฑฑ
ฑฑบ          ณ					 				          				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CancBxLote()

Local aArea 	:= GetArea()
Local cMsgAuto  := ""
Local aPerg		:= {}
Local cQuery	:= ""
Local cArqTmp	:= ""
Local nCnt		:= 0

If Aviso("Aten็ใo","Deseja efetuar o cancelamento da baixa por lote ?",{"Sim","Nใo"}) == 1
	
	//Pergunta para preenchimento do lote
	If PergCEXBx(@aPerg)
		
		cArqTmp := GetNextAlias()
		cQuery	:= " SELECT R_E_C_N_O_ RECPZH FROM "+RetSqlName("PZH")+" PZH "+CRLF
		cQuery	+= " WHERE PZH.PZH_FILIAL = '"+xFilial("PZH")+"' "+CRLF
		cQuery	+= " AND PZH.PZH_SEQARQ = '"+aPerg[1]+"' "+CRLF
		cQuery	+= " AND PZH.PZH_ESTORN != 'S'"+CRLF
		cQuery	+= " AND PZH.D_E_L_E_T_ = ' ' "+CRLF
		
		dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)
		
		(cArqTmp)->( DbGoTop() )
		(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
		(cArqTmp)->( DbGoTop() )

		
		If nCnt > 0
		    ProcRegua(nCnt)
		
			DbSelectArea("PZH")
			DbSetOrder(1)
			While (cArqTmp)->(!Eof())
				
				PZH->(DbGoTo((cArqTmp)->RECPZH))
				
				IncProc("Processando o titulo: "+PZH->PZH_NUM)
				
								
				If Len(aPerg)> 0

					//Chama a rotina para efetuar o cancelamento da baixa do titulo
					cMsgAuto := CancBxTit(PZH->PZH_PREFIX,;//Prefixo
											PZH->PZH_NUM,;//Titulo
											PZH->PZH_PARCEL,;//Parcela
											PZH->PZH_TIPO,; //Tipo
											PZH->PZH_NATURE,; //Natureza
											PZH->PZH_CLIENT,; //Cliente
											PZH->PZH_LOJA,; //Loja
											PZH->PZH_NOME,; //Nome
											PZH->PZH_IDMOIP);//Moip
											
					//Atualiza a flag de estorno
					If Empty(cMsgAuto)
						Reclock("PZH",.F.)
						PZH->PZH_ESTORN := "S"
						PZH->(MsUnLock())
					EndIf
					
				EndIf

				(cArqTmp)->(DbSkip())
			EndDo
		
			If Empty(cMsgAuto)
				Aviso("สxito","Cancelamento da baixa efetuado com sucesso.",{"Ok"},2)
			EndIf
	
		Else
			Aviso("Aten็ใo","Nenhum item encontrado com o lote: "+aPerg[1],{"Ok"},2)
		EndIf
		(cArqTmp)->(DbCloseArea())
	Else
		Aviso("Aten็ใo","Erro ao abrir a tela de parโmetro, entre em contato com o administrador",{"Ok"},2)
	EndIf                 

EndIf

RestArea(aArea)
Return cMsgAuto


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExcBxLote บAutor  ณElton C.		     บ Data ณ  24/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExclusใo da baixa por lote								  บฑฑ
ฑฑบ          ณ					 				          				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ExcBxLote()

Local aArea 	:= GetArea()
Local cMsgAuto  := ""
Local aPerg		:= {}
Local cQuery	:= ""
Local cArqTmp	:= ""
Local nCnt		:= 0

If Aviso("Aten็ใo","Deseja efetuar a exclusใo da baixa por lote ?",{"Sim","Nใo"}) == 1
	
	//Pergunta para preenchimento do lote
	If PergCEXBx(@aPerg)
		
		cArqTmp := GetNextAlias()
		cQuery	:= " SELECT R_E_C_N_O_ RECPZH FROM "+RetSqlName("PZH")+" PZH "+CRLF
		cQuery	+= " WHERE PZH.PZH_FILIAL = '"+xFilial("PZH")+"' "+CRLF
		cQuery	+= " AND PZH.PZH_SEQARQ = '"+aPerg[1]+"' "+CRLF
		cQuery	+= " AND PZH.PZH_ESTORN != 'S'"+CRLF
		cQuery	+= " AND PZH.D_E_L_E_T_ = ' ' "+CRLF
		
		dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)
		
		(cArqTmp)->( DbGoTop() )
		(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
		(cArqTmp)->( DbGoTop() )

		
		If nCnt > 0
		    ProcRegua(nCnt)
		
			DbSelectArea("PZH")
			DbSetOrder(1)
			While (cArqTmp)->(!Eof())
				
				PZH->(DbGoTo((cArqTmp)->RECPZH))
				
				IncProc("Processando o titulo: "+PZH->PZH_NUM)
				
								
				If Len(aPerg)> 0

					//Chama a rotina para efetuar o cancelamento da baixa do titulo
					cMsgAuto := ExcBxTit(PZH->PZH_PREFIX,;//Prefixo
											PZH->PZH_NUM,;//Titulo
											PZH->PZH_PARCEL,;//Parcela
											PZH->PZH_TIPO,; //Tipo
											PZH->PZH_NATURE,; //Natureza
											PZH->PZH_CLIENT,; //Cliente
											PZH->PZH_LOJA,; //Loja
											PZH->PZH_NOME,; //Nome
											PZH->PZH_IDMOIP);//Moip
											
					//Atualiza a flag de estorno
					If Empty(cMsgAuto)
						Reclock("PZH",.F.)
						PZH->PZH_ESTORN := "S"
						PZH->(MsUnLock())
					EndIf
					
				EndIf

				(cArqTmp)->(DbSkip())
			EndDo

			If Empty(cMsgAuto)
				Aviso("สxito","Exclusใo da baixa efetuado com sucesso.",{"Ok"},2)
			EndIf
		Else
			Aviso("Aten็ใo","Nenhum item encontrado com o lote: "+aPerg[1],{"Ok"},2)
		EndIf
		(cArqTmp)->(DbCloseArea())
	Else
		Aviso("Aten็ใo","Erro ao abrir a tela de parโmetro, entre em contato com o administrador",{"Ok"},2)
	EndIf                

EndIf

RestArea(aArea)
Return cMsgAuto



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPergCEXBx	บAutor  ณElton C.		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Pergunta para cancelamento\exclusใo em lote		          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergCEXBx(aParams)

Local aParamBox := {}
Local llRet      := .T.

AADD(aParamBox,{1,"Lote", Space(TAMSX3("PZH_SEQARQ")[1])		,"@!"	,"","","",70,.F.})

llRet := ParamBox(aParamBox, "Parโmetros", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .t., .t.)

Return llRet




