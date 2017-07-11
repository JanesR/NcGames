#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#Include "XMLXFUN.CH"
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Ecom16JOB  ºAutor  ³Janes Raulino      º Data ³  28/06/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Ecom16Job(aDados)

Default aDados:={"01","03"}
RpcSetEnv(aDados[1],aDados[2])

U_NcEcom16()

RpcClearEnv()

Return

User Function NCECOM16(cNumPV)

Local aAreaAtu	:= GetArea()
Local aAreaZC5	:= ZC5->(GetArea())
Local aAreaQry	:= GetNextAlias()

Local oobj		:= nil
Local oXml		:= nil
Local _cxml		:= ""
Local cError	:= ""
Local cWarning	:= ""
Local _cQuery	:= ""
Local _aStatus	:= {}
Local _aConfi	:= {}
Local nHDL
Local _aXml		:= {}
Local _nCont	:= 0

Default cNumPV:=""

    _cQuery := "select zc5.ZC5_STATUS , zc5.ZC5_NUM,zc5.ZC5_NUMPV, zc5.ZC5_ATUALI, "+CRLF
    _cQuery += "zc5.zc5_plataf, zc5.ZC5_CODENT ,sc5.C5_EMISSAO,ZC5.ZC5_NOTA,ZC5_SERIE,zc5.ZC5_RASTRE, zc5.R_E_C_N_O_"+CRLF
    _cQuery += "from "+RetSqlName("ZC5")+" zc5"+CRLF
    _cQuery += "left join "+RetSqlName("SC5")+" sc5"+CRLF
    _cQuery += "on zc5.ZC5_NUMPV = sc5.c5_num"+CRLF
    _cQuery += "where zc5_filial = '"+xFilial("ZC5")+"'"+CRLF
    _cQuery += "and zc5.D_E_L_E_T_ = ' '"+CRLF
    _cQuery += "and sc5.D_E_L_E_T_ = ' '"+CRLF
    _cQuery += "and ZC5_NUM != 0"+CRLF
    _cQuery += "and zc5.ZC5_PLATAF in( ' ','01')"+CRLF
    _cQuery += "and ZC5_STATUS in('15','30','40')"+CRLF
    _cQuery += "and sc5.C5_EMISSAO BETWEEN '20160101' and '20171231'"+CRLF
    //_cQuery += "and zc5.ZC5_ATUALI = 'N'"+CRLF
                                                                        
    _cQuery := ChangeQuery(_cQuery)

    DbUseArea(.T., "TOPCONN", TCGenQry(,,_cQuery), aAreaQry, .T., .F.)


//Verifica quais pedidos precisam ser atualizados
While (aAreaQry)->(!Eof())
	
	Aadd(_aStatus,{(aAreaQry)->ZC5_NUM,(aAreaQry)->ZC5_STATUS,(aAreaQry)->R_E_C_N_O_})
	
	(aAreaQry)->(DbSkip())
EndDo

(aAreaQry)->(DbGoTop())

For i:=1 to Len(_aStatus)
	If _nCont==1000
		_nCont:=0
		Aadd(_aXml,_cxml)
		_cXml:=""
	Endif
	
	ZC5->(DbGoTo(_aStatus[i][3]))
	
	_cxml+='<receipt_status xmlns="" op="I" order_id="'+alltrim(str((aAreaQry)->ZC5_NUM))+'" passo="'+(aAreaQry)->ZC5_STATUS+'"'
	
	If     alltrim((aAreaQry)->ZC5_STATUS) == "15"
            _cxml+=' status_shopper="Enviado para a Expedição Pedido Venda ERP:'+(aAreaQry)->ZC5_NUMPV+'| Nota Fiscal '+(aAreaQry)->ZC5_NOTA+'/'+(aAreaQry)->ZC5_SERIE+'"'
            _cxml+=' status_adm="Enviado para a Expedição"
            _cxml+=' rastreamento=""
            _cxml+=' sendMail="1"
            _cxml+=' shipping_method="" />'
            Aadd(_aConfi,{alltrim(str((aAreaQry)->ZC5_NUM)),"1"})
       //JR
        ElseIf (aAreaQry)->ZC5_STATUS =="30" .And. !Empty((aAreaQry)->ZC5_RASTRE)
            _cxml+=' status_shopper="Enviado para o Cliente"'
            _cxml+=' status_adm="Enviado para a Cliente"
            _cxml+=' rastreamento="'+(aAreaQry)->ZC5_RASTRE+'"'
            _cxml+=' sendMail="1"
            _cxml+=' shipping_method="" />'
            Aadd(_aConfi,{alltrim(str((aAreaQry)->ZC5_NUM)),"1"})
        ElseIf (aAreaQry)->ZC5_STATUS =="40"
            _cxml+=' status_shopper="Pedido Entregue"'
            _cxml+=' status_adm="Pedido Entregue"
            _cxml+=' rastreamento=""'
            _cxml+=' sendMail="1"
            _cxml+=' shipping_method="" />'
            Aadd(_aConfi,{alltrim(str((aAreaQry)->ZC5_NUM)),"1"})
	Endif
	
	ZC5->(Reclock("ZC5",.F.))
	ZC5->ZC5_ATUALI := "N"
	ZC5->(MsUnlock())
	
    (aAreaQry)->(DbSkip())
	_nCont++
	
Next i

If !Empty(Alltrim(_cxml))
	Aadd(_aXml,_cxml)
Endif


For i:=1 to Len(_aXml)
	
	_cxml:='<?xml version="1.0" encoding="utf-8" standalone="no" ?><receipt_statusList xmlns="dsReceipt.xsd">'
	_cxml+=_aXml[i]
	_cxml+='</receipt_statusList>'
	

	oobj:=NC_WSWSIntegracao():new()
	
	oobj:StatusPedidos(SuperGetMV("EC_NCG0010",,"wsncgames"),SuperGetMV("EC_NCG0011",,"apeei.1453"),_cxml)
	
	If oobj:lStatusPedidosResult
		
		//transforma o xml do resultado em objeto
		oXml := XmlParser( oobj:cxml, "_", @cError, @cWarning )
		
	Else
		
	Endif
	
Next i


If Len(_aConfi)>0
	u_NcEcom06(_aConfi)
Endif

Semaforo(.F.,nHDL,"NCECOM07")

(aAreaQry)->(DbCloseArea())
RestArea(aAreaZC5)
RestArea(aAreaAtu)
Return