#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"
/* ===============================================================================
WSDL Location    \wsdl\ciashop.wsdl
Gerado em        04/14/14 13:19:45
Observa็๕es      C๓digo-Fonte gerado por ADVPL WSDL Client 1.120703
                 Altera็๕es neste arquivo podem causar funcionamento incorreto
                 e serใo perdidas caso o c๓digo-fonte seja gerado novamente.
=============================================================================== */

//url produ็ใo
//Static cWSUrl:="https://www.ncgames.com.br/ws/wsintegracao.asmx"   //"https://www9.ciashop.com.br/ncgames/ws/wsintegracao.asmx"
//Url de testes
Static cWSUrl:="https://www.ncgames.com.br/ws/wsintegracao.asmx"   //"https://www9.ciashop.com.br/ncgames/ws/wsintegracao.asmx"


User Function _KYSBAAE(aDados)

Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service NC_WSWSIntegracao
------------------------------------------------------------------------------- */

WSCLIENT NC_WSWSIntegracao

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD Compradores
	WSMETHOD ConfirmaCompradores
	WSMETHOD Pedidos
	WSMETHOD ConfirmaPedidos
	WSMETHOD StatusPedidos
	WSMETHOD Produtos
	WSMETHOD AtualizaPreco
	WSMETHOD Variantes
	WSMETHOD AtualizaEstoque
	WSMETHOD ListaPresente
	WSMETHOD Descricao
	WSMETHOD Departamentos
	WSMETHOD DepartamentosProdutos
	WSMETHOD EnviaImagem
	WSMETHOD Afiliados
	WSMETHOD ConfirmaAfiliado
	WSMETHOD CamposExtras
	WSMETHOD TabelaPrecoVariante
	WSMETHOD TabelaPrecoProduto

	WSDATA   _URL                      AS String
	WSDATA   _CERT                     AS String
	WSDATA   _PRIVKEY                  AS String
	WSDATA   _PASSPHRASE               AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   clogin                    AS string
	WSDATA   csenha                    AS string
	WSDATA   cxml                      AS string
	WSDATA   nCompradoresResult        AS int
	WSDATA   lConfirmaCompradoresResult AS boolean
	WSDATA   nPedidosResult            AS int
	WSDATA   lConfirmaPedidosResult    AS boolean
	WSDATA   lStatusPedidosResult      AS boolean
	WSDATA   lProdutosResult           AS boolean
	WSDATA   lAtualizaPrecoResult      AS boolean
	WSDATA   lVariantesResult          AS boolean
	WSDATA   lAtualizaEstoqueResult    AS boolean
	WSDATA   lListaPresenteResult      AS boolean
	WSDATA   lDescricaoResult          AS boolean
	WSDATA   lDepartamentosResult      AS boolean
	WSDATA   lDepartamentosProdutosResult AS boolean
	WSDATA   cpassword                 AS string
	WSDATA   cstream                   AS string
	WSDATA   ccaminho                  AS string
	WSDATA   cnome_arquivo             AS string
	WSDATA   csku                      AS string
	WSDATA   nidx                      AS int
	WSDATA   ctipo                     AS string
	WSDATA   lEnviaImagemResult        AS boolean
	WSDATA   nAfiliadosResult          AS int
	WSDATA   lConfirmaAfiliadoResult   AS boolean
	WSDATA   nCamposExtrasResult       AS int
	WSDATA   lTabelaPrecoVarianteResult AS boolean
	WSDATA   lTabelaPrecoProdutoResult AS boolean

ENDWSCLIENT

WSMETHOD NEW WSCLIENT NC_WSWSIntegracao
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O C๓digo-Fonte Client atual requer os executแveis do Protheus Build [7.00.121227P-20131106] ou superior. Atualize o Protheus ou gere o C๓digo-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT NC_WSWSIntegracao
Return

WSMETHOD RESET WSCLIENT NC_WSWSIntegracao
	::clogin             := NIL 
	::csenha             := NIL 
	::cxml               := NIL 
	::nCompradoresResult := NIL 
	::lConfirmaCompradoresResult := NIL 
	::nPedidosResult     := NIL 
	::lConfirmaPedidosResult := NIL 
	::lStatusPedidosResult := NIL 
	::lProdutosResult    := NIL 
	::lAtualizaPrecoResult := NIL 
	::lVariantesResult   := NIL 
	::lAtualizaEstoqueResult := NIL 
	::lListaPresenteResult := NIL 
	::lDescricaoResult   := NIL 
	::lDepartamentosResult := NIL 
	::lDepartamentosProdutosResult := NIL 
	::cpassword          := NIL 
	::cstream            := NIL 
	::ccaminho           := NIL 
	::cnome_arquivo      := NIL 
	::csku               := NIL 
	::nidx               := NIL 
	::ctipo              := NIL 
	::lEnviaImagemResult := NIL 
	::nAfiliadosResult   := NIL 
	::lConfirmaAfiliadoResult := NIL 
	::nCamposExtrasResult := NIL 
	::lTabelaPrecoVarianteResult := NIL 
	::lTabelaPrecoProdutoResult := NIL 
	::Init()
