#Include 'Protheus.Ch'
#Include 'TopConn.Ch'
#Include 'TbiConn.Ch'
#Include 'XMLXFUN.Ch'
#Include 'TOTVS.Ch'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE "TOTVS.CH"
#include "Fileio.ch"

user function geraCSVimp()

Local aArea := GetArea()
Local cFileOpen 	:= ""
Local cExtens   	:= "Arquivo XML | *.xml"
Local dirPadr := "C:\notas-a-processar\"
Local cBuffer := ""
Local tagsXML :=""
Private oXML
Public cError      := ""
Public cWarning    := ""
cFileOpen := cGetFile( '*.xml|*.xml' , 'NOTAS (XML)', 1, dirPadr, .F., GETF_LOCALHARD + GETF_LOCALFLOPPY)
         
If Empty(cFileOpen)                                                                 
   MsgAlert("Nenhum arquivo selecionado! O processo será finalizado!","Arquivo não selecionado!")
   Return
EndIF

If !File(cFileOpen)
   MsgAlert("Arquivo texto: "+cFileOpen+" não localizado!","Arquivo não encontrado!")
   Return
Endif
      Processa()
		FT_FUSE(cFileOpen)  //ABRIR XLM
		FT_FGOTOP() 		//PONTO NO TOPO
		ProcRegua(FT_FLASTREC()) //QTOS REGISTROS LER
		
		While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
			IncProc("Efetuando a leitura do arquivo")
			
			cBuffer := FT_FREADLN() //LENDO LINHA
			
			tagsXML += cBuffer
			
			FT_FSKIP()   //pr?imo registro no arquivo txt
		EndDo
		FT_FUSE()
		
		oXML := XmlParser( tagsXML, "_", @cError, @cWarning)
		MsgRun("Processando....", "Lendo o arquivo XML",{|| ProcItens()})
//		Processa(ProcItens())

restArea(aArea)
return

Static Function ProcItens()
Local aArea := GetArea()
local cod
Local qtd
Local vuni
Local vTot
Local bProd
Local desc
Local nItens
Local aCabExcel :={}
Local aItens:={}

IF(Type("oXML:_NFEPROC:_NFE:_INFNFE:_DET") == "A")
	nItens := LEN(oXML:_NFEPROC:_NFE:_INFNFE:_DET)
ELSEIF(Type("oXML:_NFEPROC:_NFE:_INFNFE:_DET") == "O")
	nItens := 1
ENDIF

ProcRegua(nItens)

For nX:=1 To nItens
	IncProc( 'Processando Item ' + Str(nX) + " de " + Str(nItens) + " itens.")
	
	IF !(nItens == 1)
		cod	:= iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_CPROD)== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_CPROD:TEXT	,"")
		qtd   := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_QCOM) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_QCOM:TEXT	,"")
		vuni  := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_VUNCOM) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_VUNCOM:TEXT,"")
		vTot  := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_VPROD) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_VPROD:TEXT	,"")
		desc 	:=	iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_XPROD) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_XPROD:TEXT	,"")
		bProd := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_CEAN) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_CEAN:TEXT	,"")	
		iif(empty(bProd), bProd:= "0", bProd:= bProd)
		
	ELSE
		cod	   := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_CPROD)== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_CPROD:TEXT	,"")
		qtd   := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_QCOM) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_QCOM:TEXT		,"")
		vuni  := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_VUNCOM) == "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_VUNCOM:TEXT	,"")
		vTot  := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_VPROD) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_VPROD:TEXT	,"")
		bProd := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_CEAN) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_CEAN:TEXT		,"")
		iif(empty(bProd), bProd:= "0", bProd:= bProd)
	ENDIF
	//ITEM,CODIGO,CODIGO DE BARRAS, CODIGO NC,DESCRICAO, QUANTIDADE, VALOR UNITARIO, TOTAL, TES, Armazem, Nota Origem, Serie Nota Origem
	aadd(aItens,{nX,cod,trim(bProd),space(15),desc,STRTRAN(qtd,".",","),STRTRAN(vuni,".",","),STRTRAN(vTot,".",","),"   ","03", "XXXXXXXXX","XXX","X"})
	
Next

	AADD(aCabExcel,{"Item","N"				,TamSX3("D1_ITEM")[1],0} )
	AADD(aCabExcel,{"Cod Nota","C"			,TamSX3("D1_DOC")[1],0} )
	AADD(aCabExcel,{"Cod de Barras","C"	,TamSX3("B1_CODBAR")[1],0} )
	AADD(aCabExcel,{"Codigo Protheus","C"	,TamSX3("B1_COD")[1],0} )
	AADD(aCabExcel,{"Descrição","C"	,TamSX3("B1_DESC")[1],0} )
	AADD(aCabExcel,{"Quantidade","C"		,TamSX3("D1_QUANT")[1],0} )
	AADD(aCabExcel,{"Valor unitario","C"	,TamSX3("D1_VUNIT")[1],0} )
	AADD(aCabExcel,{"Total","C"				,TamSX3("D1_TOTAL")[1],0} )
	AADD(aCabExcel,{"TES","C"				,TamSX3("D1_TES")[1],0} )
	AADD(aCabExcel,{"Armazem","C"			,TamSX3("D1_LOCAL")[1],0} )
	AADD(aCabExcel,{"Nota Origem","C"			,TamSX3("D1_NFORI")[1],0} )
	AADD(aCabExcel,{"Serie Origem","C"			,TamSX3("D1_SERIORI")[1],0} )
	
	MsgRun("Favor Aguardar, Exportando para EXCEL....", "Exportando os Registros para o Excel",{||DlgToExcel({{"GETDADOS","",aCabExcel,aItens}})})
	
RestArea(aArea)
Return
