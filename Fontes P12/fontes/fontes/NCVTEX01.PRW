#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "XMLXFUN.CH"
//Winexec("C:\Program Files\SmartBear\SoapUI-5.0.0\bin\testrunner.bat -sNcGames -cProdutos -a -fD:\ces\report -I -S D:\ces\Proximo.xml")
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCVTEX01  �Autor  �Microsiga           � Data �  02/05/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina de integra��o de produtos protheus x vtex           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function NCVTEX01(cMensagem)
Local cPostUrl
Local aPostUrl	:= {}
Local cUser
Local cPassword

Local cSoap
Local cProduto
Local cRetorno	:= ""
Local cIdVtex	:= ""
Local nInd		:= 1
Local cCliNc	:= Alltrim(U_MyNewSX6("VT_NCG0005","000000","C","C�d. de cliente NcGames utilizado no VTex","","",.F. ))
Local cLojaNc	:= Alltrim(U_MyNewSX6("VT_NCG0006","00","C","C�d. de loja NcGames utilizado no VTex","","",.F. )) 

Default cMensagem	:= ""

U_VTEX01Param(@cUser,@cPassword,aPostUrl)
cMensagem 	:= ""

cProduto	:= AllTrim(SB1->B1_COD)
SA7->(DbSetOrder(1))//A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO

For nInd:=1 To Len(aPostUrl)
	
	cPostUrl := aPostUrl[nInd,1]
	HttpSetPass(cUser,cPassword)
	
	cSoap := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">'
	cSoap += '   <soapenv:Header/>
	cSoap += '   <soapenv:Body>
	cSoap += '      <tem:ProductGetByRefId>
	cSoap += '         <tem:refId>'+cProduto+'</tem:refId>
	cSoap += '      </tem:ProductGetByRefId>
	cSoap += '   </soapenv:Body>
	cSoap += '</soapenv:Envelope>
	
	cSoapAction	:= "http://tempuri.org/IService/ProductGetByRefId"
	cRetorno	:= SvcSoapCall(cSoap,cSoapAction,cPostUrl)
	
	If At(cProduto,cRetorno)>0
		cMensagem += "Produto j� cadastrado."
		cIdVtex	:= AllTrim( SubStr(cRetorno,At('<a:Id>',cRetorno)+6, At('</a:Id>',cRetorno)-At('<a:Id>',cRetorno)-6 ))
	Else
		If  SA7->(MsSeek(xFilial("SA7")+cCliNc+cLojaNc+cProduto ))
			cMensagem += "Produto j� cadastrado."
			cIdVtex := SA7->A7_CODCLI
		Else
			//Gravacao Produto
			HttpSetPass(cUser,cPassword)
			cSoap		:= VTEX01WSProd()
			cSoapAction	:= "http://tempuri.org/IService/ProductInsertUpdate"
			cSoap 		:= EncodeUTF8(cSoap)//Adicionado pois alguns produtos estavam apresentando erro na integra��o
			cRetorno		:= SvcSoapCall(cSoap,cSoapAction,cPostUrl)
			
			If At(cProduto,cRetorno)>0
				cIdVtex	:= AllTrim( SubStr(cRetorno,At('<a:Id>',cRetorno)+6, At('</a:Id>',cRetorno)-At('<a:Id>',cRetorno)-6 ))
				cMensagem	+= "Produto gravado com sucesso(ID Vtex="+cIdVtex+").
			Else
				cMensagem	+= "Erro Produto"+CRLF+GetErro(cRetorno)
			EndIf
			
		EndIf
	EndIf
	
	cMensagem	+= CRLF
	
	//Gravacao SKU
	HttpSetPass(cUser,cPassword)
	cSoap		:= VTEX01SKU(cIdVtex)
	cSoapAction	:= "http://tempuri.org/IService/StockKeepingUnitInsertUpdate"
	cSoap 		:= EncodeUTF8(cSoap) //Adicionado pois alguns produtos estavam apresentando erro na integra��o
	cRetorno		:= SvcSoapCall(cSoap,cSoapAction,cPostUrl)
	
	If At(cIdVtex,cRetorno)>0
		cIdVtex:=AllTrim( SubStr(cRetorno,At('<a:Id>',cRetorno)+6, At('</a:Id>',cRetorno)-At('<a:Id>',cRetorno)-6 ))
		U_NCGRAVASA7(cCliNc,cLojaNc,cIdVtex,SB1->B1_DESC,SB1->B1_COD)
		cMensagem += "SKU gravado com sucesso(ID Vtex="+cIdVtex+").
	Else
		cMensagem += "Erro SKU"+CRLF+GetErro(cRetorno)
	EndIf
	
	