Return

WSMETHOD CLONE WSCLIENT NC_WSWSIntegracao
Local oClone := NC_WSWSIntegracao():New()
	oClone:_URL          := ::_URL 
	oClone:_CERT         := ::_CERT 
	oClone:_PRIVKEY      := ::_PRIVKEY 
	oClone:_PASSPHRASE   := ::_PASSPHRASE 
	oClone:clogin        := ::clogin
	oClone:csenha        := ::csenha
	oClone:cxml          := ::cxml
	oClone:nCompradoresResult := ::nCompradoresResult
	oClone:lConfirmaCompradoresResult := ::lConfirmaCompradoresResult
	oClone:nPedidosResult := ::nPedidosResult
	oClone:lConfirmaPedidosResult := ::lConfirmaPedidosResult
	oClone:lStatusPedidosResult := ::lStatusPedidosResult
	oClone:lProdutosResult := ::lProdutosResult
	oClone:lAtualizaPrecoResult := ::lAtualizaPrecoResult
	oClone:lVariantesResult := ::lVariantesResult
	oClone:lAtualizaEstoqueResult := ::lAtualizaEstoqueResult
	oClone:lListaPresenteResult := ::lListaPresenteResult
	oClone:lDescricaoResult := ::lDescricaoResult
	oClone:lDepartamentosResult := ::lDepartamentosResult
	oClone:lDepartamentosProdutosResult := ::lDepartamentosProdutosResult
	oClone:cpassword     := ::cpassword
	oClone:cstream       := ::cstream
	oClone:ccaminho      := ::ccaminho
	oClone:cnome_arquivo := ::cnome_arquivo
	oClone:csku          := ::csku
	oClone:nidx          := ::nidx
	oClone:ctipo         := ::ctipo
	oClone:lEnviaImagemResult := ::lEnviaImagemResult
	oClone:nAfiliadosResult := ::nAfiliadosResult
	oClone:lConfirmaAfiliadoResult := ::lConfirmaAfiliadoResult
	oClone:nCamposExtrasResult := ::nCamposExtrasResult
	oClone:lTabelaPrecoVarianteResult := ::lTabelaPrecoVarianteResult
	oClone:lTabelaPrecoProdutoResult := ::lTabelaPrecoProdutoResult
Return oClone

// WSDL Method Compradores of Service NC_WSWSIntegracao

WSMETHOD Compradores WSSEND clogin,csenha,cxml WSRECEIVE nCompradoresResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<Compradores xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</Compradores>"
           
//WSDLSaveXML(.T.)

oXmlRet := SvcSoapCall(	Self,cSoap,"WSIntegB2C/Compradores","DOCUMENT","WSIntegB2C",,,cWSUrl)

