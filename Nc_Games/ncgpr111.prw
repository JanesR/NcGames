#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE 'TopConn.ch'

Static aDadosA09:={}
Static aDadosA06:={}
Static aDadCliFor	:={}

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR111  บAutor  ณMicrosiga           บ Data ณ  09/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR111EnvLayout(cLayout,cTabela)
Local aAreaAtu :=GetArea()
Local aAreaSA1	:=SA1->(GetArea())
Local aAreaSD1	:=SD1->(GetArea())
Local aAreaSA2	:=SA2->(GetArea())
Local aAreaSA4	:=SA4->(GetArea())
Local cLinha	:=""
Local cChave
Local cCodEstab:="204"

If cLayout=="NFE_A01"
	aDadCliFor	:={}
	If SF1->F1_TIPO$'D*B'
		SA1->(DbSetOrder(1)) //A1_FILIAL+A1_COD+A1_LOJA
		SA1->(MsSeek(xFilial("SA1")+SF1->(F1_FORNECE+F1_LOJA)))
		AADD(aDadCliFor,SA1->A1_CGC)		//01
		AADD(aDadCliFor,SA1->A1_NOME)		//02
		AADD(aDadCliFor,SA1->A1_END)		//03
		AADD(aDadCliFor,SA1->A1_BAIRRO)	//04
		AADD(aDadCliFor,SA1->A1_MUN)		//05
		AADD(aDadCliFor,SA1->A1_EST)		//06
		AADD(aDadCliFor,SA1->A1_CEP)		//07
		AADD(aDadCliFor,SA1->A1_INSCR)		//08
		AADD(aDadCliFor,"")					//09
		AADD(aDadCliFor,SA1->A1_PESSOA)	//10
		AADD(aDadCliFor,"DEV"			)		//11
		cLinha+=U_PR111EnvLayout("A09","SA1")
	Else
		SA2->(DbSetOrder(1)) //A2_FILIAL+A2_COD+A2_LOJA
		SA2->(MsSeek(xFilial("SA2")+SF1->(F1_FORNECE+F1_LOJA)))
		AADD(aDadCliFor,IIf(SA2->A2_TIPO=="X","00000000000000",SA2->A2_CGC))	//01
		AADD(aDadCliFor,SA2->A2_NOME)		//02
		AADD(aDadCliFor,SA2->A2_END)		//03
		AADD(aDadCliFor,SA2->A2_BAIRRO)	//04
		AADD(aDadCliFor,SA2->A2_MUN)		//05
		AADD(aDadCliFor,SA2->A2_EST)		//06
		AADD(aDadCliFor,SA2->A2_CEP)		//07
		AADD(aDadCliFor,SA2->A2_INSCR)		//08
		AADD(aDadCliFor,""				)		//09
		AADD(aDadCliFor,IIf(SA2->A2_TIPO=="X","J",SA2->A2_TIPO)				)		//10
		AADD(aDadCliFor,"NFE"			)		//11
		cLinha+=U_PR111EnvLayout("A09","SA2")
		
		
		
		
	EndIf
	AADD(aDadCliFor,0)	//12
	AADD(aDadCliFor,"")//13
	
	
	SA4->(DbSetOrder(1))//A4_FILIAL+A4_COD
	SA4->(MsSeek(xFilial("SA4")+SF1->F1_TRANSP )  )
	
	cLinha+=U_PR111EnvLayout("A09","SA4")
	
	
	cChave:=xFilial("SD1")+SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA)
	SD1->(DbSetOrder(1))
	SD1->(MsSeek(cChave))
	Do While SD1->(!Eof()) .And. SD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA) ==cChave
		aDadCliFor[12]+=SD1->D1_VALACRS
		aDadCliFor[13]:=SD1->D1_CF
		SD1->(dbSkip())
	EndDo
	
	
	cLinha+=PR111Trans("01"															,'C',02)  //TIPOREGISTRO
	cLinha+=PR111Trans("NCGAMES"													,'C',15)   //CODIGODEPOSITANTE
	cLinha+=PR111Trans("NCGAMES"													,'C',15)      //CODIGOEMPRESA
	cLinha+=PR111Trans(aDadCliFor[01]													,'C',15)      //CGCEMPRESA
	cLinha+=PR111Trans(aDadCliFor[02]													,'C',40)      //NOMEEMPRESA
	cLinha+=PR111Trans(aDadCliFor[03]													,'C',40)      //ENDERECOEMPRESA
	cLinha+=PR111Trans(aDadCliFor[04]													,'C',25)      //BAIRROEMPRESA
	cLinha+=PR111Trans(aDadCliFor[05]													,'C',25)      //MUNICIPIOEMPRESA
	cLinha+=PR111Trans(aDadCliFor[06]													,'C',02)      //UFEMPRESA
	cLinha+=PR111Trans(aDadCliFor[07]													,'C',09)      //CEPEMPRESA
	cLinha+=PR111Trans(aDadCliFor[08]													,'C',15)      //INSCRICAOEMPRESA
	cLinha+=PR111Trans("NFE"															,'C',05)      //TIPODOCUMENTO
	cLinha+=PR111Trans(IiF(Empty(SF1->F1_SERIE),".",SF1->F1_SERIE)  	,'C',05)      //SERIEDOCUMENTO
	cLinha+=PR111Trans(SF1->F1_DOC												,'C',10)      //NUMERODOCUMENTO
	cLinha+=PR111Trans("NCGAMES"													,'C',15)      //CODIGOMATRIZ
	cLinha+=PR111Trans(cCodEstab													,'N',10,.F.)  //CODIGOESTABELECIMENTO
	cLinha+=PR111Trans(aDadCliFor[13]     											,'C',06)      //NATUREZAOPERACAO
	cLinha+=PR111Trans(""															,'C',10)      //CONHECIMENTOTRANSPORTE
	cLinha+=PR111Trans(SF1->F1_EMISSAO											,'D',08)      //DATAEMISSAO
	cLinha+=PR111Trans(1					 											,'N',20)      //VALORTOTALDOCUMENTO
	cLinha+=PR111Trans(1											  					,'N',20)      //VALORTOTALPRODUTO
	cLinha+=PR111Trans(1																,'N',20)      //VALORICMS
	cLinha+=PR111Trans(1																,'N',20)      //VALORICMSSUB
	cLinha+=PR111Trans(1																,'N',20)      //VALORIPI
	cLinha+=PR111Trans(1																,'N',20)      //VALORFRETE
	cLinha+=PR111Trans(1																,'N',20)      //BASEICMS
	cLinha+=PR111Trans(1																,'N',20)      //BASEICMSSUB
	cLinha+=PR111Trans(1																,'N',20)      //BASEIPI
	cLinha+=PR111Trans(1 															,'N',20)      //VALORSEGURO
	cLinha+=PR111Trans(1																,'N',20)      //VALORDESCONTO
	cLinha+=PR111Trans(aDadCliFor[12]													,'N',20)      //VALORACRESCIMO
	cLinha+=PR111Trans(SA4->A4_CGC    											,'C',15)      //CODIGOTRANSPORTADORA
	cLinha+=PR111Trans(SF1->F1_TIPO												,'C',25)      //INFORMACAOADICIONAL1
	cLinha+=PR111Trans(""															,'C',25)      //INFORMACAOADICIONAL2
	cLinha+=PR111Trans(""															,'C',25)      //INFORMACAOADICIONAL3
	cLinha+=PR111Trans(""															,'C',15)      //CODIGOEMPRESAENTREGA
	cLinha+=PR111Trans(""															,'C',15)      //CODIGOEMPRESAFATURAMENTO
	cLinha+=PR111Trans(""															,'C',15)      //CODIGOEMPRESADESTINO
	cLinha+=PR111Trans(""															,'C',15)      //CODIGOEMPRESAEMITENTE
	cLinha+=PR111Trans(SF1->F1_DTDIGIT											,'D',08)      //DATAMOVIMENTO
	cLinha+=PR111Trans(SF1->F1_PBRUTO 											,'N',20)      //PESOBRUTO
	cLinha+=PR111Trans(SF1->F1_PESOL  											,'N',20)      //PESOLIQUIDO
	cLinha+=PR111Trans(aDadCliFor[13]											,'C',06)      //CFOP
	cLinha+=PR111Trans("PE"															,'C',05)      //ESPECIEDOCUMENTO
	cLinha+=PR111Trans(aDadCliFor[09]											,'C',10)      //TIPOEMPRESA
	cLinha+=PR111Trans(aDadCliFor[10]											,'C',01)      //TIPOPESSOAEMPRESA
	cLinha+="00"+Space(08)							  											      //ESTADODOCUMENTO
	cLinha+=PR111Trans(""															,'C',40)      //ESPECIEVOLUME
	cLinha+=PR111Trans("0"															,'N',20)      //QUANTIDADEVOLUME
	cLinha+=PR111Trans(""															,'C',10)      //MARCAVOLUME
	cLinha+=PR111Trans(""															,'C',10)      //NUMEROVOLUME
	cLinha+=PR111Trans("0"															,'N',10)      //TIPOFRETE
	cLinha+=PR111Trans(""															,'C',07)      //PLACAVEICULO
	cLinha+=PR111Trans(""															,'C',02)      //UFVEICULO
	cLinha+=PR111Trans(""				 											,'C',44)      //NFECHAVEACESSO
	cLinha+=PR111Trans("000"														,'C',03)      //NFEESTADO
	cLinha+=PR111Trans(""															,'C',14)      //NFEDATAAUTORIZACAO
	cLinha+=PR111Trans(""															,'C',25)      //AGRUPADOR
	cLinha+=PR111Trans("070"														,'C',03)      //ESTADOOPERACAO
	cLinha+=PR111Trans(""															,'C',14)      //DATAINICIOOPERACAO
	cLinha+=PR111Trans(""															,'C',10)  	    //FILLER
	cLinha+=CRLF