Next

Return .T.

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCVTEX01  �Autor  �Microsiga           � Data �  02/06/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina de integra��o de produtos protheus x vtex           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VTEX01WSProd()

Local cSoap		:= ""
Local cMarca		:= Alltrim(U_MyNewSX6("VT_NCG0013","2000001","C","Id marca de produto para a integra��o","","",.F. ))
Local cCategoria	:= Alltrim(U_MyNewSX6("VT_NCG0012","1","C","Id categoria de produto para a integra��o","","",.F. ))

cSoap := ''
cSoap += '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '
cSoap += 'xmlns:tem="http://tempuri.org/" '
cSoap += 'xmlns:vtex="http://schemas.datacontract.org/2004/07/Vtex.Commerce.WebApps.AdminWcfService.Contracts" '
cSoap += 'xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays"> '+CRLF
cSoap += '   <soapenv:Header/> '+CRLF
cSoap += '   <soapenv:Body> '+CRLF
cSoap += '      <tem:ProductInsertUpdate> '+CRLF
cSoap += '         <!--Optional:--> '+CRLF
cSoap += '         <tem:productVO> '+CRLF
cSoap += '            <!--Optional:--> '+CRLF
cSoap += '            <vtex:BrandId>'+ cMarca +'</vtex:BrandId> '+CRLF
cSoap += '            <!--Optional:--> '+CRLF
cSoap += '            <vtex:CategoryId>'+ cCategoria +'</vtex:CategoryId> '+CRLF
cSoap += '            <!--Optional:--> '+CRLF
cSoap += '            <vtex:DepartmentId>'+ cCategoria +'</vtex:DepartmentId> '+CRLF
cSoap += '            <!--Optional:--> '+CRLF
cSoap += '            <vtex:Description>'+ AllTrim(SB1->B1_DESC) +'</vtex:Description> '+CRLF
cSoap += '            <!--Optional:--> '+CRLF
cSoap += '            <vtex:DescriptionShort>'+ AllTrim(SB1->B1_DESC) +'</vtex:DescriptionShort> '+CRLF
cSoap += '            <!--Optional:--> '+CRLF
cSoap += '            <vtex:IsActive>false</vtex:IsActive> '+CRLF
cSoap += '            <!--Optional:--> '+CRLF
cSoap += '            <vtex:IsVisible>false</vtex:IsVisible> '+CRLF
cSoap += '            <!--Optional:--> '+CRLF
cSoap += '            <vtex:ListStoreId> '+CRLF
cSoap += '               <!--Zero or more repetitions:--> '+CRLF
cSoap += '               <arr:int>1</arr:int> '+CRLF
cSoap += '            </vtex:ListStoreId> '+CRLF
cSoap += '            <!--Optional:--> '+CRLF
cSoap += '            <vtex:Name>'+ AllTrim(SB1->B1_DESC) +'</vtex:Name> '+CRLF
cSoap += '            <!--Optional:--> '+CRLF
cSoap += '            <vtex:RefId>'+ AllTrim(SB1->B1_COD) +'</vtex:RefId> '+CRLF
cSoap += '            <!--Optional:--> '+CRLF
cSoap += '            <vtex:Title>'+ AllTrim(SB1->B1_DESC)+'</vtex:Title> '+CRLF
cSoap += '         </tem:productVO> '+CRLF
cSoap += '      </tem:ProductInsertUpdate> '+CRLF
cSoap += '   </soapenv:Body> '+CRLF
cSoap += '</soapenv:Envelope> '+CRLF

Return cSoap

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCVTEX01  �Autor  �Microsiga           � Data �  02/07/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina de integra��o de produtos protheus x vtex           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VTEX01Sku(cIdVtex)
Local cSoap:=""

