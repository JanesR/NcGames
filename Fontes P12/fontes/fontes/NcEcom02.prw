#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#Include "XMLXFUN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNcEcom02  บAutor  ณOctavio A. Estevam  บ Data ณ  29/11/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Integra็ใo Protheus x CiaShop                              บฑฑ
ฑฑบ          ณ Atualiza o status de importa็ใo na ferramenta Ciashop      บฑฑ
ฑฑบ          ณ para que o cliente nao seja mais importado ate sofrer uma  บฑฑ
ฑฑบ          ณ altera็ใo.                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NcEcom02(_aStatus)
Local oobj		:= nil
Local oXml		:= nil
Local _cxml		:= ""
Local cError   := ""
Local cWarning := ""
Local _aXml		:= {}
Local _nCont	:= 0

//Recebe por parametro os clientes a retornar para o Portal CiaShop
Default _aStatus := {}

For i:=1 to Len(_aStatus)
	If _nCont==1000
		_nCont := 0
		Aadd(_aXml,_cxml)
		_cXml := ""
	Endif
	_cxml+='<shopper_result xmlns="" shopper_id="'+_aStatus[i][1]+'" processed="'+_aStatus[i][2]+'" />'
	_nCont++
Next i
If !Empty(Alltrim(_cxml))
	Aadd(_aXml,_cxml)
Endif


For i:=1 to Len(_aXml)
	
	_cxml:='<?xml version="1.0" encoding="utf-8" standalone="no" ?><shopper_resultList xmlns="dsReceipt.xsd">'
	_cxml+=_aXml[i]
	_cxml+='</shopper_resultList>'
	
	//Cria o Obejto com os M้todos do Portal CiaShop
	oobj:=NC_WSWSIntegracao():new()
	//U_NcEcoLog("NcEcom02()","Resultado da atualiza็ใo do Status na Ciashop dos clientes importados:")
	//chama o metodo do portal
	If oobj:Confirmacompradores(SuperGetMV("EC_NCG0010",,"wsncgames"),SuperGetMV("EC_NCG0011",,"apeei.1453"),_cxml)		
		//transforma o xml do resultado em objeto
		oXml := XmlParser( oobj:cxml, "_", @cError, @cWarning )
		//recupera o conteudo dentro do objeto xml
	Else
		//U_NcEcoLog("NcEcom02()","Erro de Execu็ใo : "+GetWSCError())
		//U_COM09CAD("CLIENTE","CLIENTE","CONFIRMA","",GetWSCError(),"")
		U_COM09CAD("","CLIENTE","CONFIRMA","","",GetWSCError(),"")
	Endif
Next i
Return