ElseIf cLayout=="NFE_A02"
	cLinha+=PR111Trans("02"															,'C',02)      //TIPOREGISTRO
	cLinha+=PR111Trans("NCGAMES"													,'C',15)      //CODIGOEMPRESA
	cLinha+=PR111Trans("NFE"														,'C',05)      //TIPODOCUMENTO
	cLinha+=PR111Trans(SF1->F1_SERIE												,'C',05)      //SERIEDOCUMENTO
	cLinha+=PR111Trans(SF1->F1_DOC												,'C',10)      //NUMERODOCUMENTO
	cLinha+=PR111Trans("NCGAMES"													,'C',15)      //CODIGODEPOSITANTE
	cLinha+=PR111Trans(SD1->D1_COD												,'C',25)      //CODIGOPRODUTO
	cLinha+=PR111Trans(SD1->D1_QUANT												,'N',20)      //QUANTIDADE
	cLinha+=PR111Trans(SD1->D1_UM													,'C',05)      //TIPOUC
	cLinha+=PR111Trans("1"															,'N',20)      //FATORTIPOUC
	cLinha+=PR111Trans(1   															,'N',20)      //ALIQUOTAICMS
	cLinha+=PR111Trans(1    														,'N',20)      //ALIQUOTAIPI
	cLinha+=PR111Trans(""															,'C',20)      //FILLER
	cLinha+=PR111Trans(1																,'N',20)      //ALIQUOTAICMSSUB
	cLinha+=PR111Trans(""															,'C',10)      //TIPOLOGISTICO
	cLinha+=PR111Trans(""															,'C',15)      //DADOLOGISTICO
	cLinha+=PR111Trans("03"															,'C',05)      //CLASSEPRODUTO   //SD1->D1_LOCAL
	cLinha+=PR111Trans(Val(SD1->D1_ITEM)										,'N',03,.F.)  //SEQUENCIAITEM
	cLinha+=PR111Trans(""															,'C',25)      //INFORMACAOADICIONAL1
	cLinha+=PR111Trans(""															,'C',25)      //INFORMACAOADICIONAL2
	cLinha+=PR111Trans(""															,'C',25)      //INFORMACAOADICIONAL3
	cLinha+=PR111Trans(SD1->D1_CF													,'C',06)      //NATUREZAOPERACAO
	cLinha+=PR111Trans(SD1->D1_CF													,'C',06)      //CFOP
	cLinha+=PR111Trans(SB1->B1_POSIPI											,'C',10)      //CLASSIFICACAOFISCAL
	cLinha+=PR111Trans(SD1->D1_CLASFIS											,'C',10)      //SITUACAOTRIBUTARIA
	cLinha+=PR111Trans(""															,'C',20)      //FILLER
	cLinha+=PR111Trans(""															,'C',20)      //FILLER
	cLinha+=PR111Trans(""															,'C',15)      //IDTIPOUC
	cLinha+=PR111Trans(SD1->D1_COD												,'C',25)      //IDPRODUTO
	cLinha+=PR111Trans(SD1->D1_PESO												,'N',20)      //PESOBRUTO
	cLinha+=PR111Trans(SD1->D1_PESO												,'N',20)      //PESOLIQUIDO
	cLinha+=PR111Trans(""															,'C',20)      //ALIQUOTAICMSREDUCAO
	cLinha+=PR111Trans(""															,'C',20)      //FATORBASEICMS
	cLinha+=PR111Trans(""															,'C',20)      //ALIQUOTAIPIREDUCAO
	cLinha+=PR111Trans(""															,'C',20)      //FATORBASEIPI
	cLinha+=PR111Trans(1    														,'N',20)      //VALORUNITARIO
	cLinha+=PR111Trans(0																,'N',20)      //VALORDESCONTO
	cLinha+=PR111Trans(0																,'N',20)      //VALORACRESCIMO
	cLinha+=PR111Trans(cCodEstab													,'N',10,.F.)      //CODIGOESTABELECIMENTO
	cLinha+=PR111Trans(""															,'C',10)      //FILLER
	cLinha+=CRLF
	