cSoap := ''
cSoap += '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '
cSoap += 'xmlns:tem="http://tempuri.org/" xmlns:vtex="http://schemas.datacontract.org/2004/07/Vtex.Commerce.WebApps.AdminWcfService.Contracts">'+CRLF
cSoap += '<soapenv:Header/> '+CRLF 
cSoap += '	<soapenv:Body> '+CRLF 
cSoap += '		<tem:StockKeepingUnitInsertUpdate> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<tem:stockKeepingUnitVO> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:CubicWeight>'+ AllTrim(Str(SB1->(B1_PROF*B1_LARGURA*B1_ALT))) +'</vtex:CubicWeight> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:Height>'+ AllTrim(Str(SB1->B1_ALT)) +'</vtex:Height> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:Id>'+ cIdVtex +'</vtex:Id> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:IsActive>false</vtex:IsActive> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:IsAvaiable>false</vtex:IsAvaiable> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:IsKit>false</vtex:IsKit> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:Length>'+ AllTrim(Str(SB1->B1_PROF)) +'</vtex:Length> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:ModalId>1</vtex:ModalId> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:ModalType>Game</vtex:ModalType> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:Name>'+ AllTrim(SB1->B1_DESC) +'</vtex:Name> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:ProductId>'+ cIdVtex +'</vtex:ProductId> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:ProductName>'+ AllTrim(SB1->B1_DESC) +'</vtex:ProductName> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:RealHeight>'+ AllTrim(Str(SB1->B1_ALT)) +'</vtex:RealHeight> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:RealLength>'+ AllTrim(Str(SB1->B1_PROF)) +'</vtex:RealLength> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:RealWeightKg>'+ AllTrim(Str(1000*SB1->B1_PESBRU)) +'</vtex:RealWeightKg> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:RealWidth>'+ AllTrim(Str(SB1->B1_LARGURA)) +'</vtex:RealWidth> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:RefId>'+ cIdVtex +'</vtex:RefId> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:RewardValue>0</vtex:RewardValue> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:StockKeepingUnitEans> '+CRLF
cSoap += '				<!--Zero or more repetitions:--> '+CRLF
cSoap += '				<vtex:StockKeepingUnitEanDTO> '+CRLF
cSoap += '					<!--Optional:--> '+CRLF
cSoap += '					<vtex:Ean>'+ AllTrim(SB1->B1_CODBAR) +'</vtex:Ean> '+CRLF
cSoap += '				</vtex:StockKeepingUnitEanDTO> '+CRLF
cSoap += '			</vtex:StockKeepingUnitEans> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:UnitMultiplier>1</vtex:UnitMultiplier> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:WeightKg>'+ AllTrim(Str(1000*SB1->B1_PESBRU)) +'</vtex:WeightKg> '+CRLF
cSoap += '			<!--Optional:--> '+CRLF
cSoap += '			<vtex:Width>'+ AllTrim(Str(SB1->B1_LARGURA)) +'</vtex:Width> '+CRLF
cSoap += '		</tem:stockKeepingUnitVO> '+CRLF
cSoap += '	</tem:StockKeepingUnitInsertUpdate> '+CRLF
cSoap += '</soapenv:Body> '+CRLF
cSoap += '</soapenv:Envelope> '+CRLF

Return cSoap


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCVTEX01  �Autor  �Microsiga           � Data �  02/06/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina de integra��o de produtos protheus x vtex           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function SvcSoapCall(cSoap,cSoapAction,cPostUrl,lSaveXML,lRetObj)
Local cRetPost  := ""
Local aHeadOut  := {}
Local cXmlHead  := ""
Local cError    := ""
Local cWarning  := ""
Local oXmlRet   := Nil
Local nHdl
Local cMensagem:=""

Default lSaveXML	:=.F.
Default lRetObj	:=.F.

aadd(aHeadOut,'SOAPAction: '+cSoapAction)
aadd(aHeadOut,'Content-Type: text/xml; charset=' + "utf-8" )
aadd(aHeadOut,'User-Agent: Mozilla/4.0 (compatible; Protheus '+GetBuild()+'; '+'ADVPL WSDL Client 1.060117'+')')

If lSaveXML
	nHdl := FCreate(CriaTrab(Nil,.F.)+"_snd.xml")
	FWrite(nHdl,cSoap)
	FClose(nHdl)
EndIf

cRetPost := Httppost(cPostUrl,"",cSoap,,aHeadOut,@cXmlHead)

If (lRetObj .And. cRetPost <> Nil)
	uRetorno := XmlParser(cRetPost,'_',@cError,@cWarning)
Else
	uRetorno:=cRetPost
EndIf

If lSaveXML
	nHdl := FCreate(CriaTrab(Nil,.F.)+"_RCV.XML")
	FWrite(nHdl,cRetPost)
	FClose(nHdl)
EndIf


Return(uRetorno)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCVTEX01  �Autor  �Microsiga           � Data �  02/22/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function GetErro(cXML)
Local cError	:=""
Local cWarning	:=""
Local cRetorno	:=""
Local oXML

