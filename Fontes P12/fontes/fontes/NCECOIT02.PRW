#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

 


/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Exemplo   �Autor  �Elton C			 � Data � 22/12/12	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina de exmplo para utiliza��o	                          ���
�������������������������������������������������������������������������͹��
���Uso       � 						                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
User Function XXC()

Local cFileName := ""    
Local cUserWS	:= "wsncgames"
Local cSenhaWS	:= "apeei.1453"
Local cUrl		:= "https://www9.ciashop.com.br/ncgames/ws/wsintegracao.asmx"
Local cXml		:= ""


oXmlRet	:= U_GetCompr(cXml,cUserWS,cSenhaWS,cUrl)

Return oXmlRet


/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetComprad   �Autor  �Elton C			 � Data � 22/12/12	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna a lista de compradores	(Cadastro de clientes)	  ���
���		     �															  ���
�������������������������������������������������������������������������͹��
���Uso       � 						                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
User Function GetComprad(cXml,cUserWS,cSenhaWS,cUrl)
Local aArea       := GetArea()
Local cSoap	      :=""	
Local oXmlRet	                                                 
Local cRet		  := ""

Default cUserWS	:= "wsncgames"
Default cSenhaWS	:= "apeei.1453"
Default cUrl		:= "https://www9.ciashop.com.br/ncgames/ws/wsintegracao.asmx"
Default cXml		:= ""


	
cSoap	+= ' <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wsin="WSIntegB2C"> '
cSoap	+= '    <soapenv:Header/> '
cSoap	+= '    <soapenv:Body> '
cSoap	+= '       <wsin:Compradores>'
cSoap	+= '          <wsin:login>'+cUserWS+'</wsin:login>'
cSoap	+= '          <wsin:senha>'+cSenhaWS+'</wsin:senha>'
cSoap	+= '          <wsin:xml></wsin:xml>'
cSoap	+= '       </wsin:Compradores>'
cSoap	+= '    </soapenv:Body>'
cSoap	+= ' </soapenv:Envelope>'

                         
oXmlRet := MySvcSoapCall(	cSoap,cUrl) //Objeto de retorno do ws

Return oXmlRet




/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MySvcSoapCall	�Autor  �Elton C		 � Data � 22/12/12	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Efetua a conexa��o com o WS da embraer e retorna o objeto   ���
���		     �como XML de retorno									      ���
�������������������������������������������������������������������������͹��
���Uso       � 						                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function MySvcSoapCall(cSoap, cPostUrl )
Local cRetPost  := ""
Local aHeadOut  := {}
Local cXmlHead  := ""     
Local cError    := ""
Local cWarning  := ""
Local oXmlRet   := Nil    
Local nHdl
Local cMensagem:=""

TIMEINI := TIME()
                                           
aadd(aHeadOut,'Content-Type: text/xml; charset=' + "utf-8" )
aadd(aHeadOut,'User-Agent: Mozilla/4.0 (compatible; Protheus '+GetBuild()+'; '+'ADVPL WSDL Client 1.060117'+')')

nHdl := FCreate(CriaTrab(Nil,.F.)+"_snd.xml")
FWrite(nHdl,cSoap)                                          
FClose(nHdl)   

cRetPost := Httppost(cPostUrl,"",cSoap,,aHeadOut,@cXmlHead) 

//Faz o PARSER do XML retornado
If cRetPost <> Nil
	nHdl := FCreate(CriaTrab(Nil,.F.)+"_RCV.XML")
	FWrite(nHdl,cRetPost)
	FClose(nHdl)
	
	
	cRetPost := StrTran(cRetPost,".Response","")
	oXmlRet := XmlParser(cRetPost,'_',@cError,@cWarning)
EndIf


Return(oXmlRet)