ElseIf cLayout=="NFS"
	
	aDadCliFor	:={}
	If SF2->F2_TIPO$'D*B'
		SA2->(DbSetOrder(1)) //A2_FILIAL+A2_COD+A2_LOJA
		SA2->(MsSeek(xFilial("SA2")+SF2->(F2_CLIENTE+F2_LOJA)))
		AADD(aDadCliFor,IIf(SA2->A2_TIPO=="X","00000000000000",SA2->A2_CGC))	//01
		AADD(aDadCliFor,SA2->A2_NOME)		//02
		AADD(aDadCliFor,SA2->A2_END)		//03
		AADD(aDadCliFor,SA2->A2_BAIRRO)	//04
		AADD(aDadCliFor,SA2->A2_MUN)		//05
		AADD(aDadCliFor,SA2->A2_EST)		//06
		AADD(aDadCliFor,SA2->A2_CEP)		//07
		AADD(aDadCliFor,SA2->A2_INSCR)		//08
		AADD(aDadCliFor,""				)		//09
		AADD(aDadCliFor,IIf(SA2->A2_TIPO=="X","J",SA2->A2_TIPO)				)		//10
		//cLinha+=U_PR111EnvLayout("A09","SA2")
	Else
		SA1->(DbSetOrder(1)) //A1_FILIAL+A1_COD+A1_LOJA
		SA1->(MsSeek(xFilial("SA2")+SF2->(F2_CLIENTE+F2_LOJA)))
		AADD(aDadCliFor,SA1->A1_CGC)		//01
		AADD(aDadCliFor,SA1->A1_NOME)		//02
		AADD(aDadCliFor,SA1->A1_END)		//03
		AADD(aDadCliFor,SA1->A1_BAIRRO)	//04
		AADD(aDadCliFor,SA1->A1_MUN)		//05
		AADD(aDadCliFor,SA1->A1_EST)		//06
		AADD(aDadCliFor,SA1->A1_CEP)		//07
		AADD(aDadCliFor,SA1->A1_INSCR)		//08
		AADD(aDadCliFor,"")					//09
		AADD(aDadCliFor,SA1->A1_PESSOA)	//10
		//cLinha+=U_PR111EnvLayout("A09","SA1")
	EndIf
	
	cLinha+=PR111Trans("91"						,'C',02) //TIPOREGISTRO
	cLinha+=PR111Trans("NCGAMES"				,'C',15) //CODIGODEPOSITANTE
	cLinha+=PR111Trans(aDadCliFor[01]		,'C',15) //CODIGOEMPRESA
	cLinha+=PR111Trans("NF"						,'C',05) //TIPODOCUMENTO
	cLinha+=PR111Trans(SF2->F2_SERIE  		,'C',05) //SERIEDOCUMENTO
	cLinha+=PR111Trans(SF2->F2_FILIAL+Posicione("SD2",3,xFilial("SD2")+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA),"D2_PEDIDO"),'C',10) //NUMERODOCUMENTO
	cLinha+=PR111Trans(SF2->F2_DOC,'C',10) //INFORMACAOADICIONAL1
	cLinha+=CRLF
	                   
	
	