oXML :=XmlParser(cXML,'_',@cError,@cWarning)
If ValType(oXML)=='O'
	oXML :=XmlGetChild(oXML:_S_ENVELOPE:_S_BODY:_S_FAULT,2)
	If ValType(oXML)=='O' .And. ValType(XmlChildEx(oXML,"_XML_LANG"))=="O"
		cRetorno	:=oXML:TEXT+CRLF
	EndIf
EndIf



Return cRetorno
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCVTEX01  �Autor  �Microsiga           � Data �  03/19/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function VTEX01Param(cUser,cPassword,aPostUrl)

Default cUser		:= Alltrim(U_MyNewSX6("VT_NCG0000","nc" ,"C","Usuario Autenticacao WS Vtex","","",.F. ))
Default cPassword	:= Alltrim(U_MyNewSX6("VT_NCG0001","ncncnc","C","Senha Autenticacao WS Vtex","","",.F. ))
Default aPostUrl	:= {}

cUser		:= "nc"
cPassword 	:= "ncncnc"

aAdd(aPostUrl,{"http://webservice-ncgames.vtexcommerce.com.br/AdminWebService/Service.svc","http://webservice-ncgames.vtexcommerce.com.br"})

Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCVTEX01  �Autor  �Microsiga           � Data �  03/17/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function VTEX01EAN(cCodProduto,cMensagem)
Local aAreaAtu	:= GetArea()
Local cQryAlias	:= GetNextAlias()
Local cPostUrl
Local cSoap
Local aPostUrl	:= {}
Local nInd		:= 1
Local cRetorno	:= ""
Local cQuery	:= ""
Local cUser
Local cPassword
Local aDadosUZ	  :=Separa( Alltrim(U_MyNewSX6("VT_000003","000000;03" ,"C","Cliente Loja UzGames","","",.F. )) ,";")
Local aDadosNc	:= {}
Local aDados
Local cCliNc	:= Alltrim(U_MyNewSX6("VT_NCG0005","000000","C","C�d. de cliente NcGames utilizado no VTex","","",.F. ))
Local cLojaNc	:= Alltrim(U_MyNewSX6("VT_NCG0006","00","C","C�d. de loja NcGames utilizado no VTex","","",.F. )) 

Default cMensagem		:= ""
Default cCodProduto	:= ""

U_VTEX01Param(@cUser,@cPassword,aPostUrl)
cMensagem:=""

aAdd(aDadosNc,cCliNc)
aAdd(aDadosNc,cLojaNc)

For nInd:=1 To Len(aPostUrl)
	cPostUrl:=aPostUrl[nInd,1]
	
	If "NCGAMES"$Upper(cPostUrl)
		aDados:=aDadosNc
		cMensagem+="ID NcGames"
	EndIf
	
	cQuery:=" Select SB1.R_E_C_N_O_ RecSB1"
	cQuery+=" From "+RetSqlName("SB1")+" SB1"
	cQuery+=" Where SB1.B1_FILIAL='"+xFilial("SB1")+"'"
	
	If !Empty(cCodProduto)
		cQuery+=" And SB1.B1_COD ='"+cCodProduto+"'"
	Else
		cQuery+=" And SB1.B1_COD Between '          ' And 'ZZZZZZZZZZZ'"
		cQuery+=" And SB1.B1_CODBAR<>'      '"
	EndIf
	cQuery+=" And SB1.D_E_L_E_T_=' '"
	cQuery+=" And SB1.B1_XMOSTSI<>'2'"
	
	cQuery+=" And Not Exists ( Select 'X' From "+RetSqlName("SA7")	+" SA7
	cQuery+=" 						Where SA7.A7_FILIAL='"+xFilial("SA7")+"'"
	cQuery+=" 						And SA7.A7_PRODUTO=SB1.B1_COD"
	cQuery+=" 						And SA7.A7_CLIENTE='"+aDados[1]+"'"
	cQuery+=" 						And SA7.A7_LOJA='"+aDados[2]+"'"
	cQuery+=" 						And SA7.A7_CODCLI<>'-'
	cQuery+=" 						And SA7.D_E_L_E_T_=' ')"
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cQryAlias  ,.F.,.T.)
	
	Do While (cQryAlias)->(!Eof())
		
		
		SB1->(DbGoTo( (cQryAlias)->RecSB1 ) )
		
		HttpSetPass(cUser,cPassword)
		//Consulta por EAN
		cSoap:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">'
		cSoap+='      <soapenv:Header/>'
		cSoap+='      <soapenv:Body>'
		cSoap+='         <tem:StockKeepingUnitGetByEan>'
		cSoap+='            <tem:EAN13>'+AllTrim(SB1->B1_CODBAR)+'</tem:EAN13>'
		cSoap+='         </tem:StockKeepingUnitGetByEan>'
		cSoap+='      </soapenv:Body>'
		cSoap+='   </soapenv:Envelope>'
		cSoapAction:="http://tempuri.org/IService/StockKeepingUnitGetByEan"
		oRetorno:=SvcSoapCall(cSoap,cSoapAction,cPostUrl,,.T.)
		If Type("oRetorno:_S_ENVELOPE:_S_BODY:_STOCKKEEPINGUNITGETBYEANRESPONSE:_STOCKKEEPINGUNITGETBYEANRESULT:_A_ID")=="O"
			cMensagem+="="+oRetorno:_S_ENVELOPE:_S_BODY:_STOCKKEEPINGUNITGETBYEANRESPONSE:_STOCKKEEPINGUNITGETBYEANRESULT:_A_ID:TEXT+CRLF
			U_NCGRAVASA7(aDados[1],aDados[2],oRetorno:_S_ENVELOPE:_S_BODY:_STOCKKEEPINGUNITGETBYEANRESPONSE:_STOCKKEEPINGUNITGETBYEANRESULT:_A_ID:TEXT,oRetorno:_S_ENVELOPE:_S_BODY:_STOCKKEEPINGUNITGETBYEANRESPONSE:_STOCKKEEPINGUNITGETBYEANRESULT:_A_PRODUCTNAME:TEXT,SB1->B1_COD)
		Else
			cMensagem+="- n�o encontrado."+CRLF
			U_NCGRAVASA7(aDados[1],aDados[2],"-","nao encontrado",SB1->B1_COD)
		EndIf
		(cQryAlias)->(DbSkip())
	EndDo
	(cQryAlias)->(DbCloseArea())
