#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#Include "XMLXFUN.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NcEcom06  �Autor  �Octavio A. Estevam  � Data �  20/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Integra��o Protheus x CiaShop                              ���
���          � Atualiza o status de importa��o na ferramenta Ciashop      ���
���          � para que o pedido nao seja mais importado                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function NcEcom06(_aStatus)
Local oobj 		:=nil
Local oXml 		:=nil
Local _cxml		:=""
Local cError   := ""
Local cWarning := ""
Local _aXml		:={}
Local _nCont	:=0

//Recebe por parametro os pedidos a retornar para o Portal CiaShop
Default _aStatus := {}

For i:=1 to Len(_aStatus)
	If _nCont==1000
		_nCont:=0
		Aadd(_aXml,_cxml)
		_cXml:=""
	Endif
	_cxml+='<receipt_result xmlns="" order_id="'+alltrim(str(_aStatus[i][1]))+'" processed="'+_aStatus[i][2]+'" />'
	_nCont++
	
Next 

If !Empty(Alltrim(_cxml))
	Aadd(_aXml,_cxml)
Endif


For i:=1 to Len(_aXml)
	
	_cxml:='<?xml version="1.0" encoding="utf-8" standalone="no" ?><receipt_resultList xmlns="dsReceipt.xsd">'
	_cxml+=_aXml[i]
	_cxml+='</receipt_resultList>'
	
	//Cria o Obejto com os M�todos do Portal CiaShop
	oobj:=NC_WSWSIntegracao():new()
	//U_NcEcoLog("NcEcom06()","Resultado da atualiza��o do Status na Ciashop dos pedidos importados:")
	//chama o metodo do portal
	
	                                       
	//oSrv:=RpcConnect( "192.168.0.217",1242,"TOTVSHOM_ECOMMERCE","01","03" )
	//aReturn:=(oSrv:callproc("U_M06POST",_cxml))
	//RpcDisconnect (oSrv )
	         
	//oobj:lConfirmaPedidosResult :=aResult[1]
	//oobj:cxml               	:=aResult[2] 
	                                
	oobj:ConfirmaPedidos(SuperGetMV("EC_NCG0010",,"wsncgames"),SuperGetMV("EC_NCG0011",,"apeei.1453"),_cxml)
	
	If oobj:lConfirmaPedidosResult  
		
		//transforma o xml do resultado em objeto
		oXml := XmlParser( oobj:cxml, "_", @cError, @cWarning )
		
		//recupera o conteudo dentro do objeto xml
		//U_NcEcoLog("NcEcom06()",oxml:_result:_resulttext:text)
	Else
		//U_NcEcoLog("NcEcom06()","Erro de Execu��o : "+GetWSCError())
	Endif
	
Next i
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCECOM06  �Autor  �Microsiga           � Data �  11/24/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function xConfPed(aDados)
Local aPed := {}
Local aAreaZC5

Default aDados := {"01","03"}

RpcSetEnv(aDados[1],aDados[2])

aAreaZC5 := ZC5->(DbSelectArea("ZC5"))
ZC5->(DbsetOrder(1))
Do While ZC5->(!EOF())
	If ZC5->ZC5_NUM > 6300 .And. ZC5->ZC5_NUM < 6370
		Aadd(aPed,{ZC5->ZC5_NUM,"1"})
	EndIf
	ZC5->(DBSKIP())
	
EndDo

U_NcEcom06(aPed)

RpcClearEnv()

Return