ElseIf cLayout=="PV_A01"
	
	SA4->(DbSetOrder(1))//A4_FILIAL+A4_COD
	SA4->(MsSeek(xFilial("SA4")+SC5->C5_TRANSP )  )
	cLinha+=U_PR111EnvLayout("A09","SA4")
	
	aDadCliFor	:={}
	If SC5->C5_TIPO$'D*B'
		SA2->(DbSetOrder(1)) //A2_FILIAL+A2_COD+A2_LOJA
		SA2->(MsSeek(xFilial("SA2")+SC5->(C5_CLIENTE+C5_LOJACLI)))
		AADD(aDadCliFor,IIf(SA2->A2_TIPO=="X","00000000000000",SA2->A2_CGC))	//01
		AADD(aDadCliFor,SA2->A2_NOME)		//02
		AADD(aDadCliFor,SA2->A2_END)		//03
		AADD(aDadCliFor,SA2->A2_BAIRRO)	//04
		AADD(aDadCliFor,SA2->A2_MUN)		//05
		AADD(aDadCliFor,SA2->A2_EST)		//06
		AADD(aDadCliFor,SA2->A2_CEP)		//07
		AADD(aDadCliFor,SA2->A2_INSCR)		//08
		AADD(aDadCliFor,""				)		//09
		AADD(aDadCliFor,IIf(SA2->A2_TIPO=="X","J",SA2->A2_TIPO)				)		//10
		cLinha+=U_PR111EnvLayout("A09","SA2")
	Else
		SA1->(DbSetOrder(1)) //A1_FILIAL+A1_COD+A1_LOJA
		SA1->(MsSeek(xFilial("SA2")+SC5->(C5_CLIENTE+C5_LOJACLI)))
		AADD(aDadCliFor,SA1->A1_CGC)		//01
		AADD(aDadCliFor,SA1->A1_NOME)		//02
		AADD(aDadCliFor,SA1->A1_END)		//03
		AADD(aDadCliFor,SA1->A1_BAIRRO)	//04
		AADD(aDadCliFor,SA1->A1_MUN)		//05
		AADD(aDadCliFor,SA1->A1_EST)		//06
		AADD(aDadCliFor,SA1->A1_CEP)		//07
		AADD(aDadCliFor,SA1->A1_INSCR)		//08
		AADD(aDadCliFor,"")					//09
		AADD(aDadCliFor,SA1->A1_PESSOA)	//10
		cLinha+=U_PR111EnvLayout("A09","SA1")
	EndIf
	AADD(aDadCliFor,"PV"			)		//11
	AADD(aDadCliFor,0)	//12
	AADD(aDadCliFor,"")//13
	
	
	cLinha+=PR111Trans("03"															,'C',02)  //TIPOREGISTRO
	cLinha+=PR111Trans("NCGAMES"													,'C',15)   //CODIGODEPOSITANTE
	cLinha+=PR111Trans(aDadCliFor[01]											,'C',15)      //CODIGOEMPRESA
	cLinha+=PR111Trans(aDadCliFor[01]											,'C',15)      //CGCEMPRESA
	cLinha+=PR111Trans(aDadCliFor[02]											,'C',40)      //NOMEEMPRESA
	cLinha+=PR111Trans(aDadCliFor[03]											,'C',40)      //ENDERECOEMPRESA
	cLinha+=PR111Trans(aDadCliFor[04]											,'C',25)      //BAIRROEMPRESA
	cLinha+=PR111Trans(aDadCliFor[05]											,'C',25)      //MUNICIPIOEMPRESA
	cLinha+=PR111Trans(aDadCliFor[06]											,'C',02)      //UFEMPRESA
	cLinha+=PR111Trans(aDadCliFor[07]											,'C',09)      //CEPEMPRESA
	cLinha+=PR111Trans(aDadCliFor[08]											,'C',15)      //INSCRICAOEMPRESA
	cLinha+=PR111Trans("PV"															,'C',05)      //TIPODOCUMENTO
	cLinha+=PR111Trans("." 														 	,'C',05)      //SERIEDOCUMENTO
	cLinha+=PR111Trans(SC5->(C5_FILIAL+C5_NUM)								,'C',10)      //NUMERODOCUMENTO
	cLinha+=PR111Trans("NCGAMES"													,'C',15)      //CODIGOMATRIZ
	cLinha+=PR111Trans(cCodEstab													,'N',10,.F.)  //CODIGOESTABELECIMENTO
	cLinha+=PR111Trans("9999"     											   ,'C',06)      //NATUREZAOPERACAO
	cLinha+=PR111Trans(""															,'C',10)      //CONHECIMENTOTRANSPORTE
	cLinha+=PR111Trans(SC5->C5_EMISSAO											,'D',08)      //DATAEMISSAO
	cLinha+=PR111Trans(1					 											,'N',20)      //VALORTOTALDOCUMENTO
	cLinha+=PR111Trans(1											  					,'N',20)      //VALORTOTALPRODUTO
	cLinha+=PR111Trans(0																,'N',20)      //VALORICMS
	cLinha+=PR111Trans(0																,'N',20)      //VALORICMSSUB
	cLinha+=PR111Trans(0																,'N',20)      //VALORIPI
	cLinha+=PR111Trans(0																,'N',20)      //VALORFRETE
	cLinha+=PR111Trans(0																,'N',20)      //BASEICMS
	cLinha+=PR111Trans(0																,'N',20)      //BASEICMSSUB
	cLinha+=PR111Trans(0																,'N',20)      //BASEIPI
	cLinha+=PR111Trans(0 															,'N',20)      //VALORSEGURO
	cLinha+=PR111Trans(0																,'N',20)      //VALORDESCONTO
	cLinha+=PR111Trans(0																,'N',20)      //VALORACRESCIMO
	cLinha+=PR111Trans(SA4->A4_CGC												,'C',15)      //CODIGOTRANSPORTADORA
	cLinha+=PR111Trans(""															,'C',25)      //INFORMACAOADICIONAL1
	cLinha+=PR111Trans(""															,'C',25)      //INFORMACAOADICIONAL2
	cLinha+=PR111Trans(""															,'C',25)      //INFORMACAOADICIONAL3
	cLinha+=PR111Trans(""															,'C',15)      //CODIGOEMPRESAENTREGA
	cLinha+=PR111Trans(""															,'C',15)      //CODIGOEMPRESAFATURAMENTO
	cLinha+=PR111Trans(aDadCliFor[01] 											,'C',15)      //CODIGOEMPRESADESTINO
	cLinha+=PR111Trans(""															,'C',15)      //CODIGOEMPRESAEMITENTE
	cLinha+=PR111Trans(SC5->C5_EMISSAO											,'D',08)      //DATAMOVIMENTO
	cLinha+=PR111Trans(SC5->C5_PBRUTO  											,'N',20)      //PESOBRUTO
	cLinha+=PR111Trans(SC5->C5_PESOL   											,'N',20)      //PESOLIQUIDO
	cLinha+=PR111Trans("9999"														,'C',06)      //CFOP
	cLinha+=PR111Trans("PS"		   												,'C',05)      //ESPECIEDOCUMENTO
	cLinha+=PR111Trans(aDadCliFor[09]													,'C',10)      //TIPOEMPRESA
	cLinha+=PR111Trans(aDadCliFor[10]													,'C',01)      //TIPOPESSOAEMPRESA
	cLinha+="00"+Space(08)							  											       //ESTADODOCUMENTO
	cLinha+=PR111Trans(""															,'C',40)      //ESPECIEVOLUME
	cLinha+=PR111Trans("0"															,'N',20)      //QUANTIDADEVOLUME
	cLinha+=PR111Trans(""															,'C',10)      //MARCAVOLUME
	cLinha+=PR111Trans(""															,'C',10)      //NUMEROVOLUME
	cLinha+=PR111Trans("0"															,'N',10)      //TIPOFRETE
	cLinha+=PR111Trans(""															,'C',07)      //PLACAVEICULO
	cLinha+=PR111Trans(""															,'C',02)      //UFVEICULO
	cLinha+=PR111Trans(""             											,'C',44)      //NFECHAVEACESSO
	cLinha+=PR111Trans("000"														,'C',03)      //NFEESTADO
	cLinha+=PR111Trans(""															,'C',14)      //NFEDATAAUTORIZACAO
	cLinha+=PR111Trans(""															,'C',25)      //AGRUPADOR
	cLinha+=PR111Trans("030"														,'C',03)      //ESTADOOPERACAO
	cLinha+=PR111Trans(""															,'C',14)      //DATAINICIOOPERACAO
	cLinha+=PR111Trans(""															,'C',10)  	    //FILLER
	cLinha+=CRLF
ElseIf cLayout=="PV_A02"
	cLinha+=PR111Trans("04"															,'C',02)      //TIPOREGISTRO
	cLinha+=PR111Trans(aDadCliFor[01]											,'C',15)      //CODIGOEMPRESA
	cLinha+=PR111Trans("PV"															,'C',05)      //TIPODOCUMENTO
	cLinha+=PR111Trans("."															,'C',05)      //SERIEDOCUMENTO
	cLinha+=PR111Trans(SC9->(C9_FILIAL+C9_PEDIDO)   						,'C',10)      //NUMERODOCUMENTO
	cLinha+=PR111Trans("NCGAMES"													,'C',15)      //CODIGODEPOSITANTE
	cLinha+=PR111Trans(SC9->C9_PRODUTO											,'C',25)      //CODIGOPRODUTO
	cLinha+=PR111Trans(SC9->C9_QTDLIB 											,'N',20)      //QUANTIDADE
	cLinha+=PR111Trans(SB1->B1_UM 												,'C',05)      //TIPOUC
	cLinha+=PR111Trans("1"															,'N',20)      //FATORTIPOUC
	cLinha+=PR111Trans(0   															,'N',20)      //ALIQUOTAICMS
	cLinha+=PR111Trans(0    														,'N',20)      //ALIQUOTAIPI
	cLinha+=PR111Trans(""															,'C',20)      //FILLER
	cLinha+=PR111Trans(0																,'N',20)      //ALIQUOTAICMSSUB
	cLinha+=PR111Trans(""															,'C',10)      //TIPOLOGISTICO
	cLinha+=PR111Trans(""															,'C',15)      //DADOLOGISTICO
	cLinha+=PR111Trans(SC9->C9_LOCAL												,'C',05)      //CLASSEPRODUTO
	cLinha+=PR111Trans(Val(SC9->C9_ITEM)										,'N',03,.F.)  //SEQUENCIAITEM
	cLinha+=PR111Trans(""															,'C',25)      //INFORMACAOADICIONAL1
	cLinha+=PR111Trans(""															,'C',25)      //INFORMACAOADICIONAL2
	cLinha+=PR111Trans(""															,'C',25)      //INFORMACAOADICIONAL3
	cLinha+=PR111Trans("9999"														,'C',06)      //NATUREZAOPERACAO
	cLinha+=PR111Trans("9999"														,'C',06)      //CFOP
	cLinha+=PR111Trans(SB1->B1_POSIPI											,'C',10)      //CLASSIFICACAOFISCAL
	cLinha+=PR111Trans(""															,'C',10)      //SITUACAOTRIBUTARIA
	cLinha+=PR111Trans(""															,'C',20)      //FILLER
	cLinha+=PR111Trans(""															,'C',20)      //FILLER
	cLinha+=PR111Trans(""															,'C',15)      //IDTIPOUC
	cLinha+=PR111Trans(SC9->C9_PRODUTO											,'C',25)      //IDPRODUTO
	cLinha+=PR111Trans(1																,'N',20)      //PESOBRUTO
	cLinha+=PR111Trans(1																,'N',20)      //PESOLIQUIDO
	cLinha+=PR111Trans(""															,'C',20)      //ALIQUOTAICMSREDUCAO
	cLinha+=PR111Trans(""															,'C',20)      //FATORBASEICMS
	cLinha+=PR111Trans(""															,'C',20)      //ALIQUOTAIPIREDUCAO
	cLinha+=PR111Trans(""															,'C',20)      //FATORBASEIPI
	cLinha+=PR111Trans(1    														,'N',20)      //VALORUNITARIO
	cLinha+=PR111Trans(0																,'N',20)      //VALORDESCONTO
	cLinha+=PR111Trans(0																,'N',20)      //VALORACRESCIMO
	cLinha+=PR111Trans(cCodEstab													,'N',10,.F.)      //CODIGOESTABELECIMENTO
	cLinha+=PR111Trans(""															,'C',10)      //FILLER
	cLinha+=CRLF