Next

RestArea(aAreaAtu)

Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCVTEX00  �Autor  �Microsiga           � Data �  03/20/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function VTEX01PROD(cCodProduto,lExecWS)  //Retorna os codigos

Local aAreaAtu	:= GetArea()
Local aAreaSA7	:= SA7->(GetArea())
Local aDados    := {}
Local cCliNc	:= Alltrim(U_MyNewSX6("VT_NCG0005","000000","C","C�d. de cliente NcGames utilizado no VTex","","",.F. ))
Local cLojaNc	:= Alltrim(U_MyNewSX6("VT_NCG0006","00","C","C�d. de loja NcGames utilizado no VTex","","",.F. ))
Local cRetorno	:= ""
Local cMensagem	:= ""

Default lExecWS	:=.T.

SA7->(DbSetOrder(1))//A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO

	aAdd(aDados,cCliNc)
	aAdd(aDados,cLojaNc)

If lExecWS .And. !SA7->(MsSeek(xFilial("SA7")+aDados[1]+aDados[2]+cCodProduto ))
	U_VTEX01EAN(cCodProduto,cMensagem)
EndIf

If SA7->(MsSeek(xFilial("SA7")+aDados[1]+aDados[2]+cCodProduto ))
	cRetorno:=SA7->A7_CODCLI
EndIf

RestArea(aAreaSA7)
RestArea(aAreaAtu)

Return cRetorno
                  

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCVTEX00  �Autor  �Microsiga           � Data �  03/20/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function VTEXPROD(cCodProduto,cLojaCli,lExecWS)  //Retorna os codigos
Local aAreaAtu		:=GetArea()
Local aAreaSA7		:=SA7->(GetArea())
Local aDados
Local cRetorno		:=""
Local cMensagem	:=""
Local nWebService

Default lExecWS:=.T.

SA7->(DbSetOrder(1))//A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO

If cLojaCli=="02"
	aDados:=Separa( Alltrim(U_MyNewSX6("VT_000002","000000;02" ,"C","Cliente Loja Proximo","","",.F. )) ,";")
ElseIf cLojaCli=="03"
	aDados:=Separa( Alltrim(U_MyNewSX6("VT_000003","000000;03" ,"C","Cliente Loja UzGames","","",.F. )) ,";")
EndIf

If lExecWS .And. !SA7->(MsSeek(xFilial("SA7")+aDados[1]+aDados[2]+cCodProduto ))
	U_VTEX01EAN(cCodProduto,cMensagem)
EndIf

If SA7->(MsSeek(xFilial("SA7")+aDados[1]+aDados[2]+cCodProduto ))
	cRetorno:=SA7->A7_CODCLI
EndIf

RestArea(aAreaSA7)
RestArea(aAreaAtu)

Return cRetorno