::Init()
::nCompradoresResult :=  WSAdvValue( oXmlRet,"_COMPRADORESRESPONSE:_COMPRADORESRESULT:TEXT","int",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_COMPRADORESRESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ConfirmaCompradores of Service NC_WSWSIntegracao

WSMETHOD ConfirmaCompradores WSSEND clogin,csenha,BYREF cxml WSRECEIVE lConfirmaCompradoresResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ConfirmaCompradores xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ConfirmaCompradores>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/ConfirmaCompradores",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lConfirmaCompradoresResult :=  WSAdvValue( oXmlRet,"_CONFIRMACOMPRADORESRESPONSE:_CONFIRMACOMPRADORESRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_CONFIRMACOMPRADORESRESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method Pedidos of Service NC_WSWSIntegracao

WSMETHOD Pedidos WSSEND clogin,csenha,BYREF cxml WSRECEIVE nPedidosResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<Pedidos xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</Pedidos>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/Pedidos",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::nPedidosResult     :=  WSAdvValue( oXmlRet,"_PEDIDOSRESPONSE:_PEDIDOSRESULT:TEXT","int",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_PEDIDOSRESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ConfirmaPedidos of Service NC_WSWSIntegracao

WSMETHOD ConfirmaPedidos WSSEND clogin,csenha,BYREF cxml WSRECEIVE lConfirmaPedidosResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ConfirmaPedidos xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ConfirmaPedidos>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/ConfirmaPedidos",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lConfirmaPedidosResult :=  WSAdvValue( oXmlRet,"_CONFIRMAPEDIDOSRESPONSE:_CONFIRMAPEDIDOSRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_CONFIRMAPEDIDOSRESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StatusPedidos of Service NC_WSWSIntegracao

WSMETHOD StatusPedidos WSSEND clogin,csenha,BYREF cxml WSRECEIVE lStatusPedidosResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StatusPedidos xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StatusPedidos>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/StatusPedidos",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lStatusPedidosResult :=  WSAdvValue( oXmlRet,"_STATUSPEDIDOSRESPONSE:_STATUSPEDIDOSRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_STATUSPEDIDOSRESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method Produtos of Service NC_WSWSIntegracao

WSMETHOD Produtos WSSEND clogin,csenha,BYREF cxml WSRECEIVE lProdutosResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<Produtos xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</Produtos>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/Produtos",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lProdutosResult    :=  WSAdvValue( oXmlRet,"_PRODUTOSRESPONSE:_PRODUTOSRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_PRODUTOSRESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method AtualizaPreco of Service NC_WSWSIntegracao

WSMETHOD AtualizaPreco WSSEND clogin,csenha,BYREF cxml WSRECEIVE lAtualizaPrecoResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<AtualizaPreco xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</AtualizaPreco>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/AtualizaPreco",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lAtualizaPrecoResult :=  WSAdvValue( oXmlRet,"_ATUALIZAPRECORESPONSE:_ATUALIZAPRECORESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_ATUALIZAPRECORESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method Variantes of Service NC_WSWSIntegracao

WSMETHOD Variantes WSSEND clogin,csenha,BYREF cxml WSRECEIVE lVariantesResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<Variantes xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</Variantes>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/Variantes",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lVariantesResult   :=  WSAdvValue( oXmlRet,"_VARIANTESRESPONSE:_VARIANTESRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_VARIANTESRESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method AtualizaEstoque of Service NC_WSWSIntegracao

WSMETHOD AtualizaEstoque WSSEND clogin,csenha,BYREF cxml WSRECEIVE lAtualizaEstoqueResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<AtualizaEstoque xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</AtualizaEstoque>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/AtualizaEstoque",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lAtualizaEstoqueResult :=  WSAdvValue( oXmlRet,"_ATUALIZAESTOQUERESPONSE:_ATUALIZAESTOQUERESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_ATUALIZAESTOQUERESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ListaPresente of Service NC_WSWSIntegracao

WSMETHOD ListaPresente WSSEND clogin,csenha,BYREF cxml WSRECEIVE lListaPresenteResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ListaPresente xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ListaPresente>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/ListaPresente",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lListaPresenteResult :=  WSAdvValue( oXmlRet,"_LISTAPRESENTERESPONSE:_LISTAPRESENTERESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_LISTAPRESENTERESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method Descricao of Service NC_WSWSIntegracao

WSMETHOD Descricao WSSEND clogin,csenha,BYREF cxml WSRECEIVE lDescricaoResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<Descricao xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</Descricao>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/Descricao",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lDescricaoResult   :=  WSAdvValue( oXmlRet,"_DESCRICAORESPONSE:_DESCRICAORESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_DESCRICAORESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method Departamentos of Service NC_WSWSIntegracao

WSMETHOD Departamentos WSSEND clogin,csenha,BYREF cxml WSRECEIVE lDepartamentosResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<Departamentos xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</Departamentos>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/Departamentos",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lDepartamentosResult :=  WSAdvValue( oXmlRet,"_DEPARTAMENTOSRESPONSE:_DEPARTAMENTOSRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_DEPARTAMENTOSRESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method DepartamentosProdutos of Service NC_WSWSIntegracao

WSMETHOD DepartamentosProdutos WSSEND clogin,csenha,BYREF cxml WSRECEIVE lDepartamentosProdutosResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<DepartamentosProdutos xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</DepartamentosProdutos>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/DepartamentosProdutos",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lDepartamentosProdutosResult :=  WSAdvValue( oXmlRet,"_DEPARTAMENTOSPRODUTOSRESPONSE:_DEPARTAMENTOSPRODUTOSRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_DEPARTAMENTOSPRODUTOSRESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method EnviaImagem of Service NC_WSWSIntegracao

WSMETHOD EnviaImagem WSSEND clogin,cpassword,cstream,ccaminho,cnome_arquivo,csku,nidx,ctipo,BYREF cxml WSRECEIVE lEnviaImagemResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<EnviaImagem xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("password", ::cpassword, cpassword , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("stream", ::cstream, cstream , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("caminho", ::ccaminho, ccaminho , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("nome_arquivo", ::cnome_arquivo, cnome_arquivo , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("sku", ::csku, csku , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("idx", ::nidx, nidx , "int", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("tipo", ::ctipo, ctipo , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</EnviaImagem>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/EnviaImagem",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lEnviaImagemResult :=  WSAdvValue( oXmlRet,"_ENVIAIMAGEMRESPONSE:_ENVIAIMAGEMRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_ENVIAIMAGEMRESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method Afiliados of Service NC_WSWSIntegracao

WSMETHOD Afiliados WSSEND clogin,csenha,BYREF cxml WSRECEIVE nAfiliadosResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<Afiliados xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</Afiliados>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/Afiliados",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::nAfiliadosResult   :=  WSAdvValue( oXmlRet,"_AFILIADOSRESPONSE:_AFILIADOSRESULT:TEXT","int",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_AFILIADOSRESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ConfirmaAfiliado of Service NC_WSWSIntegracao

WSMETHOD ConfirmaAfiliado WSSEND clogin,csenha,BYREF cxml WSRECEIVE lConfirmaAfiliadoResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ConfirmaAfiliado xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ConfirmaAfiliado>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/ConfirmaAfiliado",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lConfirmaAfiliadoResult :=  WSAdvValue( oXmlRet,"_CONFIRMAAFILIADORESPONSE:_CONFIRMAAFILIADORESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_CONFIRMAAFILIADORESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CamposExtras of Service NC_WSWSIntegracao

WSMETHOD CamposExtras WSSEND clogin,csenha,BYREF cxml WSRECEIVE nCamposExtrasResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CamposExtras xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</CamposExtras>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/CamposExtras",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::nCamposExtrasResult :=  WSAdvValue( oXmlRet,"_CAMPOSEXTRASRESPONSE:_CAMPOSEXTRASRESULT:TEXT","int",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_CAMPOSEXTRASRESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method TabelaPrecoVariante of Service NC_WSWSIntegracao

WSMETHOD TabelaPrecoVariante WSSEND clogin,csenha,BYREF cxml WSRECEIVE lTabelaPrecoVarianteResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<TabelaPrecoVariante xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</TabelaPrecoVariante>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/TabelaPrecoVariante",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lTabelaPrecoVarianteResult :=  WSAdvValue( oXmlRet,"_TABELAPRECOVARIANTERESPONSE:_TABELAPRECOVARIANTERESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_TABELAPRECOVARIANTERESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method TabelaPrecoProduto of Service NC_WSWSIntegracao

WSMETHOD TabelaPrecoProduto WSSEND clogin,csenha,BYREF cxml WSRECEIVE lTabelaPrecoProdutoResult WSCLIENT NC_WSWSIntegracao
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<TabelaPrecoProduto xmlns="WSIntegB2C">'
cSoap += WSSoapValue("login", ::clogin, clogin , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("senha", ::csenha, csenha , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</TabelaPrecoProduto>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WSIntegB2C/TabelaPrecoProduto",; 
	"DOCUMENT","WSIntegB2C",,,; 
	cWSUrl)

::Init()
::lTabelaPrecoProdutoResult :=  WSAdvValue( oXmlRet,"_TABELAPRECOPRODUTORESPONSE:_TABELAPRECOPRODUTORESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 
::cxml               :=  WSAdvValue( oXmlRet,"_TABELAPRECOPRODUTORESPONSE:_XML:TEXT","string",NIL,NIL,NIL,NIL,@cxml,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOMIT  บAutor  ณMicrosiga           บ Data ณ  12/04/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Class ApiCiaShop

	Data cToken
	Data cResponse
	Data cHttp
	Data cUrl
	Data lSemAcento
	Data lUpperCase
	Data cBody

	Method New()
	Method HttpGet()	
	Method HttpPost()	
	Method Reset()	
	
End Class       


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOMIT  บAutor  ณMicrosiga           บ Data ณ  12/04/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Method New() Class ApiCiaShop
   
   //Produ็ใo//Self:cToken 	:= "eyJvIjoie1wiaVwiOlwiQ2lhc2hvcFwiLFwiblwiOlwiRVJQX1Byb3RoZXVzXCIsXCJwXCI6XCI0YmEzNDFiNS1jODQ5LTQ0OTMtOGVhYS0wNGYyYWI2MjVmNzlcIn0iLCJzIjoiSEtFaWpjMkQwanZ5ZG9OZ0c1UDBlUTNSemhKMVZoVnRNczR6Q2F3ZWlNaXFPRlp5SkE1VlgvSkI0SnRnbDdSbGd5WWw3QnFFUFcxSWUrdHQ0MDJaUHlSRi9SUGJ2ZDg3bjBaQkZ6YWxjNE1pYTJaRWlVcjJOei94Z0VuZ0x3UGpCRCtxSUpGYStTNjRzdm5RTFQ3RVJmUEZ5N2VMV2dQSkFlWi9DUFpTblVBPSJ9"
   
   //Homologa็ใo
   Self:cToken 		:= "eyJvIjoie1wiaVwiOlwiQ2lhc2hvcFwiLFwiblwiOlwiQVBJXCIsXCJwXCI6XCI0MzE5OTgxNi02ZThmLTQ1OWYtODczYi01ZmQwNWRjN2E4YTVcIn0iLCJzIjoiRW1qOXZoQlVMMEFNclhoMVppK2U4S1kxTzU5ZmQ3TlNzQWthRGVtVmtWeWJjNitOdENZMVVWWEdKRVkyNFRCVjliellURWxSNUNXY1J3bXNGcEwvV0Z4VkRGbzZZSkdkUWl4bVhtQ3lsNk81YXlQUmVsenRSYTBxUFZFTGJudWNXTHhHOUdzaVNDanErRkE3Q2xTL2NidUZJWFJzZmF2aHNBclM0T3p5ek5VPSJ9"
   
   //Produ็ใo//Self:cHttp 		:= "https://www.ncgames.com.br/api/"+GetMv("NC_VER_API",.F.,"v1")+"/"
   
   //homologa็ใo
   Self:cHttp 		:= "https://homologuzgames.myciashop.com.br/api/"+GetMv("NC_VER_API",.F.,"v1")+"/"
   Self:cUrl		:= ""
   Self:cBody		:= ""
   Self:lSemAcento	:= .F.
   Self:lUpperCase	:= .F.
Return Self


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOMIT  บAutor  ณMicrosiga           บ Data ณ  02/19/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Method Reset() Class ApiCiaShop
   Self:cHttp 			:= "https://www9.ciashop.com.br/ncgameshom/api/"+GetMv("NC_VER_API",.F.,"v1")+"/"
   Self:cUrl			:= ""
   Self:cBody			:= ""
   Self:lSemAcento	:= .F.
   Self:lUpperCase	:= .F.
Return Self


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOMIT  บAutor  ณMicrosiga           บ Data ณ  12/04/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Method HttpGet() Class ApiCiaShop
Local cUrl 			:= Self:cHttp+Self:cUrl
Local cToken		:= Self:cToken
Local nTimeOut 	:= 120 
Local aHeadStr 	:= {}
Local cParms 		:= ""
Local cBody  		:= ""
Local cHeaderRet 	:= ""

Self:cResponse :=""
aHeadStr 	:= {}
AAdd(aHeadStr ,'Authorization: Bearer '+cToken)
AAdd(aHeadStr ,'Content-Type: application/json; charset=utf-8')
                           
cResponse:=HTTPQuote( cUrl, "GET", cParms, cBody, nTimeOut, aHeadStr, @cHeaderRet )

If ValType(cResponse)=="U"
	cResponse:=""
EndIf	


Self:cResponse:=DecodeUTF8(cResponse)

If Self:lUpperCase
	Self:cResponse:=Upper(Self:cResponse)
EndIf	

If Self:lSemAcento
	Self:cResponse:=NoAcento(AnsiToOem(Self:cResponse))
EndIf	


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOMIT  บAutor  ณMicrosiga           บ Data ณ  12/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Method HttpPost() Class ApiCiaShop

Local cUrl 			:= Self:cHttp+Self:cUrl
Local cToken		:= Self:cToken
Local nTimeOut 	:= 120 
Local aHeadStr 	:= {}
Local cParms 		:= ""
Local cBody  		:= Self:cBody
Local cHeaderRet 	:= ""

Self:cResponse :=""
aHeadStr 	:= {}
AAdd(aHeadStr ,'Authorization: Bearer '+cToken)
AAdd(aHeadStr ,'Content-Type: application/json; charset=utf-8')

Self:cResponse:=HTTPQuote( cUrl, "POST", cParms, cBody, nTimeOut, aHeadStr, @cHeaderRet )

If Self:lUpperCase
	Self:cResponse:=Upper(Self:cResponse)
EndIf	

If Self:lSemAcento
	Self:cResponse:=NoAcento(AnsiToOem(Self:cResponse))
EndIf	

Return