ElseIf cLayout=="A05"
	
	cLinha+="06"																											//TIPOREGISTRO
	cLinha+=PR111Trans("NCGAMES","C",15)																			//CODIGODEPOSITANTE
	cLinha+=PR111Trans(SB1->B1_COD,"C",25)																			//CODIGOPRODUTO
	cLinha+=PR111Trans(SB1->B1_XDESC,"C",40)																		//DESCRICAOPRODUTO
	cLinha+=PR111Trans(Posicione("SX5",1,xFilial("SX5")+"02"+SB1->B1_TIPO,"X5DESCRI()"),"C",40)	//TIPOPRODUTO
	cLinha+=Space(15)																										//MODELOPRODUTO
	cLinha+=Space(06)																										//CODIGOGRUPO
	cLinha+=PR111Trans(SB1->B1_CLASFIS,"C",10)																	//CLASSIFICACAOFISCAL
	cLinha+=PR111Trans(SB1->B1_LARGURA,"N",20)																	//LARGURA
	cLinha+=PR111Trans(SB1->B1_PROF,"N",20)														            //COMPRIMENTO
	cLinha+=PR111Trans(SB1->B1_ALT,"N",20)															            //ALTURA
	cLinha+=PR111Trans(SB1->B1_PESO,"N",20)																		//PESOLIQUIDOPRODUTO
	cLinha+=PR111Trans(SB1->B1_PESBRU,"N",20)																		//PESOBRUTOPRODUTO
	cLinha+=Space(100)																									//FILLER
	cLinha+=PR111Trans(SB1->B1_PRVALID,"N",10)																	//PRAZOVALIDADE
	cLinha+=PR111Trans(SB1->B1_UM,"C",05)																			//UNIDADECONDICIONAMENTO
	cLinha+=PR111Trans(1,"N",20)																		  				//FATORTIPOUC
	cLinha+=Space(25)																						  				//IDPRODUTO
	cLinha+=Space(15)																						  				//IDTIPOUC
	cLinha+=Space(25)																						  				//INFORMACAOADICIONAL1
	cLinha+=Space(25)																						  				//INFORMACAOADICIONAL2
	cLinha+=Space(25)																						  				//INFORMACAOADICIONAL3
	cLinha+=Space(25)																						  				//INFORMACAOADICIONAL4
	cLinha+=Space(25)																						  				//INFORMACAOADICIONAL5
	cLinha+=PR111Trans(Posicione("SB5",1,xFilial("SB5")+SB1->B1_COD,"B5_CEME"),"C",80)				//DESCRICAOPRODUTODET
	cLinha+=Space(15)																										//CLASSIFICACAOPRODUTO
	cLinha+=Space(15)																										//CLASSIFICACAOPICKING
	cLinha+=PR111Trans(SB1->B1_POSIPI,"C",10)	 																	//CODIGONCM
	cLinha+=Space(15)																										//CLASSERISCO
	cLinha+=StrZero(Val(SB1->B1_SITTRIB),3)																		//SITUACAOTRIBUTARIA
	
	
	cLinha+="0"																												//INFORMARNUMEROSERIE
	cLinha+=IIf(SB1->B1_YSERIE$" 1","0","1")																		//INFORMARSERIEEXPEDICAO
	//B1_YSERIE == 1=Nao Necessario#2=Numero de Serie#3=IMEI1#4=IMEI1 e IMEI2
	
	
	cLinha+=CRLF
ElseIf cLayout=="A06"
	If Ascan(aDadosA06,SB1->B1_UM)==0
		cLinha+="07"																											//TIPOREGISTRO
		cLinha+=PR111Trans("NCGAMES","C",15)																			//CODIGODEPOSITANTE
		cLinha+=PR111Trans(SB1->B1_COD,"C",25)																			//CODIGOPRODUTO
		cLinha+=PR111Trans(SB1->B1_UM,"C",05)																			//TIPOUC
		cLinha+=PR111Trans("UNICO","C",20)			//DESCRICAOTIPOUC
		cLinha+=PR111Trans(1,"N",20)																		  				//FATORUC
		cLinha+=PR111Trans(1,"N",20)																	//LARGURA
		cLinha+=PR111Trans(1,"N",20)														            //COMPRIMENTO
		cLinha+=PR111Trans(1,"N",20)															            //ALTURA
		cLinha+=PR111Trans(1,"N",20)																		//PESOLIQUIDOPRODUTO
		cLinha+=PR111Trans(1,"N",20)																		//PESOBRUTOPRODUTO
		cLinha+=PR111Trans(1,"N",10)																						//TOTALVOLUME
		cLinha+=Space(15)																						  				//IDTIPOUC
		cLinha+=Space(25)																						  				//INFORMACAOADICIONAL1
		cLinha+=Space(25)																						  				//INFORMACAOADICIONAL2
		cLinha+=Space(25)																						  				//INFORMACAOADICIONAL3
		cLinha+=PR111Trans(0,"N",10)																						//GRUPOTIPOUC
		cLinha+=CRLF
		AAdd(aDadosA06,SB1->B1_UM)
	EndIf
ElseIf cLayout=="A07"
	cLinha+="12"																											//TIPOREGISTRO
	cLinha+=PR111Trans("NCGAMES","C",15)																			//CODIGODEPOSITANTE
	cLinha+=PR111Trans(SB1->B1_COD,"C",25)																			//CODIGOPRODUTO
	cLinha+=PR111Trans(SB1->B1_UM,"C",05)	 																		//TIPOUC
	cLinha+=PR111Trans(SB1->B1_CODBAR,"C",25)			 																		//CODIGOPRODUTORELACIONADO
	cLinha+=PR111Trans("EAN13","C",10)			 																		//TIPOCODIGORELACIONADO
	cLinha+=PR111Trans(1,"N",20)																		  				//FATORUC
	cLinha+=Space(50)																						  				//FILLER
	cLinha+=CRLF
ElseIf cLayout=="A09"
	
	If cTabela=="SA1
		AADD(aDadosA09,SA1->A1_CGC) 								///1
		AADD(aDadosA09,SA1->A1_CGC) 								//02
		AADD(aDadosA09,SA1->A1_NOME) 								//03
		AADD(aDadosA09,SA1->A1_END )								//04
		AADD(aDadosA09,SA1->A1_BAIRRO)							//05
		AADD(aDadosA09,SA1->A1_MUN)								//06
		AADD(aDadosA09,SA1->A1_EST)								//07
		AADD(aDadosA09,SA1->A1_CEP)								//08
		AADD(aDadosA09,SA1->A1_INSCR)								//09
		AADD(aDadosA09,SA1->A1_PESSOA)							//10
		AADD(aDadosA09,SA1->A1_COD )								//11
		AADD(aDadosA09,"CLIENTE" )									//12
	ElseIf cTabela=="SA2"
		AADD(aDadosA09,IIf(SA2->A2_TIPO=="X","00000000000000",SA2->A2_CGC))	//01
		AADD(aDadosA09,IIf(SA2->A2_TIPO=="X","00000000000000",SA2->A2_CGC))	//02
		AADD(aDadosA09,SA2->A2_NOME )								//03
		AADD(aDadosA09,SA2->A2_END )								//04
		AADD(aDadosA09,SA2->A2_BAIRRO)							//05
		AADD(aDadosA09,SA2->A2_MUN)								//06
		AADD(aDadosA09,SA2->A2_EST)								//07
		AADD(aDadosA09,SA2->A2_CEP)								//08
		AADD(aDadosA09,SA2->A2_INSCR )							//09
		AADD(aDadosA09,IIf(SA2->A2_TIPO=="X","J",SA2->A2_TIPO))	//10
		AADD(aDadosA09,SA2->A2_COD )								//11
		AADD(aDadosA09,"FORNECEDOR" )								//12
	ElseIf cTabela=="SA4"
		AADD(aDadosA09,SA4->A4_CGC) 								///1
		AADD(aDadosA09,SA4->A4_CGC) 								//02
		AADD(aDadosA09,SA4->A4_NOME )								//03
		AADD(aDadosA09,SA4->A4_END )								//04
		AADD(aDadosA09,SA4->A4_BAIRRO)							//05
		AADD(aDadosA09,SA4->A4_MUN    )							//06
		AADD(aDadosA09,SA4->A4_EST    )							//07
		AADD(aDadosA09,SA4->A4_CEP    )							//08
		AADD(aDadosA09,SA4->A4_INSEST )							//09
		AADD(aDadosA09,"J")											//10
		AADD(aDadosA09,SA4->A4_COD )								//11
		AADD(aDadosA09,"TRANSPORTADORA")							//12
	EndIf
	
	
	cLinha+=PR111Trans("20"			,'C',2)      //TIPOREGISTRO 				Posicao:1
	cLinha+=PR111Trans("NCGAMES"	,'C',15)     //CODIGODEPOSITANTE 		Posicao:3
	cLinha+=PR111Trans(aDadosA09[01]	,'C',15)  //CODIGOEMPRESA 				Posicao:18
	cLinha+=PR111Trans(aDadosA09[02],'C',15)   //CGCEMPRESA 					Posicao:33
	cLinha+=PR111Trans(aDadosA09[03],'C',40)   //NOMEEMPRESA 				Posicao:48
	cLinha+=PR111Trans(aDadosA09[04],'C',40)   //ENDERECOEMPRESA 			Posicao:88
	cLinha+=PR111Trans(aDadosA09[05],'C',25)   //BAIRROEMPRESA 				Posicao:128
	cLinha+=PR111Trans(aDadosA09[06],'C',25)   //MUNICIPIOEMPRESA 			Posicao:153
	cLinha+=PR111Trans(aDadosA09[07],'C',2)    //UFEMPRESA 					Posicao:178
	cLinha+=PR111Trans(aDadosA09[08],'C',9)    //CEPEMPRESA 					Posicao:180
	cLinha+=PR111Trans(aDadosA09[09],'C',15)   //INSCRICAOEMPRESA 			Posicao:189
	cLinha+=PR111Trans("",'C',10)              //TIPOEMPRESA 		  		Posicao:204
	cLinha+=PR111Trans(aDadosA09[10],'C',1)    //TIPOPESSOAEMPRESA  		Posicao:214
	cLinha+=PR111Trans(aDadosA09[11],'C',15)   //IDEMPRESA 					Posicao:215
	cLinha+=PR111Trans("0",'N',1)       		//DEPOSITANTE 					Posicao:230
	cLinha+=PR111Trans(aDadosA09[12],'C',25) 	//INFORMACAOADICIONAL1 		Posicao:231
	cLinha+=PR111Trans("",'C',25)      			//INFORMACAOADICIONAL2 		Posicao:256
	cLinha+=PR111Trans("",'C',25)      			//INFORMACAOADICIONAL3 		Posicao:281
	cLinha+=PR111Trans("",'C',13)      			//GTINEMPRESA 					Posicao:306
	cLinha+=PR111Trans(0,'N',10)      			//CODIGOESTABELECIMENTO 	Posicao:319
	cLinha+=PR111Trans("",'C',50)      			//FILLER 						Posicao:329
	cLinha+=CRLF
EndIf



RestArea(aAreaSD1)
RestArea(aAreaSA1)
RestArea(aAreaSA2)
RestArea(aAreaSA4)
RestArea(aAreaAtu)

Return cLinha

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR111  บAutor  ณMicrosiga           บ Data ณ  09/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR111Trans(uDado,cTipo,nTam,lDecimal)
Local cRetorno

Default lDecimal:=.T.


Do Case
	Case cTipo=="C"
		cRetorno:=Padr( AllTrim(uDado),nTam )
	Case cTipo=="N"
		cRetorno:=Padl(StrTran(AllTrim(Transform(uDado,IIf(lDecimal,"@E 999999999.9999","@E 999999999"))),",","") ,nTam,"0")
	Case cTipo=="D"
		cRetorno:=StrZero(Day(uDado),2)+StrZero(Month(uDado),2)+StrZero(Year(uDado),4)
EndCase

Return cRetorno
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR111  บAutor  ณMicrosiga           บ Data ณ  11/02/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR111RetLayout(cLayout)
Local aPosicao:={}

If cLayout=="A01"//Documento
	Aadd(aPosicao,{'TIPOREGISTRO','C',1,2})//1
	Aadd(aPosicao,{'CODIGODEPOSITANTE','C',3,15})//2
	Aadd(aPosicao,{'CODIGOEMPRESA','C',18,15})//3
	Aadd(aPosicao,{'CGCEMPRESA','C',33,15})//4
	Aadd(aPosicao,{'NOMEEMPRESA','C',48,40})//5
	Aadd(aPosicao,{'ENDERECOEMPRESA','C',88,40})//6
	Aadd(aPosicao,{'BAIRROEMPRESA','C',128,25})//7
	Aadd(aPosicao,{'MUNICIPIOEMPRESA','C',153,25})//8
	Aadd(aPosicao,{'UFEMPRESA','C',178,2})//9
	Aadd(aPosicao,{'CEPEMPRESA','C',180,9})//10
	Aadd(aPosicao,{'INSCRICAOEMPRESA','C',189,15})//11
	Aadd(aPosicao,{'TIPODOCUMENTO','C',204,5})//12
	Aadd(aPosicao,{'SERIEDOCUMENTO','C',209,5})//13
	Aadd(aPosicao,{'NUMERODOCUMENTO','C',214,10})//14
	Aadd(aPosicao,{'CODIGOMATRIZ','C',224,15})//15
	Aadd(aPosicao,{'CODIGOESTABELECIMENTO','N',239,10})//16
	Aadd(aPosicao,{'NATUREZAOPERACAO','C',249,6})//17
	Aadd(aPosicao,{'CONHECIMENTOTRANSPORTE','C',255,10})//18
	Aadd(aPosicao,{'DATAEMISSAO','D',265,8})//19
	Aadd(aPosicao,{'VALORTOTALDOCUMENTO','N',273,20})//20
	Aadd(aPosicao,{'VALORTOTALPRODUTO','N',293,20})//21
	Aadd(aPosicao,{'VALORICMS','N',313,20})//22
	Aadd(aPosicao,{'VALORICMSSUB','N',333,20})//23
	Aadd(aPosicao,{'VALORIPI','N',353,20})//24
	Aadd(aPosicao,{'VALORFRETE','N',373,20})//25
	Aadd(aPosicao,{'BASEICMS','N',393,20})//26
	Aadd(aPosicao,{'BASEICMSSUB','N',413,20})//27
	Aadd(aPosicao,{'BASEIPI','N',433,20})//28
	Aadd(aPosicao,{'VALORSEGURO','N',453,20})//29
	Aadd(aPosicao,{'VALORDESCONTO','N',473,20})//30
	Aadd(aPosicao,{'VALORACRESCIMO','N',493,20})//31
	Aadd(aPosicao,{'CODIGOTRANSPORTADORA','C',513,15})//32
	Aadd(aPosicao,{'INFORMACAOADICIONAL1','C',528,25})//33
	Aadd(aPosicao,{'INFORMACAOADICIONAL2','C',553,25})//34
	Aadd(aPosicao,{'INFORMACAOADICIONAL3','C',578,25})//35
	Aadd(aPosicao,{'CODIGOEMPRESAENTREGA','C',603,15})//36
	Aadd(aPosicao,{'CODIGOEMPRESAFATURAMENTO','C',618,15})//37
	Aadd(aPosicao,{'CODIGOEMPRESADESTINO','C',633,15})//38
	Aadd(aPosicao,{'CODIGOEMPRESAEMITENTE','C',648,15})//39
	Aadd(aPosicao,{'DATAMOVIMENTO','D',663,8})//40
	Aadd(aPosicao,{'PESOBRUTO','N',671,20})//41
	Aadd(aPosicao,{'PESOLIQUIDO','N',691,20})//42
	Aadd(aPosicao,{'CFOP','C',711,6})//43
	Aadd(aPosicao,{'ESPECIEDOCUMENTO','C',717,5})//44
	Aadd(aPosicao,{'TIPOEMPRESA','C',722,10})//45
	Aadd(aPosicao,{'TIPOPESSOAEMPRESA','C',732,1})//46
	Aadd(aPosicao,{'ESTADODOCUMENTO','N',733,10})//47
	Aadd(aPosicao,{'ESPECIEVOLUME','C',743,40})//48
	Aadd(aPosicao,{'QUANTIDADEVOLUME','N',783,20})//49
	Aadd(aPosicao,{'MARCAVOLUME','C',803,10})//50
	Aadd(aPosicao,{'NUMEROVOLUME','C',813,10})//51
	Aadd(aPosicao,{'TIPOFRETE','N',823,10})//52
	Aadd(aPosicao,{'PLACAVEICULO','C',833,7})//53
	Aadd(aPosicao,{'UFVEICULO','C',840,2})//54
	Aadd(aPosicao,{'NFECHAVEACESSO','C',842,44})//55
	Aadd(aPosicao,{'NFEESTADO','N',886,3})//56
	Aadd(aPosicao,{'NFEDATAAUTORIZACAO','D',889,14})//57
	Aadd(aPosicao,{'AGRUPADOR','C',903,25})//58
	Aadd(aPosicao,{'ESTADOOPERACAO','N',928,3})//59
	Aadd(aPosicao,{'DATAINICIOOPERACAO','D',931,14})//60
	Aadd(aPosicao,{'FILLER','C',945,10})//61
ElseIf cLayout=="A02"//Item Documento
	Aadd(aPosicao,{'TIPOREGISTRO','C',1,2})//1
	Aadd(aPosicao,{'CODIGOEMPRESA','C',3,15})//2
	Aadd(aPosicao,{'TIPODOCUMENTO','C',18,5})//3
	Aadd(aPosicao,{'SERIEDOCUMENTO','C',23,5})//4
	Aadd(aPosicao,{'NUMERODOCUMENTO','C',28,10})//5
	Aadd(aPosicao,{'CODIGODEPOSITANTE','C',38,15})//6
	Aadd(aPosicao,{'CODIGOPRODUTO','C',53,25})//7
	Aadd(aPosicao,{'QUANTIDADE','N',78,20})//8
	Aadd(aPosicao,{'TIPOUC','C',98,5})//9
	Aadd(aPosicao,{'FATORTIPOUC','N',103,20})//10
	Aadd(aPosicao,{'ALIQUOTAICMS','N',123,20})//11
	Aadd(aPosicao,{'ALIQUOTAIPI','N',143,20})//12
	Aadd(aPosicao,{'FILLER','C',163,20})//13
	Aadd(aPosicao,{'ALIQUOTAICMSSUB','N',183,20})//14
	Aadd(aPosicao,{'TIPOLOGISTICO','N',203,10})//15
	Aadd(aPosicao,{'DADOLOGISTICO','C',213,15})//16
	Aadd(aPosicao,{'CLASSEPRODUTO','C',228,5})//17
	Aadd(aPosicao,{'SEQUENCIAITEM','N',233,3})//18
	Aadd(aPosicao,{'INFORMACAOADICIONAL1','C',236,25})//19
	Aadd(aPosicao,{'INFORMACAOADICIONAL2','C',261,25})//20
	Aadd(aPosicao,{'INFORMACAOADICIONAL3','C',286,25})//21
	Aadd(aPosicao,{'NATUREZAOPERACAO','C',311,6})//22
	Aadd(aPosicao,{'CFOP','C',317,6})//23
	Aadd(aPosicao,{'CLASSIFICACAOFISCAL','C',323,10})//24
	Aadd(aPosicao,{'SITUACAOTRIBUTARIA','N',333,10})//25
	Aadd(aPosicao,{'FILLER','C',343,20})//26
	Aadd(aPosicao,{'FILLER','C',363,20})//27
	Aadd(aPosicao,{'IDTIPOUC','C',383,15})//28
	Aadd(aPosicao,{'IDPRODUTO','C',398,25})//29
	Aadd(aPosicao,{'PESOBRUTO','N',423,20})//30
	Aadd(aPosicao,{'PESOLIQUIDO','N',443,20})//31
	Aadd(aPosicao,{'ALIQUOTAICMSREDUCAO','N',463,20})//32
	Aadd(aPosicao,{'FATORBASEICMS','N',483,20})//33
	Aadd(aPosicao,{'ALIQUOTAIPIREDUCAO','N',503,20})//34
	Aadd(aPosicao,{'FATORBASEIPI','N',523,20})//35
	Aadd(aPosicao,{'VALORUNITARIO','N',543,20})//36
	Aadd(aPosicao,{'VALORDESCONTO','N',563,20})//37
	Aadd(aPosicao,{'VALORACRESCIMO','N',583,20})//38
	Aadd(aPosicao,{'CODIGOESTABELECIMENTO','N',603,10})//39
	Aadd(aPosicao,{'FILLER','C',613,10})//40
ElseIf cLayout=="A13"//Lote Sequ๊ncia (Rela็ใo de Lotes Dependentes)
	Aadd(aPosicao,{'TIPOREGISTRO','C',1,2})//01
	Aadd(aPosicao,{'CODIGOESTABELECIMENTO','N',3,10})//02
	Aadd(aPosicao,{'CODIGODEPOSITANTE','C',13,15})//03
	Aadd(aPosicao,{'CODIGOEMPRESA','C',28,15})//04
	Aadd(aPosicao,{'TIPODOCUMENTO','C',43,5})//05
	Aadd(aPosicao,{'SERIEDOCUMENTO','C',48,5})//06
	Aadd(aPosicao,{'NUMERODOCUMENTO','C',53,10})//07
	Aadd(aPosicao,{'CODIGOEMPRESADEPENDENTE','C',63,15})//08
	Aadd(aPosicao,{'TIPODOCUMENTODEPENDENTE','C',78,5})//09
	Aadd(aPosicao,{'SERIEDOCUMENTODEPENDENTE','C',83,5})//10
	Aadd(aPosicao,{'NUMERODOCUMENTODEPENDENTE','C',88,10})//11
	Aadd(aPosicao,{'ESPECIEDOCUMENTO','C',98,5})//12
	Aadd(aPosicao,{'ESPECIEDOCUMENTODEPENDENTE','C',103,5})//13
	Aadd(aPosicao,{'LOTE','N',108,10})//14
	Aadd(aPosicao,{'LOTESEQUENCIA','N',118,10})//15
	Aadd(aPosicao,{'LOTEDEPENDENTE','N',128,10})//16
	Aadd(aPosicao,{'LOTESEQUENCIADEPENDENTE','N',138,10})//17
	Aadd(aPosicao,{'CODIGOPRODUTO','C',148,25})//18
	Aadd(aPosicao,{'QUANTIDADE','N',173,20})//19
	Aadd(aPosicao,{'TIPOUC','C',193,5})//20
	Aadd(aPosicao,{'FATORTIPOUC','N',198,20})//21
	Aadd(aPosicao,{'CLASSEPRODUTO','C',218,5})//22
	Aadd(aPosicao,{'LOTEFABRICACAO','C',223,25})//23
	Aadd(aPosicao,{'DATAFABRICACAO','D',248,10})//24
	Aadd(aPosicao,{'DATAVENCIMENTO','D',258,10})//25
	Aadd(aPosicao,{'LOTEGERAL','C',268,25})//26
	Aadd(aPosicao,{'NFECHAVEACESSODEPENDENTE','C',293,44})//27
	Aadd(aPosicao,{'NFEESTADODEPENDENTE','N',337,3})//28
	Aadd(aPosicao,{'NFEDATAAUTORIZACAODEPENDENTE','D',340,18})//29
ElseIf cLayout=="A16"//Posi็ใo Estoque
	Aadd(aPosicao,{'TIPOREGISTRO','C',1,2})//01
	Aadd(aPosicao,{'CODIGOESTABELECIMENTO','N',3,10})//02
	Aadd(aPosicao,{'CODIGODEPOSITANTE','C',13,15})//03
	Aadd(aPosicao,{'CODIGOPOSICAOESTOQUE','C',28,10})//04
	Aadd(aPosicao,{'NUMEROPOSICAOESTOQUE','C',38,10})//05
	Aadd(aPosicao,{'DATAPOSICAOESTOQUE','D',48,14})//05
	Aadd(aPosicao,{'CODIGOPRODUTO','C',62,25})//07
	Aadd(aPosicao,{'TIPOUC','C',87,5})//08
	Aadd(aPosicao,{'FATORTIPOUC','N',92,20})//09
	Aadd(aPosicao,{'LOTEFABRICACAO','C',112,25})//10
	Aadd(aPosicao,{'DATAFABRICACAO','D',137,8})//11
	Aadd(aPosicao,{'DATAVENCIMENTO','D',145,8})//12
	Aadd(aPosicao,{'LOTEGERAL','C',153,25})//13
	Aadd(aPosicao,{'CLASSEPRODUTO','C',178,5})//14
	Aadd(aPosicao,{'QUANTIDADETOTAL','N',183,20})//15
	Aadd(aPosicao,{'QUANTIDADEBLOQUEADO','N',203,20})//16
	Aadd(aPosicao,{'QUANTIDADEEMPENHADO','N',223,20})//17
	Aadd(aPosicao,{'FILLER','C',243,50})//18
ElseIf cLayout=="A08"//Numero de Serie
	Aadd(aPosicao,{'TIPOREGISTRO','C',1,2})//01
	Aadd(aPosicao,{'CODIGOEMPRESA','C',3,15})//02
	Aadd(aPosicao,{'TIPODOCUMENTO','C',18,5})//03
	Aadd(aPosicao,{'SERIEDOCUMENTO','C',23,5})//04
	Aadd(aPosicao,{'NUMERODOCUMENTO','C',28,10})//05
	Aadd(aPosicao,{'CODIGODEPOSITANTE','C',38,15})//06
	Aadd(aPosicao,{'CODIGOPRODUTO','C',53,25})//07
	Aadd(aPosicao,{'NUMEROSERIE','C',78,25})//08
	Aadd(aPosicao,{'DATACONFERENCIA','D',103,08})//09
	Aadd(aPosicao,{'HORACONFERENCIA','D',111,06})//09
EndIf


Return aPosicao
